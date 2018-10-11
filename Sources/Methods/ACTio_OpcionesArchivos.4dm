//%attributes = {}
  //ACTio_OpcionesArchivos

C_TEXT:C284($1;$0)
C_TEXT:C284($vt_retorno;$vt_archivo;$vt_fileName;$vt_parentPath)
C_POINTER:C301($vy_pointer1;${2};$vy_pointer2;$vy_fieldID;$vy_pointer3;$vy_pointer4;$vy_pointer5;$vy_pointer6)
C_LONGINT:C283($vl_idCta;$vl_idApdo;$vl_idTipoArchivo;$vl_idRegistro)
C_TEXT:C284($vt_nombreArchivo)

$vt_archivo:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 
If (Count parameters:C259>=6)
	$vy_pointer5:=$6
End if 
If (Count parameters:C259>=7)
	$vy_pointer6:=$7
End if 
Case of 
	: ($vt_archivo="AdjuntosPagares")
		$vy_fieldID:=$vy_pointer1
		$vt_fileName:=$vy_pointer2->
		
		$vt_parentPath:=ACTio_OpcionesArchivos ("GetPath")
		  //el nombre se construye asi: ...IDTIPOARCHIVO_IDCTA_IDAPDO_IDREGISTRO_NOMBREARCHIVO
		$vl_idCta:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;$vy_fieldID;->[ACT_Pagares:184]ID_Cta:18)
		$vl_idApdo:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;$vy_fieldID;->[ACT_Pagares:184]ID_Apdo:17)
		If (Position:C15(Folder separator:K24:12;$vt_fileName)>0)
			$vt_fileName:=SYS_Path2FileName ($vt_fileName)
		End if 
		$vt_retorno:=$vt_parentPath+"1"+"_"+String:C10($vl_idCta)+"_"+String:C10($vl_idApdo)+"_"+String:C10($vy_fieldID->)+"_"+$vt_fileName
		
		
		
	: ($vt_archivo="GetNameXID")
		ARRAY LONGINT:C221($alACT_ids;0)
		ARRAY TEXT:C222($atACT_archivo;0)
		
		APPEND TO ARRAY:C911($alACT_ids;1)
		APPEND TO ARRAY:C911($atACT_archivo;__ ("Pagaré"))
		
		
	: ($vt_archivo="GetPath")
		$vt_retorno:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"ACT"+SYS_FolderDelimiterOnServer 
		
		
	: ($vt_archivo="GetArchivosXID_IDRegistro")
		ARRAY TEXT:C222($atACT_documentos;0)
		ARRAY TEXT:C222($at_tipoArchivo;0)
		ARRAY TEXT:C222($at_idCtaArchivo;0)
		ARRAY TEXT:C222($at_idApdoArchivo;0)
		ARRAY TEXT:C222($at_idRecArchivo;0)
		ARRAY TEXT:C222($at_nombreArchivo;0)
		
		ARRAY LONGINT:C221($alACT_return1;0)
		ARRAY LONGINT:C221($alACT_return2;0)
		ARRAY LONGINT:C221($alACT_return3;0)
		ARRAY LONGINT:C221($alACT_return4;0)
		
		  //IDTIPOARCHIVO_IDCTA_IDAPDO_IDREGISTRO_NOMBREARCHIVO
		
		$vl_idTipoArchivo:=$vy_pointer1->
		$vl_idCta:=$vy_pointer2->
		$vl_idApdo:=$vy_pointer3->
		$vl_idRegistro:=$vy_pointer4->
		$vt_nombreArchivo:=$vy_pointer5->
		AT_Initialize ($vy_pointer6)  // paths
		
		$vt_parentPath:=ACTio_OpcionesArchivos ("GetPath")
		SYS_DocumentList ($vt_parentPath;->$atACT_documentos;Server)
		
		For ($i;1;Size of array:C274($atACT_documentos))
			APPEND TO ARRAY:C911($at_tipoArchivo;ST_GetWord ($atACT_documentos{$i};1;"_"))
			APPEND TO ARRAY:C911($at_idCtaArchivo;ST_GetWord ($atACT_documentos{$i};2;"_"))
			APPEND TO ARRAY:C911($at_idApdoArchivo;ST_GetWord ($atACT_documentos{$i};3;"_"))
			APPEND TO ARRAY:C911($at_idRecArchivo;ST_GetWord ($atACT_documentos{$i};4;"_"))
			APPEND TO ARRAY:C911($at_nombreArchivo;ST_GetWord ($atACT_documentos{$i};5;"_"))
			APPEND TO ARRAY:C911($alACT_return4;$i)
		End for 
		
		If ($vl_idTipoArchivo#0)
			$at_tipoArchivo{0}:=String:C10($vl_idTipoArchivo)
			AT_SearchArray (->$at_tipoArchivo;"=";->$alACT_return1)
		Else 
			COPY ARRAY:C226($alACT_return4;$alACT_return1)  // se consideran todos
		End if 
		If ($vl_idCta#0)
			$at_idCtaArchivo{0}:=String:C10($vl_idCta)
			AT_SearchArray (->$at_idCtaArchivo;"=";->$alACT_return2)
		Else 
			COPY ARRAY:C226($alACT_return4;$alACT_return2)  // se consideran todos
		End if 
		AT_intersect (->$alACT_return1;->$alACT_return2;->$alACT_return3)
		If ($vl_idApdo#0)
			AT_Initialize (->$alACT_return1;->$alACT_return2)
			COPY ARRAY:C226($alACT_return3;$alACT_return1)
			$at_idApdoArchivo{0}:=String:C10($vl_idApdo)
			AT_SearchArray (->$at_idApdoArchivo;"=";->$alACT_return2)
			AT_intersect (->$alACT_return1;->$alACT_return2;->$alACT_return3)
		End if 
		If ($vl_idRegistro#0)
			AT_Initialize (->$alACT_return1;->$alACT_return2)
			COPY ARRAY:C226($alACT_return3;$alACT_return1)
			$at_idRecArchivo{0}:=String:C10($vl_idRegistro)
			AT_SearchArray (->$at_idRecArchivo;"=";->$alACT_return2)
			AT_intersect (->$alACT_return1;->$alACT_return2;->$alACT_return3)
		End if 
		If ($vt_nombreArchivo#"")
			AT_Initialize (->$alACT_return1;->$alACT_return2)
			COPY ARRAY:C226($alACT_return3;$alACT_return1)
			$at_nombreArchivo{0}:=String:C10($vt_nombreArchivo)
			AT_SearchArray (->$at_nombreArchivo;"=";->$alACT_return2)
			AT_intersect (->$alACT_return1;->$alACT_return2;->$alACT_return3)
		End if 
		
		For ($i;1;Size of array:C274($alACT_return3))
			APPEND TO ARRAY:C911($vy_pointer6->;$atACT_documentos{$alACT_return3{$i}})
		End for 
		
	: ($vt_archivo="CargaPagaresDesdeFicha")
		ARRAY TEXT:C222(atACT_AdjuntosNombre;0)
		ARRAY TEXT:C222(atACT_AdjuntosPath;0)
		
		$vl_idTipoArchivo:=1
		$vl_idCta:=0
		$vl_idApdo:=0
		$vl_idRegistro:=[ACT_Pagares:184]ID:12
		$vt_nombreArchivo:=""
		ACTio_OpcionesArchivos ("GetArchivosXID_IDRegistro";->$vl_idTipoArchivo;->$vl_idCta;->$vl_idApdo;->$vl_idRegistro;->$vt_nombreArchivo;->atACT_AdjuntosPath)
		For ($i;1;Size of array:C274(atACT_AdjuntosPath))
			APPEND TO ARRAY:C911(atACT_AdjuntosNombre;ST_GetWord (atACT_AdjuntosPath{$i};5;"_"))
		End for 
		If (Size of array:C274(atACT_AdjuntosPath)>0)
			SELECT LIST ITEMS BY POSITION:C381(lb_adjuntos;1)
		End if 
		
	: ($vt_archivo="EliminaPagares")
		ARRAY TEXT:C222($atACT_files2Del;0)
		
		$vl_idTipoArchivo:=$vy_pointer1->
		$vl_idCta:=$vy_pointer2->
		$vl_idApdo:=$vy_pointer3->
		$vl_idRegistro:=$vy_pointer4->
		$vt_nombreArchivo:=$vy_pointer5->
		$vt_retorno:="0"
		If ($vt_nombreArchivo="")
			$vt_parentPath:=ACTio_OpcionesArchivos ("GetPath")
			ACTio_OpcionesArchivos ("GetArchivosXID_IDRegistro";->$vl_idTipoArchivo;->$vl_idCta;->$vl_idApdo;->$vl_idRegistro;->$vt_nombreArchivo;->$atACT_files2Del)
			For ($i;1;Size of array:C274($atACT_files2Del))
				$atACT_files2Del{$i}:=$vt_parentPath+$atACT_files2Del{$i}
			End for 
		Else 
			$vt_parentPath:=ACTio_OpcionesArchivos ("AdjuntosPagares";->$vl_idRegistro;->$vt_nombreArchivo)
			APPEND TO ARRAY:C911($atACT_files2Del;$vt_parentPath)
		End if 
		For ($i;1;Size of array:C274($atACT_files2Del))
			If (SYS_DeleteFileOnServer ($atACT_files2Del{$i}))
				Case of 
					: ($vl_idRegistro#0)
						LOG_RegisterEvt ("Archivo adjunto "+ST_GetWord (SYS_Path2FileName ($atACT_files2Del{$i});5;"_")+", eliminado desde ficha del pagaré número: "+String:C10([ACT_Pagares:184]Numero_Pagare:11)+", id: "+String:C10([ACT_Pagares:184]ID:12)+".")
				End case 
				$vt_retorno:="1"
			End if 
		End for 
		
End case 

$0:=$vt_retorno