module hedronVertex(translation, angle1, angle2){
	translate(translation){
		children(0);
	}
	rotate(angle1){
		translate(translation){
			children(1);
		}
	}
	rotate(angle2){
		translate(translation){
			children(2);
		}
	}
}

module popsicleStick() {

	l=119;
	w=10;
	h=2.3;

	union() {
        translate([0,0,-h/2]){
            cylinder(h=h,r=w/2);
            translate(v=[l-w/2,0,-h/2]){
                cylinder(h=h,r=w/2);
            }
        }
		translate(v=[0,-w/2,-h/2]){
			cube(size=[l-w/2,w,h]);
		}
	}
}

module popsicleSocket(angle){
	l=15;
	stickW=10;
	stickH=2.3;
	wall=1.8;
	w = stickW+2*wall;
	h = stickH+2*wall;
    
	//translate(v=[0,-w/2,-h/2]){
        minOverhangCube([l,w,h], angle, 45);
	//}
}

module minOverhangCube(cubeSize, angle, minOverhangAngle){    

    trianglePoint0 = [0, 0];
    trianglePoint1 = [cos(-angle)*cubeSize[0], sin(-angle)*cubeSize[0]];
    trianglePoint2 = [trianglePoint1[0]-(tan(minOverhangAngle)*trianglePoint1[1]), 0];
    
    translate([0, -cubeSize[1]/2, 0]){
        translate([0, cubeSize[1], 0]){
            rotate([90, 0, 0]){
                linear_extrude(height = cubeSize[1]){
                polygon(points = [trianglePoint0, trianglePoint1, trianglePoint2]);
                }
            }
        }

        rotate([0, angle, 0]){
            cube(cubeSize);
        }
    }
}


//popsicleSocket();
intersection(){
    sphere(13);
difference()
{
    
hedronVertex([0, 0, 0], [0, 0, 108], [0, 0, -120]){
	popsicleSocket(0);
	popsicleSocket(0);
	popsicleSocket(-37.38);
}

hedronVertex([8, 0, 2.95], [0, 0, 108], [0, -37.38, -120])
{
	popsicleStick();
	popsicleStick();
	popsicleStick();
}
}

}