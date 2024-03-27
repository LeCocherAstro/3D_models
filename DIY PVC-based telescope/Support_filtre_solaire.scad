// FILTRE SOLAIRE POUR LUNETTE DIY 60
// Version 2 : Pierre REVEL 26/3/24
// Femeture par 3 vis M2 de 6 mm - Les vis fixent le mylar (à trouer avant)
// Serrage sur le pare-soleil par vis nylon M4
// Deux pièces : 1 et 2 (piece=0 affiche les deux)
piece=0;

$fn=180;
aju=0.1;

diam1=70;
diam2=63;
diam3=60;

module chanfrein_cyl_ext(rayon,hauteur) {
  difference() {
    translate([0,0,hauteur-1]) cylinder(3,rayon+1,rayon+1);
    translate([0,0,hauteur-2]) cylinder(5,rayon+2,rayon-3);
   }
}

module chanfrein_cyl_int(rayon,hauteur) {
  translate([0,0,hauteur-1]) cylinder(3,rayon+2,rayon-1);
}

module solid1() {
  cylinder(15,(diam1/2),(diam1/2)+5);
  translate([0,0,15]) cylinder(10,(diam1/2)+5,(diam1/2)+5);
}

module usin1() {
  translate([0,0,-10]) cylinder(23,(diam2/2)+aju,(diam2/2)+aju);
  translate([0,0,-10]) cylinder(100,diam3/2,diam3/2);
  translate([0,0,17]) cylinder(100,(diam1/2)+2,(diam1/2)+2);
  for (angle=[0:120:360]) {
    rotate([0,0,angle]) translate([33.5,0,12]) cylinder(10,0.7,0.7);
    rotate([0,0,angle+60]) translate([36,0,17]) cylinder(10,2+2*aju,2+2*aju);
  }
  chanfrein_cyl_int(diam2/2,0);
  chanfrein_cyl_int(diam3/2,14-aju);
  // SERRAGE
  translate([0,0,7.5]) rotate([90,0,30]) {
    cylinder(50,2+aju,2+aju);
    linear_extrude(height=34.5) circle(r=4+aju,$fn=6);
  }
}

module piece1() { difference() { solid1(); usin1(); }}

module solid2() {
  cylinder(3,diam1/2+2-2*aju,diam1/2+2-2*aju);
  for (angle=[0:120:360]) {
    rotate([0,0,angle+60]) translate([36,0,0]) cylinder(3,2,2);
  }
}

module usin2() {
  translate([0,0,-10]) cylinder(100,diam3/2,diam3/2);
  for (angle=[0:120:360]) {
    rotate([0,0,angle]) translate([33.5,0,-10]) cylinder(20,1,1);
    rotate([0,0,angle]) translate([33.5,0,1.7]) cylinder(1.3+aju,1,2);
  }
}

module piece2() { difference() { solid2(); usin2(); }}

// IMPRESSION

if (piece==1) piece1();

if (piece==2) piece2();
  
if (piece!=1 && piece!=2) {
  piece1();
  translate([0,0,40]) piece2();
}