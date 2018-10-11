//%attributes = {}
  // Project Method: FTP_GetHostSubPaths

C_TEXT:C284($1;$root;$sep)
C_POINTER:C301($2;$3;$pa_directories;$pa_files)
C_LONGINT:C283($vlElem)
$root:=$1
$pa_directories:=$2
$pa_files:=$3
$sep:="/"

ARRAY TEXT:C222($atNames;0)
ARRAY LONGINT:C221($alSizes;0)
ARRAY INTEGER:C220($aIKinds;0)
ARRAY DATE:C224($adModDates;0)
C_LONGINT:C283($error)
$error:=FTP_GetDirList (vlFTP_ConectionID;$root;$atNames;$alSizes;$aIKinds;$adModDates)
If ($error=0)
	For ($i;1;Size of array:C274($atNames))
		If (($atNames{$i}#".") & ($atNames{$i}#".."))
			Case of 
				: ($aIKinds{$i}=1)
					$vlElem:=Size of array:C274($pa_directories->)+1
					INSERT IN ARRAY:C227($pa_directories->;$vlElem)
					$pa_directories->{$vlElem}:=$root+$sep+$atNames{$i}
				: ($aIKinds{$i}=0)
					$vlElem:=Size of array:C274($pa_files->)+1
					INSERT IN ARRAY:C227($pa_files->;$vlElem)
					$pa_files->{$vlElem}:=$root+$sep+$atNames{$i}
			End case 
		End if 
	End for 
End if 