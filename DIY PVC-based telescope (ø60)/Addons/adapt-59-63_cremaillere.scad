// ADAPTATION CREMAILLERE 59 SUR TUBE 63
// V2 - Avec chanfreins
// Pierre REVEL 22/02/25

include <BOSL2/std.scad>

$fn=100;
aju=0.6;

diamex=69.0;
tube63=63.0;
tube59=59.25;

module matiere() {
    difference() {
        translate([0,0,16]) cylinder(h=32,d=diamex,center=true);
        // chanfrein externe supérieur
        up(32) chamfer_cylinder_mask(d=diamex, chamfer=1);
        // chanfrein exerne inférieur
        rotate([180,0,0]) chamfer_cylinder_mask(d=diamex, chamfer=1);
    }
}

module antimatiere() {
  // insertion haute tube PVC
  translate([0,0,16]) cylinder(h=100,d=tube63+aju);
  // passage coulant interne crémaillère
  translate([0,0,-50]) cylinder(h=100,d=tube59+aju);
  // insertion basse tube PVC
  translate([0,0,-94]) {
      difference() {
          cylinder(h=100,d=tube63+aju);
          up(100) chamfer_cylinder_mask(d=tube63+aju, chamfer=2);

      }
  }
}

module chanfreins_interieurs() {
  //chanfrein intérieur haut
  translate([0,0,30]) difference() {
    cylinder(h=32,d=tube63+aju+2);
    rotate([180,0,0]) chamfer_cylinder_mask(d=tube63+aju+2, chamfer=2);
  }
  //chanfrein intérieur bas
  translate([0,0,-30]) difference() {
    cylinder(h=32,d=tube63+aju+2);
    up(32) chamfer_cylinder_mask(d=tube63+aju+2, chamfer=2);
  }
}

difference() {
  matiere();
  antimatiere();
  chanfreins_interieurs();
  // morceau plus court pour vérification des diamètres
  //translate([0,0,58]) cube([100,100,100], center=true);
}

