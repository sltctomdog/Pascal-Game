unit unit_glossaire;

{$mode objfpc}{$H+}

interface
  uses
    Classes, SysUtils;

  type
    Armure = record
      id : Integer;
      nom : String;
      resistance : Real;
    end;
    Arme = record
      id : Integer;
      nom : String;
      attaqueSupplementaire : Integer;
    end;
    Conso = record
      nom : String;
      value : Integer;
      achetable : Boolean;
      vendable : Boolean;
      prixVente : Integer;
      prixAchat : Integer;
    end;
    Ennemie = record
      nom : String;
      PV_MAX : Integer;
      PV : Integer;
      nomAttaque : String;
      degat_min : Integer;
      degat_max : Integer;
      PO : Integer;
    end;
    Move = record
      nom : String;
      degat_min : Integer;
      degat_max : Integer;
    end;
    Heal = record
      nom : String;
      degat_min : Integer;
      degat_max : Integer;
    end;
  Stat_joueur = record
    nom : String ;
    race : String;
    PV_MAX : Integer;
    PV : Integer;
    ATK : Integer;
    resistance : Real;
    PO : Integer;
    arme_possede : Array of Integer;
    arme_equipe : Arme;
    armure_possede : Array of Integer;
    armure_equipe : Armure;
    conso : Array of Array[0..1] of Integer;
    moves : Array of Integer;
    heals : Array of Integer;
  end;

    Armes = array of Arme;
    Armures = array of Armure;
    Consommables = array of Conso;
    Moveset = array of Move;
    Healset  = array of Heal;
    Ennemies = array of Ennemie;
    Races = array of string;
    function initArmes(): Armes;
    function initArmures(): Armures;
    function initConsommables(): Consommables;
    function initMoveset(): Moveset;
    function initHealset(): Healset;
    function initEnnemies(): Ennemies;
    function initJoueur(): stat_joueur;
    function initRace(): races;
implementation

function initArmes(): Armes;
var armes: array of Arme;
begin
  SetLength(armes, 5);

  armes[0].id:=0;
  armes[0].nom:='Main';
  armes[0].attaqueSupplementaire:=1;

  armes[1].id:=1;
  armes[1].nom:=#201'p'#233'e Nalty';
  armes[1].attaqueSupplementaire:=2;

  armes[2].id:=2;
  armes[2].nom:='Gants De Boxe';
  armes[2].attaqueSupplementaire:=3;

  armes[3].id:=3;
  armes[3].nom:='Pistolet '#224' billes';
  armes[3].attaqueSupplementaire:=3;

  armes[4].id:=4;
  armes[4].nom:='Arc';
  armes[4].attaqueSupplementaire:=3;

  initArmes:=armes;
end;

function initArmures(): Armures;
var armures: array of Armure;
begin
  SetLength(armures, 3);

  armures[0].id:=0;
  armures[0].nom:='Aucune';
  armures[0].resistance := 0;

  armures[1].id:=1;
  armures[1].nom:='Armure Full Diams P4';
  armures[1].resistance := 0.20;

  armures[2].id:=2;
  armures[2].nom:='Armure Draconique';
  armures[2].resistance := 0.50;

  initArmures:=armures;
end;
function initConsommables(): Consommables;
var consommables: array of Conso;
begin
  SetLength(consommables, 4);

  consommables[0].nom:='Mikado';
  consommables[0].value:=10;
  consommables[0].achetable := True;
  consommables[0].vendable := False;
  consommables[0].prixVente := 4;
  consommables[0].prixAchat := 15;

  consommables[1].nom:='Twix';
  consommables[1].value:=30;
  consommables[1].achetable := True;
  consommables[1].vendable := True;
  consommables[1].prixVente := 10;
  consommables[1].prixAchat := 35;

  consommables[2].nom:='Pomme d''Or';
  consommables[2].value:=60;
  consommables[2].achetable := True;
  consommables[2].vendable := True;
  consommables[2].prixVente := 35;
  consommables[2].prixAchat := 60;

  consommables[3].nom:='Potion Revitalisante';
  consommables[3].value:=20;
  consommables[3].achetable := False;
  consommables[3].vendable := True;
  consommables[3].prixVente := 80;
  consommables[3].prixAchat := 250;

  initConsommables:=consommables;
