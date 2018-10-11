//%attributes = {}
  //AL_InitFileReport

ARRAY TEXT:C222(at_BrothersName;0)
ARRAY TEXT:C222(at_BrothersClass;0)
ARRAY DATE:C224(ad_BrothersBirthDate;0)
ARRAY TEXT:C222(at_asg1;0)
ARRAY TEXT:C222(at_asg2;0)
ARRAY TEXT:C222(at_asg3;0)
ARRAY TEXT:C222(at_asg4;0)
ARRAY TEXT:C222(at_asg5;0)
ARRAY TEXT:C222(at_asg6;0)
ARRAY TEXT:C222(at_asg7;0)
ARRAY TEXT:C222(at_asg8;0)
ARRAY TEXT:C222(at_asg9;0)
ARRAY TEXT:C222(at_asg10;0)
ARRAY TEXT:C222(at_asg11;0)
ARRAY TEXT:C222(at_asg12;0)
ARRAY TEXT:C222(at_Nota1;0)
ARRAY TEXT:C222(at_Nota2;0)
ARRAY TEXT:C222(at_Nota3;0)
ARRAY TEXT:C222(at_Nota4;0)
ARRAY TEXT:C222(at_Nota5;0)
ARRAY TEXT:C222(at_Nota6;0)
ARRAY TEXT:C222(at_Nota7;0)
ARRAY TEXT:C222(at_Nota8;0)
ARRAY TEXT:C222(at_Nota9;0)
ARRAY TEXT:C222(at_Nota10;0)
ARRAY TEXT:C222(at_Nota11;0)
ARRAY TEXT:C222(at_Nota12;0)
vt_Obs1:=""
vt_Obs2:=""
vt_Obs3:=""
vt_Obs4:=""
vt_Obs5:=""
vt_Obs6:=""
vt_Obs7:=""
vt_Obs8:=""
vt_Obs9:=""
vt_Obs10:=""
vt_Obs11:=""
vt_Obs12:=""
vt_ProblemasSalud:=""
vt_mother:=""
vt_motherFNac:=!00-00-00!
vt_motherProf:=""
vt_father:=""
vt_fatherFNac:=!00-00-00!
vt_fatherProf:=""
vt_apoderado:=""
vt_apoderadoFNac:=!00-00-00!
vt_apoderadoProf:=""
vt_sintesis:=""
For ($i;1;12)
	$nivelpointer:=Get pointer:C304("vt_nivel"+String:C10($i))
	$nivelPointer->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$i;->[xxSTR_Niveles:6]Nivel:1)
End for 
vb_printGrades1:=False:C215
vb_printGrades2:=False:C215
vs_currentDate:=DT_SpecialDate2String (Current date:C33)