//%attributes = {}
  // PICTLib_ShowManager()
  //
  //
  // creado por: Alberto Bachler Klein: 05-09-16, 16:11:34
  // -----------------------------------------------------------
C_LONGINT:C283($l_estado;$l_idProceso;$l_refVentana)

$l_idProceso:=Process number:C372("PICTLibManager")
$l_estado:=Process state:C330($l_idProceso)

Case of 
	: ($l_estado<0)
		$l_idProceso:=New process:C317(Current method name:C684;0;"PICTLibManager")
		
		
	: ($l_estado#0)
		RESUME PROCESS:C320($l_idProceso)
		SHOW PROCESS:C325($l_idProceso)
		BRING TO FRONT:C326($l_idProceso)
		
	Else 
		$l_refVentana:=Open form window:C675("PICTLib_Manager";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("PICTLib_Manager")
		CLOSE WINDOW:C154
		
End case 







