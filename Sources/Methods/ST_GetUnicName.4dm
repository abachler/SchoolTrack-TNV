//%attributes = {}
  //ST_GetUnicName


$method:=$1
$pointer:=$2
$name:=$3
If (Count parameters:C259=4)
	$maxLength:=$4
End if 

Case of 
	: ($method=1)  // compare to array
		$copyStr:=__ ("Copia de ")
		$cutat:=Position:C15($copyStr;$name)-1
		If ($cutAt>0)
			$name:=Substring:C12($name;1;$cutAt)
		End if 
		$name:=$copyStr+$name
		$newName:=$name
		$i:=1
		$el:=Find in array:C230($pointer->;$name)
		While ($el>0)
			$i:=$i+1
			$newName:=$name+String:C10($i)
			$el:=Find in array:C230($pointer->;$newName)
		End while 
		$name:=$newName
		
		
	: ($method=2)  // compare to list 
		$maxLength:=255
		$copyStr:=" copia"
		If (Position:C15($copyStr;$name)>0)
			$name:=Substring:C12($name;1;Position:C15($copyStr;$name)-1)
			$originalName:=$name
		Else 
			$originalName:=$name
		End if 
		$suffix:=$copyStr
		$maxLength:=$maxLength-Length:C16($suffix)
		$name:=Substring:C12($name;1;$maxLength)+$suffix
		$newName:=$name
		$i:=1
		$el:=HL_FindElement ($pointer->;$name)
		While ($el>0)
			$i:=$i+1
			$suffix:=$copyStr+String:C10($i)
			$maxLength:=$maxLength-Length:C16($suffix)
			$newName:=Substring:C12($originalName;1;$maxLength)+$suffix
			$el:=HL_FindElement ($pointer->;$newName)
		End while 
		$name:=$newName
	: ($method=3)  // compare to records
		
End case 


$0:=$name