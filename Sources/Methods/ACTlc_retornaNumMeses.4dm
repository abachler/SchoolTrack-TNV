//%attributes = {}
  //ACTlc_retornaNumMeses

C_LONGINT:C283($day;$mesEmision;$año;$cuenta;$mes;$validaMes)
C_DATE:C307($1;$2;$fechaEm;$fechaVenc;$dateVencT)

$fechaEm:=$1
$fechaVenc:=$2

If ($fechaEm=$fechaVenc)  //20150805 RCH 147932
	$cuenta:=1
Else 
	
	$day:=Day of:C23($fechaEm)
	$mesEmision:=Month of:C24($fechaEm)
	$año:=Year of:C25($fechaEm)
	
	$cuenta:=0
	$mes:=0
	$dateVencT:=$fechaEm
	While ($dateVencT<$fechaVenc)
		$cuenta:=$cuenta+1
		$validaMes:=Month of:C24($dateVencT)
		If ($validaMes=12)
			$mesEmision:=0
			$año:=$año+1
			$mes:=1
		Else 
			$mes:=$mes+1
		End if 
		$dateVencT:=DT_GetDateFromDayMonthYear ($day;$mesEmision+$mes;$año)
	End while 
End if 
$0:=$cuenta