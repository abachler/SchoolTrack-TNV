//%attributes = {}
  //WIZ_ImportaFotografias

  //dbu_ImportaFotografias

C_TEXT:C284($t_NombreDocLog;$t_RutaArchivoLog;$t_rutaEnServidor)
C_LONGINT:C283($l_respuesta)

C_TEXT:C284($t_logProcesamiento)

C_PICTURE:C286($picture)
C_LONGINT:C283($recordID)
C_LONGINT:C283($campTipo;$campLong)
C_BOOLEAN:C305($Indexado;$unico;$invisible)
ARRAY TEXT:C222($Files;0)
C_POINTER:C301($idFieldPointer;$tableprt)
C_TEXT:C284($id)

$t_logProcesamiento:=""

WDW_OpenFormWindow (->[xxSTR_Constants:1];"WZD_ImportacionFotografias";-1;8;__ ("Asistentes"))
DIALOG:C40([xxSTR_Constants:1];"WZD_ImportacionFotografias")
CLOSE WINDOW:C154

If (OK=1)
	
	$idFieldPointer:=Field:C253(vlTableNumber;vlFieldNumber)
	$picturePointer:=->[Alumnos:2]Fotografía:78
	$table:=vlTableNumber
	$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
	Case of 
		: ($table=Table:C252(->[Alumnos:2]))
			$picturePointer:=->[Alumnos:2]Fotografía:78
		: ($table=Table:C252(->[Profesores:4]))
			$picturePointer:=->[Profesores:4]Fotografia:59
		: ($table=Table:C252(->[Personas:7]))
			$picturePointer:=->[Personas:7]Fotografia:43
		: ($table=Table:C252(->[Familia:78]))
			$picturePointer:=->[Familia:78]Fotografia:35
	End case 
	
	$pictfolder:=Select folder:C670("Seleccione la carpeta que contiene las fotografias...")
	If ($pictfolder#"")
		DOCUMENT LIST:C474($pictfolder;$aFiles)
		  //◊vl_FileManagerProcess:=SYS_StoreFilesManager ("Start")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando fotografías..."))
		For ($i;1;Size of array:C274($aFiles))
			$filePath:=$pictfolder+$aFiles{$i}
			READ PICTURE FILE:C678($filePath;$picture)
			If ((OK=1) & (Picture size:C356($picture)>0))
				$aFiles{$i}:=Replace string:C233($aFiles{$i};<>gCountryCode+"."+<>gRolBD+".";"")
				If (Position:C15(".";$aFiles{$i})>0)
					$id:=Substring:C12($aFiles{$i};1;Position:C15(".";$aFiles{$i})-1)
				Else 
					$id:=$aFiles{$i}
				End if 
				
				
				  //20110922 As. se agrega para validar cuando un campo no esta indexado.
				GET FIELD PROPERTIES:C258($idFieldPointer;$campTipo;$campLong;$Indexado;$unico;$invisible)
				
				If (Type:C295($idFieldPointer->)=Is longint:K8:6)
					$recordID:=Num:C11($id)
					If ($Indexado)
						$recNum:=Find in field:C653($idFieldPointer->;$recordID)
					Else 
						  //cuando el campo no esta indexado
						$tableprt:=Table:C252($table)
						QUERY:C277($tableprt->;$idFieldPointer->=$recordID)
						$recNum:=Record number:C243($tableprt->)
					End if 
				Else 
					If ($Indexado)
						$recNum:=Find in field:C653($idFieldPointer->;$id)
					Else 
						  //cuando el campo no esta indexado
						$tableprt:=Table:C252($table)
						QUERY:C277($tableprt->;$idFieldPointer->=$id)
						$recNum:=Record number:C243($tableprt->)
					End if 
				End if 
				
				If ((Picture size:C356($picture)>0) & ($recNum>=0))
					  //QT COMPRESS PICTURE($picture;QT Photo compressor;1000)
					CONVERT PICTURE:C1002($picture;".jpg";1)
					KRL_GotoRecord (Table:C252($table);$recNum;True:C214)
					
					Case of 
						: ($table=Table:C252(->[Alumnos:2]))
							$recordID:=[Alumnos:2]numero:1
							$t_nombre:=[Alumnos:2]apellidos_y_nombres:40+" Identificador: "+$id
						: ($table=Table:C252(->[Profesores:4]))
							$recordID:=[Profesores:4]Numero:1
							$t_nombre:=[Profesores:4]Apellidos_y_nombres:28+" Identificador: "+$id
						: ($table=Table:C252(->[Personas:7]))
							$recordID:=[Personas:7]No:1
							$t_nombre:=[Personas:7]Apellidos_y_nombres:30+" Identificador: "+$id
						: ($table=Table:C252(->[Familia:78]))
							$recordID:=[Familia:78]Numero:1
							$t_nombre:="Familia: "+[Familia:78]Nombre_de_la_familia:3+"Identificador: "+$id
					End case 
					
					$t_logProcesamiento:=$t_logProcesamiento+"Fotografía de "+$t_nombre+" Procesada con éxito. \n"
					
					$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10($recordID)+".jpg"
					xDOC_Picture_SetMaxSize (->$picture;768)
					xDOC_WriteExternalPicture ($picture;$folder;$fileName;".jpg";False:C215)
					CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
					
					
					$picturePointer->:=$thumbnail
					SAVE RECORD:C53(Table:C252($table)->)
					UNLOAD RECORD:C212(Table:C252($table)->)
					
				Else 
					KRL_GotoRecord (Table:C252($table);$recNum;False:C215)
					Case of 
						: ($table=Table:C252(->[Alumnos:2]))
							$recordID:=[Alumnos:2]numero:1
							$t_nombre:=[Alumnos:2]apellidos_y_nombres:40+" Identificador: "+$id
						: ($table=Table:C252(->[Profesores:4]))
							$recordID:=[Profesores:4]Numero:1
							$t_nombre:=[Profesores:4]Apellidos_y_nombres:28+" Identificador: "+$id
						: ($table=Table:C252(->[Personas:7]))
							$recordID:=[Personas:7]No:1
							$t_nombre:=[Personas:7]Apellidos_y_nombres:30+" Identificador: "+$id
						: ($table=Table:C252(->[Familia:78]))
							$recordID:=[Familia:78]Numero:1
							$t_nombre:="Familia: "+[Familia:78]Nombre_de_la_familia:3+"Identificador: "+$id
					End case 
					$t_logProcesamiento:=$t_logProcesamiento+"Fotografía de "+$t_nombre+" No fue procesada (Tamaño de imagen incorrecto o registro no encontrado) \n"
					
				End if 
			Else 
				$t_logProcesamiento:=$t_logProcesamiento+"Se produjo un problema en la lectura del archivo \n"
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aFiles))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		$t_NombreDocLog:="Importacion de fotografias "+DTS_Get_GMT_TimeStamp +".log"
		$t_RutaArchivoLog:=SYS_CarpetaAplicacion (CLG_DocumentosServer)+"Importacion de Fotografias"
		SYS_CreaCarpetaServidor ($t_RutaArchivoLog)
		$t_rutaEnServidor:=$t_RutaArchivoLog+SYS_ServerFolderSeparator +$t_NombreDocLog
		
		  //TEXT TO DOCUMENT($t_rutaEnServidor;$t_logProcesamiento)
		  //$l_respuesta:=CD_Dlog (1;__ ("La Importación de fotografías ha finalizado éxitosamente.")+"\n"+__ ("Se ha generado un archivo de log llamado ")+ST_Qte ($t_NombreDocLog)+" en la ruta: "+ST_Qte ($t_RutaArchivoLog)+"\n"+__ ("¿Desea visualizarlo?");"";__ ("Abrir");__ ("Cancelar"))
		
		  //If ($l_respuesta=1)
		  //SHOW ON DISK($t_RutaArchivoLog)
		  //End if 
		
		  //ASM Ticket 215387
		TEXT TO BLOB:C554($t_logProcesamiento;$xblob;UTF8 text with length:K22:16)
		KRL_SendFileToServer ($t_rutaEnServidor;$x_blob;True:C214)
		
		If (Application type:C494#4D Volume desktop:K5:2)
			$t_RutaArchivoLogCliente:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Importacion de Fotografias"
			SYS_CreaCarpeta ($t_RutaArchivoLogCliente)
			$t_rutaEnCliente:=$t_RutaArchivoLogCliente+Folder separator:K24:12+$t_NombreDocLog
			TEXT TO DOCUMENT:C1237($t_rutaEnCliente;$t_logProcesamiento)
			$l_respuesta:=CD_Dlog (1;__ ("La Importación de fotografías ha finalizado éxitosamente.")+"\n"+__ ("Se ha generado un archivo de log llamado ")+ST_Qte ($t_NombreDocLog)+" en la ruta: "+ST_Qte ($t_rutaEnCliente)+"\n"+__ ("¿Desea visualizarlo?");"";__ ("Abrir");__ ("Cancelar"))
			If ($l_respuesta=1)
				SHOW ON DISK:C922($t_rutaEnCliente)
			End if 
		Else 
			$l_respuesta:=CD_Dlog (1;__ ("La Importación de fotografías ha finalizado éxitosamente.")+"\n"+__ ("Se ha generado un archivo de log llamado ")+ST_Qte ($t_NombreDocLog)+" en la ruta: "+ST_Qte ($t_RutaArchivoLog)+"\n"+__ ("¿Desea visualizarlo?");"";__ ("Abrir");__ ("Cancelar"))
			If ($l_respuesta=1)
				SHOW ON DISK:C922($t_RutaArchivoLog)
			End if 
		End if 
		
		  //◊vl_FileManagerProcess:=SYS_StoreFilesManager ("Pause")
	Else 
		CD_Dlog (0;__ ("Debe seleccionar la carpeta que contiene las fotografias."))
	End if 
	
	
End if 