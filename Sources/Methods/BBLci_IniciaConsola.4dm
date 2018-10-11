//%attributes = {}
  // BBLci_IniciaConsola()
  // Por: Alberto Bachler: 28/09/13, 10:55:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(<>lBBL_CircPcsID)
C_BOOLEAN:C305(<>stopBBLCirculationProcess)


<>lBBL_CircPcsID:=Process number:C372("Consola MediaTrack")
$l_estadoProceso:=Process state:C330(<>lBBL_CircPcsID)
Case of 
	: ((<>lBBL_CircPcsID=0) | ($l_estadoProceso<0))
		<>lBBL_CircPcsID:=New process:C317(Current method name:C684;Pila_256K;"Consola MediaTrack")
	: (Process state:C330(<>lBBL_CircPcsID)>0)
		RESUME PROCESS:C320(<>lBBL_CircPcsID)
		SHOW PROCESS:C325(<>lBBL_CircPcsID)
		BRING TO FRONT:C326(<>lBBL_CircPcsID)
		BBLci_InformacionesLector ("set")
	Else 
		vsBWR_CurrentModule:="MediaTrack"
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
		
		READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
		READ ONLY:C145([xxBBL_ReglasParaItems:69])
		READ ONLY:C145([BBL_Lectores:72])
		READ ONLY:C145([BBL_Registros:66])
		READ ONLY:C145([BBL_Prestamos:60])
		READ ONLY:C145([BBL_Transacciones:59])
		READ ONLY:C145([xxBBL_Logs:41])
		REDUCE SELECTION:C351([BBL_Prestamos:60];0)
		REDUCE SELECTION:C351([BBL_Items:61];0)
		REDUCE SELECTION:C351([BBL_Registros:66];0)
		REDUCE SELECTION:C351([BBL_Lectores:72];0)
		
		vd_manualDate:=!00-00-00!
		
		
		PERIODOS_Init 
		PERIODOS_LoadData (0;-2)
		BRING TO FRONT:C326(Current process:C322)
		
		  //atributos interfaz "Light"
		ModernUI_ColoresRGB 
		
		  // modos de busqueda
		BBLci_ModosDeBusqueda 
		
		  // preferencias consola de circulacion
		BBLci_PreferenciasConsola ("Leer")
		
		  //lectura del log
		BBLci_LecturaLog 
		
		  //Lectura de las reglas de items y usuarios
		ARRAY LONGINT:C221(aLBBL_UserRulesRec;0)
		_O_ARRAY STRING:C218(3;asBBL_UserRule;0)
		ALL RECORDS:C47([xxBBL_ReglasParaUsuarios:64])
		SELECTION TO ARRAY:C260([xxBBL_ReglasParaUsuarios:64];aLBBL_UserRulesRec;[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;asBBL_UserRuleCode)
		ARRAY LONGINT:C221(aLBBL_itemRulesRec;0)
		_O_ARRAY STRING:C218(3;asBBL_ItemRule;0)
		ALL RECORDS:C47([xxBBL_ReglasParaItems:69])
		SELECTION TO ARRAY:C260([xxBBL_ReglasParaItems:69];aLBBL_ItemRulesRec;[xxBBL_ReglasParaItems:69]Codigo_regla:1;asBBL_ItemRuleCode)
		
		
		
		$l_refVentana:=Open form window:C675("BBLci_Consola";Plain form window:K39:10;Horizontally centered:K39:1;At the top:K39:5)
		SET WINDOW TITLE:C213(__ ("Circulación");$l_refVentana)
		DIALOG:C40("BBLci_Consola")
		CLOSE WINDOW:C154
		
		READ ONLY:C145([BBL_Prestamos:60])
		READ ONLY:C145([BBL_Registros:66])
		READ ONLY:C145([BBL_Lectores:72])
		READ ONLY:C145([BBL_Transacciones:59])
		READ ONLY:C145([xxBBL_Logs:41])
		
		BRING TO FRONT:C326(<>lBBL_BrowserPcsID)
		SHOW PROCESS:C325(<>lBBL_BrowserPcsID)
		
		BBLci_PreferenciasConsola ("Liberar")
End case 

