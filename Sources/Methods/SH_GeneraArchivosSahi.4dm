//%attributes = {}

C_OBJECT:C1216($ob_resultado;$o_Parametros)
C_LONGINT:C283($l_AsignaturaID)
C_TEXT:C284($t_respuesta)
C_LONGINT:C283($l_AlumnoID)
C_BOOLEAN:C305($b_motivoEspecial)

$t_accion:=$1
If (Count parameters:C259=2)
	$o_Parametros:=$2
End if 

Case of 
	: ($t_accion="leeScripts")
		ARRAY TEXT:C222($at_archivos;0)
		C_OBJECT:C1216($o_parametros)
		C_LONGINT:C283($l_progress)
		$t_document:=Select folder:C670("seleccione Carpeta")
		DOCUMENT LIST:C474($t_document;$at_archivos)
		$l_progress:=IT_Progress (1;0;0;"Leyendo scripts...")
		For ($l_indice;1;Size of array:C274($at_archivos))
			$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($at_archivos);"Leyendo scripts...")
			$t_ruta:=$t_document+$at_archivos{$l_indice}
			OB SET:C1220($o_parametros;"RutaCodigo";$t_ruta)
			SH_GeneraArchivosSahi ("EjecutaCodigo";$o_parametros)
		End for 
		$l_progress:=IT_Progress (-1;$l_progress)
		
	: ($t_accion="ArchivosSoportados")
		C_OBJECT:C1216($o_digestBD)
		
		ARRAY TEXT:C222($at_nombrePropiedad;0)
		ARRAY TEXT:C222($at_digestPropiedad;0)
		APPEND TO ARRAY:C911($at_nombrePropiedad;"1.1.-Anotaciones.sah")
		APPEND TO ARRAY:C911($at_digestPropiedad;"2c3135ee88f8f127f3f846e0a64f9b66")
		APPEND TO ARRAY:C911($at_nombrePropiedad;"2.1.-Medidas.sah")
		APPEND TO ARRAY:C911($at_digestPropiedad;"03d429d8a4458b73d598dbf8dd6add4f")
		APPEND TO ARRAY:C911($at_nombrePropiedad;"3.1.-Medidas.sah")
		APPEND TO ARRAY:C911($at_digestPropiedad;"e05b88fcec344113c09b3a3567c91839")
		APPEND TO ARRAY:C911($at_nombrePropiedad;"1.1.-Licencia.sah")
		APPEND TO ARRAY:C911($at_digestPropiedad;"9fe04c486e86033092339829976c50c4")
		
		For ($l_indice;1;Size of array:C274($at_nombrePropiedad))
			OB SET:C1220($o_digestBD;$at_nombrePropiedad{$l_indice};$at_digestPropiedad{$l_indice})
		End for 
		
		$ob_resultado:=$o_digestBD
		
	: ($t_accion="GeneraObjectDigest")
		
		C_BLOB:C604($x_blob)
		C_LONGINT:C283($l_indice;$l_indiceArchivos;$l_indiceDir)
		C_TIME:C306($h_ref)
		C_TEXT:C284($t_digest;$t_rutaDirectorio;$t_rutaTemporal)
		C_OBJECT:C1216($o_digestBD)
		
		ARRAY TEXT:C222($at_directorios;0)
		ARRAY TEXT:C222($at_NombresArchivos;0)
		ARRAY TEXT:C222($at_rutasArchivos;0)
		ARRAY TEXT:C222($at_archivos;0)
		ARRAY TEXT:C222($at_directoriosTemporal;0)
		
		$t_rutaDirectorio:=Select folder:C670("Seleccione directorio")
		FOLDER LIST:C473($t_rutaDirectorio;$at_directorios)
		SORT ARRAY:C229($at_directorios;>)
		For ($l_indiceDir;1;Size of array:C274($at_directorios))
			$t_rutaTemporal:=$t_rutaDirectorio+$at_directorios{$l_indiceDir}
			DOCUMENT LIST:C474($t_rutaTemporal;$at_archivos)
			If (Size of array:C274($at_archivos)=0)
				FOLDER LIST:C473($t_rutaTemporal;$at_directoriosTemporal)
				For ($l_indiceTemporal;1;Size of array:C274($at_directoriosTemporal))
					$t_rutaTemporal2:=$t_rutaTemporal+SYS_FolderDelimiter +$at_directoriosTemporal{$l_indiceTemporal}
					DOCUMENT LIST:C474($t_rutaTemporal2;$at_archivos)
					For ($l_indiceArchivos;1;Size of array:C274($at_archivos))
						APPEND TO ARRAY:C911($at_rutasArchivos;$t_rutaTemporal2+SYS_FolderDelimiter +$at_archivos{$l_indiceArchivos})
						APPEND TO ARRAY:C911($at_NombresArchivos;$at_archivos{$l_indiceArchivos})
					End for 
				End for 
			Else 
				For ($l_indiceArchivos;1;Size of array:C274($at_archivos))
					APPEND TO ARRAY:C911($at_rutasArchivos;$t_rutaTemporal+SYS_FolderDelimiter +$at_archivos{$l_indiceArchivos})
					APPEND TO ARRAY:C911($at_NombresArchivos;$at_archivos{$l_indiceArchivos})
				End for 
			End if 
			
		End for 
		
		  //Genero digest para cada uno de los archivos existentes en el proyecto
		For ($l_indice;1;Size of array:C274($at_rutasArchivos))
			$h_ref:=Open document:C264($at_rutasArchivos{$l_indice};"*";Read mode:K24:5)
			DOCUMENT TO BLOB:C525(Document;$x_blob)
			$t_digest:=Generate digest:C1147($x_blob;MD5 digest:K66:1)
			OB SET:C1220($o_digestBD;$at_NombresArchivos{$l_indice};$t_digest)
		End for 
		
		$ob_resultado:=$o_digestBD
		
	: ($t_accion="comparaDigest")
		C_OBJECT:C1216($o_digestCL;$o_digestBD)
		C_TEXT:C284($t_mensaje)
		
		$o_digestBD:=SH_GeneraArchivosSahi ("ArchivosSoportados")
		$o_digestCL:=SH_GeneraArchivosSahi ("GeneraObjectDigest")
		
		OB GET PROPERTY NAMES:C1232($o_digestCL;$at_nombrePropiedad;$al_type)
		SORT ARRAY:C229($at_nombrePropiedad;>)
		
		For ($l_indice;1;Size of array:C274($at_nombrePropiedad))
			
			$t_digestBD:=OB Get:C1224($o_digestBD;$at_nombrePropiedad{$l_indice})
			$t_digestCL:=OB Get:C1224($o_digestCL;$at_nombrePropiedad{$l_indice})
			
			Case of 
				: ($t_digestBD="")
					$t_mensaje:=$t_mensaje+"El archivo "+ST_Qte ($at_nombrePropiedad{$l_indice})+" no puede ser generado en esta BD\r"
				: ($t_digestBD#$t_digestCL)
					$t_mensaje:=$t_mensaje+"El archivo "+ST_Qte ($at_nombrePropiedad{$l_indice})+" es distinto al original registrado en la BD\r"
			End case 
		End for 
		
		If ($t_mensaje#"")
			$t_rutaDocumento:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"automatizacion_logs"+SYS_FolderDelimiter 
			$l_ok:=SYS_CreateFolder ($t_rutaDocumento)
			$t_nombreArchivo:="archivos_Error_Logs.txt"
			$h_ref:=Create document:C266($t_rutaDocumento+$t_nombreArchivo;"TEXT")
			IO_SendPacket ($h_ref;$t_mensaje)
			CLOSE DOCUMENT:C267($h_ref)
			CD_Dlog (0;"Existen problemas")
			SHOW ON DISK:C922($t_rutaDocumento+$t_nombreArchivo)
			
		End if 
		
	: ($t_accion="EjecutaCodigo")
		
		$t_rutaCodigo:=OB Get:C1224($o_Parametros;"RutaCodigo")
		$t_codigo:=Document to text:C1236($t_rutaCodigo;"Windows-1252")
		$t_string2Execute:=ST Get plain text:C1092($t_codigo)
		$t_string2Execute:="<!--#4DCODE\r"+$t_string2Execute+"\r-->"
		PROCESS 4D TAGS:C816($t_string2Execute;$t_respuesta)
		
	: ($t_accion="UrlConexionSTWA")
		  //Cargo la IP del servidor desde donde se está sirviendo STWA
		$t_host:=ST_GetWord (SYS_GetServerProperty (XS_IPaddress);1;",")
		$l_puerto:=Num:C11(SYS_GetServerProperty (110))
		$t_url:=$t_host+":"+String:C10($l_puerto)+"/stwa/login.shtml"
		OB SET:C1220($ob_resultado;"url";$t_url)
		
	: ($t_accion="CargaUsuario")
		
		C_LONGINT:C283($l_tabla;$l_indiceUser)
		C_TEXT:C284($t_nivelAcceso)
		C_POINTER:C301($y_tabla)
		
		ARRAY LONGINT:C221($al_ProfesorID;0)
		ARRAY TEXT:C222($at_lineasArchivo;0)
		ARRAY LONGINT:C221($al_userIDs;0)
		ARRAY TEXT:C222($at_userLogin;0)
		ARRAY BLOB:C1222($ax_userContraseña;0)
		
		$l_tabla:=Num:C11(OB Get:C1224($o_Parametros;"tabla"))
		$t_nivelAcceso:=OB Get:C1224($o_Parametros;"nivel_acceso")
		$y_tabla:=Table:C252($l_tabla)
		
		  //Busco un usuario válido del sistema con permisos en conducta
		ALL RECORDS:C47([xShell_Users:47])
		QUERY SELECTION:C341([xShell_Users:47];[xShell_Users:47]No:1>0;*)
		QUERY SELECTION:C341([xShell_Users:47];[xShell_Users:47]login:9#"Administrador")
		SELECTION TO ARRAY:C260([xShell_Users:47]No:1;$al_userIDs;[xShell_Users:47]login:9;$at_userLogin;[xShell_Users:47]xPass:13;$ax_userContraseña;[xShell_Users:47]NoEmployee:7;$al_ProfesorID)
		
		For ($l_indiceUser;1;Size of array:C274($al_userIDs))
			If (USR_checkRights ($t_nivelAcceso;$y_tabla;$al_userIDs{$l_indiceUser}))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$al_ProfesorID{$l_indiceUser})
				$t_Login:=$at_userLogin{$l_indiceUser}
				$t_contraseña:=USR_DecryptPassword ($ax_userContraseña{$l_indiceUser})
				$l_profesorID:=$al_ProfesorID{$l_indiceUser}
				$b_existeUserBD:=True:C214
				$t_profesorNombre:=[Profesores:4]Apellidos_y_nombres:28
				$l_indiceUser:=Size of array:C274($al_userIDs)+1
			End if 
		End for 
		
		If ($b_existeUserBD)
			OB SET:C1220($ob_resultado;"login";$t_Login)
			OB SET:C1220($ob_resultado;"pass";$t_contraseña)
			OB SET:C1220($ob_resultado;"ProfID";$l_profesorID)
			OB SET:C1220($ob_resultado;"ProfNombre";$t_profesorNombre)
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"No existe usuario configurado en la BD que cumpla con los requisitos para realizar pruebas de automatización.\r")
		End if 
		
	: ($t_accion="DatosAsignaturasYcursoProfesor")
		
		ARRAY TEXT:C222($at_cursos;0)
		ARRAY TEXT:C222($at_nombreAsignatura;0)
		ARRAY TEXT:C222($at_nombreAsignaturaCompuesto;0)
		ARRAY LONGINT:C221($al_asignaturaID;0)
		
		C_OBJECT:C1216($o_datosProfesor;$ob_resultado;$ob_temporal)
		C_LONGINT:C283($profID;$l_posFinal;$l_pos)
		C_TEXT:C284($t_notCurso)
		C_BOOLEAN:C305($b_ok)
		
		$profID:=OB Get:C1224($o_parametros;"profID")
		$t_notCurso:=OB Get:C1224($o_parametros;"cursoDistintoA")
		
		$o_datosProfesor:=STWA2_MO_CargaInfoConducta ("ProfesoresConducta";$o_parametros)
		$ob_temporal:=OB Get:C1224($o_datosProfesor;String:C10($profID))
		
		OB GET ARRAY:C1229($ob_temporal;"cursoasignatura";$at_cursos)
		OB GET ARRAY:C1229($ob_temporal;"idAsignatura";$al_asignaturaID)
		OB GET ARRAY:C1229($ob_temporal;"nombreasignatura";$at_nombreAsignatura)
		OB GET ARRAY:C1229($ob_temporal;"nombrecompuesto";$at_nombreAsignaturaCompuesto)
		
		If (Size of array:C274($at_cursos)>0)
			If ($t_notCurso#"")
				$b_ok:=Find in sorted array:C1333($at_cursos;$t_notCurso;>;$l_pos;$l_posFinal)
				If ($l_posFinal=Size of array:C274($at_cursos))
					$l_pos:=$l_posFinal-1
				Else 
					$l_pos:=$l_posFinal+1
				End if 
				OB SET:C1220($ob_resultado;"curso";$at_cursos{$l_pos})
				OB SET:C1220($ob_resultado;"nombreAsignatura";$at_nombreAsignatura{$l_pos})
				OB SET:C1220($ob_resultado;"asignaturaID";$al_asignaturaID{$l_pos})
				OB SET:C1220($ob_resultado;"nombreAsignaturaCompuesto";$at_nombreAsignaturaCompuesto{$l_pos})
			Else 
				OB SET:C1220($ob_resultado;"curso";$at_cursos{1})
				OB SET:C1220($ob_resultado;"nombreAsignatura";$at_nombreAsignatura{1})
				OB SET:C1220($ob_resultado;"asignaturaID";$al_asignaturaID{1})
				OB SET:C1220($ob_resultado;"nombreAsignaturaCompuesto";$at_nombreAsignaturaCompuesto{1})
			End if 
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"El profesor seleccionado no tiene asignaturas asociadas")
		End if 
		
		
	: ($t_accion="DatosAlumno")
		C_OBJECT:C1216($ob_resultado)
		
		$l_AsignaturaID:=OB Get:C1224($o_parametros;"asignaturaID")
		
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_AsignaturaID)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
		REDUCE SELECTION:C351([Alumnos:2];1)
		
		If (Records in selection:C76([Alumnos:2])>0)
			OB SET:C1220($ob_resultado;"apellidoPaterno";[Alumnos:2]Apellido_paterno:3)
			OB SET:C1220($ob_resultado;"nombreAlumno";[Alumnos:2]apellidos_y_nombres:40)
			OB SET:C1220($ob_resultado;"ID";[Alumnos:2]numero:1)
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"Asignaturas sin alumnos inscritos.\r")
		End if 
		
	: ($t_accion="MotivosAnotacion")
		ARRAY TEXT:C222($at_motivosAnotaciones;0)
		ARRAY TEXT:C222($at_categoriasAnotaciones;0)
		C_OBJECT:C1216($ob_anotaciones;$ob_resultado)
		$l_cantidad:=OB Get:C1224($o_parametros;"cantidadMotivos")
		$ob_anotaciones:=STWA2_MO_CargaInfoConducta ("MotivosAnotaciones")
		OB GET ARRAY:C1229($ob_anotaciones;"categorias";$at_categoriasAnotaciones)
		OB GET ARRAY:C1229($ob_anotaciones;"motivo";$at_motivosAnotaciones)
		
		If (Size of array:C274($at_categoriasAnotaciones)>=$l_cantidad)
			
			For ($l_indice;1;$l_cantidad)
				OB SET:C1220($ob_resultado;"categoria_"+String:C10($l_indice);$at_categoriasAnotaciones{$l_indice})
				OB SET:C1220($ob_resultado;"motivo_"+String:C10($l_indice);$at_motivosAnotaciones{$l_indice})
			End for 
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"BD No tiene motivos de anotaciones configurados.\r")
		End if 
		
	: ($t_accion="MotivosMedidas")
		ARRAY TEXT:C222($at_motivosMedidas;0)
		C_OBJECT:C1216($ob_motivos)
		$ob_motivos:=STWA2_MO_CargaInfoConducta ("MotivosMedidas")
		OB GET ARRAY:C1229($ob_motivos;"motivo";$at_motivosMedidas)
		$l_cantidad:=OB Get:C1224($o_parametros;"cantidadMotivos")
		
		If (Size of array:C274($at_motivosMedidas)>=$l_cantidad)
			For ($l_indice;1;$l_cantidad)
				OB SET:C1220($ob_resultado;"motivo_"+String:C10($l_indice);$at_motivosMedidas{$l_indice})
			End for 
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"BD No tiene motivos de anotaciones configurados.\r")
		End if 
		
	: ($t_accion="MotivosSuspensiones")
		ARRAY TEXT:C222($at_motivosSuspensiones;0)
		C_OBJECT:C1216($ob_motivos)
		$ob_motivos:=STWA2_MO_CargaInfoConducta ("MotivosSuspensiones";$o_parametros)
		OB GET ARRAY:C1229($ob_motivos;"motivo";$at_motivosSuspensiones)
		$l_cantidad:=OB Get:C1224($o_parametros;"cantidadSuspensiones")
		
		If (Size of array:C274($at_motivosSuspensiones)>=$l_cantidad)
			For ($l_indice;1;$l_cantidad)
				OB SET:C1220($ob_resultado;"motivo_"+String:C10($l_indice);$at_motivosSuspensiones{$l_indice})
			End for 
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"BD No tiene motivos de anotaciones configurados.\r")
		End if 
		
	: ($t_accion="OpcionesLicencias")
		ARRAY TEXT:C222($at_motivosLicencias;0)
		ARRAY TEXT:C222($at_motivosEspecial;0)
		C_OBJECT:C1216($ob_motivos)
		$ob_motivos:=STWA2_MO_CargaInfoConducta ("OpcionesLicencias";$o_parametros)
		OB GET ARRAY:C1229($ob_motivos;"motivo";$at_motivosLicencias)
		OB GET ARRAY:C1229($ob_motivos;"motivoespecial";$at_motivosEspecial)
		$l_cantidad:=OB Get:C1224($o_parametros;"cantidad")
		$b_motivoEspecial:=OB Get:C1224($o_parametros;"MotivoEspecial")
		
		If ($b_motivoEspecial)
			If (Size of array:C274($at_motivosEspecial)>=$l_cantidad)
				For ($l_indice;1;$l_cantidad)
					OB SET:C1220($ob_resultado;"motivo_"+String:C10($l_indice);$at_motivosEspecial{$l_indice})
				End for 
				OB SET:C1220($ob_resultado;"Autorización_especial";"Autorización especial")
				OB SET:C1220($ob_resultado;"error";False:C215)
				OB SET:C1220($ob_resultado;"mensaje";"")
			Else 
				OB SET:C1220($ob_resultado;"error";True:C214)
				OB SET:C1220($ob_resultado;"mensaje";"BD No tiene motivos de anotaciones configurados.\r")
			End if 
		Else 
			If (Size of array:C274($at_motivosLicencias)>=$l_cantidad)
				For ($l_indice;1;$l_cantidad)
					OB SET:C1220($ob_resultado;"motivo_"+String:C10($l_indice);$at_motivosLicencias{$l_indice})
				End for 
				OB SET:C1220($ob_resultado;"error";False:C215)
				OB SET:C1220($ob_resultado;"mensaje";"")
			Else 
				OB SET:C1220($ob_resultado;"error";True:C214)
				OB SET:C1220($ob_resultado;"mensaje";"BD No tiene motivos de anotaciones configurados.\r")
			End if 
		End if 
		
	: ($t_accion="generaArchivo")
		C_OBJECT:C1216($o_temporal)
		ARRAY TEXT:C222($at_lineasArchivo;0)
		
		OB GET ARRAY:C1229($o_Parametros;"arregloLineasArchivos";$at_lineasArchivo)
		$t_rutaDocumento:=OB Get:C1224($o_Parametros;"ruta")
		$t_nombreArchivo:=OB Get:C1224($o_Parametros;"nombreArchivo")
		$l_ok:=SYS_CreateFolder ($t_rutaDocumento)
		If ($l_ok=1)
			If ($t_rutaDocumento#"")
				If (Test path name:C476($t_rutaDocumento+$t_nombreArchivo)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_rutaDocumento+$t_nombreArchivo)
				End if 
				$h_ref:=Create document:C266($t_rutaDocumento+$t_nombreArchivo;"TEXT")
				IO_SendPacket ($h_ref;AT_array2text (->$at_lineasArchivo;"\r"))
				CLOSE DOCUMENT:C267($h_ref)
			End if 
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
			  //CD_Dlog (0;"Archivo generado con éxito.\rLo encontrará en en: "+$t_rutaDocumento+$t_nombreArchivo) Escribir en un log!!!
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"El archivo "+$t_nombreArchivo+" no pudo ser generado.")
		End if 
		
		
	: ($t_accion="generaArchivoLogsError")
		
		ARRAY TEXT:C222($at_lineasArchivo;0)
		
		$t_nombreArchivo:=OB Get:C1224($o_Parametros;"nombreArchivo")
		$t_mensaje:=OB Get:C1224($o_Parametros;"mensaje")
		
		$o_temporal:=SH_GeneraArchivosSahi ("traeDirLogsError")
		$t_rutaDocumento:=OB Get:C1224($o_temporal;"rutaDocumento")
		
		If ($t_rutaDocumento#"")
			If (Test path name:C476($t_rutaDocumento+$t_nombreArchivo)=Is a document:K24:1)
				$h_ref:=Open document:C264($t_rutaDocumento+$t_nombreArchivo;Write mode:K24:4)
			Else 
				$h_ref:=Create document:C266($t_rutaDocumento+$t_nombreArchivo;"TEXT")
			End if 
			IO_SendPacket ($h_ref;String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))+" - "+"El archivos de Anotaciones no pudo ser creado por los siguientes motivos:\r"+$t_mensaje)
			CLOSE DOCUMENT:C267($h_ref)
			CD_Dlog (0;"Se produjo un problem en la generación del archivo.\rRevisé el log ubicado en: "+$t_rutaDocumento+$t_nombreArchivo)
		End if 
		
		
		
		
	: ($t_accion="traeDirLogsError")
		$l_ok:=SYS_CreateFolder ($t_rutaDocumento)
		If ($l_ok=1)
			OB SET:C1220($ob_resultado;"rutaDocumento";$t_rutaDocumento)
		Else 
			OB SET:C1220($ob_resultado;"rutaDocumento";"")
		End if 
		
	: ($t_accion="PosicionEnListadoAlumnoConducta")
		C_OBJECT:C1216($o_temporal)
		ARRAY LONGINT:C221($al_IDalumnos;0)
		$l_AlumnoID:=OB Get:C1224($o_Parametros;"idAlumno")
		STWA2_MO_BuildCargaAlumnoCond ($o_Parametros;->$ob_resultado)
		$o_temporal:=OB Get:C1224($ob_resultado;"alumnos")
		OB GET ARRAY:C1229($o_temporal;"id";$al_IDalumnos)
		$l_pos:=Find in array:C230($al_IDalumnos;$l_AlumnoID)-1
		CLEAR VARIABLE:C89($ob_resultado)
		OB SET:C1220($ob_resultado;"posicion";$l_pos)
		
	: ($t_accion="CargaUsuarioEncargadoDeNivel")
		ALL RECORDS:C47([Profesores:4])
		SELECTION TO ARRAY:C260([Profesores:4]Numero:1;$al_profesoresID)
		
		For ($l_indice;1;Size of array:C274($al_profesoresID))
			$b_esResponsable:=STR_ResponsableNiveles ("verificaUsuario";$al_profesoresID{$l_indice})
			If ($b_esResponsable)
				$l_idProfesor:=$al_profesoresID{$l_indice}
				QUERY:C277([xShell_Users:47];[xShell_Users:47]NoEmployee:7=$l_idProfesor)
				If (Records in selection:C76([xShell_Users:47])>0)
					$l_indice:=Size of array:C274($al_profesoresID)
					$l_UsuarioID:=[xShell_Users:47]No:1
				Else 
					$b_esResponsable:=False:C215
				End if 
			End if 
		End for 
		
		If ($b_esResponsable)
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$l_idProfesor)
			QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$l_UsuarioID)
			$t_Login:=[xShell_Users:47]login:9
			$t_contraseña:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
			$l_profesorID:=$l_idProfesor
			$b_existeUserBD:=True:C214
			$t_profesorNombre:=[Profesores:4]Apellidos_y_nombres:28
			OB SET:C1220($ob_resultado;"login";$t_Login)
			OB SET:C1220($ob_resultado;"pass";$t_contraseña)
			OB SET:C1220($ob_resultado;"ProfID";$l_profesorID)
			OB SET:C1220($ob_resultado;"ProfNombre";$t_profesorNombre)
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"No existe usuario responsable de nivel configurado en la BD.")
		End if 
		
	: ($t_accion="CargaArregloCursosProfesor")
		ARRAY TEXT:C222($at_cursosProfesor;0)
		$profID:=OB Get:C1224($o_parametros;"profID")
		$l_cantidad:=OB Get:C1224($o_parametros;"cantidad")
		dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
		AT_DistinctsFieldValues (->[Asignaturas:18]Curso:5;->$at_cursosProfesor)
		
		If (Size of array:C274($at_cursosProfesor)>0)
			AT_RedimArrays ($l_cantidad;->$at_cursosProfesor)
			OB SET ARRAY:C1227($ob_resultado;"cursos";$at_cursosProfesor)
			OB SET:C1220($ob_resultado;"error";False:C215)
			OB SET:C1220($ob_resultado;"mensaje";"")
		Else 
			OB SET:C1220($ob_resultado;"error";True:C214)
			OB SET:C1220($ob_resultado;"mensaje";"Usuario sin asignaturas asociadas.")
		End if 
		
		
End case 

$0:=$ob_resultado

