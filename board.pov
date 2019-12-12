// 320x240, AA 0.3  +FN +KFF20 �Ŏ��s

#include "Woods.inc"

// �e��萔��`
#declare boxSize = 4.25;                  // �}�X��1��
#declare discThickness = 0.7;             // �΂̌���
#declare discRadius = 1.75;               // �΂̔��a
#declare boardZ = -discThickness / 2;     // �Ֆʂ�Z���W
#declare boardSize = boxSize * 8;         // �Ֆʂ�1��
#declare eps = 0.001;                     // �����̕`�掞�̌��ݗp
#declare lineWidth = 0.2;                 // ���̑���
#declare dotRadius = 0.5;                 // �Տ�̉~�̔��a
#declare deskZ = -discThickness / 2 -2.0; // ���̖ʂ�Z���W
#declare frameHeight = 2.5;               // �g�̊�����̍���
#declare frameInner = 38;                 // �g�̏㑤��1��
#declare frameOuter = 39;                 // �g�̉�����1��

#declare black = rgb <0,0,0>;
#declare white = rgb <1,1,1>;

// �A�j���[�V�����p (cf: https://qiita.com/Hyrodium/items/089b2cf1466d0d040d61)       
#macro smootha(a)
    #if(a>0)
        #local b=exp(-1/a);
    #else
        #local b=0;
    #end
    b
#end

#macro usmooth(a,b,s)
    smootha((2/sqrt(3))*((s-a)/(b-a)))/(smootha((2/sqrt(3))*((s-a)/(b-a)))+smootha((2/sqrt(3))*(1-(s-a)/(b-a))))
#end        

// �}�X�̈ʒu(cx,cy�͍��オ0,0�ŁA�E����8,8)
#macro cellForCoordinate(cx, cy)
    <-boardSize / 2 + cx * boxSize, boardSize / 2 - cy * boxSize, 0>
#end        
            
// �J�����̈ʒu
#declare cdist = 300 - usmooth(0.0, 0.9, clock) * 100;
#declare cth = radians(20 - usmooth(0.0, 0.9, clock) * 100);
#declare ch = 180 - usmooth(0.0, 0.9, clock) * 30;
camera{ 
	location <cdist * cos(cth), cdist * sin(cth), ch> 
	look_at <0, 0, 0>
	angle 12     
	right <-1.33, 0, 0>
	sky <0, 0, 1>
}       

// ����
light_source { 
	<50, 50, 50> 
	color rgb <1.4, 1.4, 1.4>
}

// ���̖�
plane{z, deskZ
    texture {T_Wood2}
}

// �Ֆ�
box { 
   <-boardSize / 2, -boardSize / 2, boardZ>, <boardSize / 2, boardSize / 2, boardZ - eps>
   texture { pigment { rgb <0.004, 0.455, 0.302> } }
}

// ���̕`�� 
#declare i = 0; 
#while ( i <= 8 ) 
    box { 
       <-boardSize / 2 + i * boxSize - lineWidth / 2, -boardSize / 2, boardZ + eps>, 
       <-boardSize / 2 + i * boxSize + lineWidth / 2, boardSize / 2, boardZ>
       texture { pigment { black } }
    }
    box { 
       <-boardSize / 2, -boardSize / 2 + i * boxSize - lineWidth / 2, boardZ + eps>, 
       <boardSize / 2, -boardSize / 2 + i * boxSize + lineWidth / 2, boardZ>
       texture { pigment { black } }
    }
#declare i = i + 1;
#end 

// ���ۂ̕`��
#macro PutDot (cx, cy) 
#declare p0 = cellForCoordinate(cx, cy);
object {
    cylinder {
        p0 + <0, 0, -discThickness / 2>, p0 + <0, 0, -discThickness / 2 + eps>, dotRadius 
        pigment { black }
    }
} 
#end
PutDot(2, 2)
PutDot(2, 6)
PutDot(6, 2)
PutDot(6, 6)

// �g�̕`��
box { 
   <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
   <frameInner / 2, -boardSize / 2 - lineWidth / 2, deskZ>
   texture { pigment { black } }
}
box { 
   <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
   <-boardSize / 2 - lineWidth / 2, frameInner / 2, deskZ>
   texture { pigment { black } }
}
box { 
   <-frameInner / 2, frameInner / 2, deskZ + frameHeight>,
   <frameInner / 2, boardSize / 2 + lineWidth / 2, deskZ>
   texture { pigment { black } }
}
box { 
   <frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
   <boardSize / 2 + lineWidth / 2, frameInner / 2, deskZ>
   texture { pigment { black } }
} 
polygon{
    5,
    <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
    <-frameInner / 2, frameInner / 2, deskZ + frameHeight>,
    <-frameOuter / 2, frameOuter / 2, deskZ>,
    <-frameOuter / 2, -frameOuter / 2, deskZ>,
    <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>
    texture { pigment { black } }
} 
polygon{
    5,
    <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
    <frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
    <frameOuter / 2, -frameOuter / 2, deskZ>,
    <-frameOuter / 2, -frameOuter / 2, deskZ>,
    <-frameInner / 2, -frameInner / 2, deskZ + frameHeight>
    texture { pigment { black } }
} 
polygon{
    5,
    <frameInner / 2, frameInner / 2, deskZ + frameHeight>,
    <frameInner / 2, -frameInner / 2, deskZ + frameHeight>,
    <frameOuter / 2, -frameOuter / 2, deskZ>,
    <frameOuter / 2, frameOuter / 2, deskZ>,
    <frameInner / 2, frameInner / 2, deskZ + frameHeight>
    texture { pigment { black } }
} 
polygon{
    5,
    <frameInner / 2, frameInner / 2, deskZ + frameHeight>,
    <-frameInner / 2, frameInner / 2, deskZ + frameHeight>,
    <-frameOuter / 2, frameOuter / 2, deskZ>,
    <frameOuter / 2, frameOuter / 2, deskZ>,
    <frameInner / 2, frameInner / 2, deskZ + frameHeight>
    texture { pigment { black } }
} 
        
// �΂̕`��p�̃}�N��        
#macro PutDisc (cx, cy, pz, deg, color1, color2) 
#declare p0 = cellForCoordinate(cx + 0.5, cy + 0.5) + <0, 0, pz>;
object {
    cylinder {
        <0, 0, 0>, <0, 0, discThickness / 2>, discRadius 
        pigment { color1 }
    	rotate y*deg
    	rotate z*15 
    	translate p0 
    }
}
object {
    cylinder {
        <0, 0, 0>, <0, 0, -discThickness / 2>, discRadius 
        pigment { color2 }
    	rotate y*deg
    	rotate z*15 
    	translate p0 
    }
}
#end 

// �΂̕`��
PutDisc(3, 3, 0, 0, white, black) // d4
PutDisc(4, 3, 0, 0, white, black) // e4
PutDisc(5, 3, 0, 0, white, black) // f4
PutDisc(5, 4, 0, 0, white, black) // f5
PutDisc(3, 4, 0, 0, black, white) // d5
PutDisc(4, 4, 0, 0, black, white) // e5
PutDisc(4, 5, 0, 0, black, white) // e6

// �Ԃ��(f6)
#declare deg = min(180, max(0, 180 * (clock - 0.4) / 0.4));
PutDisc(5, 5, abs(sin(radians(deg))) * discRadius, deg, white, black)

// �ł�(g7)
PutDisc(6, 6, 30 - 30 * usmooth(-0.3,0.4,clock), 0, black, white)
