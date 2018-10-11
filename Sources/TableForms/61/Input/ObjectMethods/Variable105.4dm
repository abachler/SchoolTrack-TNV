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
		ARRAY LONGINT:C221($al_copyID;0)
		
		alBBL_CopyID:=AL_GetLine (xALP_Copy)
		READ ONLY:C145([BBL_Prestamos:60])
		READ ONLY:C145([BBL_Lectores:72])
		
		If (alBBL_CopyID>0)
			  //QUERY([BBL_Préstamos];[BBL_Préstamos]Número_de_registro=alBBL_CopyID{alBBL_CopyID}) 
			APPEND TO ARRAY:C911($al_copyID;alBBL_CopyID{alBBL_CopyID})
		Else 
			ARRAY LONGINT:C221($CopiesIdsArrays;0)
			COPY ARRAY:C226(alBBL_CopyID;$CopiesIdsArrays)
			QRY_QueryWithArray (->[BBL_Prestamos:60]Número_de_registro:1;->$CopiesIdsArrays)
			SELECTION TO ARRAY:C260([BBL_Prestamos:60]Número_de_registro:1;$al_copyID)
		End if 
		
		BBLitm_LeePrestamos (->$al_copyID)
		  //BBLitm_LeePrestamos (->alBBL_CopyID)
	: (alProEvt=2)
		  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
		$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
		$yBWR_currentTable:=yBWR_currentTable
		$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
		$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
		
		  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
		yBWR_CurrentTable:=->[BBL_Registros:66]
		vlBWR_BrowsingMethod:=BWR Array Browsing
		vyBWR_CustomArrayPointer:=->alBBL_CopyID
		vyBWR_CustonFieldRefPointer:=->[BBL_Registros:66]ID:3
		
		alBBL_CopyID:=AL_GetLine (xALP_Copy)
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]ID:3=alBBL_CopyID{alBBL_CopyID})
		WDW_OpenFormWindow (->[BBL_Registros:66];"Input";-1;4;__ ("Copia Nº ")+String:C10([BBL_Registros:66]Número_de_copia:2))
		KRL_ModifyRecord (->[BBL_Registros:66];"Input")
		CLOSE WINDOW:C154
		
		vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
		yBWR_currentTable:=$yBWR_currentTable
		vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
		vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
		BBL_dcLdCopys 
		BBLitm_OnActivate 
		BBLitm_ActualizaFichasCatalogo 
		
		  //20151104 JVP ticket 151922 creo validacion para actualizar los lugares en los items
		BBLRegistro_ActualizaLugares 
		
End case 
