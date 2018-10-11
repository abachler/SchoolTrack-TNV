//%attributes = {}
  //ADTcdd_GetFile

C_LONGINT:C283($vl_idAlumno)
C_TEXT:C284($vt_idSubRecord)

$vt_idSubRecord:=$1
$vl_idAlumno:=$2

If (Application type:C494=4D Remote mode:K5:5)
	_O_QUERY SUBRECORDS:C108([ADT_Candidatos:49]Documentos:50;[ADT_Candidatos]Documentos'ID=$vt_idSubRecord)
	If ([ADT_Candidatos]Documentos'path#"")
		C_BLOB:C604($xBlob)
		C_TEXT:C284($vt_serverPath;$fileName)
		C_LONGINT:C283($vl_idAl)
		$fileName:=[ADT_Candidatos]Documentos'path
		$vl_idAl:=$vl_idAlumno
		$vt_serverPath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($vl_idAl)+Folder separator:K24:12+$fileName
		$xBlob:=KRL_GetFileFromServer ($vt_serverPath;True:C214)
		If (BLOB size:C605($xBlob)>0)
			$localPath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($vl_idAl)+Folder separator:K24:12+$fileName
			SYS_CreatePath (SYS_GetParentNme ($localPath))
			$vhDocRef:=Create document:C266($localPath)
			If (OK=1)
				CLOSE DOCUMENT:C267($vhDocRef)
				BLOB TO DOCUMENT:C526(Document;$xBlob)
				If (OK=0)
					CD_Dlog (0;__ ("El documento no pudo ser abierto."))
				Else 
					If (SYS_IsMacintosh )
						_O_SET DOCUMENT CREATOR:C531($localPath;"")
						_O_SET DOCUMENT TYPE:C530($localPath;"")
					End if 
					SHOW ON DISK:C922($localPath)
				End if 
			End if 
			SET BLOB SIZE:C606($xBlob;0)
		Else 
			CD_Dlog (0;__ ("No se encontró la archivo original."))
		End if 
	End if 
Else 
	$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
	$fileName:=atADT_DPath{Self:C308->}
	$localPath:=$folder+Folder separator:K24:12+$fileName
	SHOW ON DISK:C922($localPath)
End if 

