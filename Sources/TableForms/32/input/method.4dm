Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (Is new record:C668([BU_Buses_Mantencion:32]))
			[BU_Buses_Mantencion:32]Numero:1:=SQ_SeqNumber (->[BU_Buses_Mantencion:32]Numero:1)
			[BU_Buses_Mantencion:32]Patente_Bus:2:=vtPatenteBus
		End if 
		LIST TO ARRAY:C288("STR_BUTipoMant";atTipoMant)
		LIST TO ARRAY:C288("STR_BUMantOper";atOperacion)
		BWR_SetInputButtonsAppearence 
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 