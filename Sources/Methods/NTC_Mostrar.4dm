//%attributes = {}
  // NTC_Mostrar
  //
  // DESCRIPCIÓN:
  // Muestra el centro de notificaciones
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 11:17:44
  // ---------------------------------------------
C_LONGINT:C283($i;$l_IdProcesoSoporte;$l_processNumber;$l_processState;$l_winRef)
C_POINTER:C301($y_Nil)

ARRAY DATE:C224($ad_fechaMensajes;0)
ARRAY LONGINT:C221($al_HoraCreacion;0)
ARRAY TEXT:C222($at_Encabezados;0)


C_TEXT:C284(vt_UUIDmensaje)

ARRAY TEXT:C222(at_TitulosColumnas;0)
ARRAY TEXT:C222(at_ArreglosErrores;0)
ARRAY TEXT:C222(at_Lectores;0)
ARRAY BOOLEAN:C223(ab_leido;0)



  // CÓDIGO
$l_processNumber:=Process number:C372("Notificaciones")
$l_processState:=Process state:C330($l_processNumber)
Case of 
	: ($l_processState<0)
		$l_IdProcesoSoporte:=New process:C317("NTC_Mostrar";128000;"Notificaciones")
	: ($l_processState#0)
		SHOW PROCESS:C325($l_processNumber)
		BRING TO FRONT:C326($l_processNumber)
	Else 
		
		PCS_RegisterProcesses (Current process:C322)
		
		SET MENU BAR:C67("XS_Browser")
		DISABLE MENU ITEM:C150(1;0)
		ENABLE MENU ITEM:C149(1;4)
		DISABLE MENU ITEM:C150(2;13)
		DISABLE MENU ITEM:C150(2;14)
		DISABLE MENU ITEM:C150(2;15)
		DISABLE MENU ITEM:C150(2;16)
		DISABLE MENU ITEM:C150(2;18)
		For ($i;3;Count menus:C404)
			DISABLE MENU ITEM:C150($i;0)
		End for 
		
		$l_winRef:=WDW_OpenFormWindow ($y_Nil;"Notificaciones";-1;8;__ ("Centro de notificaciones"))
		DIALOG:C40("Notificaciones")
		CLOSE WINDOW:C154
		
End case 

