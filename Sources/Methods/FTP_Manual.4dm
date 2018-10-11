//%attributes = {}
  //FTP_Manual

$filePath:=$1
$filename:=ST_GetWord ($filePath;ST_CountWords ($filePath;0;"/");"/")
$error:=FTP_Progress (100;100;"Descargando '"+$filename+"'";"*";"*")
If (($error=0) | ($error=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
	$vt_LocalPath:=""
	$error:=FTP_Receive (vlFTP_ConectionID;$filePath;$vt_LocalPath;1)
	If ($error#10000)  // Cancel by the user
		If ($error#0)
			CD_Dlog (0;IT_ErrorText ($error))
		Else 
			CD_Dlog (0;__ ("Descarga completa."))
		End if 
	End if 
Else 
	CD_Dlog (0;IT_ErrorText ($error))
End if 