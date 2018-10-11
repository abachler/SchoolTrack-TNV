//%attributes = {}

If (SN3_CheckNotColegium )
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		
		SN3_LoadDataReceptionSettings 
		C_TEXT:C284($res;$vt_xml;$xmlRef;$vt_FileName)
		C_LONGINT:C283($can_reg)
		READ ONLY:C145([XShell_FatObjects:86])
		QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos@")
		If (Records in selection:C76([XShell_FatObjects:86])>0)
			$res:=sn3ws_envia_correo_totalpendien (<>gRolBD;<>vtXS_CountryCode;String:C10(Records in selection:C76([XShell_FatObjects:86])))
			If ($res#"0")
				  //error
			End if 
		End if 
		
		ARRAY LONGINT:C221($al_fo_rn_p;0)
		
		REDUCE SELECTION:C351([XShell_FatObjects:86];0)
		
		QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_Log_ActuaDatos@";*)
		QUERY:C277([XShell_FatObjects:86]; & ;[XShell_FatObjects:86]DateObject:7=Current date:C33(*)-1)
		
		If (Records in selection:C76([XShell_FatObjects:86])>0)
			
			CREATE SET:C116([XShell_FatObjects:86];"FO")
			QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)
			LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_fo_rn_p;"")
			
			$vt_FileName:=SN3_CreateFile2Send ("crear";"";40000;"dom";->$xmlRef)
			$xmlRef:=DOM Create XML Ref:C861("colegium")
			DOM SET XML DECLARATION:C859($xmlRef;"UTF-8")
			DOM_SetElementValueAndAttr ($xmlRef;"fecha";String:C10(Current date:C33(*)-1);True:C214)
			
			For ($i;1;Size of array:C274($al_fo_rn_p))
				
				GOTO RECORD:C242([XShell_FatObjects:86];$al_fo_rn_p{$i})
				$vl_id_per:=[XShell_FatObjects:86]RecordID:6
				
				$RF_ref:=DOM Create XML element:C865($xmlRef;"relacionfamiliar")
				DOM_SetElementValueAndAttr ($RF_ref;"nombre";KRL_GetTextFieldData (->[Personas:7]No:1;->[XShell_FatObjects:86]RecordID:6;->[Personas:7]Apellidos_y_nombres:30);True:C214)
				$cambios_ref:=DOM Create XML element:C865($RF_ref;"cambios")
				
				ARRAY TEXT:C222($at_ref_fields;0)
				ARRAY TEXT:C222($at_new_value;0)
				ARRAY BOOLEAN:C223($ab_confirm;0)
				ARRAY TEXT:C222($at_new_value_edit;0)
				ARRAY TEXT:C222($at_original;0)
				
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_ref_fields;->$at_new_value;->$ab_confirm;->$at_new_value_edit;->$at_original)
				
				For ($x;1;Size of array:C274($at_ref_fields))
					If ($ab_confirm{$x})
						$cam_ref:=DOM Create XML element:C865($cambios_ref;"cambio")
						$fia:=Find in array:C230(SN3_ListaCamposRFRefField;$at_ref_fields{$x})
						DOM_SetElementValueAndAttr ($cam_ref;"campo";SN3_ListaCamposRF{$fia};True:C214)
						DOM_SetElementValueAndAttr ($cam_ref;"valoranterior";$at_original{$x};True:C214)
						DOM_SetElementValueAndAttr ($cam_ref;"valoractual";$at_new_value_edit{$x};True:C214)
					End if 
				End for 
				
				  //alumnos
				$ALU_ref:=DOM Create XML element:C865($RF_ref;"alumnos")
				
				ARRAY LONGINT:C221($al_fo_rn_a;0)
				USE SET:C118("FO")
				QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_Log_ActuaDatos_Alu_"+String:C10($vl_id_per)+"@")
				LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_fo_rn_a;"")
				
				For ($k;1;Size of array:C274($al_fo_rn_a))
					GOTO RECORD:C242([XShell_FatObjects:86];$al_fo_rn_a{$k})
					
					$alu_d_ref:=DOM Create XML element:C865($ALU_ref;"alumno")
					DOM_SetElementValueAndAttr ($alu_d_ref;"nombre";KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[XShell_FatObjects:86]RecordID:6;->[Alumnos:2]apellidos_y_nombres:40);True:C214)
					$alu_ref_cambios:=DOM Create XML element:C865($alu_d_ref;"cambios")
					
					ARRAY TEXT:C222($at_ref_fields;0)
					ARRAY TEXT:C222($at_new_value;0)
					ARRAY BOOLEAN:C223($ab_confirm;0)
					ARRAY TEXT:C222($at_new_value_edit;0)
					ARRAY TEXT:C222($at_original;0)
					BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_ref_fields;->$at_new_value;->$ab_confirm;->$at_new_value_edit;->$at_original)
					
					For ($x;1;Size of array:C274($at_ref_fields))
						If ($ab_confirm{$x})
							$cam_ref:=DOM Create XML element:C865($cambios_ref;"cambio")
							$fia:=Find in array:C230(SN3_ListaCamposAlumnoRefField;$at_ref_fields{$x})
							DOM_SetElementValueAndAttr ($cam_ref;"campo";SN3_ListaCamposAlumno{$fia};True:C214)
							DOM_SetElementValueAndAttr ($cam_ref;"valoranterior";$at_original{$x};True:C214)
							DOM_SetElementValueAndAttr ($cam_ref;"valoractual";$at_new_value_edit{$x};True:C214)
						End if 
					End for 
					
				End for 
				
			End for 
			SN3_CloseXMLCompress ($xmlRef;$vt_FileName;"dom")
			SN3_FTP_SendFiles 
		End if 
		
	End if 
End if 