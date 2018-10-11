Case of 
	: (Form event:C388=On Load:K2:1)
		ActuaDatos_LOG_tabs:=New list:C375
		APPEND TO LIST:C376(ActuaDatos_LOG_tabs;__ ("Actualizaciones");1)
		APPEND TO LIST:C376(ActuaDatos_LOG_tabs;__ ("Configuraciones");2)
		SN3_LoadDataReceptionSettings 
		vt_apoderado:=""
		vl_selected_page:=1
		opc_1:=1
		opc_2:=0
		opc_3:=0
		
		vb_Hoy:=0
		vb_Mes:=1
		vb_Año:=0
		vb_Rango:=0
		vb_todo:=0
		
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		C_LONGINT:C283(vl_selected_page)
		
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vl_Año2:=Year of:C25(Current date:C33(*))
		vt_Fecha1:=String:C10(Current date:C33(*))
		vt_Fecha2:=String:C10(Current date:C33(*))
		vt_Fecha3:=String:C10(Current date:C33(*))
		
		$viniDate:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
		$vendDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
		
		SN3_ActuaDatos_LogArrays ("";$viniDate;$vendDate)
		
		OBJECT SET ENABLED:C1123(*;"vt_Mes";False:C215)
		OBJECT SET ENABLED:C1123(*;"bMes";False:C215)
		OBJECT SET ENABLED:C1123(*;"vl_Año2";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"vl_Año";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"vt_Fecha1";False:C215)
		OBJECT SET ENABLED:C1123(*;"vt_Fecha2";False:C215)
		OBJECT SET ENABLED:C1123(*;"fecha1";False:C215)
		OBJECT SET ENABLED:C1123(*;"fecha2";False:C215)
		
	: (Form event:C388=On Close Box:K2:21)
		
		UNLOAD RECORD:C212([xShell_Logs:37])
		REDUCE SELECTION:C351([xShell_Logs:37];0)
		
		ARRAY DATE:C224(ad_fecha;0)
		ARRAY TEXT:C222(at_padres;0)
		ARRAY TEXT:C222(at_encargado;0)
		
		ARRAY LONGINT:C221(al_recnum_hide;0)
		
		ARRAY TEXT:C222(at_persona;0)
		ARRAY TEXT:C222(at_campo;0)
		ARRAY TEXT:C222(at_antes;0)
		ARRAY TEXT:C222(at_sn3;0)
		ARRAY TEXT:C222(at_final;0)
		CANCEL:C270
End case 
