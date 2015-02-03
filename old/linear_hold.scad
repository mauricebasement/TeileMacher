module t_slot() {
	translate([0,2.75])square([2.8,5.5],center=true);
	translate([0,3])square([2.5+2.8,1.65],center=true);
}
module corners() {
	for(i=[1,3])rotate(a=[0,0,i*90])for(i=[-7.5,0,7.5])translate([i,12.5])square(5,center=true);
}
module side(r=4.2) {
	corners();	
	difference() {
		square(20,center=true);
		circle(r=r,$fn=50);
	}
}
module back() {
	*translate([-60,5])square([150,15]);
	*translate([-60,5+3.5])square([150,8]);

	for(i=[0,1])mirror([i,0,0])difference() {
		square([52,28]);
		for(i=[0,7.5,15])translate([0,i+2.5])for(i=[40,40-29,40-9,40-20])translate([i,0])square(5);
		for(i=[48.5])translate([i,0])for(i=[3.5,21.5])translate([0,i])circle(r=1.45,$fn=50);
		for(i=[6])translate([i,0])for(i=[3.5,18,25])translate([0,i])circle(r=1.45,$fn=50);
		translate([0,22])circle(r=4,$fn=50);
		translate([52,12.5])rotate(a=[0,0,90])t_slot();

	}
	for(i=[0,1])mirror([i,0,0])for(i=[5,15])translate([52,i])square(5);

}
module right() {
	difference(){
		square([42,45]);
		for(i=[5,15])translate([0,i])for(i=[6,31])translate([i,0])square(5);
		for(i=[20,40])translate([0,i])for(i=[3.5,38.5])translate([i,0])circle(r=1.45,$fn=50);
		for(i=[8.5,33.5])translate([i,12.5])circle(r=1.45,$fn=50);
		translate([21,30])circle(r=4.3,$fn=50);
		translate([21,10])square([10,20],center=true);
	}
}
//Side Rod
side();
//Side Bearing
side(r=7.5);
//Back
!back();
//Right
right();
