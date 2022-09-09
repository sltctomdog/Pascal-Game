unit unit_combat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unit_Glossaire, Keyboard, unit_GestionEcran, unit_inventaire,unit_interface, unit_general;


procedure combat(var ENNEMY : Ennemie; var joueur : Stat_joueur);      //Tous le déroulement du combat
procedure barrevie(ENNEMY : Ennemie; joueur : Stat_joueur);            //Afficher la barre de vie
function choix_sort(scene: String; JOUEUR : stat_joueur): String;      //Choisir le sort
procedure logo_fight();                                                //Afficher un logo
procedure game_over();                                                 //Afficher la fenetre game over qui quite pascal
procedure win(ENNEMY : ennemie;JOUEUR : stat_joueur);                  //Afficher la fenetre quand on gagne
function degatAleatoire(min, max: Integer): Integer;                   //calcule des degats entre 2 valeurs
function critique():Integer;                                           //fonction aléatoire qui a un pourcentage de chance de faire un critique ou non
procedure logo_tour(tour : Integer);                                   //Afficher un logo
procedure nb_tour(tour : Integer);                                     //calcul du nombre de tour pour affiche le nombre de tour
procedure afficher_chiffre(chiffre,x,y : Integer);                     //Afficher le nombre de tour a coté du logo_tour

implementation


procedure combat(var ENNEMY : Ennemie; var JOUEUR : Stat_joueur);

var
  i, ko, tour, coup_crit : Integer;
  sort : String;
  moves : Moveset;
  heals : Healset;
  degatEnnemie, degatJoueur, HealJoueur : Integer;
  K : TKeyEvent;
  exit : Boolean;

begin
  //INITIALISATION

  moves:=initMoveset();
  heals:=initHealset();
  JOUEUR.ATK:=JOUEUR.arme_equipe.attaqueSupplementaire;
  ko:=0;
  tour:=0;


  //GRAPHISME

  effacerEcran();
  dessinercadrejeu();
  dessinerCadreXY(58,41,102,55,simple,4,0); //cadre de l'historique du tour
  ecrireenposition(pos(59,48),'-------------------------------------------');
  logo_tour(tour);
  ecranclear(JOUEUR);
  couleurTexte(15);
  couleurFond(0);
  logo_fight();


  //TANT QUE LE JOUEUR OU L'ADVERSAIRE N'EST PAS KO
  exit := False;
  While not exit do
  begin

       tour:=tour+1;
       nb_tour(tour);
       barrevie(ENNEMY, JOUEUR);
       sort := choix_sort('home', JOUEUR);  //choix du sort
       coup_crit:=critique();     //calcul du coup critique

       for i:=0 to length(moves)-1 do
           if sort=moves[i].nom then     //Si on choisit le tel attaque alors ca affiche différentes caracteristique
             begin
                  degatJoueur := (degatAleatoire(moves[i].degat_min, moves[i].degat_max)+JOUEUR.arme_equipe.attaqueSupplementaire)*coup_crit;
                  ENNEMY.PV:=ENNEMY.PV-degatJoueur;

                  deplacerCurseur(pos(59,43));
                  write('                                        ');
                  deplacerCurseur(pos(59,43));
                  couleurtexte(15);
                  write(' Vous attaquez avec ');
                  couleurtexte(11);
                  write(moves[i].nom);
                  deplacercurseur(pos(59,45));
                  write('                                        ');
                  deplacercurseur(pos(59,45));
                  couleurTexte(15);
                  write('  Vous infligez ');
                  couleurTexte(12);
                  write(degatJoueur);
                  couleurTexte(15);
                  write(' d'+chr(233)+'gats  ');
                  if coup_crit=2 then
                  begin
                       couleurTexte(14);
                       write('*CRITIQUE!*');
                  end;
             end;

       for i:=0 to length(heals)-1 do
           if sort=heals[i].nom then    //Si on choisit tel soin alors ca affiche différentes caracteristique
           begin
                HealJoueur := degatAleatoire(heals[i].degat_min, heals[i].degat_max);
                JOUEUR.PV:=JOUEUR.PV+HealJoueur;
                if JOUEUR.PV>JOUEUR.PV_MAX then
                   JOUEUR.PV:=JOUEUR.PV_MAX;

                deplacerCurseur(pos(59,43));
                write('                                        ');
                deplacerCurseur(pos(59,43));
                couleurtexte(15);
                write(' Vous utilisez ');
                couleurtexte(11);
                write(heals[i].nom);
                deplacercurseur(pos(59,45));
                write('                                        ');
                deplacercurseur(pos(59,45));
                couleurTexte(15);
                write('  Vous vous soignez de ');
                couleurTexte(10);
                write(HealJoueur);
                couleurTexte(15);
                write(' PV  ');
           end;

       //SI L'ADVERSAIRE EST KO ALORS ON gagne
       if (ENNEMY.PV<1) then
       begin
          JOUEUR.PO:=JOUEUR.PO+ENNEMY.PO;
          win(ENNEMY,JOUEUR);
          exit:= True;
       end

       //SINON S'IL N'EST PAS KO ALORS L'ADVERSAIRE ATTAQUE
       else
       begin
            barrevie(ENNEMY, JOUEUR);
            couleurTexte(15);
            couleurFond(4);
            ecrireEnPosition(pos(80+21,30),'<     C''est au tour de l''adversaire d''attaquer     >');
            deplacerCurseur(pos(0,0));
            readln;
            couleurFond(0);
            ecrireEnPosition(pos(80+21,30),'                                                       ');

            //Calcul des dégâts

            coup_crit:=critique();
            degatEnnemie := degatAleatoire(ENNEMY.degat_min, ENNEMY.degat_max)*coup_crit;
            degatEnnemie :=degatEnnemie - round(degatEnnemie*JOUEUR.armure_equipe.resistance);
            JOUEUR.PV:=JOUEUR.PV-degatEnnemie;
            ecranclear(JOUEUR);

            //Affichage lorsque l'adversaire attaque

            deplacercurseur(pos(59,50));
            write(' L''adversaire utilise ');
            couleurTexte(11);
            write(ENNEMY.nomAttaque);
            deplacercurseur(pos(59,52));
            write('                                        ');
            deplacercurseur(pos(59,52));
            couleurTexte(15);
            write('  Il vous inflige ');
            couleurTexte(12);
            write(degatEnnemie);
            couleurTexte(15);
            write(' d'+chr(233)+'gats  ');
            if coup_crit=2 then
            begin
                 couleurTexte(14);
                 write('*CRITIQUE!*');
            end;



            //SI LE JOUEUR N'A PLUS DE VIE ALORS LE JOUEUR PERD LE COMBAT
            if (JOUEUR.PV<1) then
            begin
                 game_over();
            end;

       end;
  end;

