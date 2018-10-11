C_LONGINT:C283($table)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_PageNumber:=1
		
		  //defectos para página 1
		
		vdACT_FEmisionBol:=Current date:C33(*)
		vtACT_FEmisionBol:=String:C10(vdACT_FEmisionBol;7)
		
		ACTbol_CargaDiasVencimiento ("CargaVars")
		OBJECT SET VISIBLE:C603(*;"FVenc@";(lACTbol_DiaVencimientoSel#0))
		
		  // defectos pagina 2 (emision/impresión)
		b1:=1
		b2:=0
		b3:=0
		bHidePrintSettings:=1
		
		$table:=Table:C252(->[ACT_Boletas:181])*-1
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ID:7=vlACT_ModRecibo)
		IT_SetButtonState (((Records in selection:C76([xShell_Reports:54])>0) & (vlACT_ModRecibo#0));->b2)
		
		  // defectos página 3 (seleccion del universo)
		
		viACT_registros1:=0
		viACT_registros2:=0
		viACT_registros3:=0
		
		ACTbol_BoletasUniverso 
		
		  //Defectos pagina 4 (agregacion)
		h1:=1
		h2:=0
		h3:=0
		h4:=0
		s1:=1
		s2:=0
		i1:=0
		i2:=1
		OBJECT SET VISIBLE:C603(i1;False:C215)
		If (IT_AltKeyIsDown )
			OBJECT SET VISIBLE:C603(i1;True:C214)
		End if 
		
		e1:=cb_EmiteXApoderado
		e2:=cb_EmiteXCuenta
		e3:=0
		
		vt_pagos1:="Se emitirán documentos agrupando pagos por período de tiempo para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+"."+" Sólo se considerarán aquellos pagos no incluídos en otro documento tributario."
		vt_impagos:="Se emitirán documentos agrupando avisos de cobranza con saldos impagos por períod"+"o de tiempo para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Los montos pagados no serán considerados indepen"+"diente de si están asociados o no a un documento tributario."
		vt_total:="Se emitirán documentos agrupando avisos de cobranza por período de tiempo para ca"+"da "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", por el total de los avisos de cobranza, pero no considerando aquell"+"os pagos incluídos en otros documentos tributarios."
		
		vt_pagos2:="Se emitirá un documento por el total de los pagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Sólo se co"+"nsiderarán aquellos pagos no incluídos en otro documento tributario."
		vt_impagos1:="Se emitirá un documento por el total de los saldos impagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". L"+"os montos pagados no serán considerados independiente de si están asociados o no "+"a un documento tributario."
		vt_total1:="Se emitirá un documento por el total de los avisos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", pero no c"+"onsiderando aquellos pagos incluídos en otros documentos tributarios."
		
		vt_pagos3:="Se emitirá un documento por cada pago para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+".  Sólo se considerarán "+"aquellos pagos no incluídos en otro documento tributario."
		vt_impagos2:="Se emitirá un documento por cada aviso de cobranza con saldos impagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Los montos pagados no serán considerados independiente de si están asoc"+"iados o no a un documento tributario."
		vt_total2:="Se emitirá un documento por cada aviso de cobranza para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", pero no c"+"onsiderando aquellos pagos incluídos en otros documentos tributarios."
		
		If (Table:C252(yBWR_CurrentTable)#Table:C252(->[ACT_Pagos:172]))
			OBJECT SET VISIBLE:C603(*;"emitirX@";True:C214)
			OBJECT SET VISIBLE:C603(*;"impagos@";(i1=1))
			OBJECT SET VISIBLE:C603(*;"total@";(i2=1))
			OBJECT SET VISIBLE:C603(*;"pagos@";False:C215)
			IT_SetButtonState (True:C214;->s1;->s2)
			
			OBJECT SET VISIBLE:C603(e4;False:C215)
			
			POST KEY:C465(Character code:C91("+");256)
		Else 
			OBJECT SET VISIBLE:C603(*;"emitirX@";True:C214)
			OBJECT SET VISIBLE:C603(*;"impagos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"total@";False:C215)
			OBJECT SET VISIBLE:C603(*;"avisos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"pagos@";True:C214)
			OBJECT MOVE:C664(*;"acumular@";0;-28)
			OBJECT MOVE:C664(*;"pagos@";0;-28)
			OBJECT MOVE:C664(*;"pagosexp";0;28)
			OBJECT MOVE:C664(*;"emitirX@";0;-28)
			OBJECT SET TITLE:C194(h3;__ ("Un documento por cada pago"))
			OBJECT SET VISIBLE:C603(e4;True:C214)
		End if 
		
		  //20131216 RCH. Genera archivos al emitir documentos.
		C_REAL:C285(bGenerarCFDI)
		C_TEXT:C284(vtACT_ErrorStringForm)
		C_LONGINT:C283($l_registros)
		bGenerarCFDI:=0
		vtACT_ErrorStringForm:=""
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ((<>gCountryCode="mx") & ($l_registros>0))
			OBJECT SET VISIBLE:C603(*;"bGenerarCFDImx_@";True:C214)
			bGenerarCFDI:=Num:C11(PREF_fGet (0;"ACT_PrefGeneracionCFDIAlEmitir";String:C10(bGenerarCFDI)))
		Else 
			OBJECT SET VISIBLE:C603(*;"bGenerarCFDImx_@";False:C215)
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		vt_pagos1:="Se emitirán documentos agrupando pagos por período de tiempo para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+"."+" Sólo se considerarán aquellos pagos no incluídos en otro documento tributario."
		vt_impagos:="Se emitirán documentos agrupando avisos de cobranza con saldos impagos por períod"+"o de tiempo para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Los montos pagados no serán considerados indepen"+"diente de si están asociados o no a un documento tributario."
		vt_total:="Se emitirán documentos agrupando avisos de cobranza por período de tiempo para ca"+"da "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", por el total de los avisos de cobranza, pero no considerando aquell"+"os pagos incluídos en otros documentos tributarios."
		
		vt_pagos2:="Se emitirá un documento por el total de los pagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Sólo se co"+"nsiderarán aquellos pagos no incluídos en otro documento tributario."
		vt_impagos1:="Se emitirá un documento por el total de los saldos impagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". L"+"os montos pagados no serán considerados independiente de si están asociados o no "+"a un documento tributario."
		vt_total1:="Se emitirá un documento por el total de los avisos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", pero no c"+"onsiderando aquellos pagos incluídos en otros documentos tributarios."
		
		vt_pagos3:="Se emitirá un documento por cada pago para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+".  Sólo se considerarán "+"aquellos pagos no incluídos en otro documento tributario."
		vt_impagos2:="Se emitirá un documento por cada aviso de cobranza con saldos impagos para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+". Los montos pagados no serán considerados independiente de si están asoc"+"iados o no a un documento tributario."
		vt_total2:="Se emitirá un documento por cada aviso de cobranza para cada "+ST_Boolean2Str (e3=1;"tercero";ST_Boolean2Str (e1=1;"apoderado";"cuenta"))+", pero no c"+"onsiderando aquellos pagos incluídos en otros documentos tributarios."
		
		IT_SetButtonState (Not:C34(e4=1);->s1;->s2;->h1;->h3)
		
	: (Form event:C388=On Close Box:K2:21)
		If (FORM Get current page:C276=5)
			  //Case of 
			  //: (b1=1)
			  //CD_Dlog (0;"Los documentos tributarios fueron emitidos con éxito ")
			  //: (b2=1)
			  //CD_Dlog (0;"Los recibos fueron emitidos con éxito.")
			  //: (b3=1)
			  //CD_Dlog (0;"Los recibos fueron reemplazados con éxito.")
			  //End case 
		End if 
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		ALP_SetInterface (xALP_Docs2Print)
		
End case 
