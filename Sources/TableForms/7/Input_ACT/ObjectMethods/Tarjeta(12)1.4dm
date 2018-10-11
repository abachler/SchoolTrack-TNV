$vb_continuar:=True:C214

$mes:=Num:C11([Personas:7]ACT_MesVenc_TD:102)
$agno:=Num:C11([Personas:7]ACT_AñoVenc_TD:100)
If (($mes=0) & (Old:C35([Personas:7]ACT_MesVenc_TD:102)#"00"))
	$resp:=CD_Dlog (0;"¿Desea limpiar el mes de vencimiento?";"";"Si";"No")
	If ($resp=1)
		[Personas:7]ACT_MesVenc_TD:102:=""
		$vb_continuar:=False:C215
	End if 
End if 

If ($vb_continuar)
	If (($mes<1) | ($mes>12))
		CD_Dlog (0;__ ("El mes de vencimiento debe estar entre 1 y 12."))
		[Personas:7]ACT_MesVenc_TD:102:=Old:C35([Personas:7]ACT_MesVenc_TD:102)
	Else 
		If (([Personas:7]ACT_MesVenc_TD:102#"") & ([Personas:7]ACT_AñoVenc_TD:100#""))
			If ($agno<Year of:C25(Current date:C33(*)))
				CD_Dlog (0;__ ("El año de vencimiento no puede ser inferior al año actual."))
				[Personas:7]ACT_AñoVenc_TD:100:=Old:C35([Personas:7]ACT_AñoVenc_TD:100)
			Else 
				If ($agno=Year of:C25(Current date:C33(*)))
					If ($mes<Month of:C24(Current date:C33(*)))
						CD_Dlog (0;__ ("El mes de vencimiento no puede ser inferior al mes actual."))
						[Personas:7]ACT_MesVenc_TD:102:=Old:C35([Personas:7]ACT_MesVenc_TD:102)
					End if 
				End if 
			End if 
		End if 
	End if 
End if 