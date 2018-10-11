If (Form event:C388=On Data Change:K2:15)
	modPago:=True:C214
End if 
  //If (Self->#"")
  //C_LONGINT($Duplicados)
  //$Duplicados:=ACTdc_buscaDuplicados (-2;Self->;[ACT_Documentos_de_Pago]Ch_Cuenta;[ACT_Documentos_de_Pago]Ch_BancoCodigo)
  //If (Self->#Old(Self->))
  //If ($duplicados>0)
  //CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
  //Self->:=Old(Self->)
  //End if 
  //Else 
  //If ($duplicados>1)
  //CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
  //Self->:=Old(Self->)
  //End if 
  //End if 
  //Else 
  //CD_Dlog (0;__ ("Debe ingresar un número de serie para este documento."))
  //Self->:=Old(Self->)
  //End if 
  //End if 