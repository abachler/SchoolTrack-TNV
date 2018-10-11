//%attributes = {}
  //SYS_CreateFolder

$path:=$1
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
	If (OK=1)
		$folderName:=$root+ST_GetWord ($path;$i;Folder separator:K24:12)
		If (Test path name:C476($folderName)<0)
			CREATE FOLDER:C475($folderName)
		Else 
			OK:=1
		End if 
		$root:=$folderName+Folder separator:K24:12
	Else 
		$i:=$folders
	End if 
End for 

$0:=OK