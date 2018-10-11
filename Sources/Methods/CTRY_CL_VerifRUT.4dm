//%attributes = {}
  //CTRY_CL_VerifRUT

$rut:=ST_GetCleanString ($1)
$rut:=ST_TrimLeadingChars ($rut;"0")
If (Count parameters:C259=2)
	$displayAlert:=$2
Else 
	$displayAlert:=True:C214
End if 

$0:=$rut
If ($rut#"")
	Case of 
		: (<>vtXS_CountryCode="cl")
			$rut:=Uppercase:C13($rut)
			$dv:=$rut[[Length:C16($rut)]]
			$rut:=Substring:C12(Replace string:C233(Replace string:C233($rut;".";"");"-";"");1;Length:C16($rut)-1)
			$m:=2
			$sum:=0
			For ($i;1;Length:C16($rut))
				$sum:=$sum+(Num:C11($rut[[Length:C16($rut)+1-$i]])*$m)
				$m:=$m+1
				If ($m=8)
					$m:=2
				End if 
			End for 
			$r:=String:C10(11-Mod:C98($sum;11))
			Case of 
				: ($r="11")
					$r:="0"
				: ($r="10")
					$r:="K"
			End case 
			If ($dv=$r)
				$0:=$rut+$dv
			Else 
				If ($displayAlert)
					CD_Dlog (0;__ ("RUT incorrecto."))
				End if 
				$0:=""
			End if 
			
		: (<>vtXS_CountryCode="uy")
			  //$rut:=CTRY_UY_VerifIDNacional ($rut;$displayAlert)
			$0:=CTRY_UY_VerifIDNacional ($rut;$displayAlert)  //20170802 RCH Se corrige valor devuelto
			
	End case 
End if 