unit unit_interface;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unit_GestionEcran,Keyboard,unit_glossaire, unit_inventaire,unit_shop,unit_general;


procedure menuInitial();

implementation

procedure menuInitial();

var
   x,y,i,actualIndex : Integer;
   choice : array[0..1] of String;
   K : TKeyEvent;
   Sortie : Boolean;
begin

  actualIndex:=0;
  initKeyboard;
  changerTailleConsole(200,60);

  couleurTexte(4);
  ecrireEnPosition(pos(93,25),'LA VI REPUBLIQUE');

  choice[0] := '<  Commencer une partie  >' ;
  choice[1] := '<        Quitter         >';




  //Selection avec les flèches
  sortie:=False;


  while not sortie do
  begin
    couleurTexte(15);
    for i:=0 to Length(choice)-1 do
    begin
        couleurFond(0);
        if i=actualIndex then
           couleurFond(4);
        ecrireEnPosition(pos(87, 30+i), choice[i]);
    end;

    deplacerCurseur(pos(0,0));
    K:=GetKeyEvent;
    K:=TranslateKeyEvent(K);
    case GetKeyEventCode(K) of
         65319: actualIndex:=actualIndex+1;
         65313: actualIndex:=actualIndex-1;
         7181: begin
           if actualIndex=0 then
             sortie:=True;
           if actualIndex=1 then
             halt(1);
           end;
    end;
    if actualIndex>(Length(choice)-1) then
       actualIndex:=0;
    if actualIndex<0 then
       actualIndex:=Length(choice)-1;
  end;


end;
end.


