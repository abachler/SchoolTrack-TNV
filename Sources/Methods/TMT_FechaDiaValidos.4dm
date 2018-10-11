//%attributes = {}
  // TMT_FechaDiaValidos()
  // Por: Alberto Bachler: 18/06/13, 20:14:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_DATE:C307($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_FechaValida)
C_DATE:C307($d_fecha;$d_fechaLimite)
C_LONGINT:C283($l_numeroDia)
C_POINTER:C301($y_Fecha_d)

If (False:C215)
	C_BOOLEAN:C305(TMT_FechaDiaValidos ;$0)
	C_POINTER:C301(TMT_FechaDiaValidos ;$1)
	C_DATE:C307(TMT_FechaDiaValidos ;$2)
	C_LONGINT:C283(TMT_FechaDiaValidos ;$3)
End if 

$y_Fecha_d:=$1
$d_fechaLimite:=$2
$l_numeroDia:=$3

$d_fecha:=$y_Fecha_d->

$b_FechaValida:=(DateIsValid ($d_fecha;0))
$b_FechaValida:=$b_FechaValida & (DT_GetDayNumber_ISO8601 ($d_fecha)=$l_numeroDia)

If (Not:C34($b_FechaValida))
	If ($d_fecha<$d_fechaLimite)
		Repeat 
			$d_fecha:=$d_fecha+1
			$b_FechaValida:=(DateIsValid ($d_fecha;0))
			$b_FechaValida:=$b_FechaValida & (DT_GetDayNumber_ISO8601 ($d_fecha)=$l_numeroDia)
		Until ($b_FechaValida | ($d_fecha>$d_fechaLimite))
	Else 
		Repeat 
			$d_fecha:=$d_fecha-1
			$b_FechaValida:=DateIsValid ($d_fecha;0)
			$b_FechaValida:=$b_FechaValida & (DT_GetDayNumber_ISO8601 ($d_fecha)=$l_numeroDia)
		Until ($b_FechaValida | ($d_fecha<$d_fechaLimite))
	End if 
End if 

$y_Fecha_d->:=$d_fecha
$0:=$b_FechaValida
