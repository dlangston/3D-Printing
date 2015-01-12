//LED CLAMP
//(c) Kai Dupke
//License: GPL

//high of the LED profile
h=9;

//width of the LED profile
w=14.5;

//how much of the LED profile to be mounted?
d=6;

//which size for the hole for wires?
d1=2;

//How thick shall the hooks be?
t1=2.5;

//How thick shall the clamp bridge be?
t2=1.25;

//high of the clamp
w1=4;

//depth of the hook
t3=2;

//profile width
l1=20;

//distance from edge to slot
l2=7;

//How much extra space needed to make print fit?
x=0.25;

union() {
	//let us do the level on top of the profile first
	cube([t2,l1+2*t1+x,w1]);

	//now the first hook
	hook();

	//second hook
	//hook mirrored and moved to the other side
	translate([0,l1+t1+t1+x,0]){
		mirror([0,1,0]){
			hook();}
	}

	//add the LED mount itself
	
	//all together centered
	translate([0,(l1+2*t1-(w+2*t2))/2,0]){
		difference(){
			union(){
				//bottom plate
				cube([t2,w+2*t2+x,d+t2]);
		
				//top plate
				translate([-(t2+h+x),0,0]){
					cube([t2,w+2*t2+x,d+t2]);
				}

				//rear plate
				translate([-(h+x),0,0]){
					cube([h+x,w+2*t2+x,t2]);
				}

				//left plate
				translate([-(h+x),0,0]){
					cube([h+x,t2,d+t2]);
				}
	
				//right plate
				translate([-(h+x),w+x+t2,0]){
					cube([h+x,t2,d+t2]);
				}
			}

			//hole for wires
			translate([-(d1/2),(w+2*t2+x)/2,0]){
				cylinder(h= t2,r = d1/2,$fn=100);
			}
		}

	}

}

module hook()
{
	//one leg
	cube([l2+t2+2*t3+x,t1,w1]);

	//the hook
	translate ([l2+t2+x,t1,0]){
		polyhedron ( points = [[0,0,0],[2*t3,0,0],[t3,t3,0],[0,t3,0],[0,0,w1],[2*t3,0,w1],[t3,t3,w1],[0,t3,w1],[0,t3,w1]],
		triangles = [[0,5,1],[5,0,4],[1,6,2],[6,1,5],[2,6,3],[6,7,3],[7,4,0],[0,3,7],[5,4,6],[4,7,6],[0,1,2],[2,3,0]]);
	}
}
