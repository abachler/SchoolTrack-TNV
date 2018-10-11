ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;3)
<>aChoicePtrs{1}:=-><>asACT_CuentaCta
<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
<>aChoicePtrs{3}:=-><>asACT_GlosaCta
TBL_ShowChoiceList (0;"Seleccione la Cuenta";2;->vtACT_CCPCAFecha)
If (ok=1)
	If ((vtACT_CCPCAFecha#<>asACT_CuentaCta{choiceIdx}) | (vtACT_CAUXCCCAFecha#<>asACT_CodAuxCta{choiceIdx}) | (Windows Ctrl down:C562 | Macintosh command down:C546))
		vtACT_CCPCAFecha:=<>asACT_CuentaCta{choiceIdx}
		vtACT_CAUXCCCAFecha:=<>asACT_CodAuxCta{choiceIdx}
		vtMsg:="Usted modificó el código de plan de cuentas de los documentos a "+"fecha."+"\r"+"Si lo desea puede aplicar el nuevo código a los documentos ya ingresados o bien u"+"tiliz"+"ar este nuevo código sólo para los docuementos que se ingresen de ahora en adelan"+"te."
		vtDesc1:="El código de plan de cuentas  es modificado, pero sólo será aplic"+"ado a los nuevos "+"documentos que se ingresen."
		vtDesc2:="Se asigna el nuevo código a los documentos ya ingresados."
		vtBtn1:="Sólo para los nuevos documentos"
		vtBtn2:="Aplicar también a los documentos ya ingresados"
		WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
		If (ok=1)
			If (r2=1)
				READ WRITE:C146([ACT_Pagos:172])
				READ ONLY:C145([ACT_Documentos_de_Pago:176])
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]En_cartera:34=True:C214;*)
				  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Estado="A Fecha@")
				QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13>[ACT_Documentos_de_Pago:176]FechaPago:4)
				KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
				$proc:=IT_UThermometer (1;0;__ ("Actualizando información contable en documentos a fecha..."))
				_O_ARRAY STRING:C218(80;asNCta;0)
				_O_ARRAY STRING:C218(80;asNCta;Records in selection:C76([ACT_Pagos:172]))
				_O_ARRAY STRING:C218(80;asCACta;0)
				_O_ARRAY STRING:C218(80;asCACta;Records in selection:C76([ACT_Pagos:172]))
				AT_Populate (->asNCta;->vtACT_CCPCAFecha)
				AT_Populate (->asCACta;->vtACT_CAUXCCCAFecha)
				  //0xDev_AvoidTriggerExecution (True)
				ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]No_CCta_Contable:19;asCACta;[ACT_Pagos:172]CodAuxCCta:23)
				  //0xDev_AvoidTriggerExecution (False)
				AT_Initialize (->asNCta;->asCACta)
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
				IT_UThermometer (-2;$proc)
			End if 
			vtACT_CCPCAFechaCurrState:=vtACT_CCPCAFecha
			vtACT_CAUXCCCAFechaCurrState:=vtACT_CAUXCCCAFecha
		Else 
			vtACT_CCPCAFecha:=vtACT_CCPCAFechaCurrState
			vtACT_CAUXCCCAFecha:=vtACT_CAUXCCCAFechaCurrState
		End if 
	End if 
End if 