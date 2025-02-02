include <BOSL2/std.scad>

$fn = 100;
chouilla = 0.2;

diam_int_tube = 97+chouilla;
diam_ext_tube = 100;

ep_lentille = 12;
diam_lentille = 82;
rattrap_diam_lentille = 1.6;
diam_utile = 80;
long_suppl_dans_tube = 8;

diam_vis = 4;


module A1_base() {
    difference() {
        // corps du support de lentille
        translate([0,0,(ep_lentille+long_suppl_dans_tube)/2]) cylinder(h=ep_lentille+long_suppl_dans_tube, d=diam_int_tube, center=true);
        // chanfrein pour aider à l'insertion de la pièce dans le tube de ø100
        up(ep_lentille+long_suppl_dans_tube) chamfer_cylinder_mask(d=diam_int_tube, chamfer=2);
        // logement lentille
        translate([0,0,-chouilla+ep_lentille/2]) cylinder(h=ep_lentille, d=diam_lentille+rattrap_diam_lentille, center=true);
        // passage lumière
         cylinder(h=50, d=diam_utile, center=true);
    }
}

module A1_lighten() {
    // rétrécit A1_base pour donner plus de passage à la lumière vers le fond du tube
    difference() {
        cylinder(h=10, d=diam_int_tube-4, center=true);
        up(5) chamfer_cylinder_mask(d=diam_int_tube-4, chamfer=8);
    }
}

module trou_vis() {
    translate([diam_int_tube/2-(diam_int_tube-diam_lentille-rattrap_diam_lentille)/4, 0, 0]) cylinder(d=diam_vis, h=32, center=true);
}


module A1_complet(){
    difference() {
        A1_base();
        translate([0,0,ep_lentille+7]) rotate([180,0,0]) A1_lighten();
        rotate([0,0,0])   trou_vis();
        rotate([0,0,120]) trou_vis();
        rotate([0,0,240]) trou_vis();
    }
}

module A2_base() {
    difference() {
        // corps du maintien de la lentille
        translate([0,0,0]) cylinder(h=4, d=diam_ext_tube, center=true);
        // passage lumière
        cylinder(h=20, d=diam_utile, center=true);
        // chanfrein pour aider à l'insertion de la pièce dans le pare-soleil
        up(3) chamfer_cylinder_mask(d=diam_ext_tube, chamfer=2);
    }
}

module A2_lighten() {
    // rétrécit A2_base pour donner plus de passage à la lumière à l'entrée
    difference() {
        cylinder(h=10, d=diam_lentille+2, center=true);
        up(5) chamfer_cylinder_mask(d=diam_lentille+2, chamfer=4);
    }
}

module A2_complet() {
    translate([0,0,-10]) {
        difference() {
            rotate ([180,0,0]) A2_base();
            translate([0,0,-3]) A2_lighten();
            rotate([0,0,0])   trou_vis();
            rotate([0,0,120]) trou_vis();
            rotate([0,0,240]) trou_vis();
        }
    }
}

// affichage des pièces
color("red")  A1_complet();
color("blue") A2_complet();