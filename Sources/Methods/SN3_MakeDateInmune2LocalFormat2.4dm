//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 03-05-18, 17:57:20
  // ----------------------------------------------------
  // Método: SN3_MakeDateInmune2LocalFormat2
  // Descripción
  // Retorna AAAA-MM-DD
  //
  // Parámetros
  // ----------------------------------------------------



C_DATE:C307($1;$d_date)
C_TEXT:C284($0;$t_dateStr)

$d_date:=$1

If ($d_date=!00-00-00!)
	$t_dateStr:=""
Else 
	$separator:="-"
	If (Count parameters:C259=2)
		$separator:=$2
	End if 
	$day:=Day of:C23($d_date)
	$month:=Month of:C24($d_date)
	$year:=Year of:C25($d_date)
	$t_dateStr:=String:C10($year;"0000")+$separator+String:C10($month;"00")+$separator+String:C10($day;"00")
End if 
$0:=$t_dateStr