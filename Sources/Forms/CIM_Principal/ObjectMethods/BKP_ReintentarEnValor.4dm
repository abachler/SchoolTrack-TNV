  // XS_CIM.BKP_ReintentarEnValor()
  // Por: Alberto Bachler K.: 09-09-14, 12:41:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_tiempoReintento)
C_POINTER:C301($y_horaReintento;$y_unidadTiempoReintento)

$y_unidadTiempoReintento:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_reintentarEnUnidad")
$l_tiempoReintento:=(OBJECT Get pointer:C1124(Object named:K67:5;"BKP_ReintentarEnValor"))->
$y_horaReintento:=OBJECT Get pointer:C1124(Object named:K67:5;"BKP_tiempoReintento")
Case of 
	: ($y_unidadTiempoReintento->=1)  // segundos
		$y_horaReintento->:=$l_tiempoReintento
	: ($y_unidadTiempoReintento->=2)  // minutos
		$y_horaReintento->:=$l_tiempoReintento*60
	: ($y_unidadTiempoReintento->=3)  // horas
		$y_horaReintento->:=$l_tiempoReintento*60*60
End case 

