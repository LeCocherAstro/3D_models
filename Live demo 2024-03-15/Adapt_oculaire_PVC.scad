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

module anneau_exterieur()
{
    translate([0,0,h_cyl_1/2]) difference() {
        cylinder(h=h_cyl_1, d=d_ext_1+10, center=true);
        cylinder(h=h_cyl_1+chouilla, d=d_ext_2, center=true);
        } 
    }

module tube_superieur()
{
    difference() {
        translate([0,0,h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_2, center=true, chamfer=1);
        translate([0,0,h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
    }
}    

module tube_inferieur()
{
    difference() {
        translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);
        translate([0,0,h_cyl_1*1/4]) cylinder(h=h_cyl_1/2+chouilla, d=d_ext_1+chouilla, center=true);
        translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1+chouilla, d=d_oculr+marge_oculr, center=true);
    }
}    

difference() {
    union() {
        tube_superieur();
        tube_inferieur();
    }
    translate([0,0,-h_cyl_1/3+0.5]) {
        // trou diam 4mm pour vis nylon
        translate([0,-d_oculr/2+chouilla*6,0]) rotate([90,0,0]) cylinder(h=d_ext_1/2-d_oculr/2+6*chouilla, d=4+3*chouilla);
        // emplacement écrou nylon M4
        offset_ecrou_1 = -d_ext_1/2+3;
        offset_ecrou_2 = -d_ext_1/2+3.6;
        // calcul deplacement Y si ecrou interieur ou exterieur
        offset_interieur_exterieur = ecrou_interieur * (d_ext_1-d_ext_2-1.25);
        translate([0,offset_ecrou_1+offset_interieur_exterieur,0]) rotate([90,30,0]) ISO4032("M4");
        translate([0,offset_ecrou_2+offset_interieur_exterieur,0]) rotate([90,30,0]) ISO4032("M4");
    }
}

