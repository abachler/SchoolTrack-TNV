
Case of 
	: (Form event:C388=On Load:K2:1)
		C_OBJECT:C1216($ob_temp)
		C_OBJECT:C1216($ob_Parametros)
		$ob_Parametros:=OB_Create 
		OB_SET_Text ($ob_Parametros;"CreaObjeto";"accion")
		$ob_temp:=STR_SegAvanzada (->$ob_Parametros)
		$ob_Configuracion:=PREF_fGetObject (0;"PreferenciaContraseñas";$ob_temp)
		OB_SET_Text ($ob_Configuracion;"CargaVariables";"accion")
		STR_SegAvanzada (->$ob_Configuracion)
End case 


