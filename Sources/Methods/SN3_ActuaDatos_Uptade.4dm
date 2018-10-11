//%attributes = {}
  //SN3_ActuaDatos_Uptade 
  //ACTUALIZAR CON LOS ARRAYS ACTUALES DE PER
  //CREAR LA SELECCION DE ALUMNOS CON EL ARREGLO DE ID DE ALUMNOS QUE ESTÁ CARGADO al_id_alu
C_LONGINT:C283($vl_id_apo_sel;$1)
C_POINTER:C301($ptr_array_alu;$2)
C_TEXT:C284($modo_de_actualización;$3;$vt_current_time)
READ ONLY:C145([xShell_Fields:52])
  //MONO 209951
C_LONGINT:C283($l_id)
C_DATE:C307($d_fecha)
C_OBJECT:C1216($o_Trat)
C_TEXT:C284($t_tratamiento)

$vl_id_apo_sel:=$1
$ptr_array_alu:=$2
$modo_de_actualización:=__ ("Automáticamente")

If (Count parameters:C259=3)
	$modo_de_actualización:=$3
End if 
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

C_BOOLEAN:C305(vb_confirm_transaction;$vb_cambio;$0)
vb_confirm_transaction:=True:C214
$vb_cambio:=False:C215
READ ONLY:C145([XShell_FatObjects:86])

ARRAY LONGINT:C221($al_recnum_Fatobj;0)
C_LONGINT:C283($rn)

$vt_current_time:=String:C10(Current time:C178(*))
  //ACTUALIZANDO APODERADO

