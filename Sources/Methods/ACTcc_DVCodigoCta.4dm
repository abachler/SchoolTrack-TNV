//%attributes = {}
  //ACTcc_DVCodigoCta

C_TEXT:C284($codigo;$1)
$codigo:=$1
If (($codigo#"") & (<>vtXS_CountryCode="co"))
	Case of 
		: (<>gRolBD="8600063381")  //Liceo Frances
			$chars:=Length:C16($codigo)
			ARRAY INTEGER:C220($aClave;4)
			$aClave{1}:=3
			$aClave{2}:=5
			$aClave{3}:=7
			$aClave{4}:=9
			$c:=1
			$total:=0
			For ($i;$chars;1;-1)
				$total:=$total+(Num:C11($codigo[[$i]])*$aClave{$c})
				If (Mod:C98($c;4)=0)
					$c:=1
				Else 
					$c:=$c+1
				End if 
			End for 
			$res:=Mod:C98($total;11)
			$dv:=11-$res
			If (($res=0) | ($res=1))
				$dv:=0
			End if 
			$0:=$codigo+String:C10($dv)
		: (<>gRolBD="205402948")  //Santa Ana
			$chars:=Length:C16($codigo)
			ARRAY INTEGER:C220($aClave;4)
			$aClave{1}:=3
			$aClave{2}:=5
			$aClave{3}:=7
			$aClave{4}:=9
			$c:=1
			$total:=0
			For ($i;$chars;1;-1)
				$total:=$total+(Num:C11($codigo[[$i]])*$aClave{$c})
				If (Mod:C98($c;4)=0)
					$c:=1
				Else 
					$c:=$c+1
				End if 
			End for 
			$res:=Mod:C98($total;11)
			$dv:=11-$res
			If (($res=0) | ($res=1))
				$dv:=0
			End if 
			$0:=$codigo+String:C10($dv)
		Else 
			$0:=$codigo
	End case 
Else 
	$0:=$codigo
End if 