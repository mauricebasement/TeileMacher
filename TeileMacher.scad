//Variables
$fn=50;
size	=	450;	//Grösse der Platte
profileDist = 200; //Abstand Profile von (0/0)
connScrewDist = size/2 - 10; //Schraube Abstand
tol = 0; //Squares Tolerance

//Modules
	//Platten
module platte1() {
	difference() {
		base();
		conn_screws();
		profile_screws();
	}
}
module platte2() {
	difference() {
		base();
		conn_screws();
		profile_cuts();
		z_holes();
	}
}
module platte3() {
	difference() {
		base();
		conn_screws();
		profile_cuts();
		z_holes();
	}
}
module platte4() {
	difference() {
		base();
		conn_screws();
		profile_screws();
	}
}
	//Seiten
module seite(rev=false) {
	length = profileDist*2+20+10;
	difference() {
		square([110,length]);
		if(rev==false)union() {
			squares(x=22);
			translate([0,length-5])squares(x=22,o=1);
		}
		if(rev==true)union() {
			squares(x=22,o=1);
			translate([0,length-5])squares(x=22);
		}
		translate([27.5,25+27.5])motor(hole=true,screw_i=true,screw_d=23.5,screws=true,rod_hole=true);
		translate([27.5,length-(25+27.5)])motor(rod=true,screw_d=23.5,screws=true,rod_hole=true);
		for(i=[25,length-30])translate([55,i])squares(x=11,o=1);
		for(j=[15,length-15])for(i=[20,90])translate([i,j])circle(r=2.5);
	}
}
module middle_motor(rod=false,bearing) {
	difference() {
		square(55);
		if(rod==false)translate([27.5,27.5])motor(face=true,screw_d=23.5,screws=true);
		if(rod==true)translate([27.5,27.5])motor(rod=true,screw_d=23.5,screws=true,rod_hole=true);
		if(bearing==true)translate([27.5,27.5])circle(r=8);
	}
}
module rear(rod=false) {
	difference() {
		back();
		translate([0,25])inv_rear(rod=rod);
		for(i=[10,45])translate([i,15])circle(r=2.5);
	}
}
//Helper Modules
module z_holes() {
 ///////////////////////////////////////////////////////////////////////////////////////////
}
module back() {
	difference() {
				square([55,55+25]);
				squares(x=11);
	}
}
module inv_rear(rod=false) {
	difference() {
		square(55);
		middle_motor(rod=rod);
	}
}
module squares(x,o=0) {
	for(i=[0:2:x])translate([o*5+i*5-tol,0])square([5+2*tol,5]);
}
module base() {
	square(size,center=true);
}
module profile() {
	import("dxf/profile.dxf");
}
module profile_cuts() {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([profileDist,profileDist])profile();
}
module profile_screws() {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([profileDist,profileDist])circle(r=2.5);
}
module conn_screws() {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([connScrewDist,connScrewDist])circle(r=1.5);
	for(i=[0:3])rotate(a=[0,0,i*90])translate([connScrewDist,0])circle(r=1.5);
}
module t_slot() {
	translate([0,3.25])square([2.8,6.5],center=true);
	translate([0,3.5])square([2.5+2.8,1.65],center=true);
}
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws,rod,rod_hole) {	
	if (face==true) square(42.8,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5);
	if (screw_i==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([15.5,15.5])circle(r=1.5);
	if (hole==true) circle(r=11);
	if (rod==true) circle(r=4);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5);
	if (rod_hole==true) translate([17.5,0])circle(r=4);
}
module mirror() {
	y=20.1;
	color("red")translate([-100,-100])hull()for (x=[[y,y],[200-y,y],[200-y,200-y],[y,200-y]])translate(x)circle(r=20);
}

//Render
seite(); //2
seite(rev=true); //2
middle_motor(rod=true); //8
middle_motor(rod=true,bearing=true); //8
middle_motor(); //16
rear(rod=true); //4
rear(); //4

platte1();
platte2();
platte3();
platte4();





