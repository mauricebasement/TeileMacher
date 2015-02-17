//Variables
$fn=50;
size	=450;	//Grösse der Platte
profileDist = 200; //Abstand Profile von (0/0)
connScrewDist = size/2 - 10; //Schraube Abstand
tol = 0; //Squares Tolerance
length = profileDist*2+20+10; //Länge der Seiten
wheelDist = 212.1; //Distanz zwischen Spiegelhalterrädern
wheelOffset = 60; //Abstand der Spiegelhalterräder 
platformX = 225;
platformY = 200;
thight = 0.2; //Platform Bearing thightener

//Modules
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
		translate([130,0])motor(face=true,cable=true,screw_d=23.5,screw_e=true);
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
module seite(rev=false) {
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
		translate([27.5,25+27.5])motor(hole=true,face=true,screw_d=23.5,screws=true);
		translate([27.5,length-(25+27.5)])rotate(a=[0,0,180])motor(rod=true,screw_d=23.5,screws=true,rod_hole=true);
		for(i=[25,length-30])translate([55,i])squares(x=11,o=1);
		for(j=[15,length-15])for(i=[20,90])translate([i,j])circle(r=2.5);
	}
}
module middle_motor(rod=false,bearing) {
	difference() {
		square(55);
		if(rod==false)translate([27.5,27.5])motor(screw_i=true,screw_d=23.5,screws=true,hole=true);
		if(rod==true)translate([27.5,27.5])motor(rod=true,screw_d=23.5,screws=true,rod_hole=true);
		if(bearing==true)translate([27.5,27.5])circle(r=8);
	}
}
module inside() {
	difference() {
		square([55,2*profileDist+30]);
		for(j=[15,2*profileDist+30-15])for(i=[10,45])translate([i,j])circle(r=2.5);
		translate([27.5,27.5+25])motor(hole=true,screw_i=true,screws=true,screw_d=23.5,rod_hole=true);
		translate([27.5,2*profileDist+30-27.5-25])motor(rod=true,rod_hole=true,screw_d=23-5,screws=true);
		for(i=[0,2*profileDist+25])translate([0,i])squares(x=11);
	}
}
module z_motor_cover() {
	difference() {
		square(65,center=true);
		z_motor_cut();
		motor(hole=true,screw_d=23.5,screw_e=true,screw_i=true);
	}
}
module linear_middle(r=4.2) {
	corners();
	difference() {
		square(20,center=true);
		circle(r=r,$fn=50);
	}
}
module linear_middle_hold(r=4.2) {
	difference() {
		union() {
			translate([0,17.5])square([34,15],center=true);
			translate([-17,12.5])square([34,17]);
		}	
		translate([0,17.5])circle(r=4.4);
		translate([0,26])circle(r=1.5);
		for(i=[-1,1])translate([-12.5*i,16.5])circle(r=1.5);
	}
	difference() {
		square([34,25],center=true);
		circle(r=r,$fn=50);
		corners();
	}
}
module linear_side(two=false) {
	for(i=[0,1])mirror([i,0,0])for(i=[-7.5,0,7.5])translate([29,i])square(5,center=true);
	difference() {
		translate([0,12.5])square([53,50],center=true);
		for(i=[0,180])rotate(a=[0,0,i])for(i=[-7.5,0,7.5])translate([0,i])for(i=[0,9,20,29])translate([i,0])square(5,center=true);
		for(i=[-1,1]) {
			translate([i*14.5,0])for(i=[-1,1])translate([0,i*9])circle(r=1.5);
			translate([i*24,35])circle(r=1.35);
			for(j=[-1,1])translate([i*10,j*5+30])square(5,center=true);	
		}
		for(i=[0,1])mirror([i,0,0])translate([9,12.5])translate([17.5,4])rotate(a=[0,0,90])t_slot();
		if (two==true)for(i=[-1,1])translate([i*19,30])circle(r=4);
		if (two==false)translate([0,30])	circle(r=4);
	}
}
module linear_spacer() {
	for(i=[-1,1])for(j=[-1,1])translate([j*12.5,i*5])square(5,center=true);
	square([20,15],center=true);
}
module z_spacer() {
	for(i=[-1,1])for(j=[-1,1])translate([j*12.5,i*7.5])square(5,center=true);
	difference() {
		square(20,center=true);
		circle(r=4);
	}
}
module z_motor_spacer(motorH=30,cable=false) {
	for(i=[-1,1])for(j=[-1,1])translate([j*15,i*(motorH/2+2.5)])square(5,center=true);
	difference() {
		square([35,motorH],center=true);
		if(cable==true)translate([0,motorH/2-2.5])square(5,center=true);
	}
}
module extruder_side() { //Probably needs update for rod distance
	difference() {
		square([72,22],center=true);
		for(i=[-1,1])translate([i*25,0])circle(r=7.5);		
		for(i=[0,1])mirror([i,0,0])for(i=[-8,8])for(j=[32.5,17])translate([j,i])circle(r=1.5);
	}
}
module platform1() {
	difference() {
		square([platformX,platformY],center=true);
		for(j=[-wheelOffset,wheelOffset])for(i=[-1,1])translate([i*wheelDist/2,j])circle(r=2);
		for(i=[0:3])rotate(a=[0,0,90*i+45]) {
			translate([0,63])for(j=[-17.5,17.5]) {
				translate([j,0])square(5,center=true);	
				circle(r=1.5);
			}
		}
		platform_holes();
	}
}
module platform_leg(h=60,b=40) {
	difference() {
		square([b,h]);
		translate([b/2,0])t_slot();
	}
	for(i=[0,35])translate([i,-5])square(5);
}
module platform2(ra=16.5/2) {
	difference() {
		square([435,platformY+5],center=true);
		for(j=[-wheelOffset,wheelOffset])for(i=[-1,1])translate([i*wheelDist/2,j])rotate(a=[0,0,max(i,0)*180])circle(r=ra);
		for(i=[platformY/2-15,-platformY/2+15])translate([profileDist,i])platform_cut();
		translate([-profileDist,0])platform_cut();
		translate([130,i])brass_cut();
		platform_holes();
	}
}
module bearing_hold() {
	difference(){
		union() {
			square([25,24-thight],center=true);
			for(j=[-14.5+thight/2,14.5-thight/2])for(i=[-10,10])translate([i,j])square(5,center=true);
		}
		for(j=[-12.5])translate([0,j])t_slot();
		for(j=[12.5])translate([0,j])rotate(a=[0,0,180])t_slot();
		for(j=[-5,5])for(i=[-10,10])translate([i,j])square(5,center=true);
	}
}
module bearing_hold_middle() {
	difference(){
		union() {
			square([25,20],center=true);
			for(j=[-12.5,12.5])for(i=[-10,10])translate([i,j])square(5,center=true);
		}
		circle(r=7.5);
	}
}
module bearing_hold_cover() {
	difference(){
		square([31,35],center=true);
		platform_cut();
	}
}
module spacers() {
	for(j=[0:3])for(i=[0:4])translate([i*(4.1*2),j*(4.1*2)])spacer(r=2,d=2.5);
}
//Helper Modules
module z_holes() {
	for(i=[platformY/2-15,-platformY/2+15])translate([profileDist,i])circle(r=4);
	translate([-profileDist,0])circle(r=4);
}
module z_spacer_cut() {
	for(i=[-1,1])translate([i*7.5,2.5])square(5,center=true);
}
module z_motor_cut() {
	for(j=[0:3])rotate(a=[0,0,90*j])for(i=[1,-1])for(i=[-1,1])translate([26,i*15])square(5,center=true);
}
module spacer(r,d) {
	difference() {
		circle(r=r+d);
		circle(r=r);
	}
}
module platform_holes() {
	for(i=[0:3])rotate(a=[0,0,90*i])translate([50,50])circle(r=1.5);
}
module platform_cut() {
	circle(r=4.2);
	for(j=[-12.5,12.5])for(i=[-10,10])translate([i,j])square(5,center=true);
	for(j=[-12.5,12.5])translate([0,j])circle(r=1.5);
}
module brass_cut() {
	circle(r=5);
	for(i=[0:3])rotate(a=[0,0,90*i])translate([8,0])circle(r=1.5);
}
module rail_middle_squares() {
		for(i=[10,-15])translate([-225/2,i])squares(x=220/5,o=0);
		for(j=[0,1])mirror([0,j,0])for(i=[-95,-35,35,95])translate([i-2.5,10])square(5);
}
module corner() {
	for(i=[-7.5,0,7.5])translate([i,0])square(5,center=true);
}
module corners() {
	for(i=[1,3])rotate(a=[0,0,i*90])translate([0,12.5])corner();
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
	if (cable==true) translate([21+5,0])square(12,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5);
	if (screw_i==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([15.5,15.5])circle(r=1.5);
	if (hole==true) circle(r=11);
	if (rod==true) circle(r=4.3);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5);
	if (rod_hole==true) translate([17.5,0])circle(r=4);
}
module xy_holes(x,y,r) {
	for(i=[1,0])for(j=[0,1])mirror([0,j,0])mirror([i,0,0])translate([x,y])circle(r=r);
}
module x_holes(x,r) {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([x,x])circle(r=r);
}
module ikea_mirror() {
	y=20.1;
	color("red")translate([-100,-100])hull()for (x=[[y,y],[200-y,y],[200-y,200-y],[y,200-y]])translate(x)circle(r=20);
}

//Render
seite(); //2
seite(rev=true); //2
inside(); //4

middle_motor(rod=true); //8
middle_motor(rod=true,bearing=true); //8
middle_motor(); //16

linear_side(); //4
linear_side(two=true); //4
linear_middle(); //4
linear_middle(r=7.5); //16
linear_middle_hold(); //8
linear_spacer(); //8


platform1(); //1
platform2(); //1
platform_leg(); //4
bearing_hold(); //6
bearing_hold_middle(); //6
bearing_hold_cover(); //3
z_spacer(); //6
z_motor_spacer();	 //3
z_motor_spacer(cable=true);	 //1
z_motor_cover(); //1

spacers(); //1

platte1(); //1
platte2(); //1
platte3(); //1
platte4(); //1






