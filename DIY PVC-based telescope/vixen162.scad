// QUEUE D'ARONDE VIXEN 162 mm & 192mm
// Pierre REVEL 24/3/24
//
// Projet lunette PVC 60 mm DIY
// Queue d'aronde au format VIXEN 162mm (possibilité 192 mm) spécifiquement conçue pour
// les colliers pour tubes diamètre 63 et leurs vis de fixation murale

$fn=72;
aju=0.1;

ep=4;
trouvis=5.4; // diamètre trou des vis des colliers 

// 0 pour version 192mm, 30 pour version 162mm (réduite de 30mm)
reduc=30;
// le nombre de murs de renfort dans la largeur dépend de la version
wall_extent = reduc > 0 ? 100 : 80;    

module matiere() {
    union() {
      difference() {
        // extérieur de la coque
        translate([-22,0,0]) rotate([90,0,0])
            linear_extrude(height=192-reduc,center=true) polygon(points=[[3.5,0],[0,15],[44,15],[40.5,0]]);
        // intérieur de la coque
        translate([-22,0,aju]) rotate([90,0,0])
            linear_extrude(height=192-reduc-2*ep,center=true) polygon(points=[[3.5+ep,ep],[ep,15],[44-ep,15],[40.5-ep,ep]]);
      }
      // renforts pour les vis des colliers
      translate([0,80-reduc*2/3,0]) cylinder(h=15,r=ep+3);
      translate([0,-80+reduc*2/3,0]) cylinder(h=15,r=ep+3);

      // murs de renfort dans la largeur  
      dz=ep/2+7.5-aju;
      for (y=[0:20:wall_extent-reduc]) {
        translate([0,y,dz]) cube([44-2*ep,ep,15-ep],center=true);
        if (y!=0) translate([0,-y,dz]) cube([44-2*ep,ep,15-ep],center=true);
      }
      // mur de renfort dans la longueur  
      translate([0,0,dz]) cube([ep,192-reduc-aju,15-ep],center=true);
    }
}

difference() {
  matiere();
  // TROUS DE DIAMETRE <trouvis>
  translate([0,80-reduc*2/3,-10]) cylinder(h=35,r=trouvis/2);
  translate([0,-80+reduc*2/3,-10]) cylinder(h=35,r=trouvis/2);
}

