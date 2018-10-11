C_LONGINT:C283($vl_Column;$vl_row)
C_POINTER:C301($vy_pointer1)
C_BOOLEAN:C305($vb_calculaMontos)
C_TEXT:C284($varName1)
C_LONGINT:C283($tableNum1;$fieldNum1)

LISTBOX GET CELL POSITION:C971(lb_duplicacion;$vl_Column;$vl_row;$vy_pointer1)
RESOLVE POINTER:C394($vy_pointer1;$varName1;$tableNum1;$fieldNum1)

Case of 
	: ($vl_Column=1)
		If (abACT_duplicaDeudaDup{$vl_row})
			If (cs_duplicarDeuda=0)
				cs_duplicarDeuda:=1
			End if 
		End if 
		$vb_calculaMontos:=True:C214
		
	: ($varName1="arACT_MontoDup")
		$vr_valor:=$vy_pointer1->{$vl_row}
		$vl_id:=alACT_idCargoDup{$vl_row}
		
		If ($vr_valor<0)
			$vy_pointer1->{$vl_row}:=0
			  //Else 
			  //$vl_pos:=Find in array(alACT_idCargo;$vl_id)
			  //If ($vl_pos>0)
			  //If (arACT_montoCargo{$vl_pos}<$vr_valor)
			  //$vy_pointer1->{$vl_row}:=arACT_montoCargo{$vl_pos}
			  //End if 
			  //End if 
		End if 
		$vb_calculaMontos:=True:C214
		
		  //: ($vl_Column=4)
		
End case 

If ($vb_calculaMontos)
	$vb_asignarMontos:=False:C215
	ACTbol_OpcionesDuplicacionNC ("CalculaMontoDuplicacion";->$vb_asignarMontos)
End if 