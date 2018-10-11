C_POINTER:C301($colPtr)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($col;$row)
		LISTBOX GET CELL POSITION:C971(lb_per_names;$col;$row;$colPtr)
		
		If ($row>0)
			
			OBJECT SET TITLE:C194(*;"vt_seleccion";at_per_name{$row}+__ (" y alumnos"))
			
			If ($col=1)
				  //ultima persona seleccionada
				$fatObjectName:="SN3_ActuaDatos_Per_"+String:C10(al_id_per{$row})
			Else 
				  //ultimo alumno seleccionado
				$fatObjectName:="SN3_ActuaDatos_Alu_"+String:C10(al_id_per{$row})+"_"+String:C10(al_id_alu{$row})
			End if 
			
			vl_id_apo_sel:=al_id_per{$row}
			
			If ($fatObjectName#vt_LastFatObjectName)  //grabar el fatobject anterior seleccionado y mostrar el actual
				
				READ WRITE:C146([XShell_FatObjects:86])
				$recNUM:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;vt_LastFatObjectName)
				If ($recNUM>=0)
					GOTO RECORD:C242([XShell_FatObjects:86];$recNUM)
					BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->at_ref_field_temp;->at_rev_new_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp)
					SAVE RECORD:C53([XShell_FatObjects:86])
				End if 
				KRL_UnloadReadOnly (->[XShell_FatObjects:86])
				
				ARRAY TEXT:C222(at_rev_field_temp;0)
				ARRAY TEXT:C222(at_ref_field_temp;0)
				ARRAY TEXT:C222(at_rev_actual_value_temp;0)
				ARRAY TEXT:C222(at_rev_new_value_temp;0)
				ARRAY TEXT:C222(at_rev_new_value_edit_temp;0)
				ARRAY BOOLEAN:C223(ab_confirm_fields_temp;0)
				ARRAY LONGINT:C221(al_estilo;0)
				
				vt_LastFatObjectName:=$fatObjectName
				SN3_ActuaDatos_LoadTemp2Display (vt_LastFatObjectName;->at_ref_field_temp;->at_rev_new_value_temp;->at_rev_field_temp;->at_rev_actual_value_temp;->ab_confirm_fields_temp;->at_rev_new_value_edit_temp;->al_estilo)
			End if 
			
		End if 
		
End case 