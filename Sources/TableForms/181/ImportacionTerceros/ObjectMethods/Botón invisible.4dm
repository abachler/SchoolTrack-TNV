ARRAY TEXT:C222($at_posDatos;0)
ACTdte_OpcionesGenerales ("EncabezadosImportacionDT";->$at_posDatos)

$vt_fileName:="ImportacionACT.txt"

If (Test path name:C476($vt_fileName)#Is a document:K24:1)
	If (cs_windows=1)
		USE CHARACTER SET:C205("windows-1252";0)
	Else 
		USE CHARACTER SET:C205("MacRoman";0)
	End if 
	
	$at_posDatos:=6
	  //agrego montos
	For ($l_indiceDetalles;1;$at_posDatos)
		APPEND TO ARRAY:C911($at_posDatos;"Monto "+String:C10($l_indiceDetalles))
	End for 
	
	  //agrego glosas
	For ($l_indiceDetalles;1;$at_posDatos)
		APPEND TO ARRAY:C911($at_posDatos;"Glosa "+String:C10($l_indiceDetalles))
	End for 
	
	$t_rutaLog:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+$vt_fileName
	SYS_DeleteFile ($t_rutaLog)
	$ref:=Create document:C266($t_rutaLog)
	If (ok=1)
		IO_SendPacket ($ref;AT_array2text (->$at_posDatos;"\t")+"\r\n")
	End if 
	CLOSE DOCUMENT:C267($ref)
	USE CHARACTER SET:C205(*;0)
	ACTcd_DlogWithShowOnDisk (document;0;"Archivo generado. Ruta completa: "+ST_Qte (document)+".")
	
Else 
	CD_Dlog (0;"Ya existe un documento en llamado "+ST_Qte (SYS_Path2FileName ($vt_fileName))+" en la carpeta "+ST_Qte (SYS_GetParentNme ($vt_fileName))+"."+"\r\r"+"Antes de crear uno nuevo debe renombrarlo o eliminarlo.")
End if 