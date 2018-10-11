//%attributes = {}
  //ACTbol_ResumenDocs2Print

If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
	Case of 
		: (b1=1)
			ACTbol_EMasivaDocTribs4Pagos 
			ACTbol_validaInfo ("ACTbolDeclaraArreglosMetodo")
		: (b2=1)
			ACTbol_EMasivaRecibos4Pagos 
		: (b3=1)
			
	End case 
Else 
	Case of 
		: (b1=1)
			ACTbol_EMasivaDocTribs 
			xALP_Set_ACT_Docs2Print 
			ACTbol_validaInfo ("ACTbolDeclaraArreglosMetodo")
		: (b2=1)
			ACTbol_EMasivaRecibos 
		: (b3=1)
			
	End case 
End if 