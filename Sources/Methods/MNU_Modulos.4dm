//%attributes = {}
  // MNU_Modulos()
  // Por: Alberto Bachler K.: 23-09-15, 19:18:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$t_parametro:=Get selected menu item parameter:C1005
$l_referenciaModulo:=Num:C11($t_parametro)
Case of 
	: ($l_referenciaModulo=1)
		$t_nombreModulo:="SchoolTrack"
	: ($l_referenciaModulo=2)
		$t_nombreModulo:="MediaTrack"
	: ($l_referenciaModulo=3)
		$t_nombreModulo:="AccountTrack"
	: ($l_referenciaModulo=4)
		$t_nombreModulo:="AdmissionTrack"
	: ($l_referenciaModulo=5)
		  //$t_nombreModulo:="SchoolTrack Web Acces"
End case 
$b_moduloLicenciado:=LICENCIA_esModuloAutorizado (2;$l_referenciaModulo)
If ($b_moduloLicenciado)
	USR_getUserRigths 
	$b_moduloAutorizado:=(Find in array:C230(<>atUSR_AuthModules;$t_nombreModulo)>0) | (USR_GetUserID <0)
	If ($b_moduloAutorizado)
		pCALL_BWR_StartBrowser ($l_referenciaModulo)
	Else 
		CD_Dlog (0;__ ("Lo siento, usted no tiene autorización para ejecutar el módulo ")+$t_nombreModulo+__ ("."))
	End if 
Else 
	CD_Dlog (0;__ ("Lo siento, su licencia no le permite ejecutar el módulo ")+$t_nombreModulo+__ ("."))
End if 