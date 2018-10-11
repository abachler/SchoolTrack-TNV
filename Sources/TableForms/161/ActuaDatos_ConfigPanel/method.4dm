Case of 
	: (Form event:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(at_IDNivel;0)
		ARRAY LONGINT:C221(aiADT_NivNo;0)
		
		ARRAY LONGINT:C221(al_minutos;0)
		APPEND TO ARRAY:C911(al_minutos;30)
		APPEND TO ARRAY:C911(al_minutos;60)
		APPEND TO ARRAY:C911(al_minutos;120)
		
		ARRAY BOOLEAN:C223(ab_NivelModificado;0)
		
		  //para llevar el registro de quine va actualizando sus datos
		  //ARRAY LONGINT(al_tipo;0)  //alu 2 - per 7
		ARRAY TEXT:C222(at_tipo_id_usr;0)  //tipo.id
		ARRAY DATE:C224(ad_last_actuadatos;0)
		$ot:=OT New 
		OT PutArray ($ot;"tipo_id";at_tipo_id_usr)
		OT PutArray ($ot;"fecha_actua";ad_last_actuadatos)
		$settingsBlob:=OT ObjectToNewBLOB ($ot)
		OT Clear ($ot)
		$settingsBlob:=PREF_fGetBlob (0;"SN3_ActuaDatos_Actualizaciones";$settingsBlob)
		$ot:=OT BLOBToObject ($settingsBlob)
		OT GetArray ($ot;"tipo_id";at_tipo_id_usr)
		OT GetArray ($ot;"fecha_actua";ad_last_actuadatos)
		OT Clear ($ot)
		
		  //INFO ACTUALIZACIONES
		C_LONGINT:C283(vl_tipo_de_consulta)
		
		SN3_TabRecepcionDatos:=New list:C375
		APPEND TO LIST:C376(SN3_TabRecepcionDatos;__ ("Alumnos");1)
		APPEND TO LIST:C376(SN3_TabRecepcionDatos;__ ("Relaciones Familiares");2)
		APPEND TO LIST:C376(SN3_TabRecepcionDatos;__ ("Configuración");3)
		APPEND TO LIST:C376(SN3_TabRecepcionDatos;__ ("Información");4)
		
		NIV_LoadArrays 
		COPY ARRAY:C226(<>al_NumeroNivelesSchoolNet;aiADT_NivNo)
		COPY ARRAY:C226(<>at_NombreNivelesSchoolNet;at_IDNivel)
		ARRAY BOOLEAN:C223(ab_NivelModificado;Size of array:C274(at_IDNivel))
		vtSNT_ConfigLevelRD:=at_IDNivel{1}
		vlSN3_CurrConfigLevel:=aiADT_NivNo{1}
		aiADT_NivNo:=1
		
		  //Para seleccionar usuario responsable y agregar usuarios para las notificaciones
		READ ONLY:C145([xShell_Users:47])
		CREATE SELECTION FROM ARRAY:C640([xShell_Users:47];<>alUSR_USERSRECNUMS)
		ORDER BY:C49([xShell_Users:47];[xShell_Users:47]Name:2;>)
		ARRAY TEXT:C222(at_usr_name;0)
		ARRAY TEXT:C222(at_usr_mail;0)
		ARRAY LONGINT:C221(al_usr_id;0)
		
		SELECTION TO ARRAY:C260([xShell_Users:47]Name:2;at_usr_name;[xShell_Users:47]No:1;al_usr_id;[xShell_Users:47]email:20;at_usr_mail)
		
		  //SN3_InitDataReceptionSettings 
		  //SN3_LoadDataReceptionSettings 
		SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		
		OBJECT SET SCROLL POSITION:C906(lb_CamposAlumno;1;*)
		OBJECT SET SCROLL POSITION:C906(lb_CamposRelaciones;1;*)
		OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
		OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
		OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
		OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))
		
		vb_ConfigModificado:=False:C215
		vlSN3_CurrentTab:=1
		vb_Gral_CFG_Mod:=False:C215  //este para la config general
		
		If (SN3_ActuaDatos_RecibirDatos=0)
			SN3_DataRecInterval:=0
			OBJECT SET ENABLED:C1123(*;"SN3_DataRecInterval";False:C215)
			OBJECT SET ENABLED:C1123(*;"btn_inv_min";False:C215)
		Else 
			OBJECT SET ENABLED:C1123(*;"SN3_DataRecInterval";True:C214)
			OBJECT SET ENABLED:C1123(*;"btn_inv_min";True:C214)
		End if 
		
		OBJECT SET VISIBLE:C603(vd_fecha_ini_actuadatos;(SN3_ActuaDatosActivar=1))
		
		FORM GOTO PAGE:C247(1)
		SELECT LIST ITEMS BY POSITION:C381(SN3_TabRecepcionDatos;1)
		OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar ahora ")+vtSNT_ConfigLevelRD)
		OBJECT SET VISIBLE:C603(*;"SN3_ActuaDatosPublica";True:C214)
		
		SET TIMER:C645(30)
	: (Form event:C388=On Close Box:K2:21)
		$page:=FORM Get current page:C276
		If (($page=1) | ($page=2))
			SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
		Else 
			SN3_SaveDataReceptionSettings 
		End if 
		
		ARRAY LONGINT:C221($DA_Return;0)
		ab_NivelModificado{0}:=True:C214
		AT_SearchArray (->ab_NivelModificado;"=";->$DA_Return)
		For ($o;1;Size of array:C274($DA_Return))
			SN3_SendDataReceptionConfigs (1;aiADT_NivNo{$DA_Return{$o}})
		End for 
		If (vb_Gral_CFG_Mod)
			SN3_SendDataReceptionConfigs (0)
		End if 
		KRL_ExecuteEverywhere ("SN3_LoadDataReceptionSettings")
		
		CANCEL:C270
	: (Form event:C388=On Timer:K2:25)
		IT_MODIFIERS 
		  //Case of 
		  //: ((Macintosh option down | Windows Alt down) & (Shift down))
		  //OBJECT SET TITLE(bEnviarNivel;__ ("Enviar sólo modificadas ahora"))
		  //: (Macintosh option down | Windows Alt down)
		  //OBJECT SET TITLE(bEnviarNivel;__ ("Enviar todas ahora"))
		  //Else 
		  //OBJECT SET TITLE(bEnviarNivel;__ ("Enviar ahora ")+vtSNT_ConfigLevelRD)
		  //End case 
End case 