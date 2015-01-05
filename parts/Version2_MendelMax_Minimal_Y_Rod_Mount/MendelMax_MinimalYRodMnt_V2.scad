//This is a replacement Y rod mount for MendelMax type printers.

//Advantages over stock part:
//1. Clamps rods to aluminum extrusions, ensuring more level travel
//2. Since rods are higher, less Y carriage elevation is needed leading
//		to a lighter carriage.
//3. Uses little plastic. Consists of just 4 small parts.
//4. Parametric

//Advantages over my V1 minimalist mount:
//1. Fewer parts/easier to assemble/easier to print
//2. Uses M5x20 socket head screws which are already recommended
//		for MendelMax builds. Socket heads are also easy to tighten
//		from the side with pliers. M5x16 might work with 8mm rod, 
//		change m5_length to 16 and try.
//3. 10mm Y-rod ready, change rod_diameter to 10 and print
//4. Beefed up for durability (I recommend ABS or Polycarbonate for
//		durabilities sake)

//Release under CC-BY-NC-SA-3.0
//by Thomas Fulenwider a.k.a. cobra18t


//uses configuration.scad and functions.scad from prusa's i3 repository
include <configuration.scad>


//**start defs**

rod_diameter=8;		//diameter of Y-rod
rod_clearance=0.3;	//clearance for Y-rod hole
rod_clamp = 0.1;		//offset to ensure rod-extrusion interference
m5_diameter=5.3;	//diameter for mounting holes
m5_length = 20;		//mounting screw length

depth=16;				//should be 12<depth<extrusion_width
width=rod_diameter+24;
height=m5_length-6;

//**end defs**


minimalYRodMnt();

module minimalYRodMnt(){
	difference(){
		cube_fillet([width,depth,height],vertical=[6,6,6,6],$fn=30);
		
		//mounting holes
		translate([(width-rod_diameter)/4,depth/2,0]) 
			cylinder(h=height,r=m5_diameter/2, $fn=20);
		translate([width-(width-rod_diameter)/4,depth/2,0]) 
			cylinder(h=height,r=m5_diameter/2, $fn=20);

		//rod hole
		translate([width/2,-0.01,height+rod_clamp-rod_diameter/2]) rotate([-90,0,0]) 
			cylinder(h=depth+0.1,r=(rod_diameter+rod_clearance)/2, $fn=30);
		translate([width/2,depth/2-0.01,height-rod_diameter/4])
			cube([rod_diameter/1.4,depth+0.1,rod_diameter], center=true);
	}

}