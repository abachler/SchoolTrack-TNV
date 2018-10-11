//%attributes = {}
  //ADTcfg_SaveItems

For ($i;1;Size of array:C274(alADT_ID))
	If ((atADT_Glosa{$i}#"") & (atADT_Moneda{$i}#"") & (arADT_Monto{$i}>=0))
		$item:=Find in field:C653([xxACT_Items:179]ID:1;alADT_ID{$i})
		If ($item#-1)
			READ WRITE:C146([xxACT_Items:179])
			GOTO RECORD:C242([xxACT_Items:179];$item)
			[xxACT_Items:179]Glosa:2:=atADT_Glosa{$i}
			[xxACT_Items:179]Moneda:10:=atADT_Moneda{$i}
			[xxACT_Items:179]Monto:7:=arADT_Monto{$i}
			[xxACT_Items:179]Afecto_IVA:12:=abADT_IVA{$i}
			[xxACT_Items:179]No_de_Cuenta_Contable:15:=asADT_CtaCta{$i}
			[xxACT_Items:179]CodAuxCta:27:=asADT_CodAuxCta{$i}
			[xxACT_Items:179]Centro_de_Costos:21:=asADT_CentroCta{$i}
			[xxACT_Items:179]No_CCta_contable:22:=asADT_CtaCCta{$i}
			[xxACT_Items:179]CodAuxCCta:28:=asADT_CodAuxCCta{$i}
			[xxACT_Items:179]CCentro_de_costos:23:=asADT_CentroCCta{$i}
			SAVE RECORD:C53([xxACT_Items:179])
		End if 
	End if 
End for 
KRL_UnloadReadOnly (->[xxACT_Items:179])