use<modules.scad>
//TeileMacher 08.11.2014
//Variabeln
a=160; //Abstand Profile (von (0/0))
b=110; //Abstand der Schraubenlöcher der Druckplatform
c=380; //Breite Bodenplatte
d=350; //Höhe der Profile
//Boden
module rod_holes() {
	translate([-b,b])circle(r=4,$fn=50);
	translate([-b,-b])circle(r=4,$fn=50);

}
module boden1() {
	square(c,center=true);
}
module boden_schrauben() {
	for(x=[1:4])rotate(a=[0,0,x*90])for(x=[[180,180],[180,0]])translate(x)circle(r=1.5,$fn=50);
}
module boden1_cut() {
	for(x=[[-a,-a],[a,a],[-a,a],[a,-a]])translate(x)circle(r=2,$fn=50);		//Schraubenlöcher für Profile
	boden_schrauben();
}
module boden2_cut() {
	profil_schrauben(a);
	for(x=[[-a,-a],[a,a],[-a,a],[a,-a]])translate(x)profil_cut();	
	translate([-b,0])motor(true,true);
	boden_schrauben();
	rod_holes();
}
module boden3_cut() {
	for(x=[[-a,-a],[a,a],[-a,a],[a,-a]])translate(x)profil_cut();	
	for(x=[[-b,0]])translate(x)motor(screw_i=true,hole=true);
	rod_holes();

}
//Platform
module platform() {
	difference() {
		square(270,center=true);
		for(x=[[b,0],[-b,b],[-b,-b]])translate(x)circle(r=4,$fn=50);
	}
}
//Deckel
module deckel1() {
	difference() {
		square(c,center=true);
		//square(c-150,center=true);
	}
}

module deckel1_cut() {
	rod_holes();
	profil_schrauben(a);
	boden_schrauben();
}
module deckel2_cut() {
	profile(a);
	rod_holes();
	boden_schrauben();
}
module deckel3_cut() {
	profile(a);
}

////Render//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Profile
h=5;
for(x=[[-a,-a,h],[a,a,h],[-a,a,h],[a,-a,h]])translate(x)profil_ext(d);	

//Spiegel
translate([0,0,51])linear_extrude(height=3)mirror();

//Boden1 (slice1.dxf)
translate([0,0,0])linear_extrude(height=5)
difference() {
	boden1();
	boden1_cut();
}

//Boden2 (slice2.dxf)
translate([0,0,5])linear_extrude(height=5)
difference() {
	boden1();
	boden2_cut();
}

//Boden3 (slice3.dxf)
translate([0,0,45])linear_extrude(height=5)difference() {
	boden1();
	boden3_cut();
}

//Deckel1
translate([0,0,d+5])linear_extrude(height=5)difference() {
	deckel1();
	deckel1_cut();
}
//Deckel2
translate([0,0,d])linear_extrude(height=5)difference() {
	deckel1();
	deckel2_cut();
}
//Deckel3
translate([0,0,d-7])linear_extrude(height=5)difference() {
	deckel1();
	deckel3_cut();
}