//%attributes = {}
  // CIM_CambiaPagina()
  // Por: Alberto Bachler K.: 04-09-14, 12:02:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_altoOptimo;$l_anchoOptimo;$l_arriba;$l_colorFondo;$l_colorTexto;$l_derecha;$l_izquierda;$l_paginaActual;$l_paginaDestino)
C_TEXT:C284($t_nombreBoton;$t_refXml)




If (Count parameters:C259=1)
	$l_paginaDestino:=$1
	$t_nombreBoton:="bPage"+String:C10($l_paginaDestino)
Else 
	$t_nombreBoton:=OBJECT Get name:C1087(Object current:K67:2)
End if 


$l_paginaActual:=FORM Get current page:C276
Case of 
	: ($l_paginaActual=3)  //respaldos
		$t_refXml:=(OBJECT Get pointer:C1124(Object named:K67:5;"refXML"))->
		CIM_BKP_GuardaPreferencias 
End case 


OBJECT SET FONT STYLE:C166(*;"bPage@";Plain:K14:1)
OBJECT SET COLOR:C271(*;"bPage@";-Dark grey:K11:12)
OBJECT SET FONT STYLE:C166(*;$t_nombreBoton;Bold:K14:2)
OBJECT GET COORDINATES:C663(*;$t_nombreBoton;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT GET BEST SIZE:C717(*;$t_nombreBoton;$l_anchoOptimo;$l_altoOptimo)
IT_SetNamedObjectRect ($t_nombreBoton;$l_izquierda;$l_arriba;$l_izquierda+$l_anchoOptimo;$l_arriba+$l_altoOptimo)
OBJECT GET COORDINATES:C663(*;$t_nombreBoton;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
IT_SetNamedObjectRect ("fondoBotonesPaginas";$l_izquierda-8;$l_arriba-5;$l_derecha+8;$l_abajo+5)
$l_colorFondo:=(210 << 16)+(228 << 8)+248
$l_colorTexto:=(31 << 16)+(102 << 8)+177
OBJECT SET RGB COLORS:C628(*;"fondoBotonesPaginas";$l_colorFondo;$l_colorFondo)
OBJECT SET RGB COLORS:C628(*;$t_nombreBoton;$l_colorTexto;$l_colorFondo)



$l_paginaDestino:=Num:C11($t_nombreBoton)
Case of 
	: ($l_paginaDestino=1)  //información sistema
		CIM_GotoPage_Info 
		
	: ($l_paginaDestino=2)  //sesiones
		CIM_GotoPage_Sessions 
		
	: ($l_paginaDestino=3)  //Respaldos
		CIM_GotoPage_BKP 
		
	: ($l_paginaDestino=4)  //FTP Colegium
		CIM_GotoPage_Maintenance 
		
	: ($l_paginaDestino=5)  //FTP Colegium
		CIM_GotoPage_FTP 
		
	: ($l_paginaDestino=7)
		CIM_GotoPage_LogActividades 
		
	: ($l_paginaDestino=8)
		CIM_Manuales 
End case 
FORM GOTO PAGE:C247($l_paginaDestino)