//%attributes = {}
  //SRcust_SetStudentVariables


dhSR_InitVariables 
SRcust_InitEvaluationVariables 

_O_ARRAY STRING:C218(255;asSRVariables;0)
_O_ARRAY STRING:C218(255;asSRVariables;1000)  //redimensionar si se necesitan más variables, los elementos en exceso se eliminan después de asignar las variables propias al alumno (SRcust_SetStudentVariables_XX)


Case of 
	: ((vlSTR_Periodos_Tipo=2 Semestres) | (Size of array:C274(atSTR_Periodos_Nombre)=2))  // semestres
		SRcust_SetStudentVariables_2S 
		
	: ((vlSTR_Periodos_Tipo=3 Trimestres) | (Size of array:C274(atSTR_Periodos_Nombre)=3))  // trimestres
		SRcust_SetStudentVariables_3T 
		
	: (vlSTR_Periodos_Tipo=4 Bimestres)  // bimestres
		SRcust_SetStudentVariables_4B 
End case 

For ($i;Size of array:C274(asSRVariables);1;-1)
	If (asSRVariables{$i}="")
		DELETE FROM ARRAY:C228(asSRVariables;$i;1)
	End if 
End for 


QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=(Table:C252(->[Personas:7])))
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNums;[xShell_Fields:52]ID:24;$aFieldIDs)
ARRAY TEXT:C222($aFieldNames;Size of array:C274($aFieldIDs))
For ($h;1;Size of array:C274($aFieldIDs))
	$aFieldNames{$h}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);$aFieldIDs{$h};<>vtXS_CountryCode;<>vtXS_Langage)
End for 
SORT ARRAY:C229($aFieldNames;$aFieldNums;>)

$nextParentMenu:=String:C10(Num:C11(ST_GetWord (asSRVariables{Size of array:C274(asSRVariables)};1;";"))+1)
$nextItem:=Size of array:C274(asSRVariables)+1
AT_ResizeArrays (->asSRVariables;Size of array:C274(asSRVariables)+Size of array:C274($aFieldNums)+1)
asSRVariables{$nextItem}:=$nextParentMenu+";Datos de la Madre"
$index:=$nextItem+1
For ($i;1;Size of array:C274($aFieldNums))
	$varName:=Substring:C12("vMadre_"+Field name:C257(7;$aFieldNums{$i});1;30)
	asSRVariables{$index}:=$nextParentMenu+";"+$aFieldNames{$i}+";"+$varName+";1"
	$index:=$index+1
End for 

$nextParentMenu:=String:C10(Num:C11($nextParentMenu)+1)
ARRAY TEXT:C222($aMenuItems;Size of array:C274($aFieldNums))
$index:=Size of array:C274(asSRVariables)+1
AT_ResizeArrays (->asSRVariables;Size of array:C274(asSRVariables)+Size of array:C274($aFieldNums)+1)
asSRVariables{$index}:=$nextParentMenu+";Datos del Padre"
$index:=$index+1
For ($i;1;Size of array:C274($aFieldNums))
	$varName:=Substring:C12("vPadre_"+Field name:C257(7;$aFieldNums{$i});1;30)
	asSRVariables{$index}:=$nextParentMenu+";"+$aFieldNames{$i}+";"+$varName+";1"
	$index:=$index+1
End for 


For ($i;1;Size of array:C274(asSRVariables))
	$varName:=ST_GetWord (asSRVariables{$i};3;";")
	If ($varName#"")
		$pointer:=Get pointer:C304($varName)
	End if 
End for 


$err:=SR Variables (xReportData;"asSRVariables")