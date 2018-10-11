//%attributes = {}
  //ASsev_InitArrays

If (False:C215)
	  //Method: ASsev_InitArrays
	  //Written by  Alberto Bachler on 10/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  ASsev_InitArrays()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v461:=False:C215
	  //implementación de bimestres
End if 


  //DECLARATIONS
ARRAY INTEGER:C220(aSubEvalOrden;0)  //21/02/97, para orden por numero
_O_ARRAY STRING:C218(5;aSubEval1;0)
_O_ARRAY STRING:C218(5;aSubEval2;0)
_O_ARRAY STRING:C218(5;aSubEval3;0)
_O_ARRAY STRING:C218(5;aSubEval4;0)
_O_ARRAY STRING:C218(5;aSubEval5;0)
_O_ARRAY STRING:C218(5;aSubEval6;0)
_O_ARRAY STRING:C218(5;aSubEval7;0)
_O_ARRAY STRING:C218(5;aSubEval8;0)
_O_ARRAY STRING:C218(5;aSubEval9;0)
_O_ARRAY STRING:C218(5;aSubEval10;0)
_O_ARRAY STRING:C218(5;aSubEval11;0)
_O_ARRAY STRING:C218(5;aSubEval12;0)
_O_ARRAY STRING:C218(5;aSubEvalP1;0)
_O_ARRAY STRING:C218(5;aSubEvalControles;0)
_O_ARRAY STRING:C218(5;aSubEvalPresentacion;0)
ARRAY LONGINT:C221(aSubEvalID;0)
ARRAY TEXT:C222(aSubEvalStdNme;0)
ARRAY TEXT:C222(aSubEvalCurso;0)
ARRAY TEXT:C222(aSubEvalStatus;0)
ARRAY INTEGER:C220(aSubEvalAsgAvg;0)
ARRAY TEXT:C222(aSubEvalNombreParciales;0)  //MONO TICKET 187315
ARRAY TEXT:C222(aSubEvalNombreParciales;12)
For ($i;1;12)
	aSubEvalNombreParciales{$i}:=__ ("Parcial")+" "+String:C10($i)
End for 

ARRAY TEXT:C222(aSubEvalSex;0)  //8/3/2011 JHB para agrupacion por sexo

_O_ARRAY STRING:C218(5;aCpySubEval1;0)
_O_ARRAY STRING:C218(5;aCpySubEval2;0)
_O_ARRAY STRING:C218(5;aCpySubEval3;0)
_O_ARRAY STRING:C218(5;aCpySubEval4;0)
_O_ARRAY STRING:C218(5;aCpySubEval5;0)
_O_ARRAY STRING:C218(5;aCpySubEval6;0)
_O_ARRAY STRING:C218(5;aCpySubEval7;0)
_O_ARRAY STRING:C218(5;aCpySubEval8;0)
_O_ARRAY STRING:C218(5;aCpySubEval9;0)
_O_ARRAY STRING:C218(5;aCpySubEval10;0)
_O_ARRAY STRING:C218(5;aCpySubEval11;0)
_O_ARRAY STRING:C218(5;aCpySubEval12;0)
_O_ARRAY STRING:C218(5;aCpySubEvalP1;0)
_O_ARRAY STRING:C218(5;aCpySubEvalControles;0)
_O_ARRAY STRING:C218(5;aCpySubEvalPresentacion;0)

ARRAY POINTER:C280(aCpySubEvalPtr;12)
aCpySubEvalPtr{1}:=->aCpySubEval1
aCpySubEvalPtr{2}:=->aCpySubEval2
aCpySubEvalPtr{3}:=->aCpySubEval3
aCpySubEvalPtr{4}:=->aCpySubEval4
aCpySubEvalPtr{5}:=->aCpySubEval5
aCpySubEvalPtr{6}:=->aCpySubEval6
aCpySubEvalPtr{7}:=->aCpySubEval7
aCpySubEvalPtr{8}:=->aCpySubEval8
aCpySubEvalPtr{9}:=->aCpySubEval9
aCpySubEvalPtr{10}:=->aCpySubEval10
aCpySubEvalPtr{11}:=->aCpySubEval11
aCpySubEvalPtr{12}:=->aCpySubEval12

ARRAY REAL:C219(aRealSubEval1;0)
ARRAY REAL:C219(aRealSubEval2;0)
ARRAY REAL:C219(aRealSubEval3;0)
ARRAY REAL:C219(aRealSubEval4;0)
ARRAY REAL:C219(aRealSubEval5;0)
ARRAY REAL:C219(aRealSubEval6;0)
ARRAY REAL:C219(aRealSubEval7;0)
ARRAY REAL:C219(aRealSubEval8;0)
ARRAY REAL:C219(aRealSubEval9;0)
ARRAY REAL:C219(aRealSubEval10;0)
ARRAY REAL:C219(aRealSubEval11;0)
ARRAY REAL:C219(aRealSubEval12;0)
ARRAY REAL:C219(aRealSubEvalP1;0)
ARRAY REAL:C219(aRealSubEvalControles;0)
ARRAY REAL:C219(aRealSubEvalPresentacion;0)

ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
aRealSubEvalArrPtr{1}:=->aRealSubEval1
aRealSubEvalArrPtr{2}:=->aRealSubEval2
aRealSubEvalArrPtr{3}:=->aRealSubEval3
aRealSubEvalArrPtr{4}:=->aRealSubEval4
aRealSubEvalArrPtr{5}:=->aRealSubEval5
aRealSubEvalArrPtr{6}:=->aRealSubEval6
aRealSubEvalArrPtr{7}:=->aRealSubEval7
aRealSubEvalArrPtr{8}:=->aRealSubEval8
aRealSubEvalArrPtr{9}:=->aRealSubEval9
aRealSubEvalArrPtr{10}:=->aRealSubEval10
aRealSubEvalArrPtr{11}:=->aRealSubEval11
aRealSubEvalArrPtr{12}:=->aRealSubEval12