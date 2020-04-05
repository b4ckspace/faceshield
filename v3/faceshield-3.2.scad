shield_width = 320;
shield_height = 220;

strap_length = 700;
strap_inner = 16;
strap_outer = 24;

$fa = 6;
$fs = .5;

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

module clip(wo, wi, f=.2) {
    difference() {
        roundedRectangle(3*wo+(wo-wi), wo, 1, 5);
        //for (x = [-1.5*wo+wi/2:wo/2:1.5*wo-wi/4])translate([x, 0, 0])roundedRectangle(wi/3, wi, 3, 1);
        translate([1*wo, 0, 0])difference() {
            roundedRectangle(wi, wi, 2, 1);
            translate([0.5*wi, 0, 0])roundedRectangle(wi, wi/3, 3, 2);
        }
        roundedRectangle(f*wi, wi, 2, 1);
        translate([-wo, 0, 0])roundedRectangle(f*wi, wi, 2, 1);
    }
}

module strap(lt, l, w, wi) {
    offset = 50;
    union() {
        difference() {
            union(){
                translate([-2*w-offset, 0])roundedRectangle(lt-4*w, wi, 1, wi/2);
                //roundedRectangle(l+40, w, 1, 5); // middle part
                translate([lt/2-2.6*w-offset, 0])clip(w, wi);
                /*
                for (msx = [-1, 1])scale([msx, 1, 1]) {
                    translate([l/2-45, 0, 0])roundedRectangle(20, wi+8, 1, 1);
                }*/
            }
            /*
            for (i = [-1, 1])for (j = [-1, 1])scale([i, j, 1]) {
                translate([l/2-15, wi/2+1])roundedRectangle(30, 2, 2, 1);
                translate([l/2-15, -(wi/2+1)])roundedRectangle(30, 2, 2, 1);
                difference() {
                    translate([l/2-15, wi/2+(w-wi)/4+1])cube([10, (w-wi)/2-2, 2], true);
                    translate([l/2-10, wi/2+(w-wi)/4+1])cylinder(5, d=(w-wi)/2-2, true);
                    translate([l/2-20, wi/2+(w-wi)/4+1])cylinder(5, d=(w-wi)/2-2, true);
                }

            }
            */
            for (x = [-lt/2-offset+w:wi:-l/2-25]) translate([x, 0])roundedRectangle(0.4*wi, wi/3, 2, 0.5);
            for (i = [-1, 1])scale([i, 1, 1]) {
                translate([l/2-25, 0])cylinder(3, d=3.1, center=true);
                /*
                translate([l/2-15, 0])roundedRectangle(1, wi/3+2, 2, 0.5);
                for (j = [-1, 1])scale([1, j, 1]) {
                    translate([l/2-5-4.5, wi/6+0.5])roundedRectangle(12, 1, 2, 0.5);
                }
                
                translate([l/2-25, 0])roundedRectangle(1, wi/3+2, 2, 0.5);
                for (j = [-1, 1])scale([1, j, 1]) {
                    translate([l/2-35+4.5, wi/6+0.5])roundedRectangle(12, 1, 2, 0.5);
                }
                */              
            }
        }
        difference() {
            for (i = [-1, 1])scale([i, 1, 1]) {
                translate([20, 0, 0])roundedRectangle(30, w/2, 1, 2);
                translate([5, 0, 0])roundedRectangle(9, 10, 1, 1);
            }
            for (i = [-1, 1])scale([i, 1, 1]) {
                // inner connection
                translate([3, 0, 0])roundedRectangle(0.6, w/8, 2, 0.05);
            }
        }
    }
}

module strap2(lt, l, w) {
    difference() {
        roundedRectangle(lt, w, 1, w/2);
        translate([-lt/2+120+25, 0, 0])cylinder(2, d=5.5, center=true);
        translate([-lt/2+120+l-25, 0, 0])cylinder(2, d=5.5, center=true);
    }
}

module shield(w, h, s=20) {
    union(){
        difference() {
            hull() {
                for (sx = [-1, 1])scale([sx, 1, 1]) {
                    translate([60, 40,])cylinder(1, r=40);
                    translate([w/2-20, h-40, 0])cylinder(1, r=20);
                    translate([w/2-10, h,])cylinder(1, r=10);
                    translate([105, h+40-2,])cylinder(1, r=2);
                    
                }
                
            }
            for (sx = [-1, 1])scale([sx, 1, 1]) {
                // Strap
                //translate([w/2, h-20])roundedRectangle(10, si, 2, 0.5);
                translate([w/2-35, h-20])
                    roundedRectangle(4, s, 2, 1);
                translate([w/2-15, h-20])
                    roundedRectangle(4, s, 2, 1);
                translate([w/2-25, h-20])
                    cylinder(2, d=3.1, true);
                /*
                translate([w/2-35, h-20+(so/2-(so-si)/4+1)])
                    roundedRectangle(4, (so-si)/2, 2, 1);
                translate([w/2-35, h-20-(so/2-(so-si)/4+1)])
                    roundedRectangle(4, (so-si)/2, 2, 1);
                */
                /*
                translate([w/2-35, h-20-si/4, 0])roundedRectangle(30, 3, 2, 1);
                translate([w/2-20, h-20, 0])roundedRectangle(2, si+1, 2, 1);
                translate([w/2-50, h-20, 0])roundedRectangle(2, si+1, 2, 1);

                translate([w/2-35, h-20-si, 0])roundedRectangle(51, 1, 2, .5);
                translate([w/2-10, h-19-si*3/4, 0])roundedRectangle(1, si/2+2, 2, .5);
                translate([w/2-60, h-19-si*3/4, 0])roundedRectangle(1, si/2+2, 2, .5);
                */
                // top fold
                translate([80, h+20, 0])cube([50, 40, 2], true);
            }
            translate([0, h+230])cylinder(3,d=400, true);
        }
        // top fold
        for (sx = [-1, 1])scale([sx, 1, 1]) {
            translate([80, h+10, 0])roundedRectangle(8, 40, 1, 4);
            hull() {
                translate([80, h+20, 0])cylinder(1, d=10);
                translate([80, h-1, 0])cube([40, 1, 1], true);
            }
            difference() {
                hull() {
                    translate([105, h+39, 0])cylinder(1, d=2);
                    translate([95, h+12, 0])cylinder(1, d=4.5);
                    translate([104, h, 0])cylinder(1, d=5);
                    translate([96, h+30, 0])cylinder(1, d=20);
                    
                }
                translate([98, h+30, 0])cylinder(1, d=10);
            }
            difference() {
                hull() {
                    translate([55, h+36.7, 0])cylinder(1, d=2.3);
                    translate([65, h+12, 0])cylinder(1, d=4.5);
                    translate([56, h, 0])cylinder(1, d=5);
                    translate([64, h+30, 0])cylinder(1, d=20);
                    
                }
                translate([62, h+30, 0])cylinder(1, d=10);
            }
        }
    }
}

projection()strap(strap_length, shield_width-60, strap_outer, strap_inner);
projection()translate([0, -300, 0])shield(shield_width, shield_height, strap_inner);
