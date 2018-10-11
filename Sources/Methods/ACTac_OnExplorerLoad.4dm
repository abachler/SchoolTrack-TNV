//%attributes = {}
  //ACTac_OnExplorerLoad

ACTcfg_LoadConfigData (1)
If (bAvisoApoderado=1)
	  //Case of 
	  //: (◊vtXS_CountryCode="co")
	  //AL_SetHeaders (xALP_Browser;2;1;"Acudiente")
	  //Else 
	  //AL_SetHeaders (xALP_Browser;2;1;"Responsable")
	  //End case 
	AL_SetHeaders (xALP_Browser;2;1;__ ("Responsable"))
	  //If (Records in table([ACT_Terceros])>0)
	  //$recs:=Size of array(alBWR_recordNumber)
	  //READ ONLY([ACT_Avisos_de_Cobranza])
	  //READ ONLY([ACT_Terceros])
	  //$arrayApdo:=Get pointer(atBWR_ArrayNames{2})
	  //For ($i;1;$recs)
	  //GOTO RECORD([ACT_Avisos_de_Cobranza];alBWR_recordNumber{$i})
	  //If ([ACT_Avisos_de_Cobranza]ID_Tercero#0)
	  //KRL_FindAndLoadRecordByIndex (->[ACT_Terceros]Id;->[ACT_Avisos_de_Cobranza]ID_Tercero)
	  //$arrayApdo->{$i}:=[ACT_Terceros]Nombre_Completo
	  //End if 
	  //End for 
	  //REDUCE SELECTION([ACT_Avisos_de_Cobranza];0)
	  //End if 
Else 
	AL_SetHeaders (xALP_Browser;2;1;__ ("Cuenta Corriente"))
	  //$recs:=Size of array(alBWR_recordNumber)
	  //READ ONLY([ACT_Avisos_de_Cobranza])
	  //READ ONLY([ACT_CuentasCorrientes])
	  //READ ONLY([Alumnos])
	  //$arrayApdo:=Get pointer(atBWR_ArrayNames{2})
	  //For ($i;1;$recs)
	  //GOTO RECORD([ACT_Avisos_de_Cobranza];alBWR_recordNumber{$i})
	  //If ([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente#0)
	  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
	  //QUERY([Alumnos];[Alumnos]Número=[ACT_CuentasCorrientes]ID_Alumno)
	  //$arrayApdo->{$i}:=[Alumnos]Apellidos_y_Nombres
	  //Else 
	  //$arrayApdo->{$i}:=""
	  //End if 
	  //End for 
	  //REDUCE SELECTION([ACT_Avisos_de_Cobranza];0)
End if 
AL_UpdateArrays (xALP_Browser;-1)