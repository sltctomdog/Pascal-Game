unit unit_histoires;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils,unit_General, unit_GestionEcran, Keyboard;



function nouveauChoix(txt: String; t: targetsType; param, retour : Integer): Choix;
function nouveauTexte(text: String; ctext, cfond : Integer; a : alignType): Texte;
function chargerHistoires(): Liste_Scene;
procedure afficherScene(s: Scene);
function retournerChoix(s: Scene; sceneId:Integer): Choix;
function menuGauche(mode : String): Integer;
procedure clearScene();

implementation

function nouveauChoix(txt: String; t: targetsType; param, retour : Integer): Choix;
var c : Choix;
begin
  c.texte := txt;
  c.targetType := t;
  c.parametre := param;
  c.sceneRetour := retour;
  nouveauChoix := c;
end;

function nouveauTexte(text: String; ctext, cfond : Integer; a : alignType): Texte;
var t : Texte;
begin
  t.txt := text;
  t.cT := ctext;
  t.cF := cfond;
  t.align := a;
  nouveauTexte := t;
end;

function chargerHistoires(): Liste_Scene;
var scenes : Liste_Scene;
begin
  SetLength(scenes, 19);

  scenes[0].textes[0] := nouveauTexte(' FLASH-BACK ', 0, 15, centre);
  scenes[0].textes[4] := nouveauTexte('Suite au déclenchement d’une guerre civile, le gouvernement a demandé au physicien Simonot de ', 8, 0, centre);
  scenes[0].textes[5] := nouveauTexte('développer une formule permettant de téléporter les Politiciens Français à travers une faille spatio-temporelle.', 8, 0, centre);
  scenes[0].textes[9] := nouveauTexte('Le physicien Simonot : ', 2, 0, gauche);
  scenes[0].textes[10] := nouveauTexte('                      C’est bon j’ai enfin réussi à développer cette faille ! préparez-vous à partir Messieurs. ', 15, 0, gauche);
  scenes[0].textes[15] := nouveauTexte('Simonot donne à chaque Président une potion qu’ils boivent en même temps.', 8, 0, centre);
  scenes[0].textes[20] := nouveauTexte('Le physicien Simonot : ', 2, 0, gauche);
  scenes[0].textes[21] := nouveauTexte('                       HÉ ZÉÉÉÉÉÉÉÉ PARTI !!!', 15, 0, gauche);
  scenes[0].textes[24] := nouveauTexte(' FIN DU FLASH-BACK ', 0, 15, centre);

  SetLength(scenes[0].liste_choix, 1);
  scenes[0].liste_choix[0] := nouveauChoix('Reprendre ses esprits.', type_scene, 0, 1);

  //SCENE 1

  scenes[1].textes[0] := nouveauTexte('Deux villageois se promenant dans le village de Blancherie heurtent les politiciens sortant de la faille.', 8, 0, centre);
  scenes[1].textes[1] := nouveauTexte('Tous les politiciens se séparent en se hurlant dessus.', 8, 0, centre);
  scenes[1].textes[2] := nouveauTexte('Au final il ne reste que vous.', 8, 0, centre);
  scenes[1].textes[4] := nouveauTexte('VILLAGEOIS 1 :', 2, 0, gauche);
  scenes[1].textes[5] := nouveauTexte('               AHHH SORCIER !', 15, 0, gauche);
  scenes[1].textes[7] := nouveauTexte('VILLAGEOIS 2 :', 2, 0, gauche);
  scenes[1].textes[9] := nouveauTexte('               Qu''est ce que ? Mais que ce passe-t''il d''où sortez-vous ?', 15, 0, gauche);
  scenes[1].textes[11] := nouveauTexte('Le premier villageois met une claque à son ami.', 8, 0, centre);
  scenes[1].textes[13] := nouveauTexte('VILLAGEOIS 1 :', 2, 0, gauche);
  scenes[1].textes[14] := nouveauTexte('               Ressaisis-toi Godefroy !', 15, 0, gauche);
  scenes[1].textes[16] := nouveauTexte('GODEFROY :', 2, 0, gauche);
  scenes[1].textes[17] := nouveauTexte('           Pardon Pierre, ca m''a surpris. :', 15, 0, gauche);
  scenes[1].textes[19] := nouveauTexte('VOUS :', 14, 0, gauche);
  scenes[1].textes[20] := nouveauTexte('       Excusez-moi, pourrais-je savoir où nous sommes ?', 15, 0, gauche);
  scenes[1].textes[22] := nouveauTexte('PIERRE et GODEFROY :', 2, 0, gauche);
  scenes[1].textes[23] := nouveauTexte('                     Vous êtes dans la province de Bordeciel à Blancherive !', 15, 0, gauche);
  scenes[1].textes[25] := nouveauTexte('VOUS : ', 14, 0, gauche);
  scenes[1].textes[26] := nouveauTexte('       MAIS COMMENT VAIS-JE FAIRE POUR RENTREZ CHEZ MOI ET FAIRE DE L''ARGENT ?!', 15, 0, gauche);
  scenes[1].textes[28] := nouveauTexte('PIERRE :', 2, 0, gauche);
  scenes[1].textes[29] := nouveauTexte('         Nous allons vous aider à rentrer chez vous, venez avec nous, je connais une physicienne très réputée, elle vous aidera j’en suis sûr.', 15, 0, gauche);
  scenes[1].textes[29] := nouveauTexte('         Il faut simplement que nous nous dirigions dans la vallée de Noirepont.', 15, 0, gauche);


  SetLength(scenes[1].liste_choix, 2);
  scenes[1].liste_choix[0] := nouveauChoix('Foncer tête baisser car vous connaissez le chemin.', type_scene, 0, 2);
  scenes[1].liste_choix[1] := nouveauChoix('Faire confiance à Pierre et Godefroy.', type_scene, 0, 4);

  //SCENE 2

  scenes[2].textes[13] := nouveauTexte('Vous entrez dans une forêt très sombre et tombez à la rencontre d''un petit chien.', 8, 0, centre);
  scenes[2].textes[15] := nouveauTexte('Vous vous approchez de ce petit chien pour le carresser...', 8, 0, centre);
  scenes[2].textes[17] := nouveauTexte('MAIS CELUI-CI SE TRANSFORME EN BÊTE FÉROCES DE 50 CM !', 4, 0, centre);


  SetLength(scenes[2].liste_choix, 1);
  scenes[2].liste_choix[0] := nouveauChoix('Vous engagez le combat.', type_combat, 0, 3);

  //SCENE 3

  scenes[3].textes[9] := nouveauTexte('Vous reussissez à tuer la bête mais entendez un grondement derrière vous.', 8, 0, centre);
  scenes[3].textes[11] := nouveauTexte('Vous vous retournez et tomber nez à nez avec une GROSSE BÊTE !', 4, 0, centre);
  scenes[3].textes[15] := nouveauTexte('Vous remarquez que tout seul vous ne vous en sortirez pas, vous décidez de courir rejoindre Pierre et Godefroy qui étaient partis au village.', 8, 0, centre);
  scenes[3].textes[17] := nouveauTexte('A Blancherive, vous êtes rejoint par les villageois qui vous trouve évanoui, Godefroy étant marchant,vous donne une potion.', 8, 0, centre);
  scenes[3].textes[19] := nouveauTexte('Le lendemain vous repartez à la recherche de la physicienne avec Pierre et Godefroy.', 8, 0, centre);


  SetLength(scenes[3].liste_choix, 1);
  scenes[3].liste_choix[0] := nouveauChoix('Vous suivez les villageois.', type_scene, 0, 4);

  //SCENE 4

  scenes[4].textes[6] := nouveauTexte('Avant de rentrer dans la forêt, Godefroy vous donne une épée Nalty et vous apprend à la manier.', 8, 0, centre);
  scenes[4].textes[8] := nouveauTexte('Pensez à équiper votre nouvelle arme.', 8, 0, centre);
  scenes[4].textes[12] := nouveauTexte('Godefroy chuchote en montrant le géant du doigt.', 8, 0, centre);
  scenes[4].textes[15] := nouveauTexte('GODEFROY :', 2, 0, gauche);
  scenes[4].textes[16] := nouveauTexte('           Ne faites surtout pas de bruit le géant est en train de dormir il ne faut pas le réveiller, il risquerait de nous courser.', 15, 0, gauche);
  scenes[4].textes[20] := nouveauTexte('Comme par hasard vous marchez sur la seule branche d''arbre qui est sur la route.', 8, 0, centre);
  scenes[4].textes[22] := nouveauTexte('Vous réveillez le Géant.', 4, 0, centre);


  SetLength(scenes[4].liste_choix, 2);
  scenes[4].liste_choix[0] := nouveauChoix('Vous fuyez comme un lâche.', type_scene, 0, 6);
  scenes[4].liste_choix[1] := nouveauChoix('Vous affrontez le géant.', type_combat, 1, 5);

  //SCENE 5

  scenes[5].textes[13] := nouveauTexte('Le géant est bien assomé.', 8, 0, centre);
  scenes[5].textes[15] := nouveauTexte('GODEFROY :', 2, 0, gauche);
  scenes[5].textes[17] := nouveauTexte('           Vous vous êtes bien débrouillés, allons au pont de bois c’est le seul chemin permettant d’aller à Noirepont.', 15, 0, gauche);


  SetLength(scenes[5].liste_choix, 1);
  scenes[5].liste_choix[0] := nouveauChoix('Allez au pont.', type_scene, 0, 6);

  //SCENE 6

  scenes[6].textes[15] := nouveauTexte('Vous arrivez au pont en bois et vous remarquez que celui-ci est en très mauvais état.', 8, 0, centre);
  scenes[6].textes[17] := nouveauTexte('Or vous devez absolument le passer pour rejoindre les terres voisines.', 8, 0, centre);


  SetLength(scenes[6].liste_choix, 3);
  scenes[6].liste_choix[0] := nouveauChoix('Courir et se jeter de la falaise.', type_scene, 0, 7);
  scenes[6].liste_choix[1] := nouveauChoix('Traverser le pont.', type_scene, 0, 9);
  scenes[6].liste_choix[2] := nouveauChoix('Imiter Tarzan.', type_scene, 0, 8);

  //SCENE 7

  scenes[7].textes[11] := nouveauTexte('Vous avez regardez la veille à la TV les J-O.', 8, 0, centre);
  scenes[7].textes[13] := nouveauTexte('Vous entendez la voix de votre plus grand idole USAIN BOLT dans votre tête.', 8, 0, centre);
  scenes[7].textes[15] := nouveauTexte('Vous prenez donc de l’élan, sprintez, puis vous vous jetez du haut de la falaise.', 8, 0, centre);
  scenes[7].textes[17] := nouveauTexte('Vous réussissez à vous accrocher', 8, 0, centre);
  scenes[7].textes[19] := nouveauTexte('et tombez car vous n''avez pas un corp d''athlète.', 4, 0, centre);


  SetLength(scenes[7].liste_choix, 1);
  scenes[7].liste_choix[0] := nouveauChoix('Vous mourrez.', type_mort, 0, 9);//IL FAUT LE FAIRE MOURIR

  //SCENE 8

  scenes[8].textes[11] := nouveauTexte('Vous trouvez une liane et vous décidez alors de l’utiliser pour vous jeter de l’autre côté, vous-vous y agrippez et vous-vous lancez.', 8, 0, centre);
  scenes[8].textes[14] := nouveauTexte('VOUS :', 14, 0, gauche);
  scenes[8].textes[15] := nouveauTexte('       AHHHHHHHHHHHHHHHHHHHHH !!!', 15, 0, gauche);
  scenes[8].textes[18] := nouveauTexte('Mais au même moment la liane n’a pas supporté votre poids, les excès que vous avez faits ces derniers mois se font ressentir, la liane craque.', 8, 0, centre);


  SetLength(scenes[8].liste_choix, 1);
  scenes[8].liste_choix[0] := nouveauChoix('Vous mourrez.', type_mort, 0, 9);//IL FAUT LE FAIRE MOURIR

  //SCENE 9

  scenes[9].textes[13] := nouveauTexte('Vous avez réussi à passer de l’autre côté, vous devez donc terminer votre voyage en trouvant la physicienne.', 8, 0, centre);
  scenes[9].textes[17] := nouveauTexte('VILLAGEOIS :', 2, 0, gauche);
  scenes[9].textes[18] := nouveauTexte('             Très bien ne perdons pas de temps nous devons trouver le grand puit du druide avant la tombée de la nuit.',15,0,gauche);
  scenes[9].textes[21] := nouveauTexte('1 heure après le début du trajet, vous êtes arrivé au grand puit du druide mais le druide n’est pas présent.',8,0,centre);
  scenes[9].textes[23] := nouveauTexte('La maison du druide étant devant vous, Pierre part toquer à la porte mais personne ne répond.',8,0,centre);
  scenes[9].textes[25] := nouveauTexte('La nuit tombe... ',8,0,centre);


  SetLength(scenes[9].liste_choix, 2);
  scenes[9].liste_choix[0] := nouveauChoix('Être un gangster et casser la vitre pour entrer dans la maison.', type_scene, 0, 12);
  scenes[9].liste_choix[1] := nouveauChoix('Dormir dehors.', type_scene, 0, 10);

  //SCENE 10

  scenes[10].textes[4] := nouveauTexte('VILLAGEOIS :', 2, 0, gauche);
  scenes[10].textes[5] := nouveauTexte('             Mince il n’est pas chez lui, on ne peut pas rentrer nous allons devoir dormir dehors...', 15, 0, gauche);
  scenes[10].textes[7] := nouveauTexte('VOUS :', 14, 0, gauche);
  scenes[10].textes[8] := nouveauTexte('       Non, non, non je ne dormirai pas dehors !', 15, 0, gauche);
  scenes[10].textes[11] := nouveauTexte('Les Villageois commencent à chercher des branches pour allumer un feu.',8, 0, centre);
  scenes[10].textes[14] := nouveauTexte('VILLAGEOIS :', 2, 0, gauche);
  scenes[10].textes[15] := nouveauTexte('             Et bien nous sommes obligés', 15, 0, gauche);
  scenes[10].textes[18] := nouveauTexte('Vous prenez sur vous et tout le monde s’endort autour du feu.', 8, 0, centre);
  scenes[10].textes[19] := nouveauTexte('Mais vous êtes réveillé par des bruits, vous avez peur,', 8, 0, centre);
  scenes[10].textes[21] := nouveauTexte('vous ouvrez les yeux et tombez nez à nez avec le propriétaire complétement ivre essayant d’ouvrir sa porte.', 8, 0, centre);
  scenes[10].textes[24] := nouveauTexte('Celui-ci se retourne vers vous et se sentant agressé, vous jette des gants de boxe pour engager un combat à mort.', 4, 0, centre);

  SetLength(scenes[10].liste_choix, 1);
  scenes[10].liste_choix[0] := nouveauChoix('Vous décidez de vous battre comme Ippo.', type_combat, 2, 11);

  //SCENE 11

  scenes[11].textes[15] := nouveauTexte('Vous fouillez le corps du druide, prenez ses clés, et récuperez son armure full diams p4.', 8, 0,centre);
  scenes[11].textes[17] := nouveauTexte('Vous jetez ce dernier dans le puit etfinissez la fin de votre nuit dans sa maison.', 8, 0, centre);


  SetLength(scenes[11].liste_choix, 1);
  scenes[11].liste_choix[0] := nouveauChoix('Dormir.', type_scene, 0, 14);

  //SCENE 12

  scenes[12].textes[13] := nouveauTexte('Vous cassez la vitre et subissez 10 dégâts.', 8, 0, centre);
  scenes[12].textes[15] := nouveauTexte('Tout le monde s’endort...', 8, 0, centre);
  scenes[12].textes[17] := nouveauTexte('Mais vous êtes réveillé par des bruits, vous avez peur,', 8, 0, centre);
  scenes[12].textes[19] := nouveauTexte('vous ouvrez les yeux et tombez nez à nez avec le propriétaire complétement ivre essayant d’ouvrir sa porte.', 8, 0, centre);
  scenes[12].textes[21] := nouveauTexte('Celui-ci se retourne vers vous et se sentant agressé, vous jette des gants de boxe pour engager un combat à mort.', 4, 0, centre);


  SetLength(scenes[12].liste_choix, 1);
  scenes[12].liste_choix[0] := nouveauChoix('Vous décidez de vous battre comme Ippo.', type_combat, 2, 13);

  //SCENE 13

  scenes[13].textes[15] := nouveauTexte('Vous fouillez le corps du druide et récuperez son armure full diams p4.', 8, 0,centre);
  scenes[13].textes[17] := nouveauTexte('Vous jetez le corps du druide dans le puit.', 8, 0, centre);


  SetLength(scenes[13].liste_choix, 1);
  scenes[13].liste_choix[0] := nouveauChoix('Vous finissez la fin de votre nuit dans sa maison.', type_scene, 0, 14);

  //SCENE 14

  scenes[14].textes[15] := nouveauTexte('Au petit matin vous décidez de fouillez la maison de fond en comble.', 8, 0, centre);
  scenes[14].textes[17] := nouveauTexte('Vous trouvez dans des vieux tiroirs 3 potions revitalisantes et un parchemin qui vous apprend le sort Tranch’R.', 8, 0, centre);


  SetLength(scenes[14].liste_choix, 1);
  scenes[14].liste_choix[0] := nouveauChoix('Apprendre le sort TRANCH''R.', type_scene, 0, 15);

  //SCENE 15

  scenes[15].textes[13] := nouveauTexte(' Vous rentrez en passant par une forêt enchantée, en mi-chemin, le ciel s’assombrit, du brouillard tombe, la terre tremble, une ombre s’élève...', 8, 0, centre);
  scenes[15].textes[15] := nouveauTexte('Selon Godefroy, il pourrait s’agir de Mirmulnir, le dragon légendaire de la forêt enchantée.', 8, 0, centre);
  scenes[15].textes[18] := nouveauTexte('L’ombre s’approche et se révèle, vous tombez nez à nez avec le dragon de la légende, vaincre ou mourir tel est votre destin.', 4, 0, centre);


  SetLength(scenes[15].liste_choix, 1);
  scenes[15].liste_choix[0] := nouveauChoix('Affronter Mirmulnir.', type_combat, 3, 16);

  //SCENE 16

  scenes[16].textes[15] := nouveauTexte('Agonisant, Mirmulnir se relève et prend le cap pour noirpont.', 8, 0, centre);
  scenes[16].textes[17] := nouveauTexte('Vous puisez dans vos dernières forces pour arrivez sain et sauf à Noirpont.', 8, 0, centre);


  SetLength(scenes[16].liste_choix, 1);
  scenes[16].liste_choix[0] := nouveauChoix('Continuer jusqu''au village.', type_scene, 0, 17);

  //SCENE 17

  scenes[17].textes[10] := nouveauTexte('Arrivés au village, vous voyez les villageois en panique, le dragon les attaque.', 8, 0, centre);
  scenes[17].textes[12] := nouveauTexte('GODEFROY :', 2, 0, gauche);
  scenes[17].textes[13] := nouveauTexte('           TENEZ L''ARMURE QUE JE CACHAIS DEPUIS SI LONGTEMPS, JE VOUS LA DONNNE, ELLE VOUS SERVIRA POUR CE DERNIER COMBAT !', 15, 0, gauche);
  scenes[17].textes[16] := nouveauTexte('Vous recevez l''Armure Draconique !', 8, 0, centre);
  scenes[17].textes[19] := nouveauTexte('Mirmulnir est de retour et vous devez l’achever pour le bien du village et votre retour dans votre monde.', 4, 0, centre);


  SetLength(scenes[17].liste_choix, 1);
  scenes[17].liste_choix[0] := nouveauChoix('Achever Mirmulnir.', type_combat, 4, 18);

  //SCENE 18

  scenes[18].textes[15] := nouveauTexte('Le dragon est à terre, vous retrouvez la physicienne qui vous ramène au près du scientifique Simonot dans votre monde d’origine.', 8, 0, centre);


  SetLength(scenes[18].liste_choix, 1);
  scenes[18].liste_choix[0] := nouveauChoix('FIN', type_mort, 0, 18);

  chargerHistoires:=scenes;
