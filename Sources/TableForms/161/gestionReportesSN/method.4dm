Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283(hlTab_Menu)
		C_TEXT:C284(vtQR_SNNombre;vtUUID_Carpeta)
		hlTab_Menu:=New list:C375
		If (SYS_IsWindows )
			OBJECT SET RGB COLORS:C628(hlTab_Menu;0x0001;0x00FFFFFF)
		End if 
		APPEND TO LIST:C376(hlTab_Menu;"Enviar";1)
		APPEND TO LIST:C376(hlTab_Menu;"Gestionar Enviados";2)
		SELECT LIST ITEMS BY POSITION:C381(hlTab_Menu;1)
		
		vdQR_SNDisponibleDesde:=Current date:C33(*)
		
		If (vb_isReportFolder)  //MONO PIBLICAR CARPETA DE INFORMES EN SN3
			
			GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
			QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
			QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportName:4=$t_nombreCarpetaFavoritos;*)
			QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
			QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=True:C214)
			vtQR_SNNombre:="Carpeta de informes "+$t_nombreCarpetaFavoritos
			vtUUID_Carpeta:=[xShell_FavoriteReports:183]Auto_UUID:10
		Else 
			$selectedItem:=Selected list items:C379(hl_informes)
			If (($selectedItem>0) & (Count list items:C380(hl_informes)>=$selectedItem))
				GET LIST ITEM:C378(hl_informes;$selectedItem;$reportRecNum;$CurrentReportName)
			Else 
				$reportRecNum:=Record number:C243([xShell_Reports:54])
			End if 
			KRL_GotoRecord (->[xShell_Reports:54];$reportRecNum)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_informes;$reportRecNum)
			GET LIST ITEM:C378(hl_informes;$selectedItem;$reportRecNum;$CurrentReportName)
			
			vtQR_SNNombre:=$CurrentReportName
		End if 
		
		ARRAY BOOLEAN:C223(abQR_SNEnviar;0)
		ARRAY TEXT:C222(atQR_SNNombres;0)
		ARRAY LONGINT:C221(alQR_SNRecNumsRegistros;0)
		
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];alQR_SNRecNumsRegistros)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atQR_SNNombres)
		AT_RedimArrays (Size of array:C274(atQR_SNNombres);->abQR_SNEnviar)
		C_BOOLEAN:C305($dummyBoolean)
		$dummyBoolean:=True:C214
		AT_Populate (->abQR_SNEnviar;->$dummyBoolean)
		OBJECT SET ENABLED:C1123(bEnviar;(Size of array:C274(abQR_SNEnviar)>0))
		OBJECT SET ENABLED:C1123(bDownload;False:C215)
	: (Form event:C388=On Unload:K2:2)
		CLEAR LIST:C377(hlTab_Menu)
End case 