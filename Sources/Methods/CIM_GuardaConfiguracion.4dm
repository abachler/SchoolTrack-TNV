//%attributes = {}
  // CIM_GuardaConfiguracion()
  // Por: Alberto Bachler K.: 31-10-14, 12:12:39
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($l_paginaActual)

$l_paginaActual:=FORM Get current page:C276
Case of 
	: ($l_paginaActual=3)  //respaldos
		CIM_BKP_GuardaPreferencias 
		
End case 
