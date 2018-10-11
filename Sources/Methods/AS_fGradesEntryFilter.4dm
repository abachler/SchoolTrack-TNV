//%attributes = {}
  //AS_fGradesEntryFilter

If (False:C215)
	  //Method: AS_getGradesEntryFilter
	  //Written by  Alberto Bachler on 8/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  AS_getGradesEntryFilter()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v46:=False:C215
End if 

  //DECLARATIONS
C_TEXT:C284($filter;$ccpts;$0)

  //INITIALIZATION
$filter:=""
$ccpts:=""
$0:=""
  //MAIN CODE



If (iEvaluationMode=4)
	$ccpts:=""
	For ($i;1;Size of array:C274(aSymbol))
		For ($j;1;Length:C16(aSymbol{$i}))
			$ccpts:=$ccpts+aSymbol{$i}[[$j]]+";"+ST_Lowercase (aSymbol{$i}[[$j]])+";"
		End for 
	End for 
	If ([Asignaturas:18]Eximible:28)
		$filter:=$ccpts+"P;p;X;x;*"
	Else 
		$filter:=$ccpts+"P;p;*"
	End if 
Else 
	Case of 
		: (iEvaluationMode=Porcentaje)
			$filter:=<>tXS_RS_DecimalSeparator+";0-9;"
		: ((iEvaluationMode=Notas) & (iGradesDec>0))
			$filter:=<>tXS_RS_DecimalSeparator+";0-9;"
		: ((iEvaluationMode=Puntos) & (iPointsDec>0))
			$filter:=<>tXS_RS_DecimalSeparator+";0-9;"
		Else 
			$filter:=";0-9;"
	End case 
	If ([Asignaturas:18]Eximible:28)
		$filter:=$filter+"P;p;X;x;*"
	Else 
		$filter:=$filter+"P;p;*"
	End if 
End if 
$0:=$filter

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 