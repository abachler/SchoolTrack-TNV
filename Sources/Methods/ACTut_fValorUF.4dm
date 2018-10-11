//%attributes = {}
  //ACTut_fValorUF

C_BOOLEAN:C305($vb_LoadfromDB)
C_DATE:C307($date;$1)
C_TEXT:C284($UFTableRef;vt_CurrentUFTableRef)
$date:=$1
If (Count parameters:C259=2)
	$vb_LoadfromDB:=$2
End if 

If (<>vtXS_CountryCode="cl")
	$0:=ACTmon_ObtieneValor ("UF";$date)
Else 
	$0:=0
End if 