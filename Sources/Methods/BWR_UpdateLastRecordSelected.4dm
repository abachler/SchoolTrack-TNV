//%attributes = {}
  //BWR_UpdateLastRecordSelected

  //20080908 RCH Método que actualiza los datos del último registro modificado. El código del presente método se repetía 2 veces (y se tenía que repetir otra vez), así que fue creado este método que es llamado desde:
  //20081020 RCH, Se agregó línea (If (Record number($tablePointer->)#-1)) ya que cuando en cuentas corrientes se desactivaba una cuenta y se eliminaba desde dentro de la ficha se generaba un error en el momento de actualizar la información del explorador
  //BWR_InputFormButtonsHandler 
  //dhBWR_UpdateRecordsList
C_POINTER:C301($tablePointer;$1)

$tablePointer:=$1
If (yBWR_currentTable=$tablePointer)  //ABK 20131216 evito que se agregen registros que no pertenecen a la tabla referenciada en la pestaña del explorador
	If (Record number:C243($tablePointer->)#-1)
		$pos:=Find in array:C230(alBWR_recordNumber;Record number:C243($tablePointer->))
		If ($pos=-1)
			For ($i;1;Size of array:C274(ayBWR_ArrayPointers))
				INSERT IN ARRAY:C227(ayBWR_ArrayPointers{$i}->;Size of array:C274(ayBWR_ArrayPointers{$i}->)+1)
			End for 
			lBWR_recordNumber:=Size of array:C274(alBWR_recordNumber)
			alBWR_recordNumber{lBWR_recordNumber}:=Record number:C243($tablePointer->)
		End if 
		For ($i;1;Size of array:C274(ayBWR_ArrayPointers)-1)
			ayBWR_ArrayPointers{$i}->{lBWR_recordNumber}:=ayBWR_FieldPointers{$i}->
		End for 
	End if 
End if 