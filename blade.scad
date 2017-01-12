$fn = 20;     // Team.Mu.Captain@gmail.com

// Globes.
NumberOfBlades= 2;
HeightOfBlade = 7;
BladeThickness= 2;
BladeLength   = 23;
BladeXoffset  = 0;
BladeYoffset  = 0;
Pitch         = 37; // give a negative if you want inverted.
HeightOfShaft = 7;
ShaftHoleSize = .5;
ShaftCore     = 3;

// sub menu for smoothing
Smooth        = false;  // This distorts everything a
SmoothR       = .4;    // little, when set to true.
SmoothH       = .5;   // Probably should replace the whole thing,
                        // if you want prettier blades.
// sub menu for cap
Cap           = false;
CapDiameter   = ShaftCore;
CapPosition   = HeightOfShaft;

// sub menu for ring
Ring          = false; // There seems to be a glitch in the viewer
RingDistance  = BladeLength; // at certain angles/distances
RingThickness = 1;    // when this is set to true.

union(){
if(Ring){  // this is the ring
translate([0,0,0]){
difference(){
cylinder(h=HeightOfShaft, r1=(RingDistance+RingThickness), r2=(RingDistance+RingThickness), center=true);
cylinder(h=HeightOfShaft+500, r1=RingDistance, r2=RingDistance, center=true);
}}}

if(Cap){  // this is the Cap
translate([0,0,CapPosition*.5])
difference(){
sphere(CapDiameter);
rotate([0,180,0])
translate([0,0,CapPosition*.5])
cylinder(h=CapDiameter+1, r1=ShaftHoleSize, r2=ShaftHoleSize, center=true);
}}

difference(){ // this is the Shaft
cylinder(h=HeightOfShaft, r1=ShaftCore, r2=ShaftCore, center=true);
cylinder(h=500+HeightOfShaft, r1=ShaftHoleSize, r2=ShaftHoleSize, center=true);
}

for(i=[0:NumberOfBlades]){  // this is the Blade
rotate([0,0,i*(360/NumberOfBlades)])
rotate([Pitch,0,0])
translate([ShaftHoleSize,BladeXoffset,BladeYoffset])
rotate([0,90,0])
translate([-.5*BladeThickness,-.5*HeightOfBlade,0]){
    if(Smooth){   // this is the Smoothing or Not.
        minkowski(){
            cube([BladeThickness,HeightOfBlade,BladeLength]);
            cylinder(r=SmoothR,h=SmoothH);
        }
    }
    else
        cube([BladeThickness,HeightOfBlade,BladeLength]);
}}}