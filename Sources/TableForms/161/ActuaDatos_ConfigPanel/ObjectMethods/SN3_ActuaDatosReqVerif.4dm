$cambiar:=False:C215
If (SN3_ActuaDatosReqVerif=1)
	$resp:=CD_Dlog (0;__ ("Tome en consideración que al no revisar los datos recibidos desde internet, puede almacenar datos basura. ¿Desea continuar?");"";__ ("Si");__ ("No"))
	If ($resp=1)
		$cambiar:=True:C214
	Else 
		SN3_ActuaDatosReqVerif:=0
	End if 
	
Else 
	$cambiar:=True:C214
End if 

If ($cambiar)
	
	SN3_SaveDataReceptionSettings 
	vb_Gral_CFG_Mod:=True:C214
	$msg:=ST_Boolean2Str (SN3_ActuaDatosReqVerif=1;"Activada";"Desactivada")+", actualizacion de datos sin previa verificación"
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
End if 