use<modules.scad>
module side(front=false,rear=false,rod=false) {
	difference() {
		square([55+25,55]);
		for(i=[1:2:11])translate([0,i*5])square(5);
		for(i=[1:3])translate([15,i*55/3-(55/6)])circle(r=2.5,$fn=50);
		if(front==true)translate([27.5+25,+27.5])motor(hole=true,screw_i=true,screw_d=23.5,screws=true);
		if(rod==true)translate([27.5+25,10])circle(r=4,$fn=50);
		if(rear==true)translate([27.5+25,+27.5])motor(face=true,screw_d=23.5,screws=true);
	}
}
module inversion() {
	intersection() {
		square([5,55]);
		side();
	}
}
module middle_motor() {
	intersection() {
		side(rear=true);
		translate([25,0])square(55);
	}
}
module middle_motor2(rod,bearing) {
	difference() {
		intersection() {
			side(rod=true);
			translate([25,0])square(55);
		}
		translate([27.5+25,+27.5])motor(screw_d=23.5,screws=true);
		if(rod==true)translate([27.5+25,+27.5])circle(r=4.2,$fn=50);
		if(bearing==true)translate([27.5+25,+27.5])circle(r=8,$fn=50);
	}
}
module back() {
	difference() {
		square([30,55]);
		inversion();
		translate([25,0])inversion();
		for(i=[1:3])translate([15,i*55/3-(55/6)])circle(r=2.5,$fn=50);
	}
}
module side_rod() {
	difference()	{
		side(rod=true);
		translate([27.5+25,27.5])circle(r=4.2,$fn=50);
		translate([27.5+25,+27.5])motor(screw_d=23.5,screws=true);
	}
}
//Front_Motor
side(front=true,rod=true);
//Rear_Motor
side(rear=true);
//Rear_Rod
side_rod();
//Middle_Motor
middle_motor();
//Middle_Rod
middle_motor2(rod=true);
//Middle_Bearing
middle_motor2(bearing=true);
//Back
back();


