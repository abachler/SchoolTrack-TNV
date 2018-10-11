Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_AltoEnzabezado:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"EspacioEncabezado"))
		bcIncluyeAreas:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"SecciónArea"))
		bcOcultaAreas:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"OcultarSecciónArea"))
		bcIncluyeEjes:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"SecciónEjes"))
		bcOcultaEje:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"OcultarSecciónEjes"))
		bcIncluyeDimensiones:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"SecciónDimension"))
		bcOcultaDimensiones:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"OcultarSecciónDimension"))
		bcImprimirSoloConLogros:=Num:C11(NV_GetValueFromTextArray (->aObjectParameters;"OcultarAsignaturas"))
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 