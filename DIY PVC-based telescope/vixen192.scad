// QUEUE D'ARONDE VIXEN 192 MM
// Pierre REVEL 24/3/24
//
// Projet lunette PVC 60 mm DIY
// Queue d'aronde au format VIXEN 192 mm spécifiquement conçue pour
// les colliers pour tubes diamètre 63 et leurs vis de fixation murale

$fn=72;
aju=0.1;

ep=4;
trouvis=5;

module matiere() {
  difference() {
    translate([-22,0,0]) rotate([90,0,0])
    linear_extrude(height=192,center=true) polygon(points=[[3.5,0],[0,15],[44,15],[40.5,0]]);
    translate([-22,0,aju]) rotate([90,0,0])
    linear_extrude(height=192-2*ep,center=true) polygon(points=[[3.5+ep,ep],[ep,15],[44-ep,15],[40.5-ep,ep]]);
  }
  translate([0,80,0]) cylinder(15,ep+3,ep+3);
  translate([0,-80,0]) cylinder(15,ep+3,ep+3);
  dz=ep/2+7.5-aju;
  for (y=[0:20:80]) {
    translate([0,y,dz]) cube([44-2*ep,ep,15-ep],center=true);
    if (y!=0) translate([0,-y,dz]) cube([44-2*ep,ep,15-ep],center=true);
  }  
  translate([0,0,dz]) cube([ep,192-aju,15-ep],center=true);
}

difference() {
  matiere();
  // TROUS DIAMETRE 6
  translate([0,80,-10]) cylinder(35,trouvis/2,trouvis/2);
  translate([0,-80,-10]) cylinder(35,trouvis/2,trouvis/2);
}
