//%attributes = {}
  //Metodo: ACTio_Num2Vars
  //Por roberto catalan
  //Creada el 02/22/2008
  // ----------------------------------------------------
  // Descripción
  // deja en variables separadas la parte entera y decimal de un número pasado en $1. En $2 y $3 van los largos de la parte entera y decima respectivamente.
  // En $4 y $5 son punteros sobre variables de texto que serán escritos con el valor en texto decimal y entero.
  // En $6 opcionalmente se puede aproximar o truncar los decimales cuando el largo sea menor al número de decimales del número
  // ----------------------------------------------------
  // Parámetros
  // $1: numero a separar en entero y decimal
  // $2: largo de la parte entera
  // $3: largo de la parte decimal
  // $4: puntero sobre variable de te
  // $5: puntero sobre variable de te
  // $6: OPCIONAL. Se utiliza si el valor pasado en $3 es menor que el número de decimales de número pasado en $1. True para truncar y OMIITIR  o False para aproximar
  // ----------------------------------------------------
C_TEXT:C284($vt_montoSTR)
C_REAL:C285($vr_monto)
C_LONGINT:C283($vl_largoEntero;$vl_largoDec)
C_TEXT:C284($vt_entero;$vt_decimal)
C_POINTER:C301($4;$5)
C_BOOLEAN:C305($vb_truncarDec)
$vr_monto:=$1
$vl_largoEntero:=$2
$vl_largoDec:=$3

If (Count parameters:C259=6)
	$vb_truncarDec:=$6
End if 

$vt_montoSTR:=Replace string:C233(String:C10($vr_monto);".";",")
If (Position:C15(",";$vt_montoSTR)>0)
	$4->:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
	$5->:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
Else 
	$4->:=$vt_montoSTR
	$5->:="00"
End if 

If (Length:C16($5->)>$vl_largoDec)
	If ($vb_truncarDec)
		$vr_monto:=Trunc:C95($vr_monto;$vl_largoDec)
	Else 
		$vr_monto:=Round:C94($vr_monto;$vl_largoDec)
	End if 
	$vt_montoSTR:=Replace string:C233(String:C10($vr_monto);".";",")
	If (Position:C15(",";$vt_montoSTR)>0)
		$4->:=Substring:C12($vt_montoSTR;1;Position:C15(",";$vt_montoSTR)-1)
		$5->:=Substring:C12($vt_montoSTR;Position:C15(",";$vt_montoSTR)+1)
	Else 
		$4->:=$vt_montoSTR
		$5->:="00"
	End if 
End if 
$4->:=ST_RigthChars (("0"*$vl_largoEntero)+$4->;$vl_largoEntero)
$5->:=ST_LeftChars ($5->+("0"*$vl_largoDec);$vl_largoDec)