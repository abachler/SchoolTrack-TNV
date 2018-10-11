//%attributes = {}
  // DT_FechaISO_a_FechaHora()
  // Por: Alberto Bachler K.: 01-11-14, 17:53:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_BOOLEAN:C305($4)

C_DATE:C307($d_fecha)
C_LONGINT:C283($l_año;$l_dia;$l_mes)
C_TIME:C306($h_hora)
C_POINTER:C301($y_fecha;$y_hora)
C_TEXT:C284($t_fechaHoraISO;$t_hora)
C_BOOLEAN:C305($b_GMTaLocal)

If (False:C215)
	C_TEXT:C284(DT_FechaISO_a_FechaHora ;$0)
	C_TEXT:C284(DT_FechaISO_a_FechaHora ;$1)
	C_POINTER:C301(DT_FechaISO_a_FechaHora ;$2)
	C_POINTER:C301(DT_FechaISO_a_FechaHora ;$3)
	C_BOOLEAN:C305(DT_FechaISO_a_FechaHora ;$4)
End if 

$t_fechaHoraISO:=$1

If (($t_fechaHoraISO#"") & ($t_fechaHoraISO#"0000-00-00T00:00:00@"))
	
	$b_GMTaLocal:=True:C214
	Case of 
		: (Count parameters:C259=4)
			$b_GMTaLocal:=$4
			$y_fecha:=$2
			$y_hora:=$3
		: (Count parameters:C259=3)
			$y_fecha:=$2
			$y_hora:=$3
		: (Count parameters:C259=2)
			$y_fecha:=$2
	End case 
	
	$l_año:=Num:C11(Substring:C12($t_fechaHoraISO;1;4))
	$l_mes:=Num:C11(Substring:C12($t_fechaHoraISO;6;2))
	$l_dia:=Num:C11(Substring:C12($t_fechaHoraISO;9;2))
	$d_fecha:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
	
	$t_hora:=Substring:C12($t_fechaHoraISO;12;8)
	$h_hora:=Time:C179($t_hora)
	
	If ($t_fechaHoraISO="@Z")
		If ($b_GMTaLocal)
			DT_GetLocalDateTimeFromGMT (->$d_fecha;->$h_hora)
			$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_hora;HH MM SS:K7:1)
		Else 
			$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_hora;HH MM SS:K7:1)+" GMT"
		End if 
	Else 
		$0:=String:C10($d_fecha;System date short:K1:1)+", "+String:C10($h_hora;HH MM SS:K7:1)
	End if 
	
	
	If (Not:C34(Is nil pointer:C315($y_fecha)))
		$y_fecha->:=$d_fecha
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_hora)))
		$y_hora->:=$h_hora
	End if 
	
Else 
	$0:="< ? >"
End if 