end;

procedure afficherScene(s: Scene);
var i: Integer;
begin
    clearScene();
    menuGauche('off');
    for i:=0 to length(s.textes)-1 do
        begin
             couleurs(s.textes[i].cT, s.textes[i].cF);
             case s.textes[i].align of
                  gauche:ecrireEnPosition(pos(53, 11+i), s.textes[i].txt);
                  centre:ecrireEnPosition(pos(53+74-round(length(s.textes[i].txt)/2), 11+i), s.textes[i].txt); // centré
                  droite:ecrireEnPosition(pos(53+145-round(length(s.textes[i].txt)), 11+i), s.textes[i].txt); // droite
             end;
        end;
    couleurs(15,0);
end;

function menuGauche(mode : String): Integer;
var choice : array[0..2] of String;
    i, actualIndex, x, y : Integer;
    sortie: Boolean;
    K : TKeyEvent;
begin
  sortie:=False;
  actualIndex:=0;
  choice[0]:= '<   Inventaire  >' ;
  choice[1]:= '<    Magasin    >' ;
  choice[2]:= '<    Quitter    >' ;

  x:=24-12;
  y:=11;
  couleurTexte(15);
  if mode='on' then
     couleurTexte(4);
  ecrireEnPosition(pos(x,y),'  __  __ ___ _  _ _   _ ');
  ecrireEnPosition(pos(x,y+1),' |  \/  | __| \| | | | |');
  ecrireEnPosition(pos(x,y+2),' | |\/| | _|| .` | |_| |');
  ecrireEnPosition(pos(x,y+3),' |_|  |_|___|_|\_|_____| ');
  couleurTexte(15);

  while not sortie do
  begin
    for i:=0 to Length(choice)-1 do
        begin
            couleurFond(0);
            if (i=actualIndex) and (mode='on') then
               couleurFond(4);
            ecrireEnPosition(pos(16, 18+2*i), choice[i]);
        end;

    deplacerCurseur(pos(0,0));
    if mode='on' then
      begin
          K:=GetKeyEvent;
          K:=TranslateKeyEvent(K);
          case GetKeyEventCode(K) of
               65319: actualIndex:=actualIndex+1;
               65313: actualIndex:=actualIndex-1;
               65317: begin
                   sortie:= True;
                   menuGauche:=-1;
                   menuGauche('off');
               end;
               7181: begin
                   sortie:= True;
                   menuGauche:=actualIndex;
                   menuGauche('off');
               end;
          end;
      end
    else
      begin
          sortie:=true;
          menuGauche:=-1
      end;

    if actualIndex>(length(choice)-1) then
       actualIndex:=0;
    if actualIndex<0 then
       actualIndex:=length(choice)-1;
  end;
