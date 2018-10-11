//%attributes = {}
  //UD_v20130619_DTSPDF

If (ACT_AccountTrackInicializado )
	If (Application type:C494#4D Remote mode:K5:5)
		
		ARRAY TEXT:C222($aAvisosPaths;0)
		C_TEXT:C284($srcFolder;$t_idAC)
		C_LONGINT:C283($l_idAC;$l_idArchivos)
		C_BOOLEAN:C305($b_bloqueado;$b_invisible)
		C_DATE:C307($d_creacion;$d_modificacion)
		C_TIME:C306($h_creacion;$h_modificacion)
		C_TEXT:C284($t_dts;$t_parametro)
		C_BOOLEAN:C305($b_hecho)
		
		$srcFolder:=SYS_CarpetaAplicacion (CLG_ArchivosAsociados)+"AvisosPDF"+SYS_FolderDelimiterOnServer 
		SYS_CreateFolder ($srcFolder)
		DOCUMENT LIST:C474($srcFolder;$aAvisosPaths)
		For ($l_idArchivos;1;Size of array:C274($aAvisosPaths))
			$t_idAC:=Replace string:C233($aAvisosPaths{$l_idArchivos};"AC_";"")
			$t_idAC:=Replace string:C233($t_idAC;".pdf";"")
			$l_idAC:=Num:C11($t_idAC)
			GET DOCUMENT PROPERTIES:C477($srcFolder+$aAvisosPaths{$l_idArchivos};$b_bloqueado;$b_invisible;$d_creacion;$h_creacion;$d_modificacion;$h_modificacion)
			$t_dts:=DTS_MakeFromDateTime ($d_creacion;$h_creacion)
			$t_parametro:=ST_Concatenate (";";->$l_idAC;->$t_dts)
			$b_hecho:=ACTac_CreaDTSPDF ($t_parametro)
			If (Not:C34($b_hecho))
				BM_CreateRequest ("ACT_escribeDTSPDF";$t_parametro;String:C10($l_idAC))
			End if 
		End for 
	End if 
End if 