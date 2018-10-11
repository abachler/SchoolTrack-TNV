//%attributes = {"executedOnServer":true}
  // SYS_GetServerFolderList()
  // Por: Alberto Bachler K.: 08-11-14, 17:19:39
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BLOB:C604($x_blob;$subBlob)
C_BOOLEAN:C305($b_invisible;$b_locked)
C_DATE:C307($d_CreatedON;$d_modifiedON)
C_LONGINT:C283($hl_Directories;$i;vl_refIndex)
C_TIME:C306($h_CreatedAT;$h_modifiedAT)
C_PICTURE:C286($icon)
C_TEXT:C284($directoryPath;$t_rutaCarpeta)

ARRAY TEXT:C222($aDirectories;0)


If (False:C215)
	C_TEXT:C284(SYS_GetServerFolderList ;$1)
End if 

$t_rutaCarpeta:=$1


ON ERR CALL:C155("ERR_GenericOnError")
$hl_Directories:=New list:C375
FOLDER LIST:C473($t_rutaCarpeta;$aDirectories)

For ($i;1;Size of array:C274($aDirectories))
	If (SYS_IsMacintosh )
		If (($aDirectories{$i}#"$@") & ($aDirectories{$i}#".@") & ($aDirectories{$i}#"cores") & ($aDirectories{$i}#"bin") & ($aDirectories{$i}#"private") & ($aDirectories{$i}#"volumes") & ($aDirectories{$i}#"usr") & ($aDirectories{$i}#"network") & ($aDirectories{$i}#"sbin") & ($aDirectories{$i}#"@.app") & ($aDirectories{$i}#"@.bundle"))
			vl_refIndex:=vl_refIndex+1
			$directoryPath:=$t_rutaCarpeta+Folder separator:K24:12+$aDirectories{$i}
			$directoryPath:=Replace string:C233($directoryPath;"\\\\";"\\")
			GET DOCUMENT PROPERTIES:C477($directoryPath;$b_locked;$b_invisible;$d_CreatedON;$h_CreatedAT;$d_modifiedON;$h_modifiedAT)
			GET DOCUMENT ICON:C700($directoryPath;$icon;16)
			APPEND TO LIST:C376($hl_Directories;$aDirectories{$i};vl_refIndex)
			SET LIST ITEM ICON:C950($hl_Directories;vl_refIndex;$icon)
			  //SET LIST ITEM PARAMETER($hl_Directories;vl_refIndex;Additional text;String(vl_refIndex))
			SET LIST ITEM PARAMETER:C986($hl_Directories;vl_refIndex;"Path";$directoryPath)
		End if 
	Else 
		If (($aDirectories{$i}#"$@") & ($aDirectories{$i}#".@"))
			vl_refIndex:=vl_refIndex+1
			$directoryPath:=$t_rutaCarpeta+Folder separator:K24:12+$aDirectories{$i}
			$directoryPath:=Replace string:C233($directoryPath;"\\\\";"\\")
			GET DOCUMENT PROPERTIES:C477($directoryPath;$b_locked;$b_invisible;$d_CreatedON;$h_CreatedAT;$d_modifiedON;$h_modifiedAT)
			GET DOCUMENT ICON:C700($directoryPath;$icon;16)
			APPEND TO LIST:C376($hl_Directories;$aDirectories{$i};vl_refIndex)
			SET LIST ITEM ICON:C950($hl_Directories;vl_refIndex;$icon)
			  //SET LIST ITEM PARAMETER($hl_Directories;vl_refIndex;Additional text;String(vl_refIndex))
			SET LIST ITEM PARAMETER:C986($hl_Directories;vl_refIndex;"Path";$directoryPath)
		End if 
	End if 
End for 

LIST TO BLOB:C556($hl_Directories;$x_blob)
$0:=$x_blob

CLEAR LIST:C377($hl_Directories)
ON ERR CALL:C155("")

