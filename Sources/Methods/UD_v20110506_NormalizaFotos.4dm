//%attributes = {}
  // MÉTODO: UD_v20110506_NormalizaFotos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/05/11, 13:09:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110506_NormalizaFotos()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL


C_PICTURE:C286($picture;$thumbnail)
ARRAY TEXT:C222($aFolders;0)
ARRAY TEXT:C222($aDocuments;0)

$p:=IT_UThermometer (1;0;__ ("Respaldando fotografías..."))
BKP_RespaldaFotografias 
$p:=IT_UThermometer (-2;$p)

$dataFilePath:=sys_getRutaBaseDatos 
$folderPath:=$dataFilePath+"Archivos"+Folder separator:K24:12+"Fotografías "+<>gCountryCode+" "+<>gRolBD

FOLDER LIST:C473($folderPath;$aFolders)

$p:=IT_UThermometer (1;0;"Ajustando tamaño y comprimiendo fotografías...")
For ($i;1;Size of array:C274($aFolders))
	$path:=$folderPath+Folder separator:K24:12+$aFolders{$i}
	DOCUMENT LIST:C474($path;$aDocuments)
	For ($i_Docs;1;Size of array:C274($aDocuments))
		$filePath:=$path+Folder separator:K24:12+$aDocuments{$i_Docs}
		READ PICTURE FILE:C678($filePath;$picture)
		xDOC_Picture_SetMaxSize (->$picture;768)
		DELETE DOCUMENT:C159($filePath)
		$filePath:=Substring:C12($filePath;1;Length:C16($filePath)-4)+".jpg"
		WRITE PICTURE FILE:C680($filePath;$picture;".jpg")
		
		Case of 
			: ($aFolders{$i}="0187")
				$id:=Num:C11(ST_GetWord ($aDocuments{$i_Docs};3;"."))
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionCompetencias:187]ID:1;->$id;True:C214)
				CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
				[MPA_DefinicionCompetencias:187]Graphic:29:=$thumbnail
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			: ($aFolders{$i}="0188")
				$id:=Num:C11(ST_GetWord ($aDocuments{$i_Docs};3;"."))
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->$id;True:C214)
				CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
				[MPA_DefinicionDimensiones:188]Graphic:22:=$thumbnail
				SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
			: ($aFolders{$i}="0185")
				$id:=Num:C11(ST_GetWord ($aDocuments{$i_Docs};3;"."))
				KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->$id;True:C214)
				CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
				[MPA_DefinicionEjes:185]Graphic:22:=$thumbnail
				SAVE RECORD:C53([MPA_DefinicionEjes:185])
		End case 
		
	End for 
End for 

$p:=IT_UThermometer (-2;$p)