//%attributes = {}
  // SRP_CreaObjeto()
  //
  //
  // creado por: Alberto Bachler Klein: 10-04-16, 10:03:23
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_LONGINT:C283($7)
C_LONGINT:C283($8)

C_LONGINT:C283($l_area;$l_error;$l_idObjeto;$l_idObjetoPadre;$l_idSeccion;$l_posicionAbajo;$l_posicionArriba;$l_posicionDerecha;$l_posicionIzquierda;$l_tipoObjeto)
C_TEXT:C284($t_nombreObjeto;$t_tipoObjeto)


If (False:C215)
	C_LONGINT:C283(SRP_CreaObjeto ;$0)
	C_LONGINT:C283(SRP_CreaObjeto ;$1)
	C_TEXT:C284(SRP_CreaObjeto ;$2)
	C_LONGINT:C283(SRP_CreaObjeto ;$3)
	C_TEXT:C284(SRP_CreaObjeto ;$4)
	C_LONGINT:C283(SRP_CreaObjeto ;$5)
	C_LONGINT:C283(SRP_CreaObjeto ;$6)
	C_LONGINT:C283(SRP_CreaObjeto ;$7)
	C_LONGINT:C283(SRP_CreaObjeto ;$8)
End if 

$l_area:=$1
$t_tipoObjeto:=$2
$l_idObjetoPadre:=$3
$t_nombreObjeto:=$4

$l_posicionIzquierda:=$5
$l_posicionArriba:=$6
$l_posicionDerecha:=$7
$l_posicionAbajo:=$8

$l_error:=SR_NewObject (xReportData;$l_idObjeto;$t_tipoObjeto;$l_idObjetoPadre)
SR_SetTextProperty (xReportData;$l_idObjeto;SRP_Object_Name;$t_nombreObjeto)
SR_SetLongProperty (xReportData;$l_idObjeto;SRP_Object_PosLeft;$l_posicionIzquierda)
SR_SetLongProperty (xReportData;$l_idObjeto;SRP_Object_PosTop;$l_posicionArriba)
SR_SetLongProperty (xReportData;$l_idObjeto;SRP_Object_PosRight;$l_posicionDerecha)
SR_SetLongProperty (xReportData;$l_idObjeto;SRP_Object_PosBottom;$l_posicionAbajo)

If ($l_error=0)
	$0:=$l_idObjeto
End if 