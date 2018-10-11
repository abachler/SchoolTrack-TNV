//%attributes = {}
  // DT_GetLocalDateTimeFromGMT(Fecha:Y; Hora:Y) <- DesfaseLocal
  // Por: Alberto Bachler: 11/01/13, 10:03:56
  //  ---------------------------------------------
  // Retorna la fecha y hora locales a partir de una fecha y hora GMT
  // <-> Fecha: puntero sobre variable o campo fecha
  // <-> Hora: puntero sobre variable o campo hora
  // <- DesfaseLocal: desfase con respecto a GMT en segundos
  //
  //  ---------------------------------------------







C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($l_timeOffset)
C_TIME:C306($h_HoraLocal;$h_horaLocal2)
C_POINTER:C301($y_fechaLocal;$y_horaLocal)
If (False:C215)
	C_POINTER:C301(DT_GetLocalDateTimeFromGMT ;$1)
	C_POINTER:C301(DT_GetLocalDateTimeFromGMT ;$2)
End if 


$y_fechaLocal:=$1
$y_horaLocal:=$2

$l_timeOffset:=DTS_GMT_TimeOffset 

If ($l_timeOffset<0)
	$h_horaLocal2:=$y_horaLocal->-Abs:C99($l_timeOffset)
Else 
	$h_horaLocal2:=$y_horaLocal->+Abs:C99($l_timeOffset)
End if 
Case of 
	: ($h_horaLocal2<?00:00:00?)
		$y_HoraLocal->:=$h_horaLocal2+?24:00:00?
		$y_fechaLocal->:=$y_fechaLocal->-1
	: ($h_horaLocal2>?24:00:00?)
		$y_HoraLocal->:=$h_horaLocal2-?24:00:00?
		$y_fechaLocal->:=$y_fechaLocal->+1
	Else 
		$y_HoraLocal->:=$h_horaLocal2
End case 

$0:=$l_timeOffset

