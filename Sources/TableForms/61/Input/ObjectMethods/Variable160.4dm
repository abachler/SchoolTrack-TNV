If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script baddCopy
	  //Autor: Alberto Bachler
	  //Creada el 9/6/96 a 4:32 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
aSubID:=0


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

WDW_OpenFormWindow (->[BBL_RegistrosAnaliticos:74];"Input";0;8;__ ("Nuevo registro analítico");"wdwClose")
FORM SET INPUT:C55([BBL_RegistrosAnaliticos:74];"Input")
ADD RECORD:C56([BBL_RegistrosAnaliticos:74];*)
CLOSE WINDOW:C154

yBWR_CurrentTable:=$yBWR_CurrentTable
vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
yBWR_currentTable:=$yBWR_currentTable
vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer

BBL_dcLdSubRec 
BBLitm_OnActivate 