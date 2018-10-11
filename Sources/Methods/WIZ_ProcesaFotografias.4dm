//%attributes = {}
  //Metodo: WIZ_ProcesaFotografias
  //Por abachler
  //Creada el 07/07/2008, 12:14:21
  // ----------------------------------------------------
  // Descripción
  // Ofrece opciones de procesamiento de fotografías:
  // conversión de formato y compresión
  // escalado
  // copia de las fotografías a un directorio local, en el formato seleccionado
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES


  //CUERPO

  //LIMPIEZA



C_BOOLEAN:C305(<>vb_ProcesandoFotografias;vb_ProcesandoFotografias)

PROCESS PROPERTIES:C336(Current process:C322;$name;$procState;$procTime)
If ($name#Current method name:C684)
	$p:=New process:C317(Current method name:C684;128000;Current method name:C684)  //el proceso se inicia a si mismo
Else 
	
	If (Not:C34(Semaphore:C143("ProcesamientoImagenes")))
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"WZD_ProcesamientoFotografias";-1;8;__ ("Asistentes"))
		DIALOG:C40([xxSTR_Constants:1];"WZD_ProcesamientoFotografias")
		CLOSE WINDOW:C154
		CLEAR SEMAPHORE:C144("ProcesamientoImagenes")
		If (OK=1)
			
			vb_ProcesandoFotografias:=True:C214
			
			
			
			If (Application type:C494=4D Remote mode:K5:5)
				If (vlTableNumber=-1)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Alumnos:2]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Personas:7]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Profesores:4]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Personas:7]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
				Else 
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;vlTableNumber;vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
				End if 
				
				DELAY PROCESS:C323(Current process:C322;145)
				$p:=IT_UThermometer (1;0;__ ("Esperando fin del procesamiento de imagenes en el servidor..."))
				While (vb_ProcesandoFotografias)
					DELAY PROCESS:C323(Current process:C322;30)
					GET PROCESS VARIABLE:C371(-1;<>vb_ProcesandoFotografias;vb_ProcesandoFotografias)
				End while 
				$p:=IT_UThermometer (-2;$p)
				
			Else 
				If (vlTableNumber=-1)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Alumnos:2]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Personas:7]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Profesores:4]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
					$processID:=PICT_ProcesaImagenes (".jpg";vl_Calidad;Table:C252(->[Personas:7]);vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
				Else 
					PICT_ProcesaImagenes (vs_NewPictureFormat;vl_Calidad;vlTableNumber;vt_ResizeMode;vl_ResizeValue;bc_Respaldo)
				End if 
			End if 
			
			
			
			$newExtension:=aPictFormats{aPictFormats}
			$pictureFormat:=$newExtension
			  //$pictureFormat:=PICT_GetDefaultFormat 
			  //$extension:=PICT_GetDefaultExtension 
			If (vt_DirectorioLocal#"")
				
				
				Case of 
					: (vlTableNumber=-1)
						ARRAY POINTER:C280($aPointers;5)
						$aPointers{1}:=->[Alumnos:2]Fotografía:78
						$aPointers{2}:=->[Profesores:4]Fotografia:59
						$aPointers{3}:=->[Personas:7]Fotografia:43
						$aPointers{4}:=->[BBL_Lectores:72]Fotografia:32
						$aPointers{5}:=->[Familia:78]Fotografia:35
						ARRAY TEXT:C222($aFolders;5)
						$aFolders{1}:=vt_DirectorioLocal+"Alumnos"
						$aFolders{2}:=vt_DirectorioLocal+"Profesores"
						$aFolders{3}:=vt_DirectorioLocal+"Padres y Relaciones Familiares"
						$aFolders{4}:=vt_DirectorioLocal+"Lectores"
						$aFolders{5}:=vt_DirectorioLocal+"Familias"
					: (vlTableNumber>0)
						ARRAY POINTER:C280($aPointers;1)
						ARRAY TEXT:C222($aFolders;1)
						Case of 
							: (vlTableNumber=Table:C252(->[Alumnos:2]))
								$aPointers{1}:=->[Alumnos:2]Fotografía:78
								$aFolders{1}:=vt_DirectorioLocal+"Alumnos"
							: (vlTableNumber=Table:C252(->[Profesores:4]))
								$aPointers{1}:=->[Profesores:4]Fotografia:59
								$aFolders{1}:=vt_DirectorioLocal+"Profesores"
							: (vlTableNumber=Table:C252(->[Personas:7]))
								$aPointers{1}:=->[Personas:7]Fotografia:43
								$aFolders{1}:=vt_DirectorioLocal+"Padres y Relaciones Familiares"
							: (vlTableNumber=Table:C252(->[BBL_Lectores:72]))
								$aPointers{1}:=->[BBL_Lectores:72]Fotografia:32
								$aFolders{1}:=vt_DirectorioLocal+"Lectores"
							: (vlTableNumber=Table:C252(->[Familia:78]))
								$aPointers{1}:=->[Familia:78]Fotografia:35
								$aFolders{1}:=vt_DirectorioLocal+"Familias"
						End case 
				End case 
				
				
				For ($iFields;1;Size of array:C274($aPointers))
					$table:=Table:C252(Table:C252($aPointers{$iFields}))
					$field:=$aPointers{$iFields}
					$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252($table);"0000")
					  //If (Test path name(◊syT_ArchivosFolder+$folder)=0)
					$picture:=$picture*0
					Case of 
						: (Table:C252($table)=Table:C252(->[Alumnos:2]))
							$idFieldPointer:=->[Alumnos:2]numero:1
							$nameFieldPointer:=->[Alumnos:2]apellidos_y_nombres:40
							$tipoFotografias:="Alumnos"
						: (Table:C252($table)=Table:C252(->[Profesores:4]))
							$idFieldPointer:=->[Profesores:4]Numero:1
							$nameFieldPointer:=->[Profesores:4]Apellidos_y_nombres:28
							$tipoFotografias:="Profesores"
						: (Table:C252($table)=Table:C252(->[Personas:7]))
							$idFieldPointer:=->[Personas:7]No:1
							$nameFieldPointer:=->[Personas:7]Apellidos_y_nombres:30
							$tipoFotografias:="Padres y Relaciones Familiares"
						: (Table:C252($table)=Table:C252(->[BBL_Lectores:72]))
							$idFieldPointer:=->[BBL_Lectores:72]ID:1
							$nameFieldPointer:=->[BBL_Lectores:72]NombreCompleto:3
							$tipoFotografias:="Lectores"
						: (Table:C252($table)=Table:C252(->[Familia:78]))
							$idFieldPointer:=->[Familia:78]Numero:1
							$nameFieldPointer:=->[Familia:78]Nombre_de_la_familia:3
							$tipoFotografias:="Familias"
					End case 
					
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando fotografías de ")+$tipoFotografias+__ (" a un directorio local..."))
					ARRAY LONGINT:C221($aRecordID;0)
					ARRAY TEXT:C222($aNames;0)
					ALL RECORDS:C47($table->)
					SELECTION TO ARRAY:C260($idFieldPointer->;$aRecordID;$nameFieldPointer->;$aNames)
					For ($i;1;Size of array:C274($aRecordID))
						$storedfileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10($aRecordID{$i})+".jpg"
						$picture:=xDOC_ReadExternalPicture ($folder;$storedfileName;False:C215)
						SYS_CreateFolder ($aFolders{$iFields})
						If (Picture size:C356($picture)>0)
							$localFileName:=$aFolders{$ifields}+Folder separator:K24:12+$aNames{$i}+"_"+String:C10($aRecordID{$i})+$newExtension
							WRITE PICTURE FILE:C680($localFileName;$picture;vtLocalFormat)
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecordID))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					
					  //End if º
				End for 
			End if 
			
		End if 
		CLEAR SEMAPHORE:C144("ProcesamientoImagenes")
		
	Else 
		CD_Dlog (0;__ ("Otra estación inicio una tarea de procesamiento de imágenes. Por favor intente nuevamente más tarde."))
	End if 
	
End if 
