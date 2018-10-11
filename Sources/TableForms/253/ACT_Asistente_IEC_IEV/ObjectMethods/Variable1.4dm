  //CAMBIOS
  //20150227 RCH Se genera archivo en excel y se agrega si es IEC o IEV al nombre del archivo

C_LONGINT:C283($l_resp;$i;$l_hecho)
C_TEXT:C284($t_tipo;$line;$t_tipo;$t_dirName;$t_fullPath)
$l_resp:=CD_Dlog (0;__ ("Se generará un archivo de texto con todos los documentos procesados.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
If ($l_resp=1)
	$t_dirName:=xfGetDirName 
	If ($t_dirName#"")
		$t_tipo:=Choose:C955(l_compra=1;"IEC";"IEV")
		$t_fullPath:=$t_dirName+$t_tipo+"_"+String:C10(Day of:C23(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*)))+String:C10(Year of:C25(Current date:C33(*)))+".xls"
		ok:=1
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		If (SYS_TestPathName ($t_fullPath)=1)
			DELETE DOCUMENT:C159($t_fullPath)
		End if 
		EM_ErrorManager ("Clear")
		
		If (ok=1)
			ARRAY POINTER:C280($ay_datos;0)
			ARRAY TEXT:C222($aHeaders;0)
			
			ACTdte_OpcionesGeneralesIE ("CargaArchivoConfiguracion";->$t_tipo;->$aHeaders)
			$t_tipo:=$t_tipo+"_"+String:C10(vlACTdte_YearIE)+String:C10(vlACTdte_MesIE;"00")
			For ($i;1;Size of array:C274($aHeaders))
				$y_puntero:=Get pointer:C304("atACTie_COLUMNA"+String:C10($i))
				APPEND TO ARRAY:C911($ay_datos;$y_puntero)
			End for 
			$l_hecho:=XLS_GeneraArchivo ($t_fullPath;$t_tipo;"";->$aHeaders;->$ay_datos)
			If ($l_hecho=1)
				ACTcd_DlogWithShowOnDisk ($t_fullPath;0;"Archivo "+ST_Qte (SYS_Path2FileName ($t_fullPath))+" generado con éxito. Puede encontrarlo en: "+"\r\r"+SYS_GetParentNme ($t_fullPath))
			Else 
				CD_Dlog (0;"El archivo no pudo ser creado.")
			End if 
		Else 
			CD_Dlog (0;"El documento ya existe y no pudo ser eliminado. Por favor cierre el archivo y vuelva a intentar generarlo.")
		End if 
	End if 
End if 