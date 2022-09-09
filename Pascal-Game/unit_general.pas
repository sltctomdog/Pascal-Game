unit unit_general;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,unit_GestionEcran, unit_glossaire, Keyboard;

type
   lieu = (Blancherive,chateau,Donjon,village1,village2,foret);
  targetsType = (type_scene,type_combat,type_inventaire,type_magasin, type_mort);
  alignType = (gauche, centre, droite);
  Choix = record
     texte : String;
     targetType : targetsType;
     parametre : Integer;
     sceneRetour : Integer;
  end;
  Texte = record
     txt : String;
     cT : Integer;
     cF : Integer;
     align : alignType;
  end;
  Scene = record
     textes : array[0..30] of Texte;
     liste_choix : array of Choix;
  end;
  Liste_Scene = array of Scene;
var
  JOUEUR : Stat_joueur;
  ENNEMY : Ennemies;
  place : string;

function pos(posX,posY : Integer): Coordonnees;
procedure ecranclear(var JOUEUR : stat_joueur);
procedure dessinercadrejeu();
procedure continuer();
procedure donnerArme(var JOUEUR: stat_joueur; idArme: Integer);
procedure donnerArmure(var JOUEUR: stat_joueur; idArmure: Integer);
procedure donnerConsommable(var JOUEUR: stat_joueur; idConso, quantity: Integer);
procedure retirerConsommable(var JOUEUR: stat_joueur; index: Integer; soin: Boolean);
procedure donnerMoves(var JOUEUR: stat_joueur; idMoves: Integer);
procedure donnerHeals(var JOUEUR: stat_joueur; idHeals: Integer);
implementation


function pos(posX,posY : Integer): Coordonnees;
var position: Coordonnees;
begin
  position.x := posX;
  position.y := posY;
  pos := position;
end;

procedure ecranclear(var JOUEUR : stat_joueur);

