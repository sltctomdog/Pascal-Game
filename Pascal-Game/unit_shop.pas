unit unit_shop;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils,unit_General,Keyboard,unit_glossaire, unit_GestionEcran, unit_inventaire;


procedure dessinerMagasin(var JOUEUR : stat_joueur);  // dessiner l'interface de magasin

procedure magasinChoix(scene: String; var JOUEUR : stat_joueur); // dessiner la partie du magasin sélectionnée (vendre, acheter)


implementation


procedure dessinerMagasin(var JOUEUR : stat_joueur);
var i, actualIndex: Integer;
  K : TKeyEvent;
  choice: array[0..2] of String;
  exit: Boolean;
begin
  InitKeyBoard;
  actualIndex:=0;

  choice[0] := '>>>   Acheter';
  choice[1] := '>>>   Vendre';
  choice[2] := '>>>   Quitter';

  magasinChoix('off',JOUEUR);

  exit := False;
    while not exit do
    begin
      couleurTexte(15);
      for i:=0 to Length(choice)-1 do                 // afficher la liste des choix
      begin
          couleurFond(0);
          if i=actualIndex then                       // si c'est le choix en cours, le surligné
             couleurFond(4);
          ecrireEnPosition(pos(53, 33+i*4), choice[i])
      end;

      deplacerCurseur(pos(0,0));
      K:=GetKeyEvent;
      K:=TranslateKeyEvent(K);
      case GetKeyEventCode(K) of
           65319: actualIndex:=actualIndex+1;         // si flèche du bas : passer au choix suivant
           65313: actualIndex:=actualIndex-1;         // si flèche du haut : passer au choix précédent
           7181: begin                                // touche entrée
             couleurFond(12);
             ecrireEnPosition(pos(53, 33+actualIndex*4), choice[actualIndex]);
             if actualIndex=0 then                    // si choix 0 : lancer le choix d'acheter
               magasinChoix('acheter',JOUEUR);
             if actualIndex=1 then                    // si choix 1 : lancer le choix de vendre
               magasinChoix('vendre', JOUEUR);
             if actualIndex=2 then                    // si choix 2 : quitter
               exit := True;

             couleurFond(4);
             ecrireEnPosition(pos(53, 33+actualIndex*4), choice[actualIndex]);
             end;
      end;
      if actualIndex>(Length(choice)-1) then
         actualIndex:=0;                              // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité
      if actualIndex<0 then
         actualIndex:=Length(choice)-1;
    end;

end;

procedure magasinChoix(scene: String; var JOUEUR : stat_joueur);
var x, y, i, j, actualIndex, len, nb: Integer;
  K : TKeyEvent;
  consommables: array of Conso;
  c: Conso;
  exit: Boolean;
