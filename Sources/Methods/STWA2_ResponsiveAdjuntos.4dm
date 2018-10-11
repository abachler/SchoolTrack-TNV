//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 08-01-18, 13:23:56
  // ----------------------------------------------------
  // Método: STWA2_ResponsiveAdjuntos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


ARRAY TEXT:C222($at_archivosbase64;0)
ARRAY TEXT:C222($at_tipobase64;0)
ARRAY TEXT:C222($at_nombrebase64;0)
ARRAY TEXT:C222($at_referencia64;0)
ARRAY TEXT:C222($at_uuid64;0)
ARRAY TEXT:C222($at_uuid64delete;0)

C_REAL:C285($r_filesize)
C_BLOB:C604($x_blob)
$t_accion:=$1
$y_table:=$2
$y_field:=$3

If (Count parameters:C259=4)
	$o_jsonAdjuntos:=$4
	  //extraigo los datos del objeto
	OB GET ARRAY:C1229($o_jsonAdjuntos;"archivosbase64";$at_archivosbase64)
	OB GET ARRAY:C1229($o_jsonAdjuntos;"tipobase64";$at_tipobase64)
	OB GET ARRAY:C1229($o_jsonAdjuntos;"nombrebase64";$at_nombrebase64)
	OB GET ARRAY:C1229($o_jsonAdjuntos;"referencia64";$at_referencia64)
	OB GET ARRAY:C1229($o_jsonAdjuntos;"delete";$at_uuid64delete)
	OB GET ARRAY:C1229($o_jsonAdjuntos;"uuid";$at_uuid64)
End if 


Case of 
	: ($t_accion="insert")
		For ($i;1;Size of array:C274($at_archivosbase64))
			If ($at_uuid64{$i}="-1")
				BASE64 DECODE:C896($at_archivosbase64{1};$x_blob)
				CREATE RECORD:C68([xShell_Documents:91])
				[xShell_Documents:91]RelatedTable:1:=Table:C252($y_table)
				[xShell_Documents:91]RelatedID:2:=$y_field->
				[xShell_Documents:91]DocumentCreator:8:=""
				[xShell_Documents:91]RefType:10:=$at_referencia64{$i}
				[xShell_Documents:91]DocumentName:3:=$at_nombrebase64{$i}
				[xShell_Documents:91]OriginalPath:12:="DocsConducta"
				[xShell_Documents:91]Created_On:14:=Current date:C33
				[xShell_Documents:91]CreatedAt:15:=Current time:C178
				[xShell_Documents:91]ModifiedOn:16:=Current date:C33
				[xShell_Documents:91]ModifiedAt:17:=Current time:C178
				[xShell_Documents:91]DocSize:13:=0
				[xShell_Documents:91]DocumentDescription:4:=$at_tipobase64{$i}
				[xShell_Documents:91]ApplicationName:6:=""
				SAVE RECORD:C53([xShell_Documents:91])
				$extensions:=ST_CountWords ([xShell_Documents:91]DocumentName:3;0;".")
				$extension:=ST_GetWord ([xShell_Documents:91]DocumentName:3;$extensions;".")
				If ($extension#"")
					$externalFileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
					[xShell_Documents:91]DocumentType:5:=$extension
				Else 
					[xShell_Documents:91]DocumentType:5:=""
					$externalFileName:=String:C10([xShell_Documents:91]DocID:9)
				End if 
				$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsConducta"
				$dataFilePath:=sys_getRutaBaseDatos 
				$filePath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$serverFolder+Folder separator:K24:12+$externalFileName
				$parentH:=SYS_GetParentNme ($filePath)
				SYS_CreateFolder ($parentH)
				BLOB TO DOCUMENT:C526($filePath;$x_blob)
				$size:=Get document size:C479($filePath)
				[xShell_Documents:91]DocSize:13:=$size
				SAVE RECORD:C53([xShell_Documents:91])
				KRL_UnloadReadOnly (->[xShell_Documents:91])
			End if 
		End for 
	: ($t_accion="delete")
		
		QUERY WITH ARRAY:C644([xShell_Documents:91]Auto_UUID:20;$at_uuid64delete)
		SELECTION TO ARRAY:C260([xShell_Documents:91];$al_RnAdjuntosEliminar)
		For ($i;1;Size of array:C274($al_RnAdjuntosEliminar))
			XDOC_RemoveAttachedDocument ($al_RnAdjuntosEliminar{$i};"DocsConducta")
		End for 
		KRL_DeleteSelection (->[xShell_Documents:91])
		
		
	: ($t_accion="Load")
		C_OBJECT:C1216($o_adjunto)
		
		ARRAY TEXT:C222($at_archivosbase64;0)
		ARRAY TEXT:C222($at_tipobase64;0)
		ARRAY TEXT:C222($at_nombrebase64;0)
		ARRAY TEXT:C222($at_referencia64;0)
		ARRAY REAL:C219($ar_size64;0)
		ARRAY TEXT:C222($at_uuid;0)
		
		QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=Table:C252($y_table);*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedID:2=$y_field->)
		SELECTION TO ARRAY:C260([xShell_Documents:91];$al_adjuntosRN)
		
		For ($i;1;Size of array:C274($al_adjuntosRN))
			C_TEXT:C284($t_base64)
			$t_base64:=""
			GOTO RECORD:C242([xShell_Documents:91];$al_adjuntosRN{$i})
			$extension:=[xShell_Documents:91]DocumentType:5
			$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
			$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsConducta"
			$dataFilePath:=sys_getRutaBaseDatos +"Archivos"+Folder separator:K24:12+$serverFolder+Folder separator:K24:12+$fileName
			C_BLOB:C604($xblob;0)
			DOCUMENT TO BLOB:C525($dataFilePath;$xblob)
			BASE64 ENCODE:C895($xblob;$t_base64)
			
			$r_filesize:=Round:C94(([xShell_Documents:91]DocSize:13/1024)/1024;4)
			
			APPEND TO ARRAY:C911($at_archivosbase64;"data:"+[xShell_Documents:91]DocumentDescription:4+";base64,"+$t_base64)
			APPEND TO ARRAY:C911($at_tipobase64;[xShell_Documents:91]DocumentDescription:4)
			APPEND TO ARRAY:C911($at_nombrebase64;[xShell_Documents:91]DocumentName:3)
			APPEND TO ARRAY:C911($at_referencia64;[xShell_Documents:91]RefType:10)
			APPEND TO ARRAY:C911($ar_size64;$r_filesize)
			APPEND TO ARRAY:C911($at_uuid;[xShell_Documents:91]Auto_UUID:20)
		End for 
		
		C_OBJECT:C1216($o_adjunto)
		OB SET ARRAY:C1227($o_adjunto;"archivosbase64";$at_archivosbase64)
		OB SET ARRAY:C1227($o_adjunto;"tipobase64";$at_tipobase64)
		OB SET ARRAY:C1227($o_adjunto;"nombrebase64";$at_nombrebase64)
		OB SET ARRAY:C1227($o_adjunto;"referencia64";$at_referencia64)
		OB SET ARRAY:C1227($o_adjunto;"size64";$ar_size64)
		OB SET ARRAY:C1227($o_adjunto;"uuid64";$at_uuid)
		
		$0:=$o_adjunto
End case 

