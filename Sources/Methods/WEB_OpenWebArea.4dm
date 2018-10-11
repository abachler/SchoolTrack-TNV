//%attributes = {}
  // MÉTODO: WEB_OpenWebArea
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 18/05/11, 13:12:57
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // WEB_OpenWebArea()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;WebArea_URL;$2;$winTitle;$6;vt_HTML)
C_BOOLEAN:C305($3;vbWEB_ShowURL;$4;vbWEB_URLEditable;$5;vbWEB_executeJavaScript)

WebArea_URL:=$1
$winTitle:=$2

vbWEB_ShowURL:=False:C215
vbWEB_URLEditable:=False:C215
vbWEB_executeJavaScript:=True:C214
vt_HTML:=""

Case of 
	: (Count parameters:C259=6)
		vbWEB_ShowURL:=$3
		vbWEB_URLEditable:=$4
		vbWEB_executeJavaScript:=$5
		vt_HTML:=$6
		
	: (Count parameters:C259=5)
		vbWEB_ShowURL:=$3
		vbWEB_URLEditable:=$4
		vbWEB_executeJavaScript:=$5
		
	: (Count parameters:C259=4)
		vbWEB_ShowURL:=$3
		vbWEB_URLEditable:=$4
		
	: (Count parameters:C259=3)
		vbWEB_ShowURL:=$3
		
End case 


$l_refVentana:=Open form window:C675([xShell_Dialogs:114];"XS_HelpBrowser";Plain form window:K39:10+_o_Compositing mode:K34:18;On the right:K39:3;At the top:K39:5;*)
SET WINDOW TITLE:C213($winTitle;$l_refVentana)
DIALOG:C40([xShell_Dialogs:114];"XS_HelpBrowser")
CLOSE WINDOW:C154
