  // [xShell_Reports].XS_ReportManager()
  // Por: Alberto Bachler K.: 21-08-14, 00:35:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

$y_pais:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoPais")
$y_Idioma:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoIdioma")
$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresionBusqueda")
Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vb_isReportFolder)  //MONO PIBLICAR CARPETA DE INFORMES EN SN3
		$l_indexPais:=Find in array:C230(<>atXS_PaisesCodigos;"all")
		GET PICTURE FROM LIBRARY:C565(<>alXS_PaisesIconos{$l_indexPais};vBanderaPAIS)
		IT_PropiedadesBotonPopup ("pais";<>atXS_PaisesNombres{$l_indexPais};120)
		$y_pais->:=""
		IT_PropiedadesBotonPopup ("pais";" ";120)
		
		$l_indexIdioma:=Find in array:C230(<>atXS_IdiomasCodigos;<>vtXS_langage)
		GET PICTURE FROM LIBRARY:C565(<>alXS_IdiomasIconos{$l_indexIdioma};vBanderaIdioma)
		IT_PropiedadesBotonPopup ("idioma";<>atXS_IdiomasNombres{$l_indexIdioma};120)
		$y_Idioma->:=<>vtXS_langage
		IT_PropiedadesBotonPopup ("idioma";" ";120)
		
		If (Num:C11(PREF_fGet (USR_GetUserID ;"LookForReportInRepository";"1"))=1)  //20171205 RCH Se verifica conexión solo si la opción para actualizar informes está marcada.
			If (INET_IntranetColegiumDisponible )
				bc_lookforUpdatedReport:=Num:C11(PREF_fGet (USR_GetUserID ;"LookForReportInRepository";"1"))
			Else 
				bc_lookforUpdatedReport:=0
			End if 
		Else 
			bc_lookforUpdatedReport:=0
		End if 
		
		OBJECT SET ENABLED:C1123(*;"ReportData_actualizar";False:C215)
		OBJECT SET ENABLED:C1123(*;"ReportData_Example";False:C215)  //(bExample)
		
		
		ARRAY TEXT:C222(atQR_Selection2Print;4)
		atQR_Selection2Print{1}:=__ ("Registros seleccionados")
		atQR_Selection2Print{2}:=__ ("Los registros en la lista")
		atQR_Selection2Print{3}:=__ ("Todos los registros")
		atQR_Selection2Print{4}:=__ ("Búsqueda Previa")
		
		REDUCE SELECTION:C351(vyQR_TablePointer->;0)
		OBJECT SET ENTERABLE:C238(hl_Reports;True:C214)
		OBJECT SET VISIBLE:C603(*;"exemple@";False:C215)
		
		SET_UseSet ("$RecordSet_Table"+String:C10(Table:C252(vyQR_TablePointer)))
		CREATE SET:C116(vyQR_TablePointer->;"recordsInList")
		$tableNum:=Table:C252(vyQR_TablePointer)
		vt_QRtableVName:=API Get Virtual Table Name ($tableNum)
		Case of 
			: (Records in table:C83(vyQR_TablePointer->)=0)
				atQR_Selection2Print:=0
				vtQR_Records:=__ ("No hay nada para imprimir (no existen registros en la tabla)")
			: (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(vyQR_TablePointer)))=0)
				atQR_Selection2Print:=0
				vtQR_SelectionType:=__ ("Selección a imprimir: Búsqueda previa")
				vyQRY_TablePointer:=vyQR_TablePointer
				vtQR_Records:="0 entre "+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
			: (Size of array:C274(aBRSelect)>0)
				atQR_Selection2Print:=1
				vtQR_SelectionType:=__ ("Selección a imprimir: Registros seleccionados")
				BWR_SearchRecords 
				vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+__ (" entre ")+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
			Else 
				atQR_Selection2Print:=2
				vtQR_SelectionType:=__ ("Selección a imprimir: Los registros de la lista")
				SET_UseSet ("$RecordSet_Table"+String:C10(Table:C252(vyQR_TablePointer)))
				vtQR_Records:=String:C10(Records in selection:C76(vyQR_TablePointer->))+__ (" entre ")+String:C10(Records in table:C83(vyQR_TablePointer->))+" "+vt_QRtableVName
		End case 
		
		
		vbQR_FavoritesSelected:=False:C215
		vtQR_MainFileName:=vt_QRtableVName
		MESSAGES OFF:C175
		
		hl_Informes:=New list:C375
		
		QR_BuildFavoritesList 
		$currentFolderID:=0
		$items:=Count list items:C380(hl_FavoriteReports)
		For ($i;1;$items)
			GET LIST ITEM:C378(hl_FavoriteReports;$i;$itemRef;$itemText)
			QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
			QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportParentListId:7=$itemRef;*)
			QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer))
			If (Records in selection:C76([xShell_FavoriteReports:183])>0)
				$currentFolderID:=$itemRef
				$i:=$items+1
			End if 
		End for 
		SET LIST PROPERTIES:C387(hl_FavoriteReports;1;0;18)
		
		
		OBJECT SET ENTERABLE:C238(hl_Reports;True:C214)
		
		If ((<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001;<>lUSR_CurrentUserID)))
			PREF_Set (<>lUSR_CurrentUserID;"universoInformes";"todos")
		End if 
		QR_BuildReportHList 
		
		
		If ($currentFolderID#0)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$currentFolderID)
			vbQR_FavoritesSelected:=True:C214
			QR_GetFolderReports ($currentFolderID)
			QR_LoadSelectedReport 
		Else 
			vtQR_CurrentReportType:="gSR2"
			OBJECT SET FONT STYLE:C166(*;"gSR2_Title";Bold:K14:2)
			vbQR_FavoritesSelected:=False:C215
			POST KEY:C465(Character code:C91("2");256)
		End if 
		
		OBJECT SET VISIBLE:C603(*;"filter@";Not:C34(vbQR_FavoritesSelected))
		GOTO OBJECT:C206(hl_informes)
		
		
		
		
		OBJECT SET ENABLED:C1123(*;"print@";(Records in selection:C76(vyQR_TablePointer->)>0))
		OBJECT SET COLOR:C271(*;"registrosEnSeleccion";Choose:C955(Records in selection:C76(vyQR_TablePointer->)>0;-15;-3))
		OBJECT SET ENABLED:C1123(*;"print_pdf";True:C214)
		
		
		C_TEXT:C284(MenuBusqueda)
		C_OBJECT:C1216($ob)
		C_OBJECT:C1216($ob_pref)
		QR_filtroBusqueda ("CreaObjeto";->$ob;->$ob)
		$ob_pref:=PREF_fGetObject (<>lUSR_CurrentUserID;"MenuBusquedaInformes";$ob)
		QR_filtroBusqueda ("CreaMenu";->$ob_pref;->MenuBusqueda)
		
		OBJECT SET ENABLED:C1123(*;"New";USR_GetMethodAcces ("QR_NewTemplate";0))
		
		
	: (Form event:C388=On After Keystroke:K2:26)
		If (OBJECT Get name:C1087(Object with focus:K67:3)="SearchText_@")
			$y_expresion->:=Get edited text:C655
			POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Shift key mask:K16:3)
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		
		
	: (Form event:C388=On Activate:K2:9)
		QR_AjustesMenu 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		QR_SaveFavoritesList 
		UNLOAD RECORD:C212([xShell_Reports:54])
		HL_ClearList (hl_FavoriteReports;hl_Informes;hl_Reports;HL_NewTemplatePopup;hl_Informes_temp)
		
		
	: (Form event:C388=On Menu Selected:K2:14)
		$l_refMenu:=Menu selected:C152
		$l_menu:=$l_refMenu\65536
		$l_linea:=$l_refMenu%65536
		
		Case of 
			: ($l_menu=0)
				$y_refMenu:=OBJECT Get pointer:C1124(Object named:K67:5;"menuImpresion")
				$t_parametro:=Get menu item parameter:C1003($y_refMenu->;Menu selected:C152%65536)
				If ($t_parametro#"")
					QR_EjecutaItemMenu ($t_parametro)
				End if 
				
			: ($l_menu=1)
				$t_parametro:=Get menu item parameter:C1003(1;Menu selected:C152%65536)
				If ($t_parametro#"")
					QR_EjecutaItemMenu ($t_parametro)
				End if 
				
			Else 
				
		End case 
End case 

