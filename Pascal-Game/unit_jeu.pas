unit unit_jeu;

{$mode objfpc}{$H+}

interface

uses unit_GestionEcran, unit_Glossaire, Keyboard, unit_combat, unit_inventaire,unit_interface, unit_General, unit_creationperso, unit_shop, unit_histoires;

procedure main();

implementation

procedure main();
var scenes : Liste_Scene;
  sceneSuivante : Integer;
  choixRetour : Choix;
  armes : array of Arme;
  armures : array of Armure;

begin
  //INITIALISATIOn
  armes := initArmes();
  armures := initArmures();
  ENNEMY:=initEnnemies();
  JOUEUR:=initJOUEUR();
  changerTailleConsole(200,60);
  menuInitial();
  creationperso(JOUEUR);

  donnerArme(JOUEUR, 0);
  JOUEUR.arme_equipe := armes[0];

  JOUEUR.armure_equipe := armures[0];

  donnerConsommable(JOUEUR, 0, 3);
  donnerConsommable(JOUEUR, 1, 2);
  donnerConsommable(JOUEUR, 2, 1);

  donnerHeals(JOUEUR, 0);
  donnerMoves(JOUEUR, 0);
  donnerHeals(JOUEUR, 1);

  scenes := chargerHistoires();
  sceneSuivante := 0;

  while true do
  begin
     InitKeyBoard;
     afficherScene(scenes[sceneSuivante]);
     ecranclear(JOUEUR);
     choixRetour := retournerChoix(scenes[sceneSuivante], sceneSuivante);

     if (choixRetour.targetType=type_combat) or (choixRetour.targetType=type_inventaire) or (choixRetour.targetType=type_magasin) then
        clearScene();

     case sceneSuivante of
          4: begin
                  donnerArme(JOUEUR, 1);
                  donnerMoves(JOUEUR, 1);
             end;
          10: donnerArme(JOUEUR, 2);
          11: donnerArmure(JOUEUR,1);
          12: begin
                   JOUEUR.PV:=JOUEUR.PV-15;
                   donnerArme(JOUEUR, 2);
              end;
          13: donnerArmure(JOUEUR,1);
          14: begin
                   donnerConsommable(JOUEUR, 3, 3);
                   donnerMoves(JOUEUR,2);
              end;
          17: donnerArmure(JOUEUR,2);

     end;

     case choixRetour.targetType of
          type_combat: combat(ENNEMY[choixRetour.parametre], JOUEUR);
          type_inventaire: dessinerInventaire(JOUEUR);
          type_magasin: dessinerMagasin(JOUEUR);
          type_mort: game_over();
     end;
     sceneSuivante:=choixRetour.sceneRetour;
  end;

end;

end.

