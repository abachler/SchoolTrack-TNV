//%attributes = {}
  //ACTdteRec_DescargaTodo2Archivos
C_LONGINT:C283($l_indiceRS;vlACT_RSSel;$l_contador)
C_BLOB:C604($xBlob_respuesta)
C_REAL:C285($r_recs)
C_TIME:C306($vhDocRef)
C_TEXT:C284($t_fileName;$t_path;$t_path2)
C_POINTER:C301($y_nil)
C_TEXT:C284($t_rutRS)

$l_idRS:=$1

$t_path:=xfGetDirName 
If ($t_path#"")
	  //ACTcfg_OpcionesRazonesSociales ("LoadConfig")
	  //For ($l_indiceRS;1;Size of array(atACTcfg_Razones))
	  //vlACT_RSSel:=alACTcfg_Razones{$l_indiceRS}
	  //ACTcfg_OpcionesRazonesSociales ("CargaByID";->vlACT_RSSel)
	  //ACTcfdi_OpcionesGenerales ("LeeConf";->vlACT_RSSel)
	$t_rutRS:=[ACT_RazonesSociales:279]RUT:3
	If (ACTdte_EsEmisorColegium ($l_idRS))
		$t_path2:=$t_path+$t_rutRS+SYS_FolderDelimiter 
		SYS_CreatePath ($t_path2)
		
		SET BLOB SIZE:C606($xBlob_respuesta;0)
		$xBlob_respuesta:=WSact_ObtieneDTEsRecibidos ($t_rutRS;->$r_recs)
		If (BLOB size:C605($xBlob_respuesta)>0)
			$t_fileName:=$t_path2+String:C10($l_contador)+".xml"
			If (Test path name:C476($t_fileName)=Is a document:K24:1)
				DELETE DOCUMENT:C159($t_fileName)
			End if 
			$vhDocRef:=Create document:C266($t_fileName)  // Guardar el documento de su elección
			If (OK=1)  // Si un documento ha sido creado
				CLOSE DOCUMENT:C267($vhDocRef)  // No necesitamos mantenerlo abierto
				BLOB TO DOCUMENT:C526(Document;$xBlob_respuesta)  // Escribir el contenido del documento
				If (OK=0)
					CD_Dlog (0;"Error al crear documento.")
				End if 
			End if 
			$l_contador:=$l_contador+1
			$r_recs:=$r_recs-100
			$l_offset:=100
		Else 
			$r_recs:=-1
		End if 
		
		While ($r_recs>0)
			C_REAL:C285($r_nil)
			SET BLOB SIZE:C606($xBlob_respuesta;0)
			
			  // Modificado por: Saúl Ponce (13/09/2017) Agregué la declaración y el cambio en el llamado para que no produzca error al consultar los DTE
			  // $xBlob_respuesta:=WSact_ObtieneDTEsRecibidos ($t_rutRS;$y_nil;$l_offset)
			$xBlob_respuesta:=WSact_ObtieneDTEsRecibidos ($t_rutRS;->$r_nil;$l_offset)
			
			If (BLOB size:C605($xBlob_respuesta)>0)
				$t_fileName:=$t_path2+String:C10($l_contador)+".xml"
				If (Test path name:C476($t_fileName)=Is a document:K24:1)
					DELETE DOCUMENT:C159($t_fileName)
				End if 
				$vhDocRef:=Create document:C266($t_fileName)  // Guardar el documento de su elección
				If (OK=1)  // Si un documento ha sido creado
					CLOSE DOCUMENT:C267($vhDocRef)  // No necesitamos mantenerlo abierto
					BLOB TO DOCUMENT:C526(Document;$xBlob_respuesta)  // Escribir el contenido del documento
					If (OK=0)
						CD_Dlog (0;"Error al crear documento.")
					End if 
				End if 
				$l_contador:=$l_contador+1
				$l_offset:=$l_offset+100
				$r_recs:=$r_recs-100
			Else 
				$r_recs:=-1
			End if 
		End while 
		If ($r_recs=-1)
			CD_Dlog (0;"Error al consultar servicio.")
		End if 
		LOG_RegisterEvt ("Todos los documentos recibidos fueron descargados en la carpeta: "+ST_Qte ($t_path2)+".")
	End if 
	  //End for 
	If ($r_recs#-1)
		ACTcd_DlogWithShowOnDisk ($t_path;0;"Documentos exportados.")
	End if 
End if 