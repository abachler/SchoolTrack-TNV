//%attributes = {}
  //PICT_LoadandShowPicture
  //$1 puntero sobre el campo con el nombre del archivo
  //$2 puntero sobre el campo o variable de imagen donde guardar el resultado (opcional)
  //$3 true abrir la imagen  

C_POINTER:C301($1;$2)
C_TEXT:C284($vt_file_name;$localFileName;$folder)
C_BOOLEAN:C305($3;$vb_abrir)
C_LONGINT:C283($table)
$vt_file_name:=$1->
$vb_abrir:=True:C214
If ((Count parameters:C259)=3)
	$vb_abrir:=$3
End if 

If ($vt_file_name#"")
	$table:=Table:C252($1)
	$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
	If (Application type:C494=4D Remote mode:K5:5)
		$localFileName:=SYS_RetrieveFile_v11 ($folder;$vt_file_name;"";True:C214)
	Else 
		$localFileName:=<>syT_ArchivosFolder+$folder+Folder separator:K24:12+$vt_file_name
	End if 
	
	$err:=0
	
	If ($vb_abrir)
		OPEN URL:C673($localFileName)
	End if 
	
	If ($err=0)
		If ((Count parameters:C259)=3)
			READ PICTURE FILE:C678($localFileName;$2->)
		End if 
	Else 
		CD_Dlog (0;__ ("No es posible acceder a la imagen"))
	End if 
Else 
	CD_Dlog (0;__ ("La ruta de la imagen no es válida"))
End if 