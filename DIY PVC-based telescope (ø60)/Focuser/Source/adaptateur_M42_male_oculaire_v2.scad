include <BOLTS/BOLTS.scad>
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

use <threads.scad>

$fn=360;
epsilon=0.01;
profondeur_file=4; //## Nicolas
epaisseur_gorge=0;
pas=0.75;
d_thread=41.95; //## Nicolas

d_ext_1 = 55; // ou 63;
h_cyl_1 = 20;

d_oculr = 31.75;
marge_oculr = 1.0;

ecrou_interieur = 1;

// *****************************
// M42 x 0.75 - MALE
// ****************************
module filetage_male()
{
  difference()
  {
    union()
    {
      translate([0,0,epaisseur_gorge]) metric_thread(d_thread,pas,profondeur_file); //## Nicolas
      // gorge
      cylinder(epaisseur_gorge,d=40.7);
      translate([0,0,profondeur_file+epaisseur_gorge+.25 ]) cylinder(.5,(d_thread-pas)/2,(d_thread-pas)/2-1,center=true); //## Nicolas
    }
        
    // trou central
    translate([0,0,-15]) cylinder(h=30,d=d_oculr+marge_oculr);
    //
  }
  
  
}
  
module tube_inferieur()
{
    difference() {
        translate([0,0,-h_cyl_1*1/6]) cyl(h=h_cyl_1, d=d_ext_1, center=true, chamfer=1);
        translate([0,0,h_cyl_1*1/4]) cylinder(h=h_cyl_1/2+epsilon, d=d_ext_1+epsilon, center=true);
        translate([0,0,-h_cyl_1*1/6]) cylinder(h=h_cyl_1+epsilon, d=d_oculr+marge_oculr, center=true);
    }
}    

difference() 
{
    union() 
    {
        filetage_male();
        tube_inferieur();
    }
    
    // Ecrou
    translate([0,0,-h_cyl_1/3+0.5]) 
    {
        // trou diam 4mm pour vis nylon
        translate([0,-d_oculr/2+epsilon*6,0]) rotate([90,0,0]) cylinder(h=d_ext_1/2-d_oculr/2+6*epsilon, d=4+3*epsilon);
        // emplacement écrou nylon M4
        offset_ecrou_1 = -d_oculr/2-1;
        offset_ecrou_2 = -d_oculr/2+2;
        // calcul deplacement Y si ecrou interieur ou exterieur
        translate([0,offset_ecrou_1,0]) rotate([90,30,0]) ISO4032("M4");
        translate([0,offset_ecrou_2,0]) rotate([90,30,0]) ISO4032("M4");
    }
}