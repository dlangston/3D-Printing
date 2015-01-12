include <MCAD/boxes.scad>

// Created by Jeremy Herrman ( @jherrm, jeremy@jherrman.com )
// Sept 2011

module LaptopArm(w,l,h1,h2,gap) {
	wiggle = 1;
	wall = 4;

	//back
	cube([w,l,h2]);

	translate([0,-(gap+wall),h2-wall]) {
		// top
		cube([w,gap+wall,wall]);

		//front 
		translate([0,-wall,-h1+wall]) {
			cube([w,wall,h1]);
		}
	}
}

// define inner dimensions (how big the box will be inside)
// Dimensions are millimeters
w = 87;
l = 70;
h = 20;
cr = 25;
cable = 8;

wall = 6;
wiggle = 2; // wiggle room added to inside of box

//origins
o_x = -1*((w+wall*2)/2); // left
o_y = -1*((l+wall*2)/2); // front
o_z = -1*((h+wall)/2); // bottom

tab_w = 40;
tab_front_h = 15;
tab_back_h = h+wall;
tab_l = -1*o_y;
gap = 20;//change this number to adjust for laptop screen thickness

cable_guide_w = 8;
cable_guide_h = h+wall*2;

union() {
	difference() {
		// outside box needs to fit whatever object is defined above
		roundedBox([w+wall*2, l+wall*2, h+wall], cr + wall/2, true);

		union() {
			// inside box
			translate([0,0,((h+wall*2)/2) - ((h+wiggle*2)/2)]) roundedBox([w+wiggle*2, l+wiggle*2, h+wiggle*2+1], cr, true);

			// cable guide
			translate([0, -o_y-wall/2+1, o_z+cable_guide_h/2-wall/2]) {
				//rotate([90,0,0]) cylinder(wall/2+12,5,5);
				rotate([90,0,0]) roundedBox([cable_guide_w, cable_guide_h, wall], 2, true);
			}

		}
	}

	difference() {
		union() {
			translate([o_x,o_y,-o_z - tab_back_h]) {
				LaptopArm(tab_w,tab_l,tab_front_h,tab_back_h,gap);
			}
			translate([-o_x - tab_w,o_y,-o_z - tab_back_h]) {
				LaptopArm(tab_w,tab_l,tab_front_h,tab_back_h,gap);
			}
		}

		// inside box
		translate([0,0,((h+wall*2)/2) - ((h+wiggle*2)/2)]) roundedBox([w+wiggle*2, l+wiggle*2, h+wiggle*2+1], cr, true);
	}

}