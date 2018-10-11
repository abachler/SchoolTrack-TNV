//%attributes = {}
C_POINTER:C301($tablePtr;$fieldPtr)
  //$m:=IT_StartTimer 
ARRAY TEXT:C222($aNames;0)
ARRAY TEXT:C222($aValues;0)


WEB GET VARIABLES:C683($aNames;$aValues)

$uuid:=NV_GetValueFromPairedArrays (->$aNames;->$aValues;"UUID")
$profID:=STWA2_Session_GetProfID ($uuid)
$modulo:=NV_GetValueFromPairedArrays (->$aNames;->$aValues;"modulo")
$columnas:=NV_GetValueFromPairedArrays (->$aNames;->$aValues;"columnas")
$ordenamiento:=NV_GetValueFromPairedArrays (->$aNames;->$aValues;"ordenamiento")

AT_Delete (Size of array:C274($aNames)-3;4;->$aNames;->$aValues)  //para sacar el UUID y modulo y columnas y ordenamiento

$tableName:=$aValues{1}
EXECUTE FORMULA:C63("$tablePtr:=->["+$tableName+"]")

If (Size of array:C274($aNames)>=5)  //Por si alguien se equivoca y no manda los parametros minimos...
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	$fieldPtr:=KRL_GetFieldPointerByName ("["+$tableName+"]"+$aValues{3})
	$comparator:=$aValues{4}
	If (Character code:C91($comparator)=Character code:C91("@"))
		$value:="@"+$aValues{5}+"@"
		$comparator:="="
	Else 
		$value:=$aValues{5}
	End if 
	QUERY:C277($tablePtr->;$fieldPtr->;$comparator;$value;*)
	For ($i;6;Size of array:C274($aNames);6)
		$fieldPtr:=KRL_GetFieldPointerByName ("["+$tableName+"]"+$aValues{$i+2})
		$operator:=$aValues{$i+1}
		$comparator:=$aValues{$i+3}
		If (Character code:C91($comparator)=Character code:C91("@"))
			$value:="@"+$aValues{$i+4}+"@"
			$comparator:="="
		Else 
			$value:=$aValues{$i+4}
		End if 
		Case of 
			: ($operator="&")
				QUERY:C277($tablePtr->; & ;$fieldPtr->;$comparator;$value;*)
			: ($operator="|")
				QUERY:C277($tablePtr->; | ;$fieldPtr->;$comparator;$value;*)
			: ($operator="#")
				QUERY:C277($tablePtr->;#;$fieldPtr->;$comparator;$value;*)
		End case 
	End for 
	QUERY:C277($tablePtr->)
	dhSTWA2_SpecialSearch ($modulo;$tablePtr;$profID)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	If (Records in selection:C76($tablePtr->)>0)
		$0:=STWA2_Selection2JSON ($tablePtr;$columnas;$ordenamiento)
	Else 
		  //send error
		$0:=STWA2_SendErrJSON ("No se encontraron registros que cumplan con los criterios de búsqueda";"-1")
	End if 
Else 
	  //send error
	$0:=STWA2_SendErrJSON ("Error en la definición de los criterios de búsqueda";"-2")
End if 

  //IT_StopTimer ($m)