end;

function retournerChoix(s: Scene; sceneId:Integer): Choix;
var i, actualIndex, gauche: Integer;
    K : TKeyEvent;
    sortie: Boolean;
    choixPerso: Choix;
begin
  actualIndex:=0;
  sortie:=False;
  couleurs(15, 0);

  while not sortie do
  begin
      for i:=0 to length(s.liste_choix)-1 do
          begin
              couleurFond(0);
              if (i=actualIndex) then
                   couleurFond(4);
              ecrireEnPosition(pos(55, 55-(length(s.liste_choix)-1-i)*2), '>  ' + s.liste_choix[i].texte);
          end;

      deplacerCurseur(pos(0,0));
      K:=GetKeyEvent;
      K:=TranslateKeyEvent(K);
      case GetKeyEventCode(K) of  //gauche 65315   //droite 65317
           65319: actualIndex:=actualIndex+1;
           65313: actualIndex:=actualIndex-1;
           65315: begin
               couleurFond(0);
               for i:=0 to length(s.liste_choix)-1 do
                   begin
                       ecrireEnPosition(pos(55, 55-(length(s.liste_choix)-1-i)*2), '>  ' + s.liste_choix[i].texte);
                   end;
               gauche := menuGauche('on');
               choixPerso.sceneRetour:=sceneId;
               case gauche of
                    0: choixPerso.targetType:= type_inventaire;//inventaire
                    1: choixPerso.targetType:= type_magasin;//magasin
                    2: halt();
               end;
               retournerChoix := choixPerso;
               sortie:=True;
           end;
           7181: begin
                   retournerChoix := s.liste_choix[actualIndex];
                   sortie:= True;
                 end;
      end;

      if actualIndex>(length(s.liste_choix)-1) then
         actualIndex:=0;
      if actualIndex<0 then
         actualIndex:=length(s.liste_choix)-1;
  end;
end;

procedure clearScene();
var i:Integer;
begin
  couleurFond(0);
  for i:= 0 to 47 do
      ecrireEnPosition(pos(51, 10+i), stringOfChar(' ', 148));

end;

end.

