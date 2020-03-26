$fa = 6;
$fs = 0.5;

module mushroom (h=6) {
    translate([0, h-3.5, -0.5])
    union(){
        difference() {
            cylinder(1, d=7);
            translate([0, -7, 0])cylinder(h=3, d=16, center=true);
        };
        translate([0, 2-(h/2), 0.5])cube([4, h, 1], center=true);
    }
}


module holes(w) {
    for (i = [-1, 1]) {
        for (j = [0, 1]) {
            translate([i*(w/2 - j*20), 0, 0])
                        cylinder(2, d=4.4, center=true);
        }
    }
}

module roundover(r, w) {
    for (i = [-1, 1]) {
        scale([i, 1, 1])translate([w/2, 0, 0])difference() {
            cube([2*r, 2*r, 3], center=true);
            translate([-r, 0, 0])cylinder(h=3, r=r, center=true); 
        }
    }
}

module outer(w) {
    difference() {
        union(){
            cube([420, w, 1], center=true);
            for (i=[-2.5:2.5]) {
                translate([i*79, w/2, 0])mushroom();
            }
        }
        holes(420-w-40);
        for (i = [-1, 1]) {
            translate([i*((420-w)/2), 0, 0])
                cylinder(h=3, d=6, center=true);
        }
        roundover(w/2, 420);
    }
}


module inner(w) {
    difference() {
        cube([330, w, 1], center=true);
        holes(330-w);
        roundover(w/2, 330);        
    }
}


projection() 
{
    outer(12);
    translate([0, -20, 0])inner(12);
}
