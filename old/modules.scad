//Motor
module motor(face,cable,screw_e,screw_i,hole,screw_d,screws) {	
	if (face==true) square(42.2,center=true);
	if (cable==true) translate([21+5,0])square(10,center=true);
	if (screw_e==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([26,26])circle(r=1.5,$fn=50);
	if (screw_i==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([15.5,15.5])circle(r=1.5,$fn=50);
	if (hole==true) circle(r=11,$fn=50);
	if (screws==true) for(x=[1:4])rotate(a=[0,0,x*90])translate([screw_d,screw_d])circle(r=1.5,$fn=50);
}
//Spiegel
module mirror() {
	y=20.1;
	color("red")translate([-100,-100])hull()for (x=[[y,y],[200-y,y],[200-y,200-y],[y,200-y]])translate(x)circle(r=20,$fn=20);
}
//Profil
module profil() {
	import("dxf/profile.dxf");
}
module profil_ext(h) {
	linear_extrude(height=h,$fn=50)profil();
}
module profil_cut() {
	profil();
	circle(r=2.5,$fn=50);
}
module profil_schrauben(a) {
	for(x=[[-a,-a],[a,a],[-a,a],[a,-a]])translate(x)circle(r=2,$fn=50);
}
module profile(a) {
	for(x=[[-a,-a],[a,a],[-a,a],[a,-a]])translate(x)profil_cut();
}
//Lineare Führung
module linear_br() {
	cylinder(r=7.5,h=24,$fn=50);
}
//T-Slot
module t_slot() {
	translate([0,3.75])square([2.8,7.5],center=true);
	translate([0,5])square([2.5+2.8,1.65],center=true);
}
module t_slot1() {
	translate([0,3.25])square([2.8,6.5],center=true);
	translate([0,3.5])square([2.5+2.8,1.65],center=true);
}
!t_slot1();
