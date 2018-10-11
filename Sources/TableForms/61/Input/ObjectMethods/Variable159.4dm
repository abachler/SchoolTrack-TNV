If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script xAL_Copy
	  //Autor: Alberto Bachler
	  //Creada el 9/6/96 a 4:59 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
Case of 
	: (alProEvt=1)
		aSubID:=AL_GetLine (xALP_SubRec)
	: (alProEvt=2)
		aSubID:=AL_GetLine (xALP_SubRec)
		  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
		$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
		$yBWR_currentTable:=yBWR_currentTable
		$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
		$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
		
		  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
		yBWR_CurrentTable:=->[BBL_RegistrosAnaliticos:74]
		vlBWR_BrowsingMethod:=BWR Array Browsing
		vyBWR_CustomArrayPointer:=->aSubID
		vyBWR_CustonFieldRefPointer:=->[BBL_RegistrosAnaliticos:74]ID_sub:8
		
		QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID_sub:8=aSubID{aSubID})
		WDW_OpenFormWindow (->[BBL_RegistrosAnaliticos:74];"Input";-1;4)
		KRL_ModifyRecord (->[BBL_RegistrosAnaliticos:74];"Input")
		CLOSE WINDOW:C154
		BBL_dcLdSubRec 
		
		yBWR_CurrentTable:=$yBWR_CurrentTable
		vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
		yBWR_currentTable:=$yBWR_currentTable
		vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
		vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
		BBLitm_OnActivate 
End case 
