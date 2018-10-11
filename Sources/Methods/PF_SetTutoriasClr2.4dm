//%attributes = {}
  //PF_SetTutoriasNotasClr

If (False:C215)
	  //Method: AL_SetNotasClr
	  //Written by  Alberto Bachler on 9/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  AL_SetNotasClr()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v461:=False:C215  //9/8/98 at 10:29:02 by: Alberto Bachler
	  //implementación de bimestres
End if 


  //DECLARATIONS
C_LONGINT:C283($k;$1;$2)
ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBleu;2;0)
ARRAY INTEGER:C220(aSetBleu{1};0)
ARRAY INTEGER:C220(aSetBleu{2};0)
ARRAY INTEGER:C220(aSetGreen;2;0)
ARRAY INTEGER:C220(aSetGreen{1};0)
ARRAY INTEGER:C220(aSetGreen{2};0)
ARRAY INTEGER:C220(aSetViol;2;0)
ARRAY INTEGER:C220(aSetViol{1};0)
ARRAY INTEGER:C220(aSetViol{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)

  //INITIALIZATION

  //MAIN CODE
ARRAY TEXT:C222($aArrayNames;0)
$err:=AL_GetArrayNames (xALP_Tutoria1;$aArrayNames;1)
$posP1:=Find in array:C230($aArrayNames;"aNtaP1")
$posP2:=Find in array:C230($aArrayNames;"aNtaP2")
$posP3:=Find in array:C230($aArrayNames;"aNtaP3")
$posP4:=Find in array:C230($aArrayNames;"aNtaP4")
$posP5:=Find in array:C230($aArrayNames;"aNtaP5")
$posPF:=Find in array:C230($aArrayNames;"aNtaPF")
$posEX:=Find in array:C230($aArrayNames;"aNtaEX")
$posNF:=Find in array:C230($aArrayNames;"aNtaF")

For ($k;1;Size of array:C274(aNtaF))
	  //NTA_SetCellClr (aRealNta1{$k};11+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta2{$k};12+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta3{$k};13+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta4{$k};14+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta5{$k};15+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta6{$k};16+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta7{$k};17+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta8{$k};18+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta9{$k};19+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta10{$k};20+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta11{$k};21+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNta12{$k};22+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	If ($posP1#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posP1;$k;aRealPctMinimum{$k})
	End if 
	If ($posP2#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posP2;$k;aRealPctMinimum{$k})
	End if 
	If ($posP3#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posP3;$k;aRealPctMinimum{$k})
	End if 
	If ($posP4#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posP4;$k;aRealPctMinimum{$k})
	End if 
	If ($posP5#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posP5;$k;aRealPctMinimum{$k})
	End if 
	If ($posPF#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posPF;$k;aRealPctMinimum{$k})
	End if 
	If ($posEX#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posEX;$k;aRealPctMinimum{$k})
	End if 
	If ($posNF#-1)
		NTA_SetCellClr (aRealNtaP1{$k};$posNF;$k;aRealPctMinimum{$k})
	End if 
	
	  //NTA_SetCellClr (aRealNtaPF{$k};7;$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNtaEX{$k};8;$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNtaF{$k};9;$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealAsgAverage{$k};9+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //NTA_SetCellClr (aRealNtaExP{$k};10+Num(vb_NotaOficialVisible);$k;aRealPctMinimum{$k})
	  //If (aNtaReprobada{$k})
	  //INSERT IN ARRAY(aSetRed{1};Size of array(aSetRed{1})+1)
	  //INSERT IN ARRAY(aSetRed{2};Size of array(aSetRed{2})+1)
	  //aSetRed{1}{Size of array(aSetRed{1})}:=1
	  //aSetRed{2}{Size of array(aSetRed{2})}:=$k
	  //If (vb_NotaOficialVisible)
	  //INSERT IN ARRAY(aSetRed{1};Size of array(aSetRed{1})+1)
	  //INSERT IN ARRAY(aSetRed{2};Size of array(aSetRed{2})+1)
	  //aSetRed{1}{Size of array(aSetRed{1})}:=2
	  //aSetRed{2}{Size of array(aSetRed{2})}:=$k
	  //End if 
	  //Else 
	  //INSERT IN ARRAY(aSetBlack{1};Size of array(aSetBlack{1})+1)
	  //INSERT IN ARRAY(aSetBlack{2};Size of array(aSetBlack{2})+1)
	  //aSetBlack{1}{Size of array(aSetBlack{1})}:=1
	  //aSetBlack{2}{Size of array(aSetBlack{2})}:=$k
	  //If (vb_NotaOficialVisible)
	  //INSERT IN ARRAY(aSetBleu{1};Size of array(aSetBleu{1})+1)
	  //INSERT IN ARRAY(aSetBleu{2};Size of array(aSetBleu{2})+1)
	  //aSetBleu{1}{Size of array(aSetBleu{1})}:=2
	  //aSetBleu{2}{Size of array(aSetBleu{2})}:=$k
	  //End if 
	  //End if 
End for 

AL_SetCellColor (xALP_Tutoria1;0;0;0;0;aSetBlack;"";16)
AL_SetCellColor (xALP_Tutoria1;0;0;0;0;aSetRed;"";4)
AL_SetCellColor (xALP_Tutoria1;0;0;0;0;aSetBleu;"";7)
AL_SetCellColor (xALP_Tutoria1;0;0;0;0;aSetGreen;"";10)
AL_SetCellColor (xALP_Tutoria1;0;0;0;0;aSetViol;"";240)
ARRAY INTEGER:C220(aSetRed;0;0)
ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBleu;0;0)
ARRAY INTEGER:C220(aSetBleu;2;0)
ARRAY INTEGER:C220(aSetBleu{1};0)
ARRAY INTEGER:C220(aSetBleu{2};0)
ARRAY INTEGER:C220(aSetGreen;2;0)
ARRAY INTEGER:C220(aSetGreen{1};0)
ARRAY INTEGER:C220(aSetGreen{2};0)
ARRAY INTEGER:C220(aSetViol;2;0)
ARRAY INTEGER:C220(aSetViol{1};0)
ARRAY INTEGER:C220(aSetViol{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 



