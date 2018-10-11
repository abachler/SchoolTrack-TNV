//%attributes = {}
  // SRP_CreaSeccion()
  //
  //
  // creado por: Alberto Bachler Klein: 10-04-16, 10:17:06
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($l_altura;$l_area;$l_error;$l_idSeccion;$l_posicionEtiqueta)
C_TEXT:C284($t_nombreSeccion;$t_tipoSeccion)


If (False:C215)
	C_LONGINT:C283(SRP_CreaSeccion ;$0)
	C_LONGINT:C283(SRP_CreaSeccion ;$1)
	C_TEXT:C284(SRP_CreaSeccion ;$2)
	C_TEXT:C284(SRP_CreaSeccion ;$3)
	C_LONGINT:C283(SRP_CreaSeccion ;$4)
	C_LONGINT:C283(SRP_CreaSeccion ;$5)
End if 

$l_area:=$1
$t_tipoSeccion:=$2
$t_nombreSeccion:=$3
$l_altura:=$4

$l_posicionEtiqueta:=50
If (Count parameters:C259=5)
	$l_posicionEtiqueta:=$5
End if 

$l_error:=SR_NewObject (xReportData;$l_idSeccion;$t_tipoSeccion;0)
SR_SetTextProperty (xReportData;$l_idSeccion;SRP_Object_Name;$t_nombreSeccion)
SR_SetLongProperty (xReportData;$l_idSeccion;SRP_Section_Height;$l_altura)
SR_SetLongProperty (xReportData;$l_idSeccion;SRP_Section_LabelPos;$l_posicionEtiqueta)

If ($l_error=0)
	$0:=$l_idSeccion
End if 


