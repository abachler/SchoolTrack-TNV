//%attributes = {}
  //STR_ReplicaCambios

C_POINTER:C301($1;$punteroRUT)
C_LONGINT:C283($table;vl_SourceTable)
C_LONGINT:C283($saveRec)
C_BOOLEAN:C305($cambiar)
C_TEXT:C284(vt_RUT)
$cambiar:=False:C215
C_BLOB:C604($xBlob)
$0:=True:C214



If (Count parameters:C259=1)
	<>vb_dontCallOnTrigger:=False:C215
	$punteroRUT:=$1
	$rut:=$punteroRUT->
	$table:=Table:C252($punteroRUT)
	$testTriggerLevel:=True:C214
Else 
	<>vb_dontCallOnTrigger:=True:C214
	$xBlob:=$2
	vt_RUT:=""
	BLOB_Blob2Vars (->$xBlob;0;->vl_SourceTable;->vt_RUT)
	$table:=vl_SourceTable
	$rut:=vt_RUT
	$testTriggerLevel:=False:C215
End if 

If ($testTriggerLevel)
	$go:=(Trigger level:C398=1)
Else 
	$go:=True:C214
End if 


If ($go)
	If ($rut#"")
		Case of 
			: ($table=Table:C252(->[Alumnos:2]))
				If (Trigger level:C398=0)
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]RUT:5;->$rut;False:C215)
				End if 
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Personas:7]RUT:6;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Personas:7]Sexo:8:=[Alumnos:2]Sexo:49
					[Personas:7]Apellidos_y_nombres:30:=[Alumnos:2]apellidos_y_nombres:40
					[Personas:7]Fecha_de_nacimiento:5:=[Alumnos:2]Fecha_de_nacimiento:7
					[Personas:7]Nombre_Comun:60:=[Alumnos:2]Nombre_Común:30
					[Personas:7]Apellido_paterno:3:=[Alumnos:2]Apellido_paterno:3
					[Personas:7]Apellido_materno:4:=[Alumnos:2]Apellido_materno:4
					[Personas:7]Nombres:2:=[Alumnos:2]Nombres:2
					[Personas:7]Nacionalidad:7:=[Alumnos:2]Nacionalidad:8
					[Personas:7]Direccion:14:=[Alumnos:2]Direccion:12
					[Personas:7]Codigo_postal:15:=[Alumnos:2]Codigo_Postal:13
					[Personas:7]Region_o_Estado:18:=[Alumnos:2]Región_o_estado:16
					[Personas:7]Comuna:16:=[Alumnos:2]Comuna:14
					[Personas:7]Telefono_domicilio:19:=[Alumnos:2]Telefono:17
					[Personas:7]Celular:24:=[Alumnos:2]Celular:95
					[Personas:7]Fax:35:=[Alumnos:2]Fax:69
					[Personas:7]eMail:34:=[Alumnos:2]eMAIL:68
					[Personas:7]Religión:9:=[Alumnos:2]Religion:9
					[Personas:7]Fallecido:88:=[Alumnos:2]Fallecido:97
					[Personas:7]Fecha_Deceso:89:=[Alumnos:2]Fecha_Deceso:98
					[Personas:7]Fotografia:43:=[Alumnos:2]Fotografía:78
					SAVE RECORD:C53([Personas:7])
					KRL_ReloadAsReadOnly (->[Personas:7])
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
				End if 
				
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Profesores:4]Sexo:5:=[Alumnos:2]Sexo:49
					[Profesores:4]Apellidos_y_nombres:28:=[Alumnos:2]apellidos_y_nombres:40
					[Profesores:4]Fecha_de_nacimiento:6:=[Alumnos:2]Fecha_de_nacimiento:7
					[Profesores:4]Nombre_comun:21:=[Alumnos:2]Nombre_Común:30
					[Profesores:4]Apellido_paterno:3:=[Alumnos:2]Apellido_paterno:3
					[Profesores:4]Apellido_materno:4:=[Alumnos:2]Apellido_materno:4
					[Profesores:4]Nombres:2:=[Alumnos:2]Nombres:2
					[Profesores:4]Nacionalidad:7:=[Alumnos:2]Nacionalidad:8
					[Profesores:4]Dirección:8:=[Alumnos:2]Direccion:12
					[Profesores:4]Codigo_postal:33:=[Alumnos:2]Codigo_Postal:13
					[Profesores:4]Region_o_Estado:12:=[Alumnos:2]Región_o_estado:16
					[Profesores:4]Comuna:10:=[Alumnos:2]Comuna:14
					[Profesores:4]Telefono_domicilio:24:=[Alumnos:2]Telefono:17
					[Profesores:4]Celular:44:=[Alumnos:2]Celular:95
					[Profesores:4]eMail_Personal:61:=[Alumnos:2]eMAIL:68
					[Profesores:4]Religion:73:=[Alumnos:2]Religion:9
					[Profesores:4]Fax:39:=[Alumnos:2]Fax:69
					[Profesores:4]Fallecido:70:=[Alumnos:2]Fallecido:97
					[Profesores:4]Fecha_Deceso:71:=[Alumnos:2]Fecha_Deceso:98
					[Profesores:4]Fotografia:59:=[Alumnos:2]Fotografía:78
					SAVE RECORD:C53([Profesores:4])
					KRL_ReloadAsReadOnly (->[Profesores:4])
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
				End if 
				
				
				
			: ($table=Table:C252(->[Profesores:4]))
				If (Trigger level:C398=0)
					KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->$rut;False:C215)
				End if 
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]RUT:5;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Alumnos:2]Apellido_paterno:3:=[Profesores:4]Apellido_paterno:3
					[Alumnos:2]Apellido_materno:4:=[Profesores:4]Apellido_materno:4
					[Alumnos:2]Nombres:2:=[Profesores:4]Nombres:2
					[Alumnos:2]apellidos_y_nombres:40:=[Profesores:4]Apellidos_y_nombres:28
					[Alumnos:2]Nombre_Común:30:=[Profesores:4]Apellidos_y_nombres:28
					[Alumnos:2]Nombre_oficial:48:=[Alumnos:2]apellidos_y_nombres:40
					[Alumnos:2]Sexo:49:=[Profesores:4]Sexo:5
					[Alumnos:2]Fecha_de_nacimiento:7:=[Profesores:4]Fecha_de_nacimiento:6
					[Alumnos:2]Nacionalidad:8:=[Profesores:4]Nacionalidad:7
					[Alumnos:2]Direccion:12:=[Profesores:4]Dirección:8
					[Alumnos:2]Codigo_Postal:13:=[Profesores:4]Codigo_postal:33
					[Alumnos:2]Región_o_estado:16:=[Profesores:4]Region_o_Estado:12
					[Alumnos:2]Comuna:14:=[Profesores:4]Comuna:10
					[Alumnos:2]Telefono:17:=[Profesores:4]Telefono_domicilio:24
					[Alumnos:2]Celular:95:=[Profesores:4]Celular:44
					[Alumnos:2]eMAIL:68:=[Profesores:4]eMail_Personal:61
					[Alumnos:2]Religion:9:=[Profesores:4]Religion:73
					[Alumnos:2]Fax:69:=[Profesores:4]Fax:39
					[Alumnos:2]Fallecido:97:=[Profesores:4]Fallecido:70
					[Alumnos:2]Fecha_Deceso:98:=[Profesores:4]Fecha_Deceso:71
					[Alumnos:2]Fotografía:78:=[Profesores:4]Fotografia:59
					SAVE RECORD:C53([Alumnos:2])
					KRL_ReloadAsReadOnly (->[Alumnos:2])
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
				End if 
				
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Personas:7]RUT:6;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Personas:7]Sexo:8:=[Profesores:4]Sexo:5
					[Personas:7]Apellidos_y_nombres:30:=[Profesores:4]Apellidos_y_nombres:28
					[Personas:7]Fecha_de_nacimiento:5:=[Profesores:4]Fecha_de_nacimiento:6
					[Personas:7]Nombre_Comun:60:=[Profesores:4]Nombre_comun:21
					[Personas:7]Apellido_paterno:3:=[Profesores:4]Apellido_paterno:3
					[Personas:7]Apellido_materno:4:=[Profesores:4]Apellido_materno:4
					[Personas:7]Nombres:2:=[Profesores:4]Nombres:2
					[Personas:7]Nacionalidad:7:=[Profesores:4]Nacionalidad:7
					[Personas:7]Direccion:14:=[Profesores:4]Dirección:8
					[Personas:7]Codigo_postal:15:=[Profesores:4]Codigo_postal:33
					[Personas:7]Region_o_Estado:18:=[Profesores:4]Region_o_Estado:12
					[Personas:7]Ciudad:17:=[Profesores:4]Ciudad:11
					[Personas:7]Comuna:16:=[Profesores:4]Comuna:10
					[Personas:7]Telefono_domicilio:19:=[Profesores:4]Telefono_domicilio:24
					[Personas:7]Celular:24:=[Profesores:4]Celular:44
					[Personas:7]eMail:34:=[Profesores:4]eMail_Personal:61
					[Personas:7]Estado_civil:10:=[Profesores:4]Estado_civil:18
					[Personas:7]Religión:9:=[Profesores:4]Religion:73
					[Personas:7]Fax:35:=[Profesores:4]Fax:39
					[Personas:7]Fallecido:88:=[Profesores:4]Fallecido:70
					[Personas:7]Fecha_Deceso:89:=[Profesores:4]Fecha_Deceso:71
					[Personas:7]Fotografia:43:=[Profesores:4]Fotografia:59
					SAVE RECORD:C53([Personas:7])
					KRL_ReloadAsReadOnly (->[Personas:7])
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
				End if 
				
			: ($table=Table:C252(->[Personas:7]))
				If (Trigger level:C398=0)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]RUT:6;->$rut;False:C215)
				End if 
				
				If (Records in selection:C76([Alumnos:2])=1)
					SAVE RECORD:C53([Alumnos:2])
					$saveRec:=Record number:C243([Alumnos:2])
					$cambiar:=True:C214
				End if 
				
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]RUT:5;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Alumnos:2]Sexo:49:=[Personas:7]Sexo:8
					[Alumnos:2]apellidos_y_nombres:40:=[Personas:7]Apellidos_y_nombres:30
					[Alumnos:2]Fecha_de_nacimiento:7:=[Personas:7]Fecha_de_nacimiento:5
					[Alumnos:2]Nombre_Común:30:=[Personas:7]Nombre_Comun:60
					[Alumnos:2]Apellido_paterno:3:=[Personas:7]Apellido_paterno:3
					[Alumnos:2]Apellido_materno:4:=[Personas:7]Apellido_materno:4
					[Alumnos:2]Nombres:2:=[Personas:7]Nombres:2
					[Alumnos:2]Nacionalidad:8:=[Personas:7]Nacionalidad:7
					[Alumnos:2]Direccion:12:=[Personas:7]Direccion:14
					[Alumnos:2]Codigo_Postal:13:=[Personas:7]Codigo_postal:15
					[Alumnos:2]Región_o_estado:16:=[Personas:7]Region_o_Estado:18
					[Alumnos:2]Comuna:14:=[Personas:7]Comuna:16
					[Alumnos:2]Telefono:17:=[Personas:7]Telefono_domicilio:19
					[Alumnos:2]Celular:95:=[Personas:7]Celular:24
					[Alumnos:2]eMAIL:68:=[Personas:7]eMail:34
					[Alumnos:2]Religion:9:=[Personas:7]Religión:9
					[Alumnos:2]Fax:69:=[Personas:7]Fax:35
					[Alumnos:2]Fallecido:97:=[Personas:7]Fallecido:88
					[Alumnos:2]Fecha_Deceso:98:=[Personas:7]Fecha_Deceso:89
					[Alumnos:2]Fotografía:78:=[Personas:7]Fotografia:43
					SAVE RECORD:C53([Alumnos:2])
					KRL_ReloadAsReadOnly (->[Alumnos:2])
					
					If (($cambiar=True:C214) & ($saveRec>=0))
						GOTO RECORD:C242([Alumnos:2];$saveRec)
					End if 
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
					
					If (($cambiar=True:C214) & ($saveRec>=0))
						GOTO RECORD:C242([Alumnos:2];$saveRec)
					End if 
				End if 
				
				$recNum:=KRL_FindAndLoadRecordByIndex (->[Profesores:4]RUT:27;->$rut;True:C214)
				If ((OK=1) & ($recNum>=0))  //el registro esta cargado en lectura escritura, lo actualizamos inmediatamente
					[Profesores:4]Sexo:5:=[Personas:7]Sexo:8
					[Profesores:4]Apellidos_y_nombres:28:=[Personas:7]Apellidos_y_nombres:30
					[Profesores:4]Fecha_de_nacimiento:6:=[Personas:7]Fecha_de_nacimiento:5
					[Profesores:4]Nombre_comun:21:=[Personas:7]Nombre_Comun:60
					[Profesores:4]Apellido_paterno:3:=[Personas:7]Apellido_paterno:3
					[Profesores:4]Apellido_materno:4:=[Personas:7]Apellido_materno:4
					[Profesores:4]Nombres:2:=[Personas:7]Nombres:2
					[Profesores:4]Nacionalidad:7:=[Personas:7]Nacionalidad:7
					[Profesores:4]Dirección:8:=[Personas:7]Direccion:14
					[Profesores:4]Codigo_postal:33:=[Personas:7]Codigo_postal:15
					[Profesores:4]Region_o_Estado:12:=[Personas:7]Region_o_Estado:18
					[Profesores:4]Comuna:10:=[Personas:7]Comuna:16
					[Profesores:4]Ciudad:11:=[Personas:7]Ciudad:17
					[Profesores:4]Telefono_domicilio:24:=[Personas:7]Telefono_domicilio:19
					[Profesores:4]Celular:44:=[Personas:7]Celular:24
					[Profesores:4]eMail_Personal:61:=[Personas:7]eMail:34
					[Profesores:4]Estado_civil:18:=[Personas:7]Estado_civil:10
					[Profesores:4]Religion:73:=[Personas:7]Religión:9
					[Profesores:4]Fax:39:=[Personas:7]Fax:35
					[Profesores:4]Fallecido:70:=[Personas:7]Fallecido:88
					[Profesores:4]Fecha_Deceso:71:=[Personas:7]Fecha_Deceso:89
					[Profesores:4]Fotografia:59:=[Personas:7]Fotografia:43
					SAVE RECORD:C53([Profesores:4])
					KRL_ReloadAsReadOnly (->[Profesores:4])
				Else 
					If ($recNum>=0)
						vl_SourceTable:=$table
						vt_RUT:=$rut
						BLOB_Variables2Blob (->$xBlob;0;->vl_SourceTable;->vt_RUT)
						BM_CreateRequest ("STR_ReplicaCambios";"";"";$xBlob)
					End if 
				End if 
		End case 
	End if 
End if 

<>vb_dontCallOnTrigger:=False:C215