
  //antes de actualizar guardamos el fatobject seleccionado

READ WRITE:C146([XShell_FatObjects:86])
$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;vt_LastFatObjectName)
If ($recNUM>=0)
	GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_ref_field_temp;->at_rev_new_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp)
	SAVE RECORD:C53([XShell_FatObjects:86])
End if 
KRL_UnloadReadOnly (->[XShell_FatObjects:86])

  //como ahora tengo a todos los alumnos en el array hago uno para el apoderado seleccionado
ARRAY LONGINT:C221($DA_Return;0)
ARRAY LONGINT:C221($al_id_alumnos;0)
al_id_per{0}:=vl_id_apo_sel
AT_SearchArray (->al_id_per;"=";->$DA_Return)
For ($i;1;Size of array:C274($DA_Return))
	If (al_id_alu{$DA_Return{$i}}>0)
		APPEND TO ARRAY:C911($al_id_alumnos;al_id_alu{$DA_Return{$i}})
	End if 
End for 

If (SN3_ActuaDatos_Uptade (vl_id_apo_sel;->$al_id_alumnos;__ ("Manualmente")))
	APPEND TO ARRAY:C911(al_id_personas_actualizadas;vl_id_apo_sel)
End if 

  //ENVIO DE XML de aviso de actualización, para correo a los apoderados
SN3_ActuaDatos_resultadoproceso 

Case of 
	: (opc_1=1)
		$op_orden:=1
	: (opc_2=1)
		$op_orden:=2
	: (opc_3=1)
		$op_orden:=3
End case 

SN3_ActuaDatos_LoadRev ($op_orden;->vt_LastFatObjectName)
LISTBOX SELECT ROW:C912(*;"lb_per_names";1)

  //cuando no encontramos que mas actualizar....
If (Size of array:C274(al_id_per)=0)
	OBJECT SET TITLE:C194(*;"vt_seleccion";" ")
	If (Application type:C494=4D Remote mode:K5:5)
		$l_process_id:=Execute on server:C373("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3 Actuadatos";True:C214;False:C215)
	Else 
		$l_process_id:=New process:C317("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3 Actuadatos";True:C214;False:C215)
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
End if 