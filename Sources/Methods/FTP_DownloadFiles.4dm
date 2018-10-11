//%attributes = {}
  //FTP_DownloadFiles

  // Project Method: Create_LocalFiles

C_TEXT:C284($1;$localPath;$targetPath)
C_POINTER:C301($2;$pa_files)
C_POINTER:C301($3;$pa_Targets)
C_LONGINT:C283($lastChar;$error)
  //C_LONGINT($3;$deleteAt;$lastChar;$error)
_O_C_STRING:C293(1;$sep)

$sep:=Folder separator:K24:12  // returns \ if Windows  or  : if Mac OS

$localPath:=$1
$pa_files:=$2
$pa_Targets:=$3

$lastChar:=Length:C16($localPath)
If ($localPath[[$lastChar]]=$sep)
	$localPath:=Delete string:C232($localPath;$lastChar;1)
End if 

$replaceAll:=False:C215
For ($i;1;Size of array:C274($pa_files->))
	  //$targetPath:=Delete string($pa_files->{$i};1;$deleteAt)
	  //$targetPath:=$localPath+Replace string($targetPath;"/";$sep)
	  //$targetPath:=$localPath+SYS_FolderDelimiter +ST_GetWord ($pa_files->{$i};ST_CountWords ($pa_files->{$i};0;"/");"/")
	
	$error:=FTP_Progress (100;100;"Getting '"+$pa_files->{$i}+"'";"*";"*")
	If (($error=0) | ($error=-2201))  //este error da por que esta funcionalidad no está implementada aun en 64bits (en la documentación del comando aparece)
		
		$fileName:=Folder separator:K24:12+ST_GetWord ($pa_files->{$i};ST_CountWords ($pa_files->{$i};0;"/");"/")
		If (Test path name:C476($pa_Targets->{$i})>=0)
			If (Not:C34($replaceAll))
				OK:=CD_Dlog (0;__ ("Ya existe un archivo con el nombre ")+$fileName+__ ("\r\r¿Que desea usted hacer?");__ ("");__ ("Reemplazar");__ ("Remplazar todos");__ ("Cancelar"))
				If (ok=2)
					$replaceAll:=True:C214
					OK:=1
				End if 
			End if 
			If (ok=1)
				DELETE DOCUMENT:C159($pa_Targets->{$i})
			End if 
		Else 
			OK:=1
		End if 
		
		$error:=FTP_Receive (vlFTP_ConectionID;$pa_files->{$i};$pa_Targets->{$i};1)
		Case of 
			: ($error#10000)  // Cancel by the user
				If ($error#0)
					CD_Dlog (0;IT_ErrorText ($error))
				End if 
			Else 
				CD_Dlog (0;IT_ErrorText ($error))
		End case 
	End if 
End for 