READ WRITE:C146([Personas:7])
QUERY:C277([Personas:7];[Personas:7]No:1=$vl_id_apo_sel)
If (Not:C34(Locked:C147([Personas:7])))
	
	START TRANSACTION:C239  //tengo que cancelar todo si uno de los alumnos está tomado
	
	ARRAY TEXT:C222($at_per_ref_field_temp;0)
	ARRAY TEXT:C222($at_per_rev_new_value_temp;0)
	ARRAY TEXT:C222($at_per_rev_new_value_edit_temp;0)
	ARRAY BOOLEAN:C223($ab_confirm_per_fields_temp;0)
	ARRAY TEXT:C222($at_per_rev_actual_value_temp;0)
	
	$fatObjectName:="SN3_ActuaDatos_Per_"+String:C10($vl_id_apo_sel)
	$rec_num:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$fatObjectName)
	If ($rec_num>=0)
		GOTO RECORD:C242([XShell_FatObjects:86];$rec_num)
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_per_ref_field_temp;->$at_per_rev_new_value_temp;->$ab_confirm_per_fields_temp;->$at_per_rev_new_value_edit_temp)
		APPEND TO ARRAY:C911($al_recnum_Fatobj;$rec_num)
		ARRAY TEXT:C222($at_per_rev_actual_value_temp;Size of array:C274($at_per_ref_field_temp))
	End if 
	
	For ($i;1;Size of array:C274($at_per_ref_field_temp))
		
		$pos:=Position:C15(".";$at_per_ref_field_temp{$i})
		$num_table:=Num:C11(Substring:C12($at_per_ref_field_temp{$i};1;$pos-1))
		$num_field:=Num:C11(Substring:C12($at_per_ref_field_temp{$i};$pos+1))
		$ptr_field:=Field:C253($num_table;$num_field)
		
		$at_per_rev_actual_value_temp{$i}:=ST_Coerce_to_Text ($ptr_field;False:C215)
		If ($ab_confirm_per_fields_temp{$i})
			
			If (($num_table=7) & (($num_field=2) | ($num_field=3) | ($num_field=4) | ($num_field=6)) & ($at_per_rev_new_value_edit_temp{$i}=""))
				  //nombre, apellidos y rut, no se pueden dejar vacíos estos campos
			Else 
				ST_Text2Anything ($ptr_field;$at_per_rev_new_value_edit_temp{$i})
				
				QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$num_table;*)
				QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=$num_field)
				If ((Type:C295($ptr_field->)=2) | (Type:C295($ptr_field->)=0))
					$ptr_field->:=ST_Format2 ($ptr_field;[xShell_Fields:52]FormatoNombres:15*10)
				End if 
				
				If (($num_field=6) & (<>gCountryCode="cl"))
					$ptr_field->:=Replace string:C233($ptr_field->;".";"")
					$ptr_field->:=Replace string:C233($ptr_field->;"-";"")
					$ptr_field->:=CTRY_CL_VerifRUT ($ptr_field->;False:C215)
				End if 
				
				$vb_cambio:=True:C214
			End if 
			
		Else 
			$at_per_rev_new_value_edit_temp{$i}:=ST_Coerce_to_Text ($ptr_field;False:C215)
		End if 
		
	End for 
	
	READ WRITE:C146([XShell_FatObjects:86])
	GOTO RECORD:C242([XShell_FatObjects:86];$rec_num)
	BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->$at_per_ref_field_temp;->$at_per_rev_new_value_temp;->$ab_confirm_per_fields_temp;->$at_per_rev_new_value_edit_temp;->$at_per_rev_actual_value_temp)
	SAVE RECORD:C53([XShell_FatObjects:86])
	READ ONLY:C145([XShell_FatObjects:86])
	
	  //registro que la persona pasó por el proceso de actualización no importa si cambió datos o nó
	$fia_id:=Find in array:C230(at_tipo_id_usr;"7."+String:C10([Personas:7]No:1))
	If ($fia_id>0)
		ad_last_actuadatos{$fia_id}:=Current date:C33(*)
	Else 
		APPEND TO ARRAY:C911(at_tipo_id_usr;"7."+String:C10([Personas:7]No:1))
		APPEND TO ARRAY:C911(ad_last_actuadatos;Current date:C33(*))
	End if 
	
	SAVE RECORD:C53([Personas:7])
	
	If ([Personas:7]Apellido_paterno:3#Old:C35([Personas:7]Apellido_paterno:3))
		
		C_TEXT:C284($vt_fam_msg)
		C_LONGINT:C283($vl_resp_fam)
		
		READ ONLY:C145([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
		QUERY:C277([Familia:78]; | ;[Familia:78]Madre_Número:6=[Personas:7]No:1)
		
		If (Records in selection:C76([Familia:78])>0)
			ARRAY LONGINT:C221($al_fam_rn;0)
			LONGINT ARRAY FROM SELECTION:C647([Familia:78];$al_fam_rn;"")
			For ($h;1;Size of array:C274($al_fam_rn))
				READ WRITE:C146([Familia:78])
				GOTO RECORD:C242([Familia:78];$al_fam_rn{$h})
				If (Locked:C147([Familia:78]))
					vb_confirm_transaction:=False:C215
					$h:=Size of array:C274($al_fam_rn)
				Else 
					$vt_fam_msg:=[Personas:7]Apellidos_y_nombres:30+__ (" ha cambiado su apellido paterno, ¿Desea cambiar el apellido en el nombre de la familia ")+[Familia:78]Nombre_de_la_familia:3+__ (" ? en la cual ")
					If ([Familia:78]Padre_Número:5=[Personas:7]No:1)
						$vt_fam_msg:=$vt_fam_msg+" "+__ ("él es Padre")+"."
					Else 
						$vt_fam_msg:=$vt_fam_msg+" "+__ ("ella es Madre")+"."
					End if 
					
					$vl_resp_fam:=CD_Dlog (0;$vt_fam_msg;"";__ ("Si");__ ("No"))
					
					If ($vl_resp_fam=1)
						If ([Familia:78]Padre_Número:5=[Personas:7]No:1)
							[Familia:78]Nombre_de_la_familia:3:=[Personas:7]Apellido_paterno:3+" "+KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;->[Personas:7]Apellido_paterno:3)
						Else 
							[Familia:78]Nombre_de_la_familia:3:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;->[Personas:7]Apellido_paterno:3)+" "+[Personas:7]Apellido_paterno:3
						End if 
						SAVE RECORD:C53([Familia:78])
					End if 
				End if 
				KRL_UnloadReadOnly (->[Familia:78])
			End for 
		End if 
		
	End if 
	
	KRL_UnloadReadOnly (->[Personas:7])
	
	  //ACTUALIZANDO ALUMNOS
	For ($x;1;Size of array:C274($ptr_array_alu->))
		
		READ WRITE:C146([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$ptr_array_alu->{$x})
		
		ARRAY TEXT:C222($at_alu_ref_field_temp;0)
		ARRAY TEXT:C222($at_alu_rev_new_value_temp;0)
		ARRAY TEXT:C222($at_alu_rev_new_value_edit_temp;0)
		ARRAY BOOLEAN:C223($ab_confirm_alu_fields_temp;0)
		ARRAY TEXT:C222($at_alu_rev_actual_value_temp;0)
		
		$vb_ficha_medica:=False:C215
		$vb_cambio:=False:C215
		$vb_cambio_contactos:=False:C215  //es un registro relacionado de Xshellfatobjects lo ocupo para marcar un envío de alumno modificado a SN3
		
		If (Not:C34(Locked:C147([Alumnos:2])))
			
			$fatObjectName:="SN3_ActuaDatos_Alu_"+String:C10($vl_id_apo_sel)+"_"+String:C10($ptr_array_alu->{$x})  //id del apodreado que envió los datos y luego el id del alumno
			$rec_num:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$fatObjectName)
			
			If ($rec_num>=0)
				GOTO RECORD:C242([XShell_FatObjects:86];$rec_num)
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$at_alu_ref_field_temp;->$at_alu_rev_new_value_temp;->$ab_confirm_alu_fields_temp;->$at_alu_rev_new_value_edit_temp)
				APPEND TO ARRAY:C911($al_recnum_Fatobj;$rec_num)
				ARRAY TEXT:C222($at_alu_rev_actual_value_temp;Size of array:C274($at_alu_ref_field_temp))
			End if 
			
			For ($i;1;Size of array:C274($at_alu_ref_field_temp))
				
				$pos:=Position:C15(".";$at_alu_ref_field_temp{$i})
				$num_table:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};1;$pos-1))
				
				  //MONO: ACTUA DATOS FATOBJECTS
				If (Table:C252(->[XShell_FatObjects:86])=$num_table)
					$FO_reference:=Substring:C12($at_alu_ref_field_temp{$i};$pos+1)
				Else 
					$num_field:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};$pos+1))
					$ptr_field:=Field:C253($num_table;$num_field)
					$at_alu_rev_actual_value_temp{$i}:=ST_Coerce_to_Text ($ptr_field;False:C215)
				End if 
				
				If ($ab_confirm_alu_fields_temp{$i})
					
					Case of 
						: (Table:C252(->[XShell_FatObjects:86])=$num_table)
							
							$fia_ref:=Find in array:C230(SN3_ListaCamposAlumnoRefField;$at_alu_ref_field_temp{$i})
							
							If ($fia_ref>0)
								ARRAY TEXT:C222($at_valores_ref_fatobj;0)
								AT_Text2Array (->$at_valores_ref_fatobj;$FO_reference;"\t")
								
								Case of 
									: ($at_valores_ref_fatobj{1}="contactos.ALU.@")
										
										Case of 
											: ($at_valores_ref_fatobj{2}="1")
												ARRAY TEXT:C222(aNombreContacto;0)
												ARRAY TEXT:C222(aTelContacto;0)
												ARRAY TEXT:C222(aRelacionContacto;0)
												READ WRITE:C146([XShell_FatObjects:86])
												
												$ref:="contactos.ALU."+String:C10($ptr_array_alu->{$x})
												$rn:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$ref)
												
												If ($rn#-1)
													GOTO RECORD:C242([XShell_FatObjects:86];$rn)
													BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
												Else 
													CREATE RECORD:C68([XShell_FatObjects:86])
													[XShell_FatObjects:86]FatObjectName:1:=$ref
												End if 
												APPEND TO ARRAY:C911(aNombreContacto;$at_alu_rev_new_value_edit_temp{$i})
												
											: ($at_valores_ref_fatobj{2}="2")
												
												APPEND TO ARRAY:C911(aRelacionContacto;$at_alu_rev_new_value_edit_temp{$i})
												
											: ($at_valores_ref_fatobj{2}="3")
												
												APPEND TO ARRAY:C911(aTelContacto;$at_alu_rev_new_value_edit_temp{$i})
												BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
												SAVE RECORD:C53([XShell_FatObjects:86])
												KRL_UnloadReadOnly (->[XShell_FatObjects:86])
										End case 
										$vb_cambio_contactos:=True:C214
								End case 
								
							End if 
							
						: (Table:C252(->[Alumnos_FichaMedica:13])=$num_table)
							If (Not:C34($vb_ficha_medica))
								READ WRITE:C146([Alumnos_FichaMedica:13])
								QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=$ptr_array_alu->{$x})
								$vb_ficha_medica:=True:C214
							End if 
							  //MONO 209951
							$y_tratamientos:=->[Alumnos_FichaMedica:13]OB_tratamiento:23  //ASM por problemas de compilación
							Case of 
								: ($ptr_field=$y_tratamientos)
									$l_id:=ST_ObtieneID ("obtieneID")
									$d_fecha:=Current date:C33(*)
									$t_tratamiento:=$at_alu_rev_new_value_edit_temp{$i}
									
									OB SET:C1220($o_Trat;"tratID";$l_id)
									OB SET:C1220($o_Trat;"tratNotificacion";$d_fecha)
									OB SET:C1220($o_Trat;"tratObservacion";$t_tratamiento)
									OB SET:C1220([Alumnos_FichaMedica:13]OB_tratamiento:23;String:C10($l_id);$o_Trat)
									
								Else 
									ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})
							End case 
							
						: (Table:C252(->[Alumnos_FichaMedica_Alergias:223])=$num_table)
							
							READ WRITE:C146([Alumnos_FichaMedica_Alergias:223])
							CREATE RECORD:C68([Alumnos_FichaMedica_Alergias:223])
							[Alumnos_FichaMedica_Alergias:223]id_alumno:4:=$ptr_array_alu->{$x}
							ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})
							
							$i:=$i+1
							If ($i<=Size of array:C274($at_alu_ref_field_temp))
								$pos:=Position:C15(".";$at_alu_ref_field_temp{$i})
								$num_table:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};1;$pos-1))
								$num_field:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};$pos+1))
								$ptr_field:=Field:C253($num_table;$num_field)
								ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})
							End if 
							SAVE RECORD:C53([Alumnos_FichaMedica_Alergias:223])
							KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Alergias:223])
							
						: (Table:C252(->[Alumnos_FichaMedica_Enfermedade:224])=$num_table)
							
							READ WRITE:C146([Alumnos_FichaMedica_Enfermedade:224])
							CREATE RECORD:C68([Alumnos_FichaMedica_Enfermedade:224])
							[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3:=$ptr_array_alu->{$x}
							ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})
							SAVE RECORD:C53([Alumnos_FichaMedica_Enfermedade:224])
							KRL_UnloadReadOnly (->[Alumnos_FichaMedica_Enfermedade:224])
							
						: (Table:C252(->[Alumnos_Vacunas:101])=$num_table)
							
							READ WRITE:C146([Alumnos_Vacunas:101])
							CREATE RECORD:C68([Alumnos_Vacunas:101])
							[Alumnos_Vacunas:101]Numero_Alumno:1:=$ptr_array_alu->{$x}
							ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})  //[Alumnos_Vacunas]Enfermedad
							$i:=$i+1
							If ($i<=Size of array:C274($at_alu_ref_field_temp))
								$pos:=Position:C15(".";$at_alu_ref_field_temp{$i})
								$num_table:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};1;$pos-1))
								$num_field:=Num:C11(Substring:C12($at_alu_ref_field_temp{$i};$pos+1))
								$ptr_field:=Field:C253($num_table;$num_field)
								ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})  //[Alumnos_Vacunas]Meses
								  //[Alumnos_Vacunas]Edad:= no viene en el xml
								  //20140401 RCH Ticket 130190.
								[Alumnos_Vacunas:101]Edad:2:=DT_Months2AgeLongString ($ptr_field->)
							End if 
							
							[Alumnos_Vacunas:101]Vacunado:5:=True:C214
							SAVE RECORD:C53([Alumnos_Vacunas:101])
							KRL_ReloadAsReadOnly (->[Alumnos_Vacunas:101])
							
						Else 
							If (($num_table=2) & (($num_field=2) | ($num_field=3) | ($num_field=4) | ($num_field=5)) & ($at_alu_rev_new_value_edit_temp{$i}=""))
								  //nombre, apellidos y rut, no se pueden dejar vacíos estos campos
							Else 
								ST_Text2Anything ($ptr_field;$at_alu_rev_new_value_edit_temp{$i})
								QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$num_table;*)
								QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=$num_field)
								If ((Type:C295($ptr_field->)=2) | (Type:C295($ptr_field->)=0))
									$ptr_field->:=ST_Format2 ($ptr_field;[xShell_Fields:52]FormatoNombres:15*10)
								End if 
								
								If (($num_field=5) & (<>gCountryCode="cl"))
									$ptr_field->:=Replace string:C233($ptr_field->;".";"")
									$ptr_field->:=Replace string:C233($ptr_field->;"-";"")
									$ptr_field->:=CTRY_CL_VerifRUT ($ptr_field->;False:C215)
								End if 
								
								$vb_cambio:=True:C214
							End if 
					End case 
					
				Else 
					$at_alu_rev_new_value_edit_temp{$i}:=ST_Coerce_to_Text ($ptr_field;False:C215)
				End if 
				
			End for 
			
			READ WRITE:C146([XShell_FatObjects:86])
			GOTO RECORD:C242([XShell_FatObjects:86];$rec_num)
			BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->$at_alu_ref_field_temp;->$at_alu_rev_new_value_temp;->$ab_confirm_alu_fields_temp;->$at_alu_rev_new_value_edit_temp;->$at_alu_rev_actual_value_temp)
			SAVE RECORD:C53([XShell_FatObjects:86])
			READ ONLY:C145([XShell_FatObjects:86])
			
		Else 
			CD_Dlog (0;__ ("Registro del Alumno "+[Alumnos:2]apellidos_y_nombres:40+"está siendo utlizado por otro usuario en este momento"))
			vb_confirm_transaction:=False:C215
			$i:=Size of array:C274($ptr_array_alu->)
		End if 
		
		If ($vb_cambio)
			SAVE RECORD:C53([Alumnos:2])
		End if 
		
		If ($vb_ficha_medica)
			SAVE RECORD:C53([Alumnos_FichaMedica:13])
			SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
		End if 
		
		If ($vb_cambio_contactos)  //para los contactos de urgencia que están en xshell fatobjects
			SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos:2]numero:1;SNT_Accion_Actualizar)
		End if 
		
		  //registro que la persona pasó por el proceso de actualización no importa si cambió datos o nó
		$fia_id:=Find in array:C230(at_tipo_id_usr;"2."+String:C10([Alumnos:2]numero:1))
		If ($fia_id>0)
			ad_last_actuadatos{$fia_id}:=Current date:C33(*)
		Else 
			APPEND TO ARRAY:C911(at_tipo_id_usr;"2."+String:C10([Alumnos:2]numero:1))
			APPEND TO ARRAY:C911(ad_last_actuadatos;Current date:C33(*))
		End if 
		
		KRL_UnloadReadOnly (->[Alumnos:2])
		KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
		
	End for 
	
	If (vb_confirm_transaction)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
	
