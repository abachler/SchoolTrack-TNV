$vb_continuar:=True:C214

$mes:=Num:C11([Personas:7]ACT_MesVenc_TC:57)
$agno:=Num:C11([Personas:7]ACT_AñoVenc_TC:58)

If (($agno=0) & (Old:C35([Personas:7]ACT_AñoVenc_TC:58)#"0000"))
	$resp:=CD_Dlog (0;"¿Desea limpiar el año de vencimiento?";"";"Si";"No")
	If ($resp=1)
		[Personas:7]ACT_AñoVenc_TC:58:=""
		$vb_continuar:=False:C215
	End if 
End if 

If ($vb_continuar)
	
	If (($mes<1) | ($mes>12))
		CD_Dlog (0;__ ("El mes de vencimiento debe estar entre 1 y 12."))
		[Personas:7]ACT_MesVenc_TC:57:=Old:C35([Personas:7]ACT_MesVenc_TC:57)
	Else 
		If (([Personas:7]ACT_MesVenc_TC:57#"") & ([Personas:7]ACT_AñoVenc_TC:58#""))
			If ($agno<Year of:C25(Current date:C33(*)))
				CD_Dlog (0;__ ("El año de vencimiento no puede ser inferior al año actual."))
				[Personas:7]ACT_AñoVenc_TC:58:=Old:C35([Personas:7]ACT_AñoVenc_TC:58)
			Else 
				If ($agno=Year of:C25(Current date:C33(*)))
					If ($mes<Month of:C24(Current date:C33(*)))
						CD_Dlog (0;__ ("El mes de vencimiento no puede ser inferior al mes actual."))
						[Personas:7]ACT_MesVenc_TC:57:=Old:C35([Personas:7]ACT_MesVenc_TC:57)
					End if 
				End if 
			End if 
		End if 
	End if 
	
End if 