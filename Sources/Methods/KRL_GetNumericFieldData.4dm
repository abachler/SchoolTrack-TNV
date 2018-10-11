//%attributes = {}
  //KRL_GetNumericFieldData

C_POINTER:C301($1;$refField;$2;$pointerToValue;$3;$dataField)
C_REAL:C285($0)
C_BOOLEAN:C305($popRecord)
$popRecord:=False:C215

$refField:=$1
$pointerToValue:=$2
$dataField:=$3
$table:=Table:C252(Table:C252($refField))

$recNum:=Find in field:C653($refField->;$pointerToValue->)

If ($recNum>=0)
	If ($recNum#Record number:C243($table->))
		$popRecord:=False:C215
		If ((Record number:C243($table->)>=0) & (Trigger level:C398=0))  //si hay un registro cargado para la misma tabla lo pongo en la pila para reestablecerlo al salir
			PUSH RECORD:C176($table->)
			$popRecord:=True:C214
		End if 
		
		If ($recNum>=0)
			KRL_GotoRecord ($table;$recNum)
			If (OK=1)
				$0:=$dataField->
			End if 
		End if 
		
		If ($popRecord)  //saco el record de la pila reestableciéndolo como registro corriente
			POP RECORD:C177($table->)
		End if 
		
	Else 
		  //LOAD RECORD($table->)
		  //$0:=$dataField->
		If ($pointerToValue->#$refField->)  //JHB 20110727 work around para cuando $recNum=Record number($table->) pero el registro no esta cargado... raro, raro, raro!!!
			UNLOAD RECORD:C212($table->)
			KRL_GotoRecord ($table;$recNum)
		End if 
		$0:=$dataField->
	End if 
End if 