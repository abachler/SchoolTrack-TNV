SRtbl_ShowChoiceList (0;__ ("Seleccione el encargado...");2;->btn_ancargado;False:C215;->at_usr_name)

  //$usuarios:=AT_array2text (->$at_usr_name)
  //$choice:=Pop up menu($usuarios;$at_usr_name)

If (choiceidx>0)
	SN3_ActuaDatosEncargadoID:=al_usr_id{choiceidx}
	SN3_ActuaDatosEncargado:=at_usr_name{choiceidx}
	<>ACTUADATOS_ID_USR_REV:=SN3_ActuaDatosEncargadoID
	vb_Gral_CFG_Mod:=True:C214
	$msg:="Asignación del responsable de la actualización de datos: "+SN3_ActuaDatosEncargado
	LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")
	
End if 
