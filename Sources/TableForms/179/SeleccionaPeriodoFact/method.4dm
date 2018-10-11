Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_BOOLEAN:C305(vb_ocultarExportar)
		C_BOOLEAN:C305(vbACT_SoloMes)
		C_BOOLEAN:C305(vbACT_BuscaEnSel)
		C_TEXT:C284($vt_filter)
		C_BOOLEAN:C305(vbACTrz_InformePreparado)
		C_BOOLEAN:C305(vbACT_TextoCS)
		C_TEXT:C284(vtACT_TextoCS)
		vb_Hoy:=0
		vb_Mes:=1
		vb_Año:=0
		vb_Rango:=0
		cb_Archivo:=0
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vl_Año2:=Year of:C25(Current date:C33(*))
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		
		OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
		OBJECT SET ENTERABLE:C238(vl_Año2;True:C214)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;False:C215)
		_O_ENABLE BUTTON:C192(bMes)
		_O_DISABLE BUTTON:C193(bCalendar1)
		_O_DISABLE BUTTON:C193(bCalendar2)
		OBJECT SET VISIBLE:C603(cb_Archivo;Not:C34(vb_ocultarExportar))
		$vt_filter:="&9##"+<>tXS_RS_DateSeparator+"##"+<>tXS_RS_DateSeparator+"####"
		OBJECT SET FILTER:C235(*;"vt_Fecha@";$vt_filter)
		
		C_DATE:C307(vdACT_SelFecha1;vdACT_SelFecha2)
		If ((vdACT_SelFecha1#!00-00-00!) & (vdACT_SelFecha2#!00-00-00!))
			vd_Fecha1:=vdACT_SelFecha1
			vd_Fecha2:=vdACT_SelFecha2
			vb_Mes:=0
			vb_Rango:=1
			_O_DISABLE BUTTON:C193(bMes)
			_O_ENABLE BUTTON:C192(bCalendar1)
			_O_ENABLE BUTTON:C192(bCalendar2)
		End if 
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		IT_SetEnterable (vb_Mes=1;0;->vl_Año2)
		
		If (vbACT_SoloMes)
			_O_DISABLE BUTTON:C193(vb_Hoy)
			_O_DISABLE BUTTON:C193(vb_Año)
			_O_DISABLE BUTTON:C193(vb_Rango)
			_O_DISABLE BUTTON:C193(vl_Año)
			_O_DISABLE BUTTON:C193(vt_Fecha1)
			_O_DISABLE BUTTON:C193(vt_Fecha2)
		End if 
		
		Case of 
			: (vbACT_TextoCS)
				OBJECT SET TITLE:C194(cb_Archivo;vtACT_TextoCS)
				
			: (vbACT_BuscaEnSel)
				OBJECT SET TITLE:C194(cb_Archivo;__ ("Buscar en los registros listados"))
				
		End case 
		
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformes")
		If (cs_todasRazones=1)
			OBJECT MOVE:C664(*;"botones@";0;-40)
			C_LONGINT:C283($left;$top;$right;$buttom)
			GET WINDOW RECT:C443($left;$top;$right;$buttom)
			SET WINDOW RECT:C444($left;$top;$right;$buttom-40)
			REDRAW WINDOW:C456
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;vb_Rango=1)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;vb_Rango=1)
		OBJECT SET ENTERABLE:C238(vl_Año;vb_Año=1)
		OBJECT SET ENTERABLE:C238(vl_Año2;vb_Mes=1)
		OBJECT SET ENTERABLE:C238(vl_Año2;vb_Mes=1)
		If (vb_Mes=1)
			_O_ENABLE BUTTON:C192(bMes)
		Else 
			_O_DISABLE BUTTON:C193(bMes)
		End if 
		IT_SetEnterable (vb_Mes=1;0;->vl_Año2)
		If (vb_Rango=1)
			_O_ENABLE BUTTON:C192(bCalendar1)
			_O_ENABLE BUTTON:C192(bCalendar2)
		Else 
			_O_DISABLE BUTTON:C193(bCalendar1)
			_O_DISABLE BUTTON:C193(bCalendar2)
		End if 
		ACTcfg_OpcionesRazonesSociales ("SetObjetosInformesClick")
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		vd_Fecha1:=!00-00-00!
		vd_Fecha2:=!00-00-00!
		vdACT_SelFecha1:=!00-00-00!
		vdACT_SelFecha2:=!00-00-00!
		vbACTrz_InformePreparado:=False:C215
End case 
