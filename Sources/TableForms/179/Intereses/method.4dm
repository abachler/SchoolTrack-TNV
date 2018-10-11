Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateInteresRecord 
		End if 
		vtACT_GlosaIntereses:=[xxACT_Items:179]Glosa:2
		vtACT_GlosaImpIntereses:=[xxACT_Items:179]Glosa_de_Impresión:20
		vsACT_CtaIntereses:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vsACT_CentroIntereses:=[xxACT_Items:179]Centro_de_Costos:21
		vsACT_CCtaIntereses:=[xxACT_Items:179]No_CCta_contable:22
		vsACT_CCentroIntereses:=[xxACT_Items:179]CCentro_de_costos:23
		vsACT_CodIntereses:=[xxACT_Items:179]CodAuxCta:27
		vsACT_CCodIntereses:=[xxACT_Items:179]CodAuxCCta:28
		cbACT_AfectoIVAIntereses:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
		cbACT_NoIncluirDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
		cbACT_AgruparenAC:=Num:C11([xxACT_Items:179]AgruparInteresesAC:33)
		cbACT_AgruparenDT:=Num:C11([xxACT_Items:179]AgruparInteresesDT:34)
		b1:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 1)
		b2:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 2)
		b3:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 3)
		b4:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 4)
		vtACT_GlosaInteresesIni:=vtACT_GlosaIntereses
		vtACT_GlosaImpInteresesIni:=vtACT_GlosaImpIntereses
		vsACT_CtaInteresesIni:=vsACT_CtaIntereses
		vsACT_CentroInteresesIni:=vsACT_CentroIntereses
		vsACT_CCtaInteresesIni:=vsACT_CCtaIntereses
		vsACT_CCentroInteresesIni:=vsACT_CCentroIntereses
		vsACT_CodInteresesIni:=vsACT_CodIntereses
		vsACT_CCodInteresesIni:=vsACT_CCodIntereses
		cbACT_AfectoIVAInteresesIni:=cbACT_AfectoIVAIntereses
		cbACT_NoIncluirDocTribIni:=cbACT_NoIncluirDocTrib
		cbACT_AgruparenACIni:=cbACT_AgruparenAC
		cbACT_AgruparenDTIni:=cbACT_AgruparenDT
		b1Ini:=b1
		b2Ini:=b2
		b3Ini:=b3
		b4Ini:=b4
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
