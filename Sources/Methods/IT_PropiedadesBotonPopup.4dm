//%attributes = {}
  // IT_PropiedadesBotonPopup(nombreObjeto:&T; tituloObjeto:&T; anchoMaximo:&L)

If (False:C215)
	  // Por: Alberto Bachler K.: 04-06-14, 09:29:09
	  //  ---------------------------------------------
	  // 
	  //
	  //  ---------------------------------------------
End if 

C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_alto;$l_anchoActual;$l_anchoMáximo;$l_anchoOptimo;$l_diferencia)
C_TEXT:C284($t_nombreObjeto;$t_tituloObjeto)

If (False:C215)
	C_TEXT:C284(IT_PropiedadesBotonPopup ;$1)
	C_TEXT:C284(IT_PropiedadesBotonPopup ;$2)
	C_LONGINT:C283(IT_PropiedadesBotonPopup ;$3)
End if 

$t_nombreObjeto:=$1
$t_tituloObjeto:=$2
$l_anchoMáximo:=$3

OBJECT SET TITLE:C194(*;$t_nombreObjeto;$t_tituloObjeto)
OBJECT GET BEST SIZE:C717(*;$t_nombreObjeto;$l_anchoOptimo;$l_alto;$l_anchoMáximo)
$l_anchoOptimo:=$l_anchoOptimo+3
$l_anchoActual:=IT_Objeto_Ancho ($t_nombreObjeto)
$l_diferencia:=$l_anchoOptimo-$l_anchoActual
OBJECT MOVE:C664(*;$t_nombreObjeto;0;0;$l_diferencia)

