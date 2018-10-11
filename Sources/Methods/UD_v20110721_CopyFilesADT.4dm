//%attributes = {}
  //UD_v20110721_CopyFilesADT
  //Descripcion: Mueve los documentos adjuntos ADT.

C_TEXT:C284($path;$root;$machineName;$root;$folderName;$folderArchivo;$name)
C_LONGINT:C283($startAt;$i;$err;$folders)
C_BOOLEAN:C305($mover)
ARRAY LONGINT:C221($aRecNumCan;0)
ARRAY TEXT:C222($atNombres;0)

$path:=SYS_GetServerProperty (XS_StructureFolder)+"DocsPost "+<>gCountryCode+" "+<>grolBD

If (Position:C15("//";$path)>0)
	$path:=Substring:C12($path;Position:C15("//";$path)+2)
End if 


$machineName:=""
If (SYS_IsWindows )
	If ($path="\\\\@")  //si la ruta está en otra máquina
		$machineName:=ST_GetWord ($path;3;Folder separator:K24:12)
		$root:="\\\\"+ST_GetWord ($path;3;Folder separator:K24:12)+Folder separator:K24:12+ST_GetWord ($path;4;Folder separator:K24:12)+Folder separator:K24:12
		$startAt:=1
	Else 
		$root:=ST_GetWord ($path;1;Folder separator:K24:12)+Folder separator:K24:12
	End if 
Else 
	$root:=ST_GetWord ($path;1;Folder separator:K24:12)+Folder separator:K24:12
End if 
$path:=Replace string:C233($path;$root;"")

$folders:=ST_CountWords ($path;0;Folder separator:K24:12)
OK:=1
For ($i;1;$folders)
	$folderName:=$root+ST_GetWord ($path;$i;Folder separator:K24:12)
	If (Test path name:C476($folderName)=0)
		$mover:=True:C214
	Else 
		$mover:=False:C215
	End if 
	$root:=$folderName+Folder separator:K24:12
End for 

If ($mover)
	ALL RECORDS:C47([ADT_Candidatos:49])
	SELECTION TO ARRAY:C260([ADT_Candidatos:49];$aRecNumCan)
	For ($i;1;Size of array:C274($aRecNumCan))
		GOTO RECORD:C242([ADT_Candidatos:49];$aRecNumCan{$i})
		RELATE ONE:C42([ADT_Candidatos:49]Candidato_numero:1)
		$folder:=SYS_GetServerProperty (XS_StructureFolder)+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
		$folderserver:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)+Folder separator:K24:12
		If (Test path name:C476($folder)=0)
			C_BLOB:C604($xBlob)
			DOCUMENT LIST:C474($folder;$atNombres)
			For ($x;1;Size of array:C274($atNombres))
				$folderArchivo:=SYS_GetServerProperty (XS_StructureFolder)+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)+Folder separator:K24:12+$atNombres{$x}
				$name:=SYS_Path2FileName ($folderArchivo)
				DOCUMENT TO BLOB:C525($folderArchivo;$xBlob)
				$err:=xDOC_StoreDocument ($folderserver+$name;->$xBlob;False:C215;"";"")
				SET BLOB SIZE:C606($xBlob;0)
			End for 
		End if 
	End for 
	SYS_DeleteFolder ($folderName)
End if 
