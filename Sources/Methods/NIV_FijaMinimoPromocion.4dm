//%attributes = {}
  // NIV_FijaMinimoPromocion()
  //
  //
  // creado por: Alberto Bachler Klein: 16-12-16, 17:32:24
  // -----------------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_decimales;$l_usarTablaConversion)
C_POINTER:C301($y_Campo;$y_variable)
C_REAL:C285($r_evaluacion)


If (False:C215)
	C_POINTER:C301(NIV_FijaMinimoPromocion ;$1)
	C_POINTER:C301(NIV_FijaMinimoPromocion ;$2)
End if 

$y_variable:=$1
$y_Campo:=$2


$l_usarTablaConversion:=iConversionTable  // desactivo temporalmente la eventual conversión segun tablas, para chequear el valor ingresado
$r_evaluacion:=EV2_ValidaIngreso ($y_variable->)
iConversionTable:=$l_usarTablaConversion  // restablezco la conversión segun tablas si existía

Case of 
	: (iPrintActa=Notas)
		$l_decimales:=iGradesDecNO
	: (iPrintActa=Puntos)
		$l_decimales:=iPointsDecNO
	Else 
		$l_decimales:=11
End case 


Case of 
	: ($r_evaluacion<vrNTA_minimoEscalaReferencia)
		$y_campo->:=-10
		$y_variable->:=EV2_Real_a_Literal ($r_evaluacion;iPrintActa;$l_decimales)
		
	: ($r_evaluacion>=vrNTA_minimoEscalaReferencia)
		$y_campo->:=$r_evaluacion
		$y_variable->:=EV2_Real_a_Literal ($r_evaluacion;iPrintActa;$l_decimales)
		
End case 
vb_CambiosEnPromocion:=($y_campo->#Old:C35($y_campo->))