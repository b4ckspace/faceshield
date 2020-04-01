$fa = 6;
$fs = 1;

module mushroom (h=6) {
    translate([0, h-3.5, -0.5])
    union(){
        difference() {
            cylinder(1, d=8);
            translate([0, -7, 0])cylinder(h=3, d=16, center=true);
        };
        translate([0, 2-(h/2), 0.5])cube([4, h, 1], center=true);
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

module clip(wo, wi) {
    difference() {
        roundedRectangle(3*wo+(wo-wi), wo, 1, 5);
        translate([1*wo, 0, 0])difference() {
            roundedRectangle(wi, wi, 2, 1);
            translate([0.5*wi, 0, 0])roundedRectangle(wi, wi/2, 3, 2);
        }
        roundedRectangle(wi, wi, 2, 1);
        translate([-wo, 0, 0])roundedRectangle(wi, wi, 2, 1);
    }
}

module outer(lt, l, w, wi) {
    difference() {
        union(){
            translate([-2*w, (w-wi)/2])roundedRectangle(lt-4*w, wi, 1, wi/2);
            roundedRectangle(70, w, 1, wi/2);
            translate([lt/2-2.6*w, (w-wi)/2])clip(w, wi);
            for (posx=[-2.5*79+2.5, -1.5*79, -0.5*79, 0.5*79, 1.5*79, 2.5*79-2.5]) {
                translate([posx, w/2, 0])mushroom();
            }
            for (msx = [-1, 1])scale([msx, 1, 1]) {
                translate([l/2+1.25*w, 0, 0])roundedRectangle(3*w, w, 1, 3);
            }
        }
        // inner connection
        translate([0, w/8+1, 0])roundedRectangle(45, 1, 2, 0.5);
        translate([0, -w/8-1, 0])roundedRectangle(45, 1, 2, 0.5);
        roundedRectangle(1, w/4+2, 2, 0.5);

        for (i = [-1, 1])scale([i, 1, 1]) {
            // inner connection
            translate([w/4, 0, 0])roundedRectangle(w/4, w/8, 2, 0.5);
            // outer connection
            translate([l/2+w/2, 0, 0])roundedRectangle(w, w/2, 2, 0.5);
            translate([l/2+2*w, 0, 0])roundedRectangle(w, w/2, 2, 0.5);
        }
        for (i = [1:10]) translate([i*w-lt/2, (w-wi)/2, 0])roundedRectangle(0.75*wi, wi/2, 2, 0.5);
    }
}

module inner(l, w) {
    difference() {
        union() {
            roundedRectangle(l, w, 1, 1);
            for (sx = [-1, 1]) scale([sx, 1, 1]) {
                translate([l/2, 0, 0])roundedRectangle(6*w, w/2, 1, w/4);
                translate([l/2+w, 0, 0])roundedRectangle(w, w, 1, 1);
            }
        }
        // inner connection
        translate([0, w/8, 0])roundedRectangle(45, 1, 2, 0.5);
        translate([0, -w/8, 0])roundedRectangle(45, 1, 2, 0.5);
        roundedRectangle(1, w/4, 2, 0.5);
        for (i = [-1, 1])for (j = [-3*w/32, +3*w/32])scale([i, 1, 1]) {
            translate([w/4, j, 0])roundedRectangle(w/4, w/16, 2, 0.5);
        }
    }
}


module shieldclip(w, l) {
    difference() {
        roundedRectangle(l, 2*w, 1, 2);
        roundedRectangle(l-w, 2, 2, 2);

        translate([(l-w)/2, 0, 0])roundedRectangle(2, w+2, 2, 1);
        translate([-(l-w)/2, 0, 0])roundedRectangle(2, w+2, 2, 1);
    }
}

module topshield() {
    union() {
        translate([0, -175, 0])
        difference() {
            cylinder(1, d=350, center=true);
            translate([0, -60, 0])cube([350, 350, 3], center=true);
        }
        for (sx = [-1, 1]) scale([sx, 1, 1]) {
                translate([90, -17, 0])rotate(-30)shieldclip(13, 30);
        }
    }
}

module bottom(w) {
    scale([1, 1.2, 1])
    union() {
        roundedRectangle(w-4, 7, 1, 2);
        for (i = [-1, 1]) scale([i, 1, 1])translate([w/2-4, 0, 0])rotate(-90)mushroom();
    }
}

projection()
{
    outer(780, 280, 18, 12);
    translate([0, -20, 0])inner(200, 18);
    translate([0, -40, 0])bottom(60);
    translate([0, -60, 0])topshield();
}
