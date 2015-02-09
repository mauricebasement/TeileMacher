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
		if(rod==false)translate([27.5,27.5])motor(face=true,screw_d=23.5,screws=true);
		if(rod==true)translate([27.5,27.5])motor(rod=true,screw_d=23.5,screws=true,rod_hole=true);
		if(bearing==true)translate([27.5,27.5])circle(r=8);
	}
}
module inside() {
	rear(rod=true); //4
	translate([55,length])rotate(a=[0,0,180])rear(); //4
	translate([0,80])square([55,length-160]);

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
	for(i=[0,1])mirror([i,0,0])translate([9,12.5])lead_hold();
	for(i=[0,1])mirror([i,0,0])for(i=[-7.5,0,7.5])translate([29,i])square(5,center=true);
	if (two==true) {	
		for(i=[-1,1])translate([i*19,-17.5])difference() {
			square([15,14],center=true);
			circle(r=4);
		}
	}
	if (two==false) {
		translate([0,-17.5])difference() {
			square([17,14],center=true);
			circle(r=4);
		}
	}
	difference() {
		square([53,25],center=true);
		translate([0,17.5])circle(r=4); // Other Rod
		for(i=[0,180])rotate(a=[0,0,i])for(i=[-7.5,0,7.5])translate([0,i])for(i=[0,9,20,29])translate([i,0])square(5,center=true);
		for(i=[-1,1])for(j=[14.5])translate([i*j,0])for(i=[-1,1])translate([0,i*9])circle(r=1.5);
		translate([0,17.5])circle(r=4);
	}
}
module extruder_hold() {
	difference() {
		square(60);
	}
}
module extruder_side() {
	difference() {
		square([72,22],center=true);
		for(i=[-1,1])translate([i*25,0])circle(r=7.5);		
		for(i=[0,1])mirror([i,0,0])for(i=[-8,8])for(j=[32.5,17])translate([j,i])circle(r=1.5);
	}
}
module platform1() {
	difference() {
		square([platformX,platformY],center=true);
		for(j=[-wheelOffset,0,wheelOffset])for(i=[-1,1])translate([i*wheelDist/2,j])circle(r=1.5);
	}
}
module platform2(ra=15.5/2) {
	difference() {
		square([platformX,platformY],center=true);
		for(j=[-wheelOffset,0,wheelOffset])for(i=[-1,1])translate([i*wheelDist/2,j])rotate(a=[0,0,max(i,0)*180])
			hull(){
				circle(r=ra);
				translate([-20,0])square([1,ra*2],center=true);
			}
		platform_squares();
	}
}
module rail() {
	for(i=[-90,-100,-40,-30,30,40,90,100])translate([i-2.5,-12])square(5);
	difference() {
		translate([0,-5])square([platformX+40,20],center=true);
		for(i=[0,-12])translate([-225/2,i])squares(x=220/5,o=0);
		for(i=[-95,-35,35,95])translate([i,-9.5])circle(r=1.5);
	}
}
module rail_middle() {
	difference() {
		union() {
			square([platformX,30],center=true);
			square([platformX+40,20],center=true);
		}
		rail_middle_squares();
		for(j=[0,1])mirror([0,j,0])for(i=[-95,-35,35,95])translate([i,3.5])t_slot();
	}
}
module side_one() {

}
module side_two() {

}
//Helper Modules
module z_holes() {
 ///////////////////////////////////////////////////////////////////////////////////////////
}
module platform_squares() {
		for(i=[-45,-20,20,45])translate([-225/2,i-2.5])squares(x=215/5,o=1);		
}
module rail_middle_squares() {
		for(i=[10,-15])translate([-225/2,i])squares(x=220/5,o=0);
		for(j=[0,1])mirror([0,j,0])for(i=[-95,-35,35,95])translate([i-2.5,10])square(5);
}
module lead_hold() {
	difference() {
		translate([5,0])square([12.5,10]);
		translate([17.5,4])rotate(a=[0,0,90])t_slot();
	}
}
module rear(rod=false) {
	difference() {
		back();
		translate([0,25])inv_rear(rod=rod);
		for(i=[10,45])translate([i,15])circle(r=2.5);
	}
}
module corner() {
	for(i=[-7.5,0,7.5])translate([i,0])square(5,center=true);
}
module corners() {
	for(i=[1,3])rotate(a=[0,0,i*90])translate([0,12.5])corner();
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
module mirror_plate() {
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
linear_middle(); //4
linear_middle(r=7.5); //16
linear_middle_hold(); //8
linear_side(); //4
linear_side(two=true); //4
platform1();
platform2();
rail();
rail_middle();
side_one();
side_two();



platte1(); //1
platte2(); //1
platte3(); //1
platte4(); //1






