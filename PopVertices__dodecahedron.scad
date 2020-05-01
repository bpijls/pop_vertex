popsicleStickHeight = 2.15;
popsicleStickWidth = 10.5;
popsicleStickLength = 119;

socketLength = 15;
socketThickness = 1.2;
socketHoleDistance = 8.0;

minOverhang = 45;

holeAngles = [[0, -20.905, 0],[0, -20.905, 120], [0, -20.905, -120]];        
socketAngles = [[0, 0, 0], [0, 0, 120], [0, 0, -120]];

sphereRadius = 15;

module hedronVertex(translation, angles){    
    for (iAngle = [0:len(angles)-1]){
        rotate(angles[iAngle]){
            translate(translation){
                children(iAngle);
            }
        }
    }	
}

module popsicleStick() {

	l=popsicleStickLength;
	w=popsicleStickWidth;
	h=popsicleStickHeight;

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
	l=socketLength;
	stickW=popsicleStickWidth;
	stickH=popsicleStickHeight;
	wall=socketThickness;
	w = stickW+2*wall;
	h = stickH+2*wall;
    minOverhangCube([l,w,h], angle, 45);	
}

module minOverhangCube(cubeSize, angle, minOverhangAngle){    
    trianglePoint0 = [0, 0];
    trianglePoint1 = [cos(-angle)*cubeSize[0], sin(-angle)*cubeSize[0]];
    trianglePoint2 = [trianglePoint1[0]-(tan(minOverhangAngle)*trianglePoint1[1]), 0];
    translate([0, cubeSize[1]/2, 0])
    {
        rotate([90, 0, 0])
        {
            linear_extrude(height = cubeSize[1])
            {
                rotate(-angle)
                {
                    square(size = [cubeSize[0], cubeSize[2]]);
                }
                polygon(points = [trianglePoint0, trianglePoint1, trianglePoint2]);
            }
        }
    }
}

intersection()
{
   sphere(sphereRadius);
    difference()
    {
    
        hedronVertex([0, 0, 0], socketAngles){
            popsicleSocket(holeAngles[0][1]);
            popsicleSocket(holeAngles[1][1]);
            popsicleSocket(holeAngles[2][1]);
        }
        
        hedronVertex([socketHoleDistance, 0, popsicleStickHeight], holeAngles)
        {
            popsicleStick();
            popsicleStick();
            popsicleStick();
        }
    }
}