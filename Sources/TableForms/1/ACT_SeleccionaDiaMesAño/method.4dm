Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		cb_XApdo:=1
		cb_XCta:=0
		cb_XCruzado:=0
		cb_SoloActivas:=1
		
		  //se crea variable para las deudas
		
		cb_SoloDeudas:=0
		cb_SoloDeudas:=Num:C11(PREF_fGet (0;"ACT_InformeMorosidadCuentasActivas";String:C10(cb_SoloDeudas)))
		
		
		b1:=0
		b2:=0
		b3:=1
		b4:=0
		b5:=0
		viAño:=Year of:C25(Current date:C33(*))
		viAño2:=viAño
		IT_SetButtonState (True:C214;->bMes)
		IT_SetEnterable (True:C214;0;->viAño)
		vi_SelectedMonth:=Month of:C24(Current date:C33(*))
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vt_Mes:=aMeses{vi_SelectedMonth}
		IT_SetEnterable (False:C215;0;->vt_Fecha1;->vt_Fecha2;->viAño2)
		IT_SetButtonState (False:C215;->bCalendar1;->bCalendar2)
		vd_Fecha1:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		COPY ARRAY:C226(<>atACT_ModosdePago;atACT_Modo_de_Pago)
		vt_Modo:="Todos"
		cb_AgruparPorCategorias:=0
		cb_considerarSoloPagosPeriodo:=0
		cb_incluirProtestado:=0
		OBJECT SET VISIBLE:C603(*;"pagosConsiderados@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pagosProtestados@";False:C215)
		Case of 
			: (vi_TipoInforme=1)
				OBJECT SET VISIBLE:C603(*;"Modo@";False:C215)
				OBJECT SET VISIBLE:C603(*;"Desglose@";True:C214)
				OBJECT SET VISIBLE:C603(tipoL_1;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_2;False:C215)
				cb_SoloActivas:=0
				cb_Desglosar:=1
				
			: (vi_TipoInforme=2)
				OBJECT SET VISIBLE:C603(*;"Modo@";True:C214)
				OBJECT SET VISIBLE:C603(*;"Desglose@";False:C215)
				OBJECT SET VISIBLE:C603(*;"pagosConsiderados@";True:C214)
				OBJECT SET VISIBLE:C603(*;"pagosProtestados@";True:C214)
				OBJECT SET TITLE:C194(cb_considerarSoloPagosPeriodo;__ ("Considerar opción seleccionada como fecha de corte para pagos"))
				OBJECT SET VISIBLE:C603(cb_XCruzado;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_1;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_2;False:C215)
				
			: (vi_TipoInforme=3)
				OBJECT SET VISIBLE:C603(*;"Por@";False:C215)
				OBJECT MOVE:C664(*;"li@";0;-89)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$bottom-89)
				OBJECT SET VISIBLE:C603(*;"Modo@";False:C215)
				OBJECT SET VISIBLE:C603(*;"Desglose@";False:C215)
				OBJECT SET VISIBLE:C603(cb_XCruzado;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_1;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_2;False:C215)
				
			: (vi_TipoInforme=4)
				OBJECT SET VISIBLE:C603(*;"Modo@";False:C215)
				OBJECT SET VISIBLE:C603(*;"Desglose@";False:C215)
				OBJECT SET VISIBLE:C603(cb_XCruzado;False:C215)
				OBJECT SET VISIBLE:C603(*;"pagosConsiderados@";True:C214)
				OBJECT SET VISIBLE:C603(*;"pagosProtestados@";True:C214)
				OBJECT SET TITLE:C194(cb_considerarSoloPagosPeriodo;__ ("Considerar último día de cada mes como fecha de corte para pagos"))
				OBJECT SET VISIBLE:C603(tipoL_1;False:C215)
				OBJECT SET VISIBLE:C603(tipoL_2;False:C215)
				
				IT_SetButtonState (False:C215;->b1;->b3;->b6)
				b1:=0
				b2:=0
				b3:=0
				b4:=0
				b5:=1
				IT_SetButtonState (False:C215;->bMes)
				IT_SetEnterable (False:C215;0;->viAño)
				IT_SetEnterable (True:C214;0;->viAño2)
				
			: (vi_TipoInforme=5)
				  //Listado detallado Cargos/Apodeardos
				
				tipoL_1:=1
				tipoL_2:=0
				
				OBJECT SET VISIBLE:C603(cb_XApdo;False:C215)
				OBJECT SET VISIBLE:C603(cb_XCruzado;False:C215)
				OBJECT SET VISIBLE:C603(cb_Xcta;False:C215)
				OBJECT SET VISIBLE:C603(cb_SoloActivas;False:C215)
				OBJECT SET VISIBLE:C603(cb_considerarSoloPagosPeriodo;False:C215)
				
				
				OBJECT SET VISIBLE:C603(*;"modo";False:C215)
				OBJECT SET VISIBLE:C603(*;"modo1";False:C215)
				OBJECT SET VISIBLE:C603(*;"modo2";False:C215)
				OBJECT SET VISIBLE:C603(*;"modo3";False:C215)
				OBJECT SET VISIBLE:C603(*;"desglose";False:C215)
				OBJECT SET VISIBLE:C603(*;"desglose1";False:C215)
		End case 
		C_BOOLEAN:C305(vbACT_MostrarFechaCorte)
		C_DATE:C307(vd_fechaCorte)
		OBJECT SET VISIBLE:C603(*;"pagosConsideradosF_@";False:C215)
		vd_fechaCorte:=Current date:C33(*)
		If (vbACT_MostrarFechaCorte)
			If (cb_considerarSoloPagosPeriodo=1)
				OBJECT SET VISIBLE:C603(*;"pagosConsideradosF_@";True:C214)
			Else 
			End if 
		End if 
		  //20140821 RCH El boton cuentas activas aparecia habilitado cuando estaba seleccionado apoderado
		IT_SetButtonState ((cb_XCta=1);->cb_SoloActivas)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Clicked:K2:4)
		IT_SetButtonState (cb_XApdo=1;->btn_FormasPago)
		If (cb_Desglosar=1)
			_O_ENABLE BUTTON:C192(cb_AgruparPorCategorias)
		Else 
			_O_DISABLE BUTTON:C193(cb_AgruparPorCategorias)
			cb_AgruparPorCategorias:=0
		End if 
		If (vbACT_MostrarFechaCorte)
			If ((cb_fechaSeleccionada=1) & (cb_considerarSoloPagosPeriodo=1))
				_O_ENABLE BUTTON:C192(*;"pagosConsideradosF_F_@")
			Else 
				_O_DISABLE BUTTON:C193(*;"pagosConsideradosF_F_@")
			End if 
		End if 
End case 
