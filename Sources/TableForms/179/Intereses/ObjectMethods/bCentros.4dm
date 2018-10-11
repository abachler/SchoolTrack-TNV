ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;1)
<>aChoicePtrs{1}:=-><>asACT_Centro
TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1;->vsACT_CentroIntereses)
If (ok=1)
	If ((vsACT_CentroIntereses#<>asACT_Centro{choiceIdx}) | (Macintosh command down:C546 | Windows Ctrl down:C562))
		vsACT_CentroIntereses:=<>asACT_Centro{choiceIdx}
		vtMsg:="Usted modificó el código de centro de costo para los intereses."+"\r"+"Si lo desea puede aplicar el nuevo código a los intereses ya generados o bien uti"+"liz"+"ar este nuevo código sólo para los intereses que se generen de ahora en adelante."
		vtDesc1:="El código de centro de costos es modificado, pero sólo será aplicado a los nuevos"+" "+"intereses que se generen."
		vtDesc2:="Se asigna el nuevo código a los intereses ya generados."
		vtBtn1:="Sólo para los nuevos intereses"
		vtBtn2:="Aplicar también a los intereses ya generados"
		WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
		If (ok=1)
			If (r2=1)
				READ WRITE:C146([ACT_Cargos:173])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1)
				$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en intereses..."))
				_O_ARRAY STRING:C218(80;asNCta;0)
				_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Cargos:173]))
				AT_Populate (->asNCta;->vsACT_CentroIntereses)
				  //0xDev_AvoidTriggerExecution (True)
				ARRAY TO SELECTION:C261(asNCta;[ACT_Cargos:173]Centro_de_costos:15)
				  //0xDev_AvoidTriggerExecution (False)
				AT_Initialize (->asNCta)
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				IT_UThermometer (-2;$proc)
			End if 
		End if 
	End if 
End if 