begin
  actualIndex:=0;
  consommables := initConsommables();
  couleurFond(0);
  ecranclear(JOUEUR);

  x:= 56+(74-26);
  y:= 11;
  couleurTexte(4);
  ecrireEnPosition(pos(51, y+3), stringOfChar('_', 148));
  ecrireEnPosition(pos(x, y), '  __  __                       _       ');
  ecrireEnPosition(pos(x, y+1), ' |  \/  |                     (_)      ');
  ecrireEnPosition(pos(x, y+2), ' | \  / | __ _  __ _  __ _ ___ _ _ __  ');
  ecrireEnPosition(pos(x, y+3), ' | |\/| |/ _` |/ _` |/ _` / __| | ''_ \  ');
  ecrireEnPosition(pos(x, y+4), ' | |  | | (_| | (_| | (_| \__ \ | | | |');
  ecrireEnPosition(pos(x, y+5), ' |_|  |_|\__,_|\__, |\__,_|___/_|_| |_|');
  ecrireEnPosition(pos(x, y+6), '                __/ |                  ');
  ecrireEnPosition(pos(x, y+7), '               |___/                   ');

  dessinerCadreXY(80,22, 169,52, simple, 7, 0);                     // dessin de la base du cadre et les entêtes
  couleurTexte(12);
  if scene='off' then
     couleurTexte(8);
  ecrireEnPosition(pos(81, 23), 'Nom du consommable');
  if scene='acheter' then
     ecrireEnPosition(pos(130, 23), 'Prix d''achat  ')
  else if scene='vendre' then
       ecrireEnPosition(pos(130, 23), 'Prix de vente  ')
  else
      ecrireEnPosition(pos(130, 23), 'Prix             ');

  ecrireEnPosition(pos(169-14, 23), 'Nombre poss'+#233+'d'+#233);

  exit := False;
  while not exit do
  begin
       couleurTexte(8);
         if (scene='acheter') then               // selection de l'array en fonction de la scene
           len := Length(consommables)-1
         else if (scene='vendre') then
           len := Length(JOUEUR.conso)-1;
       if (scene='acheter') or (scene='vendre') then
         for i:=0 to len do
           begin
           if (scene='acheter') then            // selection du consommable correspondant à l'id de l'array de la scene en cours
               c := consommables[i]
           else if (scene='vendre') then
               c := consommables[JOUEUR.conso[i][0]];
            couleurTexte(15);
            if (not c.achetable and (scene='acheter')) or (not c.vendable and (scene='vendre')) then      // si le conso n'est pas vendable ou achetable (en fonction de la scene), l'afficher en gris
              couleurTexte(8);
            couleurFond(0);
            if (i=actualIndex) then
               begin
               couleurFond(4);
               if (not c.achetable and (scene='acheter')) or (not c.vendable and (scene='vendre')) then   // si le conso n'est pas vendable ou achetable (en fonction de la scene), le surligner en gris
                  couleurFond(7);
               end;
            ecrireEnPosition(pos(81, 23+i+2), StringOfChar(' ', 88));

            ecrireEnPosition(pos(81, 23+i+2), (i+1).toString+'. '+c.nom+' ('+c.value.toString+' HP)                     ');    // affichage du prix de vente/d'achat du conso
            if (c.vendable and (scene='vendre')) then
               ecrireEnPosition(pos(130, 23+i+2), c.prixVente.toString+'             ')
            else if (c.achetable and (scene='acheter')) then
               ecrireEnPosition(pos(130, 23+i+2), c.prixAchat.toString+'             ')
            else if (not c.achetable and (scene='acheter')) or (not c.vendable and (scene='vendre')) then
               ecrireEnPosition(pos(130, 23+i+2), 'indisponible');

            nb := 0;
            if scene='acheter' then                                 // affichage du nombre de conso possédé pour ce conso
              for j:=0 to Length(JOUEUR.conso)-1 do
                if JOUEUR.conso[j][0] = i then
                   nb:=JOUEUR.conso[j][1];
            if scene='vendre' then
               nb:=JOUEUR.conso[i][1];
            ecrireEnPosition(pos(169-14, 23+i+2), nb.toString);
           end;

        if not (scene='vendre') and not (scene='acheter') then     // si on est pas sur la scene vendre ou acheter, on s'arrête là
           exit := True;

        if not exit then                                           // sinon on commence la selection du consommable avec les flèches
        begin
          deplacerCurseur(pos(0,0));
          K:=GetKeyEvent;
          K:=TranslateKeyEvent(K);
          case GetKeyEventCode(K) of
               65319: actualIndex:=actualIndex+1;
               65313: actualIndex:=actualIndex-1;
               7181: begin
                     if (scene='acheter') then                     // si scene achter
                         begin
                         c := consommables[actualIndex];
                         if (JOUEUR.PO>=c.prixAchat) and c.achetable then      // on verifie que le consommable est achetable et que le joueur possède assez de PO
                           begin
                                JOUEUR.PO := JOUEUR.PO - c.prixAchat;          // on lui enleve les PO
                                donnerConsommable(JOUEUR, actualIndex, 1);     // on lui donne le consommable
                           end;
                         end
                     else if (scene='vendre') then
                         begin
                           c := consommables[JOUEUR.conso[actualIndex][0]];
                           if c.vendable then                                  // on verifie que le consommable est vendable
                             begin
                               JOUEUR.PO := JOUEUR.PO + c.prixVente;           // on lui donne les PO
                               retirerConsommable(JOUEUR, actualIndex, False); // on lui retire le consommable (1x)
                             end;
                         end;

                     magasinChoix('off', JOUEUR);
                     exit := True;
                     end;
          end;
        end;

        if actualIndex>(len) then           // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité
           actualIndex:=0;
        if actualIndex<0 then
           actualIndex:=len;
  end;
end;



end.