end;
procedure barrevie(ENNEMY : Ennemie; JOUEUR : stat_joueur);
 var
   i : Integer;
begin

  //JOUEUR


  //AFFICHAGE DES PVs


  dessinerCadreXY(80,14, 102, 17, simple, 7, 0);
  deplacerCurseurXY(81,14);
  write(JOUEUR.PV, '/',JOUEUR.PV_MAX, 'PV');


  //Affichage des noms


  deplacerCurseurXY(81,18);
  write(JOUEUR.nom);
  deplacerCurseurXY(146,18);
  write(ENNEMY.nom);

  //COULEUR BARRE DE VIE JOUEUR


  if(JOUEUR.PV<=JOUEUR.PV_MAX/2) then
           couleurTexte(14);

  if(JOUEUR.PV<=JOUEUR.PV_MAX/4) then //Quand le joueur a plus beaucoup de vie alors la barre de vie devient rouge
           couleurTexte(4);

  if(JOUEUR.PV>JOUEUR.PV_MAX/2) then
           couleurTexte(2);


  //CONSTRUCTION DE LA BARRE DE VIE


  for i:=0 to Round(JOUEUR.PV*100/JOUEUR.PV_MAX/5) do
      begin
           deplacerCurseurXY(81+i,15);
           write(#178);                     //Je l'ai marqué deux fois pour que la barre de vie soit plus épaisse
           deplacerCurseurXY(81+i,16);
           write(#178);
      end;

  for i:=0 to Round((JOUEUR.PV_MAX-JOUEUR.PV)*100/JOUEUR.PV_MAX/5) do
      begin
      deplacerCurseurXY(81+i+Round(JOUEUR.PV*100/JOUEUR.PV_MAX/5),15);
      write(#176);
      deplacerCurseurXY(81+i+Round(JOUEUR.PV*100/JOUEUR.PV_MAX/5),16);
      write(#176);
      end;

  if (JOUEUR.PV_MAX=JOUEUR.PV) then
    begin
    deplacerCurseurXY(81+20,15);
    write(#178);
    deplacerCurseurXY(81+20,16);
    write(#178);
    end;


  //ENNEMIE


  //AFFICHAGE DES PVs


  dessinerCadreXY(145,14, 167, 17, simple, 7, 0);
  deplacerCurseurXY(146,14);
  write(ENNEMY.PV, '/',ENNEMY.PV_MAX, 'PV');


  //COULEUR BARRE DE VIE ADVERSAIRE


  if(ENNEMY.PV<=ENNEMY.PV_MAX/2) then
           couleurTexte(14);

  if(ENNEMY.PV<=ENNEMY.PV_MAX/4) then
           couleurTexte(4);

  if(ENNEMY.PV>ENNEMY.PV_MAX/2) then  //Quand le joueur a plus beaucoup de vie alors la barre de vie devient rouge
           couleurTexte(2);


  //CONSTRUCTION DE LA BARRE DE VIE


  for i:=0 to Round(ENNEMY.PV*100/ENNEMY.PV_MAX/5) do
      begin
      deplacerCurseurXY(146+i,15);
      write(#178);
      deplacerCurseurXY(146+i,16);
      write(#178);
      end;

  for i:=0 to Round((ENNEMY.PV_MAX-ENNEMY.PV)*100/ENNEMY.PV_MAX/5) do
      begin
      deplacerCurseurXY(146+i+Round(ENNEMY.PV*100/ENNEMY.PV_MAX/5),15);
      write(#176);
      deplacerCurseurXY(146+i+Round(ENNEMY.PV*100/ENNEMY.PV_MAX/5),16);
      write(#176);
      end;

  if (ENNEMY.PV_MAX=ENNEMY.PV) then
    begin
    deplacerCurseurXY(146+20,15);
    write(#178);
    deplacerCurseurXY(146+20,16);
    write(#178);
    end;

end;
function choix_sort(scene: String; JOUEUR : stat_joueur): String;


 var i, actualIndex, maxLength: Integer;
   K : TKeyEvent;
   exit: Boolean;
   choice: array[0..1] of String;
   moves : Moveset;
   heals : Healset;
 begin
   InitKeyBoard;
   actualIndex:=0;
   moves:=initMoveset();
   heals:=initHealset();

   //TOUS LES CHOIX

   choice[0] := '<       Attaquer       >';
   choice[1] := '<      Se Soigner      >';

   dessinerCadreXY(58+88,35,58+45+88, 25+30, simple, 8, 0);

   exit := False;
   while not exit do
   begin
        if scene='moveset' then
          begin
            couleurTexte(15);
            for i:=0 to Length(JOUEUR.moves)-1 do
              begin
               couleurFond(0);
               if (i=actualIndex) and (scene='moveset') then                     //Curseur de séléction
                  couleurFond(4);
               ecrireEnPosition(pos(60+88,36+i), (i+1).toString+'. '+moves[JOUEUR.moves[i]].nom);
               deplacerCurseur(pos(60+88+3+length(moves[JOUEUR.moves[i]].nom),36+i));
               couleurTexte(6);
               write(' (', moves[JOUEUR.moves[i]].degat_min+JOUEUR.arme_equipe.attaqueSupplementaire, '-', moves[JOUEUR.moves[i]].degat_max+JOUEUR.arme_equipe.attaqueSupplementaire, ')');
               couleurTexte(15);

              end;
          end;

        if scene='healset' then
        begin
           couleurTexte(15);
           for i:=0 to Length(JOUEUR.heals)-1 do
             begin
              couleurFond(0);
              if (i=actualIndex) and (scene='healset') then                      //Curseur de séléction
                 couleurFond(4);
              ecrireEnPosition(pos(60+88,36+i), (i+1).toString+'. '+heals[JOUEUR.heals[i]].nom);
              deplacerCurseur(pos(60+88+3+length(heals[JOUEUR.heals[i]].nom),36+i));
              couleurTexte(6);
              write(' (', heals[JOUEUR.heals[i]].degat_min, '-', heals[JOUEUR.heals[i]].degat_max, ')');
              couleurTexte(15);
             end;
         end;

         if not (scene='healset') and not (scene='moveset') then
            exit:=True;

         //TOUCHE CLAVIER

         if not exit then
           begin
             deplacerCurseur(pos(0,0));
             K:=GetKeyEvent;
             K:=TranslateKeyEvent(K);
             case GetKeyEventCode(K) of
                  65319: actualIndex:=actualIndex+1;
                  65313: actualIndex:=actualIndex-1;
                  7181: begin
                        choix_sort('clear',JOUEUR);
                        if (scene='healset') then
                          choix_sort :=heals[JOUEUR.heals[actualIndex]].nom;
                        if (scene='moveset')then
                          choix_sort :=moves[JOUEUR.moves[actualIndex]].nom;
                        exit:=True;
                        end;
             end;
         end;

         if (scene='moveset') then
            maxLength:=Length(JOUEUR.moves)
         else if (scene='healset') then
            maxLength:=Length(JOUEUR.heals);

         // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité

         if actualIndex>(maxLength-1) then
            actualIndex:=0;
         if actualIndex<0 then
            actualIndex:=maxLength-1;
   end;

   exit:= False;

   //Si on a pas selectionner d'attaque ou de soin alors on affiche pss les attaques et soins

   if scene='home' then
     while not exit do
     begin
       couleurTexte(15);
       for i:=0 to Length(choice)-1 do
       begin
           couleurFond(0);
           if i=actualIndex then
              couleurFond(4);
           ecrireEnPosition(pos(100+13, 42+i*2), choice[i]);
       end;

       //TOUCHE CLAVIER

       deplacerCurseur(pos(0,0));
       K:=GetKeyEvent;
       K:=TranslateKeyEvent(K);
       case GetKeyEventCode(K) of
            65319: actualIndex:=actualIndex+1;
            65313: actualIndex:=actualIndex-1;
            7181: begin
              if actualIndex=0 then
                begin
                choix_sort := choix_sort('moveset',JOUEUR);
                  for i:=0 to Length(choice)-1 do
                  begin
                      couleurFond(0);
                      ecrireEnPosition(pos(100+13, 42+i*2), choice[i]);
                  end;
                exit:=True;
                end;
              if actualIndex=1 then
                begin;
                choix_sort := choix_sort('healset',JOUEUR);
                  for i:=0 to Length(choice)-1 do
                  begin
                      couleurFond(0);
                      ecrireEnPosition(pos(100+13, 42+i*2), choice[i]);
                  end;
                exit:=True;
                end;
              end;
       end;

       // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité

       if actualIndex>(Length(choice)-1) then
          actualIndex:=0;
       if actualIndex<0 then
          actualIndex:=(Length(choice)-1);
     end;

 end;
procedure logo_fight();
var
  x,y : Integer;
begin

  x:=110;
  y:=11;
  ecrireEnPosition(pos(x, y),'   |\                     /)');
  ecrireEnPosition(pos(x, y+1),' /\_\\__               (_//');
  ecrireEnPosition(pos(x, y+2),'|   `>\-`     _._       //`)');
  ecrireEnPosition(pos(x, y+3),' \ /` \\  _.-`:::`-._  //');
  ecrireEnPosition(pos(x,y+4),'  `    \|`    :::    `|/');
  ecrireEnPosition(pos(x,y+5),'        |     :::     |');
  ecrireEnPosition(pos(x,y+6),'        |.....:::.....|');
  ecrireEnPosition(pos(x,y+7),'        |:::::::::::::|');
  ecrireEnPosition(pos(x,y+8),'        |     :::     |');
  ecrireEnPosition(pos(x,y+9),'        |     :::     | ');
  ecrireEnPosition(pos(x,y+10),'        \     :::     /');
  ecrireEnPosition(pos(x,y+11),'         \    :::    /');
  ecrireEnPosition(pos(x,y+12),'          `-. ::: .-'#39);
  ecrireEnPosition(pos(x,y+13),'           //`:::`\\');
  ecrireEnPosition(pos(x,y+14),'          //   '#39'   \\');
  ecrireEnPosition(pos(x,y+15),'         |/         \\');


end;
procedure game_over();
var
  x,y : Integer;
begin
  effacerEcran();

  x:=55;
  y:=21;
  couleurTexte(15);

  ecrireEnPosition(pos(x,y),' $$$$$$\');
  ecrireEnPosition(pos(x,y+1),'$$  __$$\ ');
  ecrireEnPosition(pos(x,y+2),'$$ /  \__| $$$$$$\  $$$$$$\$$$$\   $$$$$$\         $$$$$$\ $$\    $$\  $$$$$$\   $$$$$$\ ');
  ecrireEnPosition(pos(x,y+3),'$$ |$$$$\  \____$$\ $$  _$$  _$$\ $$  __$$\       $$  __$$\\$$\  $$  |$$  __$$\ $$  __$$\ ');
  ecrireEnPosition(pos(x,y+4),'$$ |\_$$ | $$$$$$$ |$$ / $$ / $$ |$$$$$$$$ |      $$ /  $$ |\$$\$$  / $$$$$$$$ |$$ |  \__| ');
  ecrireEnPosition(pos(x,y+5),'$$ |  $$ |$$  __$$ |$$ | $$ | $$ |$$   ____|      $$ |  $$ | \$$$  /  $$   ____|$$ |       ');
  ecrireEnPosition(pos(x,y+6),'\$$$$$$  |\$$$$$$$ |$$ | $$ | $$ |\$$$$$$$\       \$$$$$$  |  \$  /   \$$$$$$$\ $$ |      ');
  ecrireEnPosition(pos(x,y+7),' \______/  \_______|\__| \__| \__| \_______|       \______/    \_/     \_______|\__|      ');
  continuer();
  halt(1);     //on ferme l'executable

end;
procedure win(ENNEMY : ennemie;JOUEUR : stat_joueur);
var
  x,y : Integer;

begin
  effacerEcran();
  changerTailleConsole(200,60);
  dessinerCadreXY(0,1, 199, 9, simple, 7, 0);
  dessinerCadreXY(0,10, 49, 59, double, 7, 0);
  dessinerCadreXY(50,10,199, 59, double, 7, 0);
  ecranclear(JOUEUR);

  couleurTexte(10);
  logo_fight();


  x:=89;
  y:=30;

  ecrireEnPosition(pos(x, y+0),'  $$\     $$\  $$$$$$\  $$\   $$\       $$\      $$\ $$$$$$\ $$\   $$\  ');
  ecrireEnPosition(pos(x, y+1),'  \$$\   $$  |$$  __$$\ $$ |  $$ |      $$ | $\  $$ |\_$$  _|$$$\  $$ | ');
  ecrireEnPosition(pos(x, y+2),'   \$$\ $$  / $$ /  $$ |$$ |  $$ |      $$ |$$$\ $$ |  $$ |  $$$$\ $$ | ');
  ecrireEnPosition(pos(x, y+3),'    \$$$$  /  $$ |  $$ |$$ |  $$ |      $$ $$ $$\$$ |  $$ |  $$ $$\$$ | ');
  ecrireEnPosition(pos(x, y+4),'     \$$  /   $$ |  $$ |$$ |  $$ |      $$$$  _$$$$ |  $$ |  $$ \$$$$ | ');
  ecrireEnPosition(pos(x, y+5),'      $$ |    $$ |  $$ |$$ |  $$ |      $$$  / \$$$ |  $$ |  $$ |\$$$ | ');
  ecrireEnPosition(pos(x, y+6),'      $$ |     $$$$$$  |\$$$$$$  |      $$  /   \$$ |$$$$$$\ $$ | \$$ | ');
  ecrireEnPosition(pos(x, y+7),'      \__|     \______/  \______/       \__/     \__|\______|\__|  \__| ');

  couleurTexte(14);
  deplacerCurseur(pos(90,40));
  deplacerCurseur(pos(53+74-round((length(ENNEMY.nom)+2+16+2+3)/2),40));                                     //afficher le nombre d'argent que le monstre rapporte
  write(#39,ENNEMY.nom,#39 ,' vous rapporte +', ENNEMY.PO,' PO');
  continuer();
end;
function degatAleatoire(min, max: Integer): Integer;
begin
  degatAleatoire := random(max-min) + min;
end;
function critique():Integer;
var
   chance_critique : Integer;

begin
  critique:=1;
  chance_critique:=random(10);
  if chance_critique=1 then
    critique:=2;
end;
procedure logo_tour(tour : Integer);
var
   x,y : Integer;
begin

  x:=58;
  y:=35;
  ecrireenposition(pos(x,y),'______                      _   ');
  ecrireenposition(pos(x,y+1),'| ___ \                    | |  ');
  ecrireenposition(pos(x,y+2),'| |_/ /___  _   _ _ __   __| |  ');
  ecrireenposition(pos(x,y+3),'|    // _ \| | | | ''_ \ / _` |  ');
  ecrireenposition(pos(x,y+4),'| |\ \ (_) | |_| | | | | (_| |  ');
  ecrireenposition(pos(x,y+5),'\_| \_\___/ \__,_|_| |_|\__,_|  ');


end;
procedure nb_tour(tour : Integer);
var
  premierchiffre : Integer;
  secondchiffre: Integer;
begin
  premierchiffre := tour div 10;
  secondchiffre := tour mod 10;
  couleurtexte(random(14)+1);
  afficher_chiffre(premierchiffre,58+32,41-4);
  afficher_chiffre(secondchiffre,58+32+7,41-4);


end;
procedure afficher_chiffre(chiffre,x,y : Integer);

begin

  ecrireEnPosition(pos(x,y+0),'      ');
  ecrireEnPosition(pos(x,y+1),'      ');
  ecrireEnPosition(pos(x,y+2),'      ');
  ecrireEnPosition(pos(x,y+3),'      ');
  case chiffre of
       0 :
         begin
           ecrireEnPosition(pos(x,y+0),'  __  ');
           ecrireEnPosition(pos(x,y+1),' /  \ ');
           ecrireEnPosition(pos(x,y+2),'| () |');
           ecrireEnPosition(pos(x,y+3),' \__/ ');
         end;

       1 :
         begin
           ecrireEnPosition(pos(x,y+0),'  _ ');
           ecrireEnPosition(pos(x,y+1),' / |');
           ecrireEnPosition(pos(x,y+2),' | |');
           ecrireEnPosition(pos(x,y+3),' |_|');
         end;

       2 :
         begin
           ecrireEnPosition(pos(x,y+0),' ___ ');
           ecrireEnPosition(pos(x,y+1),'|_  )');
           ecrireEnPosition(pos(x,y+2),' / / ');
           ecrireEnPosition(pos(x,y+3),'/___|');
         end;

       3 :
         begin
           ecrireEnPosition(pos(x,y+0),' ____');
           ecrireEnPosition(pos(x,y+1),'|__ /');
           ecrireEnPosition(pos(x,y+2),' |_ \');
           ecrireEnPosition(pos(x,y+3),'|___/');
         end;

       4 :
         begin
           ecrireEnPosition(pos(x,y+0),' _ _  ');
           ecrireEnPosition(pos(x,y+1),'| | | ');
           ecrireEnPosition(pos(x,y+2),'|_  _|');
           ecrireEnPosition(pos(x,y+3),'  |_| ');
         end;

       5 :
         begin
           ecrireEnPosition(pos(x,y+0),' ___ ');
           ecrireEnPosition(pos(x,y+1),'| __|');
           ecrireEnPosition(pos(x,y+2),'|__ \');
           ecrireEnPosition(pos(x,y+3),'|___/');
         end;

       6 :
         begin
           ecrireEnPosition(pos(x,y+0),'  __ ');
           ecrireEnPosition(pos(x,y+1),' / / ');
           ecrireEnPosition(pos(x,y+2),'/ _ \');
           ecrireEnPosition(pos(x,y+3),'\___/');
         end;

       7 :
         begin
           ecrireEnPosition(pos(x,y+0),' ____ ');
           ecrireEnPosition(pos(x,y+1),'|__  |');
           ecrireEnPosition(pos(x,y+2),'  / / ');
           ecrireEnPosition(pos(x,y+3),' /_/  ');
         end;

       8 :
         begin
           ecrireEnPosition(pos(x,y+0),' ___ ');
           ecrireEnPosition(pos(x,y+1),'( _ )');
           ecrireEnPosition(pos(x,y+2),'/ _ \');
           ecrireEnPosition(pos(x,y+3),'\___/');
         end;

       9 :
         begin
           ecrireEnPosition(pos(x,y+0),' ___ ');
           ecrireEnPosition(pos(x,y+1),'/ _ \');
           ecrireEnPosition(pos(x,y+2),'\_, /');
           ecrireEnPosition(pos(x,y+3),' /_/ ');
         end;


       end;

end;

end.


