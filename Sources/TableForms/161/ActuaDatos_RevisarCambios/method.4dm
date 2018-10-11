Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY LONGINT:C221(al_id_personas_actualizadas;0)  //para enviar archivo 40001
		C_LONGINT:C283(vl_cant_actua_ini)
		C_TEXT:C284(vt_LastFatObjectName)
		
		vl_cant_actua_ini:=0
		
		opc_1:=1
		opc_2:=0
		opc_3:=0
		
		vl_cant_actua_ini:=SN3_ActuaDatos_LoadRev (1;->vt_LastFatObjectName)
		LISTBOX COLLAPSE:C1101(*;"lb_per_names";True:C214;lk all:K53:16)
		LISTBOX SELECT ROW:C912(*;"lb_per_names";1)
		
	: (Form event:C388=On Close Box:K2:21)
		
		  //salvamos al ultimo seleccionado
		READ WRITE:C146([XShell_FatObjects:86])
		$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;vt_LastFatObjectName)
		If ($recNUM>=0)
			GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
			BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_ref_field_temp;->at_rev_new_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp)
			SAVE RECORD:C53([XShell_FatObjects:86])
		End if 
		KRL_UnloadReadOnly (->[XShell_FatObjects:86])
		
		
		If (vl_cant_actua_ini>Size of array:C274(al_id_per))
			If (Application type:C494=4D Remote mode:K5:5)
				$l_process_id:=Execute on server:C373("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;False:C215)
			Else 
				$l_process_id:=New process:C317("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3 Actuadatos";True:C214;False:C215)
			End if 
		End if 
		
		If (Size of array:C274(al_id_personas_actualizadas)>0)  //archivo 40001
			C_OBJECT:C1216($ob_actualizados)
			$ob_actualizados:=OB_Create 
			OB_SET ($ob_actualizados;->al_id_personas_actualizadas;"id_actualizados")
			If (Application type:C494=4D Remote mode:K5:5)
				$l_process_id:=Execute on server:C373("SN3_ActuaDatosSendIDActualizado";128000;"Envio de Datos SN3 Actuadatos";$ob_actualizados)
			Else 
				$l_process_id:=New process:C317("SN3_ActuaDatosSendIDActualizado";128000;"Envio de Datos SN3 Actuadatos";$ob_actualizados)
			End if 
			ARRAY LONGINT:C221(al_id_personas_actualizadas;0)
			
		End if 
		
		CANCEL:C270
End case 