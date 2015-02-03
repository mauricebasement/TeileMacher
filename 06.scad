//Variables
size	=	450;	//Grösse der Platte
profileDist = 200; //Abstand Profile von (0/0)
connScrewDist = size - 5; //Schraube Abstand
tol = 0; //Squares Tolerance
//Modules
	//Platten
module platte1() {
	difference() {
		base();
		conn_screws();
	}
}
module platte2() {
	difference() {
		base();
		conn_screws();
		profile_cut();
		z_holes();
	}
}
module platte3() {
	difference() {
		base();
		conn_screws();
		profile_cut();
		z_holes();
	}
}
module platte4() {
	difference() {
		base();
		conn_screws();
	}
}
  //Seiten
module seite() {
	length = profileDist*2+20+10;
	difference() {
		square([110,length]);
		squares(x=22);
		translate([0,length-5])squares(x=22,o=1);
	}
}























//Helper Modules
module z_holes() {
 ///////////////////////////////////////////////////////////////////////////////////////////
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
module conn_screws() {
	for(i=[0:3])rotate(a=[0,0,i*90])translate([connScrewDist,connScrewDist])circle(r=1.5);
}
module t_slot() {
	translate([0,3.25])square([2.8,6.5],center=true);
	translate([0,3.5])square([2.5+2.8,1.65],center=true);
}
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws) {	
	if (face==true) square(42.4,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5,$fn=50);
	if (screw_i==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([15.5,15.5])circle(r=1.5,$fn=50);
	if (hole==true) circle(r=11,$fn=50);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5,$fn=50);
}
module mirror() {
	y=20.1;
	color("red")translate([-100,-100])hull()for (x=[[y,y],[200-y,y],[200-y,200-y],[y,200-y]])translate(x)circle(r=20,$fn=20);
}

//Render
seite();
