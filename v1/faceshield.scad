$fa = 6;
$fs = 1;

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

module roundedRectangle(x, y, z, r) {
    difference() {
        cube([x, y, z], center=true);
        for (sx = [-1, 1]) {
           for (sy = [-1, 1]) {
              scale([sx, sy]) {
                translate([x/2, y/2])difference() {
                    cube([2*r, 2*r, 2*z], center=true);
                    translate([-r, -r])cylinder(3*z, r=r, center=true);
                }
              }
            }
        }
    }
}

module outer(l, w) {
    difference() {
        union(){
            cube([l+w+40, w, 1], center=true);
            for (i=[-2.5:2.5]) {
                translate([i*79, w/2, 0])mushroom();
            }
            for (msx = [-1, 1]) {
                scale([msx, 1]) {
                    translate([(l-20)/2, 0, 0])roundedRectangle(32, 12, 1, 3);
                }
            }
        }
        holes(l);
        for (i = [-1, 1]) {
            translate([i*((l+40)/2), 0, 0])
                cylinder(h=3, d=6, center=true);
        }
        roundover(w/2, l+w+40);
    }
}


module inner(l, w) {
    difference() {
        cube([l+w, w, 1], center=true);
        holes(l);
        roundover(w/2, l+w);
    }
}


//projection()
{
    outer(370, 10);
    translate([0, -20, 0])inner(320, 12);
}
