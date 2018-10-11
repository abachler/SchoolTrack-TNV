//%attributes = {}
  //Metodo: PICT_ProcesaImagenes
  //Por abachler
  //Creada el 07/07/2008, 10:59:18
  // ----------------------------------------------------
  // Descripción
  // procesa la imagenes de acuerdo a lo establecido en el asistentente "Procesamiento de fotografías"
  //llamado desde WIZ_ProcesaFotografíás
  // ----------------------------------------------------
  // Parámetros
  // $1; &T: formato del archivo de salida (al que es convertida la imagen)
  // $2; &L: calidad de compresión (entre 0 y 1000)
  // $3; &L: numero de la tabla para la que se procesan las fotografías (-1 para procesarlas todas)
  // $4; &T: modo de redimensionamiento ("PROPORCIONAL": factor indicado, "ANCHO"; "ALTO")
  // $5; &R: factor de redimensión o tamaño en puntos al que se desea llevar la fotografía
  // $6; &T: ruta para un directorio de respaldo local
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_BOOLEAN:C305(<>vb_ProcesandoFotografias)
C_TEXT:C284($pictureFormat;$1;$vtResizeMode;$4)
C_PICTURE:C286($picture)
C_REAL:C285($vlResizeValue;$5)
C_LONGINT:C283($3;$quality;$width;$height)
C_POINTER:C301($tablePointer)
C_LONGINT:C283($0)
C_REAL:C285($calidad)
$pictureFormat:=$1
$vlQuality:=$2
$tablePointer:=Table:C252($3)
$vtResizeMode:=$4
$vlResizeTo:=$5
$vbBackupPictures:=$6

  //CUERPO
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373(Current method name:C684;128000;Current method name:C684;$1;$2;$3;$4;$5;$6)
	$0:=$p
Else 
	
	
	<>vb_ProcesandoFotografias:=True:C214
	If ($vbBackupPictures=1)
		$p:=IT_UThermometer (1;0;__ ("Respaldando fotografías..."))
		BKP_RespaldaFotografias 
		$p:=IT_UThermometer (-2;$p)
	End if 
	
	
	ARRAY POINTER:C280($aPointers;5)
	$aPointers{1}:=->[Alumnos:2]Fotografía:78
	$aPointers{2}:=->[Profesores:4]Fotografia:59
	$aPointers{3}:=->[Personas:7]Fotografia:43
	$aPointers{4}:=->[BBL_Lectores:72]Fotografia:32
	$aPointers{5}:=->[Familia:78]Fotografia:35
	ARRAY TEXT:C222($aPaths;0)
	For ($iFields;1;Size of array:C274($aPointers))
		$tablePointer:=Table:C252(Table:C252($aPointers{$iFields}))
		$field:=$aPointers{$iFields}
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252($tablePointer);"0000")
		If (Test path name:C476(<>syT_ArchivosFolder+$folder)=0)
			$picture:=$picture*0
			Case of 
				: (Table:C252($tablePointer)=Table:C252(->[Alumnos:2]))
					$idFieldPointer:=->[Alumnos:2]numero:1
				: (Table:C252($tablePointer)=Table:C252(->[Profesores:4]))
					$idFieldPointer:=->[Profesores:4]Numero:1
				: (Table:C252($tablePointer)=Table:C252(->[Personas:7]))
					$idFieldPointer:=->[Personas:7]No:1
				: (Table:C252($tablePointer)=Table:C252(->[BBL_Lectores:72]))
					$idFieldPointer:=->[BBL_Lectores:72]ID:1
				: (Table:C252($tablePointer)=Table:C252(->[Familia:78]))
					$idFieldPointer:=->[Familia:78]Numero:1
			End case 
			$tName:=API Get Virtual Table Name (Table:C252($tablePointer))
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Procesando fotografías de ")+$tName+__ ("..."))
			
			
			ARRAY TEXT:C222($aFiles;0)
			DOCUMENT LIST:C474(<>syT_ArchivosFolder+$folder;$aFiles)
			For ($i;1;Size of array:C274($aFiles))
				$recordID:=Num:C11(ST_GetWord ($aFiles{$i};3;"."))
				$fileName:=$aFiles{$i}
				READ PICTURE FILE:C678(<>syT_ArchivosFolder+$folder+Folder separator:K24:12+$fileName;$picture)
				If (ok=1)
					DELETE DOCUMENT:C159(document)
				End if 
				
				If (Picture size:C356($picture)>0)
					Case of 
						: ($vtResizeMode="Proporcional")
							$vlResizeValue:=$vlResizeTo/100
							
						: ($vtResizeMode="Ancho")
							PICTURE PROPERTIES:C457($picture;$width;$height)
							$vlResizeValue:=$vlResizeTo/$width
							
						: ($vtResizeMode="Alto")
							PICTURE PROPERTIES:C457($picture;$width;$height)
							$vlResizeValue:=$vlResizeTo/$height
							
						Else 
							$vlResizeValue:=1
					End case 
					
					$picture:=$picture*$vlResizeValue
					$calidad:=$vlQuality/1000
					CONVERT PICTURE:C1002($picture;".jpg";$calidad)
					$newFileName:=<>gCountryCode+"."+<>grolBD+"."+String:C10($recordID)+".jpg"
					xDOC_WriteExternalPicture ($picture;$folder;$newFileName;".jpg";False:C215)
					CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
					KRL_FindAndLoadRecordByIndex ($idFieldPointer;->$recordID;True:C214)
					$field->:=$thumbnail
					SAVE RECORD:C53($tablePointer->)
				End if 
				
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aFiles))
			End for 
			KRL_UnloadReadOnly ($tablePointer)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
	End for 
End if 


<>vb_ProcesandoFotografias:=False:C215



  //LIMPIEZA