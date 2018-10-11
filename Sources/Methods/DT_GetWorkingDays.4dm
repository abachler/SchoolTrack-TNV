//%attributes = {}
  //DT_GetWorkingDays


C_LONGINT:C283($feriados)
C_DATE:C307($from;$to;$1;$2)
$from:=$1
$to:=$2
Case of 
	: (Count parameters:C259=3)
		$arrayPointer:=$3
	Else 
		$arrayPointer:=->adSTR_Calendario_Feriados
End case 
If (Size of array:C274($arrayPointer->)>0)
	SORT ARRAY:C229($arrayPointer->;>)
	  //$premierFeriado:=$arrayPointer->{1}
	  //$ultimoFeriado:=$arrayPointer->{Size of array($arrayPointer->)}
	  //If ($premierFeriado>$from)
	  //$from:=$premierFeriado
	  //End if 
	  //If ($ultimoFeriado<$to)
	  //$to:=$ultimoFeriado
	  //End if 
	
	If (($from>!00-00-00!) & ($to>!00-00-00!))
		SORT ARRAY:C229($arrayPointer->;>)
		$feriados:=0
		$date:=$from
		Repeat 
			$el:=Find in array:C230($arrayPointer->;$date)
			If ($el>0)
				$feriados:=$feriados+1
			End if 
			$Date:=$date+1
		Until ($date>$To)
		$0:=($to-$from)-$feriados+1
	Else 
		$0:=0
	End if 
Else 
	$0:=($to-$from)-$feriados+1
End if 