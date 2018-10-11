//%attributes = {}

ARRAY TEXT:C222($at_fo_per;0)
C_TEXT:C284($vt_xml)
READ ONLY:C145([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ST_Actualizado_@")
CREATE SET:C116([XShell_FatObjects:86];"FO_actualizado_all")
QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)
SELECTION TO ARRAY:C260([XShell_FatObjects:86]FatObjectName:1;$at_fo_per)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Informando a Schoolnet de los datos actualizados...")

For ($i;1;Size of array:C274($at_fo_per))
	
	ARRAY LONGINT:C221($al_rn_to_delete;0)
	
	$vt_xml:=""
	
	ARRAY TEXT:C222($at_per_ref_field_temp;0)
	ARRAY TEXT:C222($at_per_rev_new_value_temp;0)
	ARRAY TEXT:C222($at_per_rev_actual_value_temp;0)
	ARRAY BOOLEAN:C223($ab_confirm_per_fields_temp;0)
	ARRAY TEXT:C222($at_per_rev_new_value_edit_temp;0)
	
	$rn_fo:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$at_fo_per{$i})
	
	If ($rn_fo>0)
		GOTO RECORD:C242([XShell_FatObjects:86];$rn_fo)
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_per_ref_field_temp;->$at_per_rev_new_value_temp;->$ab_confirm_per_fields_temp;->$at_per_rev_new_value_edit_temp;->$at_per_rev_actual_value_temp)
		APPEND TO ARRAY:C911($al_rn_to_delete;$rn_fo)
	End if 
	
	If (SN3_ActuaDatosNoMailApo=0)
		
		$xmlRef:=DOM Create XML Ref:C861("cambiosrechazados")
		XML SET OPTIONS:C1090($xmlRef;XML String encoding:K45:21;XML raw data:K45:23)
		  //DOM SET XML DECLARATION($xmlRef;"UTF-8")
		DOM SET XML DECLARATION:C859($xmlRef;"ISO-8859-1")
		$rf:=DOM Create XML element:C865($xmlRef;"relacionfamiliar")
		DOM_SetElementValueAndAttr ($rf;"id";String:C10([XShell_FatObjects:86]RecordID:6);True:C214)
		
		$fia:=Find in array:C230($ab_confirm_per_fields_temp;False:C215)
		
		If ($fia>0)
			$cambios:=DOM Create XML element:C865($rf;"cambios")
			
			For ($x;1;Size of array:C274($ab_confirm_per_fields_temp))
				
				If (Not:C34($ab_confirm_per_fields_temp{$x}))
					$cambio:=DOM Create XML element:C865($cambios;"cambio")
					
					$fia:=Find in array:C230(SN3_ListaCamposRFRefField;$at_per_ref_field_temp{$x})
					
					DOM_SetElementValueAndAttr ($cambio;"campo";XML_GetValidXMLText (SN3_ListaTagsXMLRF{$fia});True:C214)
					DOM_SetElementValueAndAttr ($cambio;"valoractual";XML_GetValidXMLText ($at_per_rev_actual_value_temp{$x});True:C214)
					DOM_SetElementValueAndAttr ($cambio;"valorrechazado";XML_GetValidXMLText ($at_per_rev_new_value_temp{$x});True:C214)
					
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	ARRAY TEXT:C222($at_fo_alu;0)
	
	$fatObjectName:="SN3_ST_Actualizado_Alu_"+String:C10([XShell_FatObjects:86]RecordID:6)+"_@"
	USE SET:C118("FO_actualizado_all")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1=$fatObjectName)
	SELECTION TO ARRAY:C260([XShell_FatObjects:86]FatObjectName:1;$at_fo_alu)
	
	If (Size of array:C274($at_fo_alu)>0)
		
		If (SN3_ActuaDatosNoMailApo=0)
			$alumnos:=DOM Create XML element:C865($xmlRef;"alumnos")
		End if 
		
		For ($n;1;Size of array:C274($at_fo_alu))
			
			ARRAY TEXT:C222($at_alu_rev_field_temp;0)
			ARRAY TEXT:C222($at_alu_ref_field_temp;0)
			ARRAY TEXT:C222($at_alu_rev_actual_value_temp;0)
			ARRAY TEXT:C222($at_alu_rev_new_value_temp;0)
			ARRAY BOOLEAN:C223($ab_confirm_alu_fields_temp;0)
			ARRAY TEXT:C222($at_alu_rev_new_value_edit_temp;0)
			
			$rn_fo:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$at_fo_alu{$n})
			If ($rn_fo>0)
				  //$rn_fo:=SN3_ActuaDatos_LoadTemp2Display ($at_fo_alu{$n};->$at_alu_ref_field_temp;->$at_alu_rev_new_value_temp;->$at_alu_rev_field_temp;->$at_alu_rev_actual_value_temp;->$ab_confirm_alu_fields_temp;->$at_alu_rev_new_value_edit_temp)
				GOTO RECORD:C242([XShell_FatObjects:86];$rn_fo)
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_alu_ref_field_temp;->$at_alu_rev_new_value_temp;->$ab_confirm_alu_fields_temp;->$at_alu_rev_new_value_edit_temp;->$at_alu_rev_actual_value_temp)
				APPEND TO ARRAY:C911($al_rn_to_delete;$rn_fo)
			End if 
			
			If (SN3_ActuaDatosNoMailApo=0)
				$alumno:=DOM Create XML element:C865($alumnos;"alumno")
				DOM_SetElementValueAndAttr ($alumno;"id";String:C10([XShell_FatObjects:86]RecordID:6);True:C214)
				
				$fia:=Find in array:C230($ab_confirm_alu_fields_temp;False:C215)
				
				If ($fia>0)
					$cambios:=DOM Create XML element:C865($alumno;"cambios")
					
					For ($x;1;Size of array:C274($ab_confirm_alu_fields_temp))
						
						If (Not:C34($ab_confirm_alu_fields_temp{$x}))
							$cambio:=DOM Create XML element:C865($cambios;"cambio")
							
							$fia:=Find in array:C230(SN3_ListaCamposAlumnoRefField;$at_alu_ref_field_temp{$x})
							
							If (SN3_FieldGroupsAlumno{$fia}="")
								DOM_SetElementValueAndAttr ($cambio;"campo";XML_GetValidXMLText (SN3_ListaTagsXMLAlumno{$fia});True:C214)
							Else 
								DOM_SetElementValueAndAttr ($cambio;"campo";XML_GetValidXMLText (Lowercase:C14(SN3_FieldGroupsAlumno{$fia}));True:C214)
							End if 
							
							DOM_SetElementValueAndAttr ($cambio;"valoractual";XML_GetValidXMLText ($at_alu_rev_actual_value_temp{$x});True:C214)
							If ($at_alu_rev_new_value_edit_temp{$x}#"")
								DOM_SetElementValueAndAttr ($cambio;"valorrechazado";XML_GetValidXMLText ($at_alu_rev_new_value_edit_temp{$x});True:C214)
							Else 
								DOM_SetElementValueAndAttr ($cambio;"valorrechazado";XML_GetValidXMLText ($at_alu_rev_new_value_temp{$x});True:C214)
							End if 
							
						End if 
						
					End for 
					
				End if 
				
			End if 
			
		End for 
	End if 
	
	
	If (SN3_ActuaDatosNoMailApo=0)  //Si esta desactivado el "No avisar a los apoderados" se crean los xml con el detalle de la actualización
		If (Size of array:C274($al_rn_to_delete)>0)
			DOM EXPORT TO VAR:C863($xmlRef;$vt_xml)
			SET TEXT TO PASTEBOARD:C523($vt_xml)
			DOM CLOSE XML:C722($xmlRef)
			READ ONLY:C145([XShell_FatObjects:86])
			GOTO RECORD:C242([XShell_FatObjects:86];$al_rn_to_delete{1})
			sn3ws_ActuaDatos_resultadoproce (<>gRolBD;<>vtXS_CountryCode;String:C10([XShell_FatObjects:86]RecordID:6);$vt_xml)
		End if 
	End if 
	
	For ($o;1;Size of array:C274($al_rn_to_delete))
		READ WRITE:C146([XShell_FatObjects:86])
		GOTO RECORD:C242([XShell_FatObjects:86];$al_rn_to_delete{$o})
		$vt_newname:=Replace string:C233([XShell_FatObjects:86]FatObjectName:1;"ST_Actualizado";"Log_ActuaDatos")
		[XShell_FatObjects:86]FatObjectName:1:=$vt_newname+"_"+DTS_MakeFromDateTime 
		SAVE RECORD:C53([XShell_FatObjects:86])
		KRL_UnloadReadOnly (->[XShell_FatObjects:86])
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_fo_per))
	
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
