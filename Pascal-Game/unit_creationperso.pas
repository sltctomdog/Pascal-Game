unit unit_creationperso;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,unit_General,Keyboard,unit_glossaire, unit_GestionEcran;

procedure creationperso(var JOUEUR : stat_joueur);

implementation

procedure creationperso(var JOUEUR : stat_joueur);
var
  x, y, i, actualIndex : Integer;
  choice : array [0..5] of String;
  K : TKeyEvent;
  race: array of string;
  exit : Boolean;

begin

  //INITIALISATION

  actualIndex:=0;
  InitKeyBoard;
  JOUEUR:=initJoueur;
  race:=initRace();

  //GRAPISME

  effacerecran();
  dessinercadrejeu();
  dessinerCadreXY(110,22,139,24,simple,12,0);
  ecranclear(JOUEUR);

  couleurFond(0);
  x:=68;
  y:=13;
  CouleurTexte(4);
  ecrireEnPosition(pos(51, y+3), stringOfChar('_', 148));
  ecrireEnPosition(pos(x, y+0), '   _____       __       _   _                   _                                                                ');
  ecrireEnPosition(pos(x, y+1), '  / ____|     /_/      | | (_)                 | |                                                               ');
  ecrireEnPosition(pos(x, y+2), ' | |     _ __ ___  __ _| |_ _  ___  _ __     __| |_   _   _ __   ___ _ __ ___  ___  _ __  _ __   __ _  __ _  ___ ');
  ecrireEnPosition(pos(x, y+3), ' | |    | ''__/ _ \/ _` | __| |/ _ \| ''_ \   / _` | | | | | ''_ \ / _ \ ''__/ __|/ _ \| ''_ \| ''_ \ / _` |/ _` |/ _ \ ');
  ecrireEnPosition(pos(x, y+4), ' | |____| | |  __/ (_| | |_| | (_) | | | | | (_| | |_| | | |_) |  __/ |  \__ \ (_) | | | | | | | (_| | (_| |  __/');
  ecrireEnPosition(pos(x, y+5), '  \_____|_|  \___|\__,_|\__|_|\___/|_| |_|  \__,_|\__,_| | .__/ \___|_|  |___/\___/|_| |_|_| |_|\__,_|\__, |\___|');
  ecrireEnPosition(pos(x, y+6), '                                                         | |                                           __/ |     ');
  ecrireEnPosition(pos(x, y+7), '                                                         |_|                                          |___/      ');

  CouleurTexte(15);
  deplacerCurseur(pos(111,23));
  write('Veuillez choisir votre H'#130'ros');
  CouleurTexte(12);
  deplacerCurseur(pos(0,0));

  //TOUS NOS CHOIX DE RACE

  choice[0]:='<        MACARON        >';
  choice[1]:='<       GROLLANDE       >';
  choice[2]:='<        SARZOKY        >';
  choice[3]:='<        LESTYLO        >';
  choice[4]:='<       LAISSELLE       >';
  choice[5]:='<       ROBLOCHON       >';

  exit := False;
  while not exit do
    begin
      couleurTexte(15);
      for i:=0 to Length(choice)-1 do                                  //On écrit tous les choix
      begin
          couleurFond(0);
          if i=actualIndex then                                       //Surligné le choix selectionné
             couleurFond(4);
          ecrireEnPosition(pos(100+13, 27+i*3), choice[i]);
      end;

      deplacerCurseur(pos(0,0));

      //TOUCHE CLAVIER

      K:=GetKeyEvent;
      K:=TranslateKeyEvent(K);
      case GetKeyEventCode(K) of
           65319: actualIndex:=actualIndex+1;
           65313: actualIndex:=actualIndex-1;
           7181: begin
             JOUEUR.race:=race[actualIndex];
             couleurFond(0);
             ecranclear(JOUEUR);
             exit := True;
             end
      end;

      if actualIndex>(Length(choice)-1) then        // si le choix dépasse le nbr de choix ou 0, on repasse à l'autre extrémité
         actualIndex:=0;
      if actualIndex<0 then
         actualIndex:=Length(choice)-1;
    end;

  ecrireEnPosition(pos(60,50),'Quel surnom voulez-vous donnez '#224' votre H'#233'ros ?');
  continuer();
  ecrireEnPosition(pos(60,52),'Mon H'#233'ros se surnomme : ');
  readln(JOUEUR.nom);                                                 //On donne un surnom a notre personnage
  ecranclear(JOUEUR);
  couleurTexte(14);
  ecrireEnPosition(pos(121,55),'TR'#200'S BIEN !');
  ecrireEnPosition(pos(105,57),'Vous commencez donc votre aventure avec '+JOUEUR.nom);
  continuer();
end;
end.

