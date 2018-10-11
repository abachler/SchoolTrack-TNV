//%attributes = {}
  //ACTter_DeleteSelection

$0:=0
If (USR_checkRights ("D";->[ACT_Terceros:138]))
	C_BOOLEAN:C305($vb_registrosAsociados)
	$resp:=CD_Dlog (0;__ ("Está seguro de querer eliminar este registro.");__ ("");__ ("Si");__ ("No"))
	If ($resp=1)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Terceros:138];$aRecNums;"")
		$validate:=True:C214
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([ACT_Terceros:138];$aRecNums{$i})
			$delete:=ACTter_Delete (False:C215)
			If ($delete=2)
				$vb_registrosAsociados:=True:C214
			End if 
			If ($delete=0)
				$i:=Size of array:C274($aRecNums)
				CD_Dlog (0;__ ("Existen registros en uso. La eliminación no puede ser efectuada."))
			Else 
				$0:=1
			End if 
		End for 
	End if 
	If ($vb_registrosAsociados)
		$0:=2
		  //CD_Dlog (0;__ ("Existían registros asociados a pagos y/o avisos de coranza. Dichos registros no fueron eliminados."))
		CD_Dlog (0;__ ("Existían registros asociados a Pagos y/o Cargos y/o Documentos Tributarios. Dichos registros no fueron eliminados."))
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 