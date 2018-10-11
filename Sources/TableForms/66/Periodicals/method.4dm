Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET TITLE:C194(*;"cancelar";__ ("Cancelar"))
		OBJECT SET TITLE:C194(*;"guardar";__ ("Guardar"))
		OBJECT SET TITLE:C194(*;"eliminar";__ ("Eliminar"))
		
		RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
		If (Is new record:C668([BBL_Registros:66]))
			[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
			[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
			[BBL_Registros:66]StatusID:34:=Disponible
			BBLreg_GeneraCodigoBarra 
		Else 
			If ([BBL_Registros:66]Status:10#"")
				
			Else 
				[BBL_Registros:66]StatusID:34:=Disponible
			End if 
		End if 
		
		OBJECT SET ENTERABLE:C238([BBL_Registros:66]Código_de_barra:20;False:C215)
		viBBL_BarCodeEnterable:=0
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
		
		HIGHLIGHT TEXT:C210([BBL_Registros:66]Número_de_volumen:19;81;81)
		
	: (Form event:C388=On Close Box:K2:21)
		BWR_OnCloseBoxFormEvent (->[BBL_Registros:66])
End case 
