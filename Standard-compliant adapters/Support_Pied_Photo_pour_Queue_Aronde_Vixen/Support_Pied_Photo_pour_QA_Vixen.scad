include <BOLTS/BOLTS.scad>

$fn=100;
chouilla=0.01;      // pour micro-ajustements notamment lors des unions

lg_socle=70;        // longueur du support (axe optique)
la_socle=56;        // largeur max du support
ep_socle=4;         // épaisseur de la partie plane sur laquelle vient se poser la QA Vixen

ep_ecrou_m4=3.15;    // épaisseur réelle mesurée de l'écrou nylon utilisé
gdiam_ecrou_m4=7.8;  // "grand diamètre" = distance entre sommets opposés
pdiam_ecrou_m4=7;    // "petit diamètre" = distanc entre faces opposées
margin_ecrou_m4=0.5; // pour garantir l'insertion de l'écrou dans le support
diam_passage_m4=4.5; // passage libre pour vis nylon M4 qui est maintenue par l'écrou

modele_pied_photo ="Ulanzi"; // choisir entre "Manfrotto" et "Ulanzi"

module dovetail_manfrotto_male(length=50) {
    difference() {
        bottom_width = 40;
        top_width = 34;
        height = 8;
        rail_depth = 3;
        diff = bottom_width-top_width;
        // main body
        translate([bottom_width/2, 0, height]) rotate([90,180,0]) {
            linear_extrude(height=length,center=true) polygon(points=[[diff,0],[0,height],[bottom_width,height],[top_width,0]]);
        }
        // bottom rail for screw
        translate([0, 0, rail_depth/2-0.01]) cube([14, length+2, rail_depth], center=true);
        // snip sharp angles on both sides
        translate([bottom_width/2,0,1]) cube([2,length+2,4],center=true);
        translate([-bottom_width/2,0,1]) cube([2,length+2,4],center=true);
    }
}

module dovetail_ulanzi_ombra_video(length=70) {

    width  = 41;
    height = 10;

    translate([-width/2, length/2, 0]) 
        rotate([90,0,0]) 
            linear_extrude(length) {
                polygon([[0,0],[12,0],[12,3],[width-12,3],[width-12,0],[width,0],[width,3],[width-4,height],[4,height],[0,3]]);
            }
}

// margin sert à élargir le passage de la QA qui sera serrée par des vis ensuite :
// margin = 0 : dimensions de la QA
// margin = 2 : 2 mm de plus pour faciliter l'insertion, le vissage des M4 nylon permet ensuite de bloquer la QA
module queue_aronde_vixen(h=192, margin=0) {
    translate([-22-margin/2,0,15]) rotate([-90,0,0]) 
    linear_extrude(height=h,center=true) polygon(points=[[3.5,0],[0,15],[44+margin,15],[40.5+margin,0]]);
}

// assemblage des différentes pièces
difference() {
  // on pose un bloc sur le dos de la QA "photo"
  union() {
    // bloc de matière à creuser
    translate([-la_socle/2,-lg_socle/2,-chouilla]) cube([la_socle,lg_socle,15+ep_socle]);
    // base de fixation Manfrotto
    if (modele_pied_photo =="Manfrotto")
        color("yellow") translate([0,0,-8]) dovetail_manfrotto_male(length=lg_socle);
    if (modele_pied_photo =="Ulanzi")
        color("lightgreen") translate([0,0,-10]) dovetail_ulanzi_ombra_video(length = lg_socle);
  }
  // et on perce la matière avec une QA Vixen élargie de 2mm
  translate([0,0,ep_socle]) queue_aronde_vixen(h=192, margin=2);
  // on creuse les trous pour glisser les écrous M4
  translate([-la_socle/2+2,-lg_socle/2+4,21+5-1-pdiam_ecrou_m4-pdiam_ecrou_m4-2]) cube([ep_ecrou_m4+margin_ecrou_m4,gdiam_ecrou_m4+margin_ecrou_m4,12]);
  translate([-la_socle/2+2,+lg_socle/2-12,21+5-1-pdiam_ecrou_m4-pdiam_ecrou_m4-2]) cube([ep_ecrou_m4+margin_ecrou_m4,gdiam_ecrou_m4+margin_ecrou_m4,12]);
  // et on perce un passage pour les vis M4
  translate([-la_socle/2-chouilla,-lg_socle/2+8,21.5-pdiam_ecrou_m4-2]) rotate([0,90,0]) cylinder(h=10, d=diam_passage_m4);
  translate([-la_socle/2-chouilla,+lg_socle/2-8,21.5-pdiam_ecrou_m4-2]) rotate([0,90,0]) cylinder(h=10, d=diam_passage_m4);
}

//Ecrous M4 pour vérification :
//translate([-la_socle/2+2,-lg_socle/2+8,21.5]) rotate([0,90,0]) ISO4032("M4");
//translate([-la_socle/2+2,+lg_socle/2-8,21.5]) rotate([0,90,0]) ISO4032("M4");
