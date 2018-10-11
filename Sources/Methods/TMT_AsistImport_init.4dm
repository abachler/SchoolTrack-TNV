//%attributes = {}
  //TMT_AsistImport_init

C_LONGINT:C283(l_ultimoNivelCargado)
l_ultimoNivelCargado:=0
C_OBJECT:C1216(o_horarioOK;o_horarioNotFound)
o_horarioOK:=OB_Create 
o_horarioNotFound:=OB_Create 

ARRAY TEXT:C222(at_cursos_selector;0)
at_cursos_selector{0}:=""
ARRAY LONGINT:C221(ai_num_hora;0)
ARRAY TEXT:C222(at_lbdia1;0)
ARRAY TEXT:C222(at_lbdia2;0)
ARRAY TEXT:C222(at_lbdia3;0)
ARRAY TEXT:C222(at_lbdia4;0)
ARRAY TEXT:C222(at_lbdia5;0)
ARRAY TEXT:C222(at_lbdia6;0)

ARRAY TEXT:C222(at_noCargado;0)

ARRAY TEXT:C222(at_lbNFCurso;0)
ARRAY TEXT:C222(at_lbNFLlave;0)
ARRAY TEXT:C222(at_lbGradeCurso;0)
ARRAY TEXT:C222(at_lbGradeAsig;0)