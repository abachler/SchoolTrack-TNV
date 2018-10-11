ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;1)
<>aChoicePtrs{1}:=-><>asACT_Centro
TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1;->vtACT_CCCAFecha)
If (ok=1)
	If ((vtACT_CCCAFecha#<>asACT_Centro{choiceIdx}) | (Windows Ctrl down:C562 | Macintosh command down:C546))
		vtACT_CCCAFecha:=<>asACT_Centro{choiceIdx}
		vtMsg:="Usted modificó el código de centro de costos de los documentos a fecha."+"\r"+"Si lo desea puede aplicar el nuevo código a los documentos ya ingresados o bien u"+"tiliz"+"ar este nuevo código sólo para los docuementos que se ingresen de ahora en adelan"+"te."
		vtDesc1:="El código de centros de costos es modificado, pero sólo será aplicado a los nuevo"+"s "+"documentos que se ingresen."
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
				AT_Populate (->asNCta;->vtACT_CCCAFecha)
				  //0xDev_AvoidTriggerExecution (True)
				ARRAY TO SELECTION:C261(asNCta;[ACT_Pagos:172]Centro_de_costos:17)
				  //0xDev_AvoidTriggerExecution (False)
				AT_Initialize (->asNCta)
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
				IT_UThermometer (-2;$proc)
			End if 
			vtACT_CCCAFechaCurrState:=vtACT_CCCAFecha
		Else 
			vtACT_CCCAFecha:=vtACT_CCCAFechaCurrState
		End if 
	End if 
End if 