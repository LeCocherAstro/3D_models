$fn=100;
chouilla = 0.02;

include <BOLTS/BOLTS.scad>

include <BOSL/constants.scad>
use <BOSL/shapes.scad>

d_ext_1 = 50;
d_ext_2 = 43.2;
h_cyl_1 = 20;

d_oculr = 31.75;
marge_oculr = 1.0;

ecrou_interieur = 1;

// 1a. Cylindre simple

//cylinder(h=h_cyl_1, d=d_ext_1, center=true);

// 1b. Translation

//translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1, d=d_ext_1, center=true);

// 1c. Cylindre chanfreiné et déplacé

//translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);

// 2a. On commence à creuser des trous...

//difference() {
//    translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);
//    translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
//    }
    
 // 2b. avec du debug (#) pour bien comprendre où on fait les trous
    
//difference() {
//    translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);
//#    translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
//    }

// 2c. figeons la pièce dans un bloc nommé (module) 

//module tube_inferieur() {    
//    difference() {
//        translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);
//        translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
//    }
//}

//tube_inferieur();    

// 3a. ajoutons le tube supérieur dans son propre module

//module tube_superieur() {    
//    difference() {
//        translate([0,0,h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_2, center=true, chamfer=1);
//        translate([0,0,h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
//    }
//}

// tube_superieur();    

// 3b. en couleur pour bien le différencier du premier

// color("red") tube_superieur();    

// 4a. fusionnons les deux pièces ensemble

//union() {
//    color("red") tube_superieur();
//    tube_inferieur();
//}

// 4b. et maintenant, un trou pour la vis nylon
//module piece_intermediaire() {
//    difference() {
//        union() {
//            color("red") tube_superieur();
//            tube_inferieur();
//        }
//        translate([0,0,-h_cyl_1/3+0.5]) {
//            // trou diam 4mm pour vis nylon
//            # translate([0,-d_oculr/2+chouilla*6,0]) rotate([90,0,0]) cylinder(h=10, d=4+3*chouilla);
//        }
//    }
//}
//piece_intermediaire();

// 5a. On ajoute un écrou M4

//ISO4032("M4");

// 5b. Qu'on utilise deux fois pour réserver son emplacement dans le cylindre

//difference() {
//    piece_intermediaire();
//    translate([0,0,-h_cyl_1/3+0.5]) {
//        // emplacement écrou nylon M4
//        offset_ecrou_1 = -d_ext_1/2+3;
//        offset_ecrou_2 = -d_ext_1/2+3.6;
//        // calcul deplacement Y si ecrou interieur ou exterieur
//        offset_interieur_exterieur = ecrou_interieur * (d_ext_1-d_ext_2-1.25);
//        # translate([0,offset_ecrou_1+offset_interieur_exterieur,0]) rotate([90,30,0]) ISO4032("M4");
//        # translate([0,offset_ecrou_2+offset_interieur_exterieur,0]) rotate([90,30,0]) ISO4032("M4");
//    }
//}
