$fa = 1;
$fs = 0.2;

difference()
{
difference()
{cylinder(h=3,r=15);
translate([34,0,-0.5]) cylinder(h=4,r=37);
}
translate([0,0,47]) difference()
{cylinder(h=3,r=17);
translate([29.4,0,-0.5]) cylinder(h=4,r=34);
}
translate([-9,0,-0.5])cylinder(h=5,r=4);
}



translate([0,0,47])
difference()
{
difference()
{cylinder(h=3,r=15);
translate([34,0,-0.5]) cylinder(h=4,r=37);
}
translate([0,0,47]) difference()
{cylinder(h=3,r=17);
translate([29.4,0,-0.5]) cylinder(h=4,r=34);
}
translate([-9,0,-0.5])cylinder(h=5,r=1.5);
}


union()
{
translate([0,13.008,0]) cylinder(h=50,r=2);
translate([0,-13.008,0]) cylinder(h=50,r=2);
}

translate([-9,0,0])
union()
    {
translate([-5,-1,0])cube([10,2,3]);
translate([-1,-5,0])cube([2,10,3]);
cylinder(h=3,r=2.5);
    }

 

difference()
{
difference()
{
translate([0,0,20])
difference()
{translate([32,0,0]) cylinder(h=10,r=36.539);
translate([34,0,-1]) cylinder(h=17,r=37);
}
union()
translate([0,0,17])
{
translate([0,38.7,0]) cylinder(h=16,r=25);
translate([0,-38.7,0]) cylinder(h=16,r=25);
}
};
translate([0,13.008,20])
difference()
{cylinder(h=5,r=4);cylinder(h=5,r=2);};
translate([0,-13.008,20])
difference()
{cylinder(h=5,r=4);cylinder(h=5,r=2);};
}
