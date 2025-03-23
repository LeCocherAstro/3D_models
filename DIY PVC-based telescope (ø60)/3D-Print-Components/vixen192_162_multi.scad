// QUEUE D'ARONDE VIXEN 162 mm & 192mm
// Pierre REVEL 24/3/24
//
// Projet lunette PVC 60 mm DIY
// Queue d'aronde au format VIXEN 162mm (possibilité 192 mm) spécifiquement conçue pour
// les colliers pour tubes diamètre 63 et leurs vis de fixation murale
// fonctionne également pour les lunettes 80 mm DIY et les colliers pour tubes de 100mm

$fn=72;
aju=0.1;

ep=4;
trouvis=5.4; // diamètre trou des vis des colliers 

// 0 pour version 192mm, 30 pour version 162mm (réduite de 30mm)
reduc=0;
// le nombre de murs de renfort dans la largeur dépend de la version
wall_extent = reduc > 0 ? 100 : 80;  

// 0 = Vixen-only, 1 = Vixen + Ulanzi Ombra Video & Manfrotto photo tripods
multi_standard = 1;

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

module queue_aronde_ulanzi_ombra_video(length = 70, shrink = 0) {
    // set "shrink" to 1(mm) for Manfrotto compatibility, or 0 for original model

    width  = 41-shrink;
    height = 10;

    translate([-width/2, length/2, 0]) 
        rotate([90,0,0]) 
            linear_extrude(length) {
                polygon([[0,0],[12,0],[12,3],[width-12,3],[width-12,0],[width,0],[width,3],[width-4,height],[4,height],[0,3]]);
            }
}


union() {
    difference() {
      matiere();
      // TROUS DE DIAMETRE <trouvis>
      translate([0,80-reduc*2/3,-10]) cylinder(h=35,r=trouvis/2);
      translate([0,-80+reduc*2/3,-10]) cylinder(h=35,r=trouvis/2);
      if(multi_standard) {
          //translate([0,0,10+aju]) cube([20,76,10], center=true);
          translate([0,0,10+aju]) cube([100,62,10], center=true);
      }
    }
    if(multi_standard) translate([0,0,15]) rotate([0,180,0]) queue_aronde_ulanzi_ombra_video(length=64, shrink=1);
}