end;

function initMoveset(): Moveset;
var moves: array of move;
begin
  SetLength(moves,3);

  moves[0].nom:='Coup De Boule';
  moves[0].degat_min:=1;
  moves[0].degat_max:=3;

  moves[1].nom:='Tranch'#233'p'#233'e';
  moves[1].degat_min:=3;
  moves[1].degat_max:=5;

  moves[2].nom:='Tranch''R';
  moves[2].degat_min:=10;
  moves[2].degat_max:=17;

  initMoveset:=moves;
end;

function initHealset(): Healset;
var heals: array of heal;
begin
  SetLength(heals,2);

  heals[0].nom:='Main Curative';
  heals[0].degat_min:=3;
  heals[0].degat_max:=5;

  heals[1].nom:='Potion Du P'#232're Lapinpin';
  heals[1].degat_min:=7;
  heals[1].degat_max:=10;

  initHealset:=heals;
end;

function initEnnemies():Ennemies;
var ennemies: array of Ennemie;
begin
  SetLength(ennemies,5);

  ennemies[0].nom:='B'+chr(234)+'te F'+chr(233)+'roce';
  ennemies[0].PV_MAX:=20;
  ennemies[0].PV:=20;
  ennemies[0].nomAttaque:='Coup De Griffe';
  ennemies[0].degat_min:=2;
  ennemies[0].degat_max:=5;
  ennemies[0].PO:=10;

  ennemies[1].nom:='G'+chr(233)+'ant';
  ennemies[1].PV:=60;
  ennemies[1].PV_MAX:=60;
  ennemies[1].nomAttaque:='Coup De Gourdin';
  ennemies[1].degat_min:=3;
  ennemies[1].degat_max:=7;
  ennemies[1].PO:=30;

  ennemies[2].nom:='Druire Ivre';
  ennemies[2].PV:=45;
  ennemies[2].PV_MAX:=45;
  ennemies[2].nomAttaque:='Tranch''R';
  ennemies[2].degat_min:=6;
  ennemies[2].degat_max:=10;
  ennemies[2].PO:=50;

  ennemies[3].nom:='Mirmulnir';
  ennemies[3].PV:=150;
  ennemies[3].PV_MAX:=150;
  ennemies[3].nomAttaque:='Souffle De Feu';
  ennemies[3].degat_min:=8;
  ennemies[3].degat_max:=15;
  ennemies[3].PO:=0;

  ennemies[4].nom:='Mirmulnir Affaiblit';
  ennemies[4].PV:=100;
  ennemies[4].PV_MAX:=150;
  ennemies[4].nomAttaque:='Flamme C'+chr(233)+'l'+chr(232)+'ste';
  ennemies[4].degat_min:=20;
  ennemies[4].degat_max:=28;
  ennemies[4].PO:=1000;

  initEnnemies:=ennemies
end;
function initJoueur(): stat_joueur;
var
  JOUEUR : stat_joueur;
begin
  JOUEUR.PO:=100;
  JOUEUR.PV_MAX:=100;
  JOUEUR.PV:=JOUEUR.PV_MAX;
  JOUEUR.nom:='none';
  JOUEUR.race:='none';
  setLength(JOUEUR.arme_possede, 0);
  setLength(JOUEUR.armure_possede, 0);
  setLength(JOUEUR.conso, 0);
  setLength(JOUEUR.moves, 0);
  setLength(JOUEUR.heals, 0);
  JOUEUR.ATK := 0;

  initJoueur:=JOUEUR;
end;
function initRace(): races;
var
  race: array of string;
begin
  SetLength(race,6);

  race[0]:='Macaron';
  race[1]:='Grollande';
  race[2]:='Sarzoky';
  race[3]:='Lestylo';
  race[4]:='Laisselle';
  race[5]:='Roblochon';

  initRace:=race;
end;

end.
