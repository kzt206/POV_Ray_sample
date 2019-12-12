// 288x288, AA 0.3  +FN +KFF13 Ç≈é¿çs
#declare deg = clock * 360;

#declare discRadius = 1.75;
#declare discThickness = 0.7;
#declare boxSize = 4.25;
#declare cameraDistance = 25;

camera{ 
	location <0, 0, cameraDistance> 
	look_at <0, 0, 0>
	angle degrees(atan2(boxSize / 2, cameraDistance)) * 2     
	right <1, 0, 0>
	up <0, 1, 0>
}       

light_source { 
	<-5, 5, 50> 
	color rgb <1.4, 1.4, 1.4>
}

object { 
	cylinder {<0, 0, 0>, <0, 0, discThickness / 2>, discRadius} 
	texture { pigment { rgb <1, 1, 1> } }
	rotate y*deg
	rotate z*15 
	translate <0, 0, discRadius * abs(sin(radians(deg)))> 
}
object { 
	cylinder {<0, 0, 0>, <0, 0, -discThickness / 2>, discRadius} 
	texture { pigment { rgb <0, 0, 0> } }    
	rotate y*deg
	rotate z*15 
	translate <0, 0, discRadius * abs(sin(radians(deg)))> 
}  

object { 
	plane {<0, 0, 1>, -discThickness / 2} 
	texture { pigment { rgb <0, 1, 0> } } 
}

 