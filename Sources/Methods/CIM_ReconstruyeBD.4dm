//%attributes = {"executedOnServer":true}
  // CIM_ReconstruyeBD()
  // Por: Alberto Bachler K.: 15-10-14, 14:31:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_noReiniciar;$b_reconstruirBD;$b_ReiniciarAplicacion;$b_semaforo)
C_LONGINT:C283($i;$i_tablas;$l_Proceso;$l_records;$l_registros;$l_tablas)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_archivoEstructura;$t_asunto;$t_cuerpo;$t_datafile;$t_emailAviso;$t_indexDatos;$t_indexEstructura;$t_json;$t_modo;$t_nombreProceso)
C_TEXT:C284($t_nombreTabla;$t_rdb;$t_rebuildDoc;$t_rutaArchivo;$t_rutaCompactado;$t_rutaExport;$t_sesion;$t_usuario;$t_uuidDatabase;$t_uuidExport)
C_TEXT:C284($t_uuidSesion)
C_OBJECT:C1216($ob_raiz)



If (False:C215)
	C_BOOLEAN:C305(CIM_ReconstruyeBD ;$0)
End if 

C_TEXT:C284(<>t_uuidDatabase;<>t_uuidSesion;<>gRolBD)

If ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6))
	$b_semaforo:=Semaphore:C143("ReconstruyendoBD")
	If (Count parameters:C259=1)
		$t_modo:=$1
	End if 
	$t_datafile:=Data file:C490
	$t_indexDatos:=Substring:C12($t_datafile;1;Length:C16($t_datafile)-4)+".4DIndx"
	$t_archivoEstructura:=Structure file:C489
	$t_indexEstructura:=Substring:C12($t_archivoEstructura;1;Length:C16($t_archivoEstructura)-4)+".4DIndy"
	
	Case of 
		: ($t_modo="")
			If (Count parameters:C259=2)
				$t_emailAviso:=$2
			End if 
			READ ONLY:C145([xShell_ApplicationData:45])
			ALL RECORDS:C47([xShell_ApplicationData:45])
			FIRST RECORD:C50([xShell_ApplicationData:45])
			<>t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
			<>t_uuidSesion:=[xShell_ApplicationData:45]UUID_Sesion:18
			<>gRolBD:=[xShell_ApplicationData:45]ID_Organizacion:17
			
			For ($i;1;Get last table number:C254)
				If (Is table number valid:C999($i))
					UNLOAD RECORD:C212(Table:C252($i)->)
					If (Locked:C147(Table:C252($i)->))
						LOCKED BY:C353(Table:C252($i)->;$l_Proceso;$t_usuario;$t_sesion;$t_nombreProceso)
					End if 
				End if 
			End for 
			READ ONLY:C145(*)
			
			$t_uuidExport:=Generate UUID:C1066
			$t_datafile:=Data file:C490
			$t_rutaExport:=Temporary folder:C486+$t_uuidExport+Folder separator:K24:12
			
			$t_rebuildDoc:=Substring:C12($t_datafile;1;Length:C16($t_datafile)-4)+".rebuild.json"
			$ob_raiz:=OB_Create 
			OB_SET ($ob_raiz;-><>t_uuidDatabase;"uuidDatabase")
			OB_SET ($ob_raiz;-><>t_uuidSesion;"uuidSesion")
			OB_SET ($ob_raiz;-><>gRolBD;"rdb")
			OB_SET ($ob_raiz;->$t_rutaExport;"rutaExport")
			OB_SET ($ob_raiz;->$t_emailAviso;"emailAviso")
			$t_json:=OB_Object2Json ($ob_raiz;True:C214)
			$h_refDocumento:=Create document:C266($t_rebuildDoc)
			CLOSE DOCUMENT:C267($h_refDocumento)
			TEXT TO DOCUMENT:C1237($t_rebuildDoc;$t_json;"UTF-8")
			
			  // Hago el conteo actual de los registros
			CIM_CuentaRegistros ("GuardaArchivo")
			  //exporto los datos
			IO_ExportDatabase (True:C214;$t_rutaExport)
			
			  // elimino completamente todos los registros de la base de datos
			$l_tablas:=Get last table number:C254
			For ($i_tablas;1;$l_tablas)
				If (Is table number valid:C999($i_tablas))
					READ WRITE:C146(Table:C252($i_tablas)->)
					TRUNCATE TABLE:C1051(Table:C252($i_tablas)->)
				End if 
			End for 
			
			  // evito el conteo de registros antes de la reapertura de la bd que fue compactada
			  // despues de la eliminación de todos los registros (usando TRUNCATE TABLE)
			<>b_NoGuardarCuentaRegistros:=True:C214
			<>b_NoEjecutarOnExit:=True:C214
			
			$b_noReiniciar:=True:C214
			$t_rutaCompactado:=CIM_CompactDataFile ($t_emailAviso;$b_noReiniciar;Temporary folder:C486)
			If (Test path name:C476($t_rutaCompactado)=Is a folder:K24:2)
				SYS_DeleteFolder ($t_rutaCompactado)
			End if 
			$b_ReiniciarAplicacion:=True:C214
			
		: ($t_modo="check")
			$l_records:=0
			For ($i;1;Get last table number:C254)
				If (Is table number valid:C999($i))
					$y_tabla:=Table:C252($i)
					If (Records in table:C83($y_tabla->)>0)
						LOCKED BY:C353($y_tabla->;$l_Proceso;$t_usuario;$t_sesion;$t_nombreProceso)
					End if 
					$l_records:=$l_records+Records in table:C83($y_tabla->)
				End if 
			End for 
			$t_rebuildDoc:=Substring:C12($t_datafile;1;Length:C16($t_datafile)-4)+".rebuild.json"
			
			If (Test path name:C476($t_rebuildDoc)=Is a document:K24:1)
				  //hay un documento que indica que hay datos exportados para reconstruir una base de datos
				If ($l_records=0)
					  // si hay 0 registros en la base de datos se trata de una base de datos vacía que debe ser reconstruida importando los datos exportados
					
					  // leo en el json la identificacion de la la base de datos y camino en que se encuentra los datos a reimportar
					$t_json:=Document to text:C1236($t_rebuildDoc;"UTF-8")
					$ob_raiz:=OB_JsonToObject ($t_json)
					OB_GET ($ob_raiz;-><>t_uuidDatabase;"uuidDatabase")
					OB_GET ($ob_raiz;-><>t_uuidSesion;"uuidSesion")
					OB_GET ($ob_raiz;-><>gRolBD;"rdb")
					OB_GET ($ob_raiz;->$t_rutaExport;"rutaExport")
					OB_GET ($ob_raiz;->$t_emailAviso;"emailAviso")
					
					If (Test path name:C476($t_rutaExport)=Is a folder:K24:2)
						  // si existe la carpeta con los datos exportados
						$y_tabla:=->[xShell_ApplicationData:45]
						$t_rutaArchivo:=$t_rutaExport+"Tabla"+String:C10(Table:C252($y_tabla))+".txt"
						
						If (Test path name:C476($t_rutaArchivo)=Is a document:K24:1)
							  //lee los datos almacenados en el registros xShell_applicationData
							SET CHANNEL:C77(10;$t_rutaArchivo)
							If (ok=1)
								RECEIVE VARIABLE:C81($t_nombreTabla)
								RECEIVE VARIABLE:C81($l_registros)
								RECEIVE RECORD:C79($y_tabla->)
								If (($t_nombreTabla=Table name:C256($y_tabla)) & ($l_registros=1))
									If ($l_registros=1)
										$t_uuidDatabase:=[xShell_ApplicationData:45]UUID_database:13
										$t_uuidSesion:=[xShell_ApplicationData:45]UUID_Sesion:18
										$t_rdb:=[xShell_ApplicationData:45]ID_Organizacion:17
										UNLOAD RECORD:C212($y_tabla->)
										If (<>t_uuidDatabase=$t_uuidDatabase)
											  // si los datos son los mismos que en el archivo <nombreBd>.rebuild.json
											$b_reconstruirBD:=True:C214
										End if 
									Else 
										  // HAY MAS DE UN REGISTRO EN LA TABLA xShell_applicationData. Es un problema existente en la base de datos original. No se hace nada
									End if 
								Else 
									  // NO SE PUEDEN LEER LOS DATOS DEL DOCUMENTO
								End if 
								SET CHANNEL:C77(11)
							End if 
							
						Else 
							  // NO HAY DATOS EXPORTADOS PARA LA TABLA xShell_applicationData
						End if 
						
					Else 
						DELETE DOCUMENT:C159($t_rebuildDoc)
					End if 
					
				Else 
					  //  LA CARPETA CON DATOS EXPORTADOS NO EXISTE EN LA RUTA QUE INDICA EL ARCHIVO <nombreBd>.rebuild.json
				End if 
				
			Else 
				  //el documento<nombreBd>.rebuild.json no existe
				  //si la base de datos no tiene nigún registro es una base de datos nueva
			End if 
			
			If ($b_reconstruirBD)
				KRL_VaciaBaseDeDatosCompleta 
				
				IO_ImportDatabase ($t_rutaExport)
				CIM_CuentaRegistros ("InicioAplicacion")
				DELETE DOCUMENT:C159($t_rebuildDoc)
				
				KRL_UnloadAll 
				
				READ ONLY:C145([Colegio:31])
				ALL RECORDS:C47([Colegio:31])
				FIRST RECORD:C50([Colegio:31])
				<>gCustom:=[Colegio:31]Nombre_Colegio:1
				<>gtOrganisation_Name:=[Colegio:31]Nombre_Colegio:1
				<>gRolBD:=[Colegio:31]Rol Base Datos:9
				
				If (vt_jsonPerdidaRegistros="")
					If ((Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Server:K5:6))
						$t_asunto:=__ ("Reconstrucción exitosa de la base de datos")
						$t_cuerpo:=__ ("La reconstrucción de la base de datos concluyó sin que se detectaran problemas. Schooltrack Server se reinició y estará disponible en unos minutos después de compactar la base de datos.")
						Mail_EnviaNotificacion ($t_asunto;$t_cuerpo;$t_emailAviso)
						Notificacion_Mostrar ($t_asunto;$t_cuerpo)
					End if 
				Else 
					TRACE:C157
				End if 
				
				$b_noReiniciar:=True:C214
				  //$t_rutaCompactado:=CIM_CompactDataFile ($t_emailAviso;$b_noReiniciar;Temporary folder)
				If (Test path name:C476($t_rutaCompactado)=Is a folder:K24:2)
					SYS_DeleteFolder ($t_rutaCompactado)
				End if 
				$b_ReiniciarAplicacion:=False:C215
			End if 
			
			
	End case 
	CLEAR SEMAPHORE:C144("ReconstruyendoBD")
End if 

$0:=$b_ReiniciarAplicacion