//%attributes = {}
  //ACTutl_CalculaUF

C_DATE:C307($1;$date;$2;$inicioPeriodo)
C_REAL:C285($3;$ufRef;$4;$ipc)
$date:=$1
$inicioPeriodo:=$2
$ufRef:=$3
$ipc:=$4

If (Day of:C23($date)=9)
	$uf:=Round:C94($ufRef*(1+($ipc));2)
Else 
	$dias:=$date-$InicioPeriodo
	$fechaTerminoPeriodo:=$InicioPeriodo+32
	$fechaTerminoPeriodo:=DT_GetDateFromDayMonthYear (9;Month of:C24($fechaTerminoPeriodo);Year of:C25($fechaTerminoPeriodo))
	$d:=$fechaTerminoPeriodo-$InicioPeriodo
	$factor1:=Exp:C21(Log:C22(1+$ipc)/$d)
	$uf:=Round:C94($ufRef*(Round:C94($factor1;16)^$dias);2)
End if 
$0:=$uf
