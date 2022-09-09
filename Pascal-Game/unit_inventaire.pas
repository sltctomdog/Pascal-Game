unit unit_inventaire;

{$mode objfpc}{$H+}

interface

uses unit_GestionEcran, Keyboard, Sysutils, unit_Glossaire, unit_general;

procedure inventaireChoix(scene: String; var JOUEUR: stat_joueur); // lancer le choix d'une arme, d'une armure ou d'un consommable
procedure dessinerInventaire(var JOUEUR : stat_joueur);  // dessiner l'interface inventaire


implementation


procedure inventaireChoix(scene: String; var JOUEUR: stat_joueur);
var x, y, i, actualIndex, maxLength: Integer;
  K : TKeyEvent;
  armures: array of Armure;
  armes: array of Arme;
  consommables: array of Conso;
  a : Arme; p : Armure; c : Conso;
  exit : Boolean;
begin
  actualIndex:=0;
  armes := initArmes();
  armures := initArmures();              // charger les armes, armures, consommables
  consommables := initConsommables();

  x:= 56+(74-30);
  y:= 11;
  couleurFond(0);
  ecranclear(JOUEUR);
  couleurTexte(4);


  ecrireEnPosition(pos(51, y+3), stringOfChar('_', 148));
  ecrireEnPosition(pos(x, y), '  _____                      _        _          ');
  ecrireEnPosition(pos(x, y+1), ' |_   _|                    | |      (_)         ');
  ecrireEnPosition(pos(x, y+2), '   | |  _ ____   _____ _ __ | |_ __ _ _ _ __ ___ ');
  ecrireEnPosition(pos(x, y+3), '   | | | ''_ \ \ / / _ | ''_ \| __/ _` | | ''__/ _ \ ');
  ecrireEnPosition(pos(x, y+4), '  _| |_| | | \ V |  __| | | | || (_| | | | |  __/');
  ecrireEnPosition(pos(x, y+5), ' |_____|_| |_|\_/ \___|_| |_|\__\__,_|_|_|  \___|');

  x:= 64;
  y:= 20;
  couleurTexte(8);
  if scene='armes' then
     couleurTexte(12);
  ecrireEnPosition(pos(x, y), '   __ _ _ __ _ __ ___   ___  ___           ');
  ecrireEnPosition(pos(x, y+1), '  / _` | ''__| ''_ ` _ \ / _ \/ __|          ');
  ecrireEnPosition(pos(x, y+2), ' | (_| | |  | | | | | |  __/\__ \          ');
  ecrireEnPosition(pos(x, y+3), '  \__,_|_|  |_| |_| |_|\___||___/          ');

  x:= 59+88;
  y:= 20;
  couleurTexte(8);
  if scene='armures' then
     couleurTexte(12);
  ecrireEnPosition(pos(x, y), '   __ _ _ __ _ __ ___  _   _ _ __ ___  ___ ');
  ecrireEnPosition(pos(x, y+1), '  / _` | ''__| ''_ ` _ \| | | | ''__/ _ \/ __|');
  ecrireEnPosition(pos(x, y+2), ' | (_| | |  | | | | | | |_| | | |  __/\__ \');
  ecrireEnPosition(pos(x, y+3), '  \__,_|_|  |_| |_| |_|\__,_|_|  \___||___/');

  for i:= 0 to (length(JOUEUR.conso)+1) do
      ecrireEnPosition(pos(58+45+4,37+i), '                                     ');

  exit := False;
  while not exit do
  begin
       for i:=0 to length(JOUEUR.arme_possede)-1 do              // afficher les armes possédés
         begin
          a := armes[JOUEUR.arme_possede[i]];

          couleurTexte(8);
          if scene='armes' then                                  // si on est sur la selection d'armes, écrire le texte en blanc et non en gris
                   couleurTexte(15);
          if (i=actualIndex) and (scene='armes') then            // si on est sur la selection d'armes, surligner le choix en cours
                   couleurFond(4);
          ecrireEnPosition(pos(60,26+i), (i+1).toString+'. '+a.nom);
          couleurfond(0);
          if scene='armes' then
             couleurtexte(6);
          deplacerCurseur(pos(60+3+length(a.nom),26+i));
          write(' (+', a.attaqueSupplementaire,' DMG)');
         end;


       for i:=0 to length(JOUEUR.armure_possede)-1 do
         begin
            p := armures[JOUEUR.armure_possede[i]];

            couleurTexte(8);
            if scene='armures' then                             // si on est sur la selection d'armures, écrire le texte en blanc et non en gris
                couleurTexte(15);
            if (i=actualIndex) and (scene='armures') then       // si on est sur la selection d'armures, surligner le choix en cours
                    couleurFond(4);
            ecrireEnPosition(pos(60+88,26+i), (i+1).toString+'. '+p.nom);
            couleurfond(0);
            if scene='armures' then
                couleurTexte(6);
            deplacerCurseur(pos(60+88+3+length(p.nom),26+i));
            write(' (', p.resistance:3:2,' DEF)');
         end;
       for i:=0 to Length(JOUEUR.conso)-1 do
         begin
              c := consommables[JOUEUR.conso[i][0]];
              couleurTexte(8);
              if scene='consommables' then                      // si on est sur la selection de consommables, écrire le texte en blanc et non en gris
                 couleurTexte(15);
              couleurFond(0);
              if (i=actualIndex) and (scene='consommables') then   // si on est sur la selection de consommables, surligner le choix en cours
                 couleurFond(4);
              ecrireEnPosition(pos(58+45+4,37+i), (i+1).toString+'. '+c.nom);
              couleurtexte(8);
              couleurfond(0);
              if scene='consommables' then
                 couleurTexte(6);
              deplacerCurseur(pos(58+44+4+4+length(c.nom),37+i));
              write(' (+', c.value,' HP)');
              if scene='consommables' then
                 couleurTexte(10);
              ecrireenposition(pos(58+83,36),'nb');
              deplacercurseur(pos(58+83,37+i));
              write(JOUEUR.conso[i][1]);
              if JOUEUR.conso[i][1]<100 then
                 write(' ');
              if JOUEUR.conso[i][1]<10 then
                 write(' ');
         end;

        if not (scene='armures') and not (scene='armes') and not (scene='consommables') then   // si on est pas sur la sélection d'armures, d'armes ou de consommables, on s'arrête là
           exit := True;

        if not exit then                                                                       // sinon on commence la sélection de l'item
        begin
            deplacerCurseur(pos(0,0));
            K:=GetKeyEvent;
            K:=TranslateKeyEvent(K);
            case GetKeyEventCode(K) of
                 65319: actualIndex:=actualIndex+1;
                 65313: actualIndex:=actualIndex-1;
                 7181: begin
                       if scene='armes' then
                          JOUEUR.arme_equipe:= armes[JOUEUR.arme_possede[actualIndex]];       // équiper l'arme
                       if scene='armures' then
                          JOUEUR.armure_equipe:=armures[JOUEUR.armure_possede[actualIndex]];  // équiper l'armure
                       if scene='consommables' then
                          retirerConsommable(JOUEUR, actualIndex, True);                      // consommer le consommable
                       inventaireChoix('off',JOUEUR);                                         // on repasse tous les cadres en "gris"
                       ecranclear(JOUEUR);
                       exit := True;
                       end;

            end;
        end;



        if (scene='armes') then
           maxLength:=Length(JOUEUR.arme_possede)
        else if (scene='armures') then
           maxLength:=Length(JOUEUR.armure_possede)               // maximum de choix pour chaque scene
        else if (scene='consommables') then
           maxLength:=Length(JOUEUR.conso);

        if actualIndex>(maxLength-1) then                         // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité
           actualIndex:=0;
        if actualIndex<0 then
           actualIndex:=maxLength-1;
  end;
end;

procedure dessinerInventaire(var JOUEUR : stat_joueur);
var i, actualIndex : Integer;
  K : TKeyEvent;
  choice: array[0..3] of String;
  exit : Boolean;

begin
  InitKeyBoard;
  actualIndex:=0;

  dessinerCadreXY(58,25,58+45, 25+30, simple, 8, 0);            // Cadre Arme
  dessinerCadreXY(58+88,25,58+45+88, 25+30, simple, 8, 0);      // Cadre Armure
  dessinerCadreXY(58+45+2,36, 58+88-2, 55, simple, 8, 0);       // Cadre Consommables

  ecranclear(JOUEUR);

  choice[0] := '<   '#201'quiper une arme   >';
  choice[1] := '<  '#201'quiper une armure   >';
  choice[2] := '<     Consommables     >';
  choice[3] := '<        Quitter       >';


  inventaireChoix('off',JOUEUR);

  exit := False;
    while not exit do
    begin
      couleurTexte(15);
      for i:=0 to Length(choice)-1 do                            // Ecrire les différents choix du menu
      begin
          couleurFond(0);
          if i=actualIndex then                                  // si c'est le choix actuel, on le surligne
             couleurFond(4);
          ecrireEnPosition(pos(100+13, 26+i*2), choice[i])
      end;

      deplacerCurseur(pos(0,0));
      K:=GetKeyEvent;
      K:=TranslateKeyEvent(K);
      case GetKeyEventCode(K) of
           65319: actualIndex:=actualIndex+1;                    // flèche du haut : passer au choix suivant
           65313: actualIndex:=actualIndex-1;                    // flèche du bas : passer au choix précédent
           7181: begin                                           // touche entré
             couleurFond(12);
             ecrireEnPosition(pos(100+13, 26+actualIndex*2), choice[actualIndex]);
             if (actualIndex=0) and not (length(JOUEUR.arme_possede)=0) then      // si choix 0 : ouvrir la selection des armes
               inventaireChoix('armes',JOUEUR);
             if (actualIndex=1) and not (length(JOUEUR.armure_possede)=0) then    // si choix 1 : ouvrir la selection des armures
               inventaireChoix('armures',JOUEUR);
             if (actualIndex=2) and not (length(JOUEUR.conso)=0) then             // si choix 2 : ouvrir la selection des consommables
               inventaireChoix('consommables',JOUEUR);
             if actualIndex=3 then                                                // si choix 3 : Retour au menu
                exit := True;

             couleurFond(4);
             ecrireEnPosition(pos(100+13, 26+actualIndex*2), choice[actualIndex]);

             end;
      end;
      if actualIndex>(Length(choice)-1) then         // si le choix>nombre de choix, revenir au premier choix
         actualIndex:=0;
      if actualIndex<0 then                         // si le choix<0, revenir au dernier choix
         actualIndex:=Length(choice)-1;
    end;

end;

end.






