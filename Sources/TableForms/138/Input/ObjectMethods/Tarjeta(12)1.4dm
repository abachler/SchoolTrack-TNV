$mes:=Num:C11([ACT_Terceros:138]RC_VencMesTD:71)
$agno:=Num:C11([ACT_Terceros:138]RC_VencAgnoTD:70)
If (($mes<1) | ($mes>12))
	CD_Dlog (0;__ ("El mes de vencimiento debe estar entre 1 y 12."))
	[ACT_Terceros:138]RC_VencMesTD:71:=Old:C35([ACT_Terceros:138]RC_VencMesTD:71)
Else 
	If (([ACT_Terceros:138]RC_VencMesTD:71#"") & ([ACT_Terceros:138]RC_VencAgnoTD:70#""))
		If ($agno<Year of:C25(Current date:C33(*)))
			CD_Dlog (0;__ ("El año de vencimiento no puede ser inferior al año actual."))
			[ACT_Terceros:138]RC_VencAgnoTD:70:=Old:C35([ACT_Terceros:138]RC_VencAgnoTD:70)
		Else 
			If ($agno=Year of:C25(Current date:C33(*)))
				If ($mes<Month of:C24(Current date:C33(*)))
					CD_Dlog (0;__ ("El mes de vencimiento no puede ser inferior al mes actual."))
					[ACT_Terceros:138]RC_VencMesTD:71:=Old:C35([ACT_Terceros:138]RC_VencMesTD:71)
				End if 
			End if 
		End if 
	End if 
End if 