begin
     couleurTexte(7);
    ecrireEnPosition(pos(161,2),'Points de vie : ');
    deplacerCurseur(pos(161+16,2));

    if(JOUEUR.PV<=JOUEUR.PV_MAX/2) then
             couleurTexte(14);

    if(JOUEUR.PV<=JOUEUR.PV_MAX/4) then
             couleurTexte(4);

    if(JOUEUR.PV>JOUEUR.PV_MAX/2) then
             couleurTexte(2);
    write('                     ');
    deplacerCurseur(pos(161+16,2));
    write(JOUEUR.PV,' / ',JOUEUR.PV_MAX,' PV');
    couleurTexte(7);

    ecrireEnPosition(pos(164,4),'Piece d''or : ');
    deplacerCurseur(pos(164+13,4));
    couleurTexte(14);
    write('      ');
    deplacerCurseur(pos(164+13,4));
    write(JOUEUR.PO,' PO');
    couleurTexte(7);

    ecrireEnPosition(pos(3,2),'Surnom : ');
    deplacerCurseur(pos(3+9,2));
    couleurTexte(15);
    write('             ');
    deplacerCurseur(pos(3+9,2));
    write(JOUEUR.nom);
    couleurTexte(7);

    ecrireEnPosition(pos(3,1),'H'#233'ros : ');
    deplacerCurseur(pos(3+8,1));
    couleurTexte(15);
    write('              ');
    deplacerCurseur(pos(3+8,1));
    write(JOUEUR.race);
    couleurTexte(7);

    ecrireEnPosition(pos(3,4),'Arme : ');
    deplacerCurseur(pos(3+7,4));
    couleurTexte(11);
    write('                       ');
    deplacerCurseur(pos(3+7,4));
    write(JOUEUR.arme_equipe.nom);
    couleurTexte(7);

    ecrireEnPosition(pos(3,5),'Armure : ');
    deplacerCurseur(pos(3+9,5));
    couleurTexte(11);
    write('                       ');
    deplacerCurseur(pos(3+9,5));
    write(JOUEUR.armure_equipe.nom);
    couleurTexte(15);

    ecrireEnPosition(pos(60,9),'LA VI REPUBLIQUE : Province Bordeciel');
    couleurTexte(7);
end;
procedure dessinercadrejeu();
var
  x,y : Integer;

begin

  dessinerCadreXY(0,1, 199, 9, simple, 7, 0);
  dessinerCadreXY(0,10, 49, 59, double, 7, 0);
  dessinerCadreXY(50,10,199, 59, double, 7, 0);
end;
procedure continuer();
var
  K: TKeyEvent;
begin
  couleurfond(15);
  couleurTexte(0);
  ecrireEnPosition(pos(185,56),' CONTINUER ');
  deplacerCurseur(pos(0,0));
  couleurfond(0);
  couleurTexte(15);
  initKeyboard;
  repeat
    K:=GetKeyEvent;
    K:=TranslateKeyEvent(K);
  until (GetKeyEventChar(K)<>' ');
  DoneKeyboard;
  ecrireEnPosition(pos(185,56),'           ');
end;

procedure donnerArme(var JOUEUR: stat_joueur; idArme: Integer);
var exist: Boolean;
    i : Integer;
begin
  exist:=False;
  for i:=0 to length(JOUEUR.arme_possede)-1 do
      if JOUEUR.arme_possede[i]=idArme then
         exist:=True;
  if not exist then
     begin
          SetLength(JOUEUR.arme_possede, length(JOUEUR.arme_possede)+1);
          JOUEUR.arme_possede[length(JOUEUR.arme_possede)-1] := idArme;
     end;
end;
procedure donnerArmure(var JOUEUR: stat_joueur; idArmure: Integer);
var exist: Boolean;
    i : Integer;
begin
  exist:=False;
  for i:=0 to length(JOUEUR.armure_possede)-1 do
      if JOUEUR.armure_possede[i]=idArmure then
         exist:=True;
  if not exist then
     begin
          SetLength(JOUEUR.armure_possede, length(JOUEUR.armure_possede)+1);
          JOUEUR.armure_possede[length(JOUEUR.armure_possede)-1] := idArmure;
     end;
end;

procedure donnerMoves(var JOUEUR: stat_joueur; idMoves: Integer);
var exist: Boolean;
    i : Integer;
begin
  exist:=False;
  for i:=0 to length(JOUEUR.moves)-1 do
      if JOUEUR.moves[i]=idMoves then
         exist:=True;
  if not exist then
     begin
          SetLength(JOUEUR.moves, length(JOUEUR.moves)+1);
          JOUEUR.moves[length(JOUEUR.moves)-1] := idMoves;
     end;
end;

procedure donnerHeals(var JOUEUR: stat_joueur; idHeals: Integer);
var exist: Boolean;
    i : Integer;
begin
  exist:=False;
  for i:=0 to length(JOUEUR.heals)-1 do
      if JOUEUR.heals[i]=idHeals then
         exist:=True;
  if not exist then
     begin
          SetLength(JOUEUR.heals, length(JOUEUR.heals)+1);
          JOUEUR.heals[length(JOUEUR.heals)-1] := idHeals;
     end;
end;


procedure donnerConsommable(var JOUEUR: stat_joueur; idConso, quantity: Integer);
var exist: Boolean;
    i, n : Integer;
begin
    exist:= False;
    for i:=0 to length(JOUEUR.conso)-1 do
        if JOUEUR.conso[i][0]=idConso then
           begin
           exist:=True;
           n:=i;
           end;
   if not exist and not (quantity = 0) then
     begin
          SetLength(JOUEUR.conso, length(JOUEUR.conso)+1);
          JOUEUR.conso[length(JOUEUR.conso)-1][0] := idConso;
          JOUEUR.conso[length(JOUEUR.conso)-1][1] := quantity;
     end
   else if not (quantity = 0) then
          JOUEUR.conso[n][1] := JOUEUR.conso[n][1]+quantity;
end;

procedure retirerConsommable(var JOUEUR: stat_joueur; index: Integer; soin: Boolean);
var i : Integer;
    consommables: array of Conso;
begin
    JOUEUR.conso[index][1] := JOUEUR.conso[index][1]-1;
    if soin then
      begin
        consommables := initConsommables();
        JOUEUR.PV:=JOUEUR.PV+consommables[JOUEUR.conso[index][0]].value;
        if JOUEUR.PV>JOUEUR.PV_MAX then
           JOUEUR.PV:=JOUEUR.PV_MAX;
      end;
    if JOUEUR.conso[index][1]<1 then
      begin
          for i:= index to length(JOUEUR.conso)-2 do
              JOUEUR.conso[i] := JOUEUR.conso[i+1];
          SetLength(JOUEUR.conso, length(JOUEUR.conso)-1);
      end;
end;
end.

