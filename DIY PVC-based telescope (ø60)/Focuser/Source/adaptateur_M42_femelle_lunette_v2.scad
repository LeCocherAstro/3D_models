include <BOLTS/BOLTS.scad>
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

use <threads.scad>

$fn=360;
epsilon=0.01;
profondeur_file=5; // min = 3.00
pas=0.75;
d_thread=41.95;

d_ext_1 = 50;

h_cyl_2 = 15;
d_ext_2 = 43.0; //43.2; //## Nicolas
epaisseur = 3;

marge = 0.1;


// ***************************
// M42 x 0.75 - FEMELLE
// ***************************
module filetage_femelle()
{
  difference()
  {
    cylinder(profondeur_file,d=d_ext_1);
    union()
    {
      translate([0,0,-epsilon]) metric_thread(42.35,pas,profondeur_file+1*marge,internal=true);
    } 
  }
}

  
module tube_interieur()
{
    translate([0,0,h_cyl_2/2])
    difference() 
    {
      {
        cyl(h=h_cyl_2, d=d_ext_2, center=true, chamfer2=1);
        cyl(h=1.2*h_cyl_2, d=d_ext_2-2*epaisseur, center=true);
      }
    }
}    

difference() 
{
    union() 
    { 
        filetage_femelle();
        translate([0,0,profondeur_file-epsilon]) tube_interieur();      
    }
    

}