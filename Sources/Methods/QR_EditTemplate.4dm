//%attributes = {}
  // QR_EditTemplate()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 16:00:21
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable;$b_many;$b_one)
C_LONGINT:C283($l_IdInforme;$l_nuevaLista;$l_recNum;$l_respuesta)
C_POINTER:C301($y_dtsRepositorio)
C_TEXT:C284($t_dtsModificacion;$t_dtsRepositorio;$t_nombreActual;$t_nombreInforme;$t_tipoInforme;$t_uuidActualizacion)

C_LONGINT:C283(vlQR_ReportListRef)
C_TEXT:C284(vtWS_DTS_Modificacion)
READ ONLY:C145(*)


$y_dtsRepositorio:=OBJECT Get pointer:C1124(Object named:K67:5;"ReportData_dtsRepositorio")
$b_editable:=False:C215
Case of 
	: ((USR_GetUserID <0) & (USR_GetUserID >=-100) & ($y_dtsRepositorio->>[xShell_Reports:54]DTS_UltimaModificacion:46) & ([xShell_Reports:54]IsStandard:38))
		$l_respuesta:=CD_Dlog (0;__ ("El informe almacenado en el repositorio es más reciente que la versión existente en esta librería.\rSi editas este informe a partir de esta versión y luego lo envías al repositorio se perderán cambios almacenados en el repositorio.\r");__ ("");__ ("Cargar versión reciente");__ ("Cancelar");__ ("Editar versión anterior"))
		Case of 
			: ($l_respuesta=1)  //cargar versión
				$t_uuidActualizacion:=RIN_RefUltimaVersion ([xShell_Reports:54]UUID:47)
				RIN_DescargaActualizacion ($t_uuidActualizacion)
				$b_editable:=True:C214
				
			: ($l_respuesta=2)  //cancelar edición
				  //nada
			: ($l_respuesta=3)
				$l_respuesta:=CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("Si envías el informe al repositorio después de editarlo se perderán los cambios efectuados en el informe desde el ^0 a las ^1 (GMT).\r\r¿Estás realmente seguro(a)?");__ ("^0");String:C10([xShell_Reports:54]_inutilizado:22;7));__ ("^1");String:C10([xShell_Reports:54]timestampISO_repositorio:37));__ ("");__ ("No editar ahora");__ ("Si. Editar"))
				If ($l_respuesta=2)
					$b_editable:=True:C214
				End if 
		End case 
		
		
	: ((USR_GetUserID <0) & (USR_GetUserID >=-100) & ($y_dtsRepositorio->="") & ([xShell_Reports:54]IsStandard:38))
		$l_respuesta:=CD_Dlog (0;__ ("No fue posible obtener información sobre este informe desde el repositorio.\rSi lo editas y luego lo envías al repositorio es posible que pierdas los cambios realizados en una versión más reciente.\r");__ ("");__ ("Cancelar");__ ("Editar versión anterior"))
		Case of 
			: ($l_respuesta=1)  //cancelar
				
			: ($l_respuesta=2)  //editar
				$b_editable:=True:C214
		End case 
	Else 
		$b_editable:=True:C214
End case 


If ($b_editable) & (USR_GetMethodAcces ("QR_EditTemplate";0))
	GET AUTOMATIC RELATIONS:C899($b_one;$b_many)
	OK:=0
	Case of 
		: (([xShell_Reports:54]IsStandard:38) & ((USR_GetUserID >0) | (USR_GetUserID <-99)))
			
			
		: (([xShell_Reports:54]Propietary:9#<>lUSR_CurrentUserID) & (<>lUSR_CurrentUserID>0) & (Not:C34(USR_IsGroupMember_by_GrpID (-15001))))
			If (QR_IsReportAllowed ([xShell_Reports:54]ID:7))
				
			Else 
				CD_Dlog (0;__ ("Usted no está autorizado para utilizar este informe."))
			End if 
		Else 
			OK:=1
	End case 
	
	
	If ((ok=1) | (OK=2))
		GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$l_recNum;$t_nombreActual)
		KRL_GotoRecord (->[xShell_Reports:54];$l_recNum;True:C214)
		
		$t_tipoInforme:=[xShell_Reports:54]ReportType:2
		$l_IdInforme:=[xShell_Reports:54]ID:7
		vlQR_manyTableNumber:=[xShell_Reports:54]RelatedTable:14
		If ([xShell_Reports:54]RelatedTable:14=0)
			vlQR_MainTable:=[xShell_Reports:54]MainTable:3
		Else 
			vlQR_MainTable:=[xShell_Reports:54]RelatedTable:14
		End if 
		COPY NAMED SELECTION:C331(vyQR_TablePointer->;"◊Editions")
		
		MESSAGES ON:C181
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		$t_dtsModificacion:=[xShell_Reports:54]DTS_UltimaModificacion:46
		$l_recNum:=Record number:C243([xShell_Reports:54])
		Case of 
			: ($t_tipoInforme="4DFO")  // 4D Form
				BEEP:C151
				
			: ($t_tipoInforme="gSR2")  // SuperReport
				QR_EditSuperReportTemplate 
				
			: ($t_tipoInforme="4DSE")  //Quick Report
				QR_EditQuickReportTemplate 
				
			: ($t_tipoInforme="4DET")  //Quick Report
				QR_CleanReportFolder 
				QR_EditLabelTemplate 
				
			: ($t_tipoInforme="4DWR")  //Quick Report
				QR_EditWriteTemplate 
				
		End case 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		MESSAGES OFF:C175
		FLUSH CACHE:C297
		GOTO RECORD:C242([xShell_Reports:54];$l_recNum)
		If (([xShell_Reports:54]DTS_UltimaModificacion:46>$t_dtsModificacion) & (USR_GetUserID <0) & ([xShell_Reports:54]EnRepositorio:48=True:C214))
			OK:=CD_Dlog (0;__ ("Modificaste este informe estándar.\r¿Quieres enviarlo ahora mismo al repositorio?\r\rSi no lo haces puedes enviarlo después utilizando el menú contextual del informe.");__ ("");__ ("Si");__ ("No"))
			If (OK=1)
				$t_dtsRepositorio:=RIN_SubirAlRepositorio 
				If ($t_dtsRepositorio#"")
					If ([xShell_Reports:54]UUID_institucion:33="")
						$l_nuevaLista:=New list:C375
						LIST TO BLOB:C556($l_nuevaLista;[xShell_Reports:54]xAuthorizedGroups:27)
						LIST TO BLOB:C556($l_nuevaLista;[xShell_Reports:54]xAuthorizedUsers:28)
						CLEAR LIST:C377($l_nuevaLista)
						[xShell_Reports:54]IsStandard:38:=True:C214
						[xShell_Reports:54]Public:8:=True:C214
					End if 
					SAVE RECORD:C53([xShell_Reports:54])
					Notificacion_Mostrar ("Envio de informe al repositorio";"El informe "+[xShell_Reports:54]ReportName:26+" fue almacenado en el repositorio de informes")
				End if 
				SAVE RECORD:C53([xShell_Reports:54])
			End if 
		End if 
		
		
		If (vbQR_FavoritesSelected)
			QR_GetFolderReports 
		Else 
			QR_BuildReportHList 
		End if 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Informes;$l_recNum)
		QR_LoadSelectedReport 
		
		
		USE NAMED SELECTION:C332("◊Editions")
		vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+" entre "+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
	End if 
	SET AUTOMATIC RELATIONS:C310($b_one;$b_many)
End if 




