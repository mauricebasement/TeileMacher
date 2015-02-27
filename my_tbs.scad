$fn=40;
//Bearing Screw
rod=8;
br_o=4;
br_i=1.5;
o=30;
h=10;

module body() {
	difference() {
		cylinder(r=o/2,h=h);
		cylinder(r=rod/2,h=h);
	}
}





