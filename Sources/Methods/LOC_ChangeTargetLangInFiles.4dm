//%attributes = {}
Case of 
	: (Count parameters:C259=2)
		$newLang:=$1
		$path:=$2
	: (Count parameters:C259=1)
		$newLang:=$1
		$path:=""
	Else 
		$newLang:="es"
		$path:=""
End case 
If ($path="")
	$path:=xfGetDirName 
End if 
If ($path#"")
	If (SYS_TestPathName ($path)=Is a folder:K24:2)
		ARRAY TEXT:C222($documents;0)
		DOCUMENT LIST:C474($path;$documents)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Modificando target-language en XLIFFS..")
		For ($i;1;Size of array:C274($documents))
			$file:=$path+$documents{$i}
			$xml:=DOM Parse XML source:C719($file)
			$ref:=DOM Find XML element:C864($xml;"xliff/file")
			DOM SET XML ATTRIBUTE:C866($ref;"target-language";$newLang)
			DOM EXPORT TO FILE:C862($xml;$file)
			DOM CLOSE XML:C722($xml)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($documents))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		ALERT:C41("Path invalido!!!!")
	End if 
End if 