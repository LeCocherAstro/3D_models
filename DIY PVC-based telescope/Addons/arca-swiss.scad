// QUEUE D'ARONDE ARKA-SWISS POUR TREPIED ULANZI VIDEO OMBRA
// Pierre REVEL 15/06/24
//
// Projet lunette PVC 60 mm DIY
// Spécifiquement conçue pour les colliers pour tubes diamètre 63 et leurs vis de fixation murale 30 mm

$fn=72;

longueur=160;   // Longueur queue d'aronde
ecart=133;      // Ecart entre les colliers
trouvis=5;      // Diamètre des trous

module matiere() {
  union() {
    translate([-20.5,0,0]) rotate([90,0,0]) linear_extrude(height=longueur,center=true) polygon(points=[[0,0],[0,3],[7,10],[34,10],[41,3],[41,0]]);
    translate([0,ecart/2,0]) cylinder(25,13,13);
    translate([0,-ecart/2,0])  cylinder(25,13,13);
  }
}

module percage() {
  translate([0,ecart/2,-10]) cylinder(45,trouvis/2,trouvis/2);
  translate([0,-ecart/2,-10])  cylinder(45,trouvis/2,trouvis/2);
}

difference() {
  matiere();
  percage();
}
