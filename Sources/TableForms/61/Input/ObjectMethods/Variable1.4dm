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

aCpyBCode:=0

  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
$yBWR_currentTable:=yBWR_currentTable
$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer

  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
yBWR_CurrentTable:=->[BBL_Registros:66]
vlBWR_BrowsingMethod:=BWR Array Browsing
vyBWR_CustomArrayPointer:=->aCpyBCode
vyBWR_CustonFieldRefPointer:=->[BBL_Registros:66]ID:3

  //START TRANSACTION
WDW_OpenFormWindow (->[BBL_Registros:66];"Input";-1;4;__ ("Nueva copia"))
FORM SET INPUT:C55([BBL_Registros:66];"Input")
ADD RECORD:C56([BBL_Registros:66];*)
CLOSE WINDOW:C154
  //If (bBWRSaveRecord=1)
  //VALIDATE TRANSACTION
  //Else 
  //CANCEL TRANSACTION
  //End if 
yBWR_CurrentTable:=$yBWR_CurrentTable
vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
yBWR_currentTable:=$yBWR_currentTable
vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer

BBL_dcLdCopys 
BBLitm_OnActivate 
BBLitm_ActualizaFichasCatalogo 
  //20170928 ASM Se estaban generando numero de registros duplicados, cuando se trabajaba en clientes.
  //SQ_RestauraSecuencias (->[BBL_Registros]No_Registro) 