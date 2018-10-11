//%attributes = {}
  //AL_SetHnotasClr

If (False:C215)
	  //Method: AL_SetHnotasClr
	  //Written by  Alberto Bachler on 9/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  AL_SetHnotasClr()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v461:=False:C215  //10/8/98 at 07:07:55 by: Alberto Bachler
	  //implementación de bimestres
End if 


  //DECLARATIONS
C_LONGINT:C283($k;$col)
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
  //INITIALIZATION


  //MAIN CODE
For ($k;1;Size of array:C274(aHNF))
	$col:=2
	NTA_SetCellClr (Num:C11(aHNota1{$k});$Col;$k)
	$Col:=$col+1
	NTA_SetCellClr (Num:C11(aHNota2{$k});$Col;$k)
	If (Size of array:C274(aPeriodos_Historico)>=3)
		$Col:=$col+1
		NTA_SetCellClr (Num:C11(aHNota3{$k});$Col;$k)
	End if 
	If (Size of array:C274(aPeriodos_Historico)=4)
		$Col:=$col+1
		NTA_SetCellClr (Num:C11(aHNota4{$k});$Col;$k)
	End if 
	NTA_SetCellClr (Num:C11(aHPF{$k});$Col+1;$k)
	NTA_SetCellClr (Num:C11(aHEX{$k});$Col+2;$k)
	NTA_SetCellClr (Num:C11(aHNF{$k});$Col+3;$k)
End for 

AL_SetCellColor (xALP_HNotasECursos;0;0;0;0;aSetRed;"";4;"";1)
AL_SetCellColor (xALP_HNotasECursos;0;0;0;0;aSetBleu;"";7;"";1)
AL_SetCellColor (xALP_HNotasECursos;0;0;0;0;aSetGreen;"";10;"";1)
AL_SetCellColor (xALP_HNotasECursos;0;0;0;0;aSetViol;"";240;"";1)
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

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 





