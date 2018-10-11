//%attributes = {}
  //NTA_adjustInterval

$nValue:=$1
$decimals:=$2
$interval:=$3

Case of 
	: (($decimals=0) & ($interval>0))
		$DECresult:=0
		$nValue:=$nValue/10
		$d:=1-Dec:C9($nValue)
		$intV:=1/$interval
		For ($i;1;$intV)
			$a:=(1-(($i-1)*$interval))
			$b:=1-($i*$interval)
			If ($a>=$d) & ($d>$b)
				$dif:=($a-$d)
				If ($dif<=(($interval)/2))
					$DECresult:=1-(($intV-($i-1))*$interval)
					$i:=$intV+1
				Else 
					$DECresult:=1-(($intV-$i)*$interval)
					$i:=$intV+1
				End if 
			End if 
		End for 
		$nValue:=(Int:C8($nValue)+$DECresult)*10
		
	: (($decimals=1) & ($interval>0))
		$DECresult:=0
		$d:=1-Dec:C9($nValue)
		$intV:=1/$interval
		For ($i;1;$intV)
			$a:=(1-(($i-1)*$interval))
			$b:=1-($i*$interval)
			If ($a>=$d) & ($d>$b)
				$dif:=($a-$d)
				If ($dif<=(($interval)/2))
					$DECresult:=1-(($intV-($i-1))*$interval)
					$i:=$intV+1
				Else 
					$DECresult:=1-(($intV-$i)*$interval)
					$i:=$intV+1
				End if 
			End if 
		End for 
		$nValue:=Int:C8($nValue)+$DECresult
		
		
	: (($decimals=2) & ($interval>0))
		$DECresult:=0
		$d:=1-Dec:C9($nValue)
		$intV:=1/$interval
		For ($i;1;$intV)
			$a:=(1-(($i-1)*$interval))
			$b:=1-($i*$interval)
			If ($a>=$d) & ($d>$b)
				$dif:=($a-$d)
				If ($dif<=(($interval)/2))
					$DECresult:=1-(($intV-($i-1))*$interval)
					$i:=$intV+1
				Else 
					$DECresult:=1-(($intV-$i)*$interval)
					$i:=$intV+1
				End if 
			End if 
		End for 
		$nValue:=Int:C8($nValue)+$DECresult
		
		
	: (($decimals=3) & ($interval>0))
		$DECresult:=0
		$d:=1-Dec:C9($nValue)
		$intV:=1/$interval
		For ($i;1;$intV)
			$a:=(1-(($i-1)*$interval))
			$b:=1-($i*$interval)
			If ($a>=$d) & ($d>$b)
				$dif:=($a-$d)
				If ($dif<=(($interval)/2))
					$DECresult:=1-(($intV-($i-1))*$interval)
					$i:=$intV+1
				Else 
					$DECresult:=1-(($intV-$i)*$interval)
					$i:=$intV+1
				End if 
			End if 
		End for 
		$nValue:=(Int:C8($nValue)+$DECresult)
End case 

$0:=$nValue