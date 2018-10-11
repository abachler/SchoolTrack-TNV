Case of 
	: (Form event:C388=On Load:K2:1)
		C_DATE:C307(vdACT_fechaIntereses)
		C_TEXT:C284(vtACT_FechaInt;$vt_format)
		C_REAL:C285(cs_generarIntereses;bo_todos;bo_seleccionados)
		C_REAL:C285(cs_simple;cs_compuesto;vrACT_tasa)
		
		vdACT_fechaIntereses:=Current date:C33(*)
		vtACT_FechaInt:=String:C10(vdACT_fechaIntereses;7)
		cs_generarIntereses:=1
		
		cs_simple:=0
		cs_compuesto:=0
		vrACT_tasa:=0
		ACTexe_CambiarTasaInteres ("SetObjetosForm")
		
	: (Form event:C388=On Clicked:K2:4)
		ACTexe_CambiarTasaInteres ("SetObjetosForm")
		
End case 