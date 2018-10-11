//%attributes = {}
  //BWR_SearchRecords

If (Count parameters:C259=1)
	$searchFile:=$1
Else 
	$searchFile:=yBWR_CurrentTable
End if 

If (Size of array:C274(abrSelect)>0)
	  //$searchFile:=yBWR_currentTable
	CREATE EMPTY SET:C140($searchFile->;"$temp")
	For ($i;1;Size of array:C274(abrSelect))
		
		  // Modificado por: Saúl Ponce (28/08/2017) Ticket 186422, aparecía error al ingresar a un aviso de cobro que previamente fue eliminado en la ventana de ingreso de pagos.
		  // y dejé los set locales...
		  // GOTO RECORD($searchFile->;alBWR_recordNumber{abrSelect{$i}})
		
		KRL_GotoRecord ($searchFile;alBWR_recordNumber{abrSelect{$i}})
		If (Records in selection:C76($searchFile->)>0)
			ADD TO SET:C119($searchFile->;"$temp")
		End if 
		
	End for 
	
	USE SET:C118("$temp")
	CLEAR SET:C117("$temp")
	  //CLEAR SET("Temp2")
	$0:=Records in selection:C76($searchFile->)
Else 
	$0:=-1
End if 

