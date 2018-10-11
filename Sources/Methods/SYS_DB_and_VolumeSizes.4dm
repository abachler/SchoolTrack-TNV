//%attributes = {}
  //SYS_DB_and_VolumeSizes

  //ABK 20090106

  //asigna los tamaños en Mb del volumen (total, usado y disponible) y de la base de datos
C_REAL:C285(<>vrXS_DBVolumeSize;<>vrXS_DBVolumeUsed;<>vrXS_DBVolumeFree;<>vrXS_DBSize)
C_LONGINT:C283($iSegments)
$volume:=ST_GetWord (Data file:C490;1;Folder separator:K24:12)+Folder separator:K24:12
VOLUME ATTRIBUTES:C472($volume;<>vrXS_DBVolumeSize;<>vrXS_DBVolumeUsed;<>vrXS_DBVolumeFree)
ARRAY TEXT:C222($aDataSegments;0)

If (Application version:C493>="11@")
	<>vrXS_DBSize:=Get document size:C479(Data file:C490)
Else 
	_O_DATA SEGMENT LIST:C527($aDataSegments)
	<>vrXS_DBSize:=0
	For ($iSegments;1;Size of array:C274($aDataSegments))
		<>vrXS_DBSize:=<>vrXS_DBSize+Get document size:C479($aDataSegments{$iSegments})
	End for 
End if 

<>vrXS_DBVolumeSize:=Round:C94(<>vrXS_DBVolumeSize/1024/1024;2)
<>vrXS_DBVolumeUsed:=Round:C94(<>vrXS_DBVolumeUsed/1024/1024;2)
<>vrXS_DBVolumeFree:=Round:C94(<>vrXS_DBVolumeFree/1024/1024;2)
<>vrXS_DBSize:=Round:C94(<>vrXS_DBSize/1024/1024;2)