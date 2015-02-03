b=230;
l=240;

difference() {
	translate([a,0,0])square([l,b]);
	translate([0,0.5*(b-212.1),0])cut_wheel();
}
module cut_wheel(){
	for(x=[40:60:160]) {
		translate([x,0,0])circle(r=7.55);
		translate([x,212.1,0])circle(r=7.55);
	}
}

!difference() {
	translate([-(l-200)/2,0,0])square([l,b]);
	union() {
		translate([0,0.5*(b-212.1),0])cut_screws();
	}
}

module cut_screws(){
	for(x=[40:60:160]) {
		translate([x,0,0])circle(r=2);
		translate([x,212.1,0])circle(r=2);
	}
}