Else 
	CD_Dlog (0;__ ("Registro del Apoderado "+[Personas:7]Apellidos_y_nombres:30+"está siendo utlizado por otro usuario en este momento"))
End if 
KRL_UnloadReadOnly (->[Personas:7])

If (vb_confirm_transaction)
	$ot:=OT New 
	OT PutArray ($ot;"tipo_id";at_tipo_id_usr)
	OT PutArray ($ot;"fecha_actua";ad_last_actuadatos)
	$settingsBlob:=OT ObjectToNewBLOB ($ot)
	OT Clear ($ot)
	PREF_SetBlob (0;"SN3_ActuaDatos_Actualizaciones";$settingsBlob)
	
	  //AQUI DEBO PASAR A OTRO  FATOBJECTNAME los procesados
	READ WRITE:C146([XShell_FatObjects:86])
	For ($i;1;Size of array:C274($al_recnum_Fatobj))
		GOTO RECORD:C242([XShell_FatObjects:86];$al_recnum_Fatobj{$i})
		[XShell_FatObjects:86]FatObjectName:1:=Replace string:C233([XShell_FatObjects:86]FatObjectName:1;"ActuaDatos";"ST_Actualizado")+"_"+DTS_MakeFromDateTime 
		[XShell_FatObjects:86]TextObject:3:=$modo_de_actualización+" "+__ ("por")+" "+SN3_ActuaDatosEncargado+": "+$vt_current_time
		[XShell_FatObjects:86]DateObject:7:=Current date:C33(*)
		SAVE RECORD:C53([XShell_FatObjects:86])
		
	End for 
	KRL_UnloadReadOnly (->[XShell_FatObjects:86])
	
End if 

$0:=vb_confirm_transaction
KRL_UnloadReadOnly (->[XShell_FatObjects:86])