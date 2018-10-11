  //If (bto_Exportacion=1)
$modelos:=AT_array2text (->at_FileName)
$choice:=Pop up menu:C542($modelos)
If ($choice>0)
	vNombreOldModeloAB:=at_FileName{$choice}  //
	vI_RecordNumber:=al_idsBankFiles{$choice}
	vt_tipoArchivo:=KRL_GetTextFieldData (->[xxACT_ArchivosBancarios:118]ID:1;->vI_RecordNumber;->[xxACT_ArchivosBancarios:118]Tipo:6)
	vlACT_id_modo_pago:=KRL_GetNumericFieldData (->[xxACT_ArchivosBancarios:118]ID:1;->vI_RecordNumber;->[xxACT_ArchivosBancarios:118]id_forma_de_pago:13)
End if 
  //Else 
  //
  //End if 