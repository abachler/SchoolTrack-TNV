Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vb_Hoy:=0
		vb_Mes:=1
		vb_Año:=0
		vb_Rango:=0
		vt_Documento:=""
		vl_DocID:=0
		cb_Agrupar:=0
		cb_IncluirDA:=0
		$recNumReport:=Record number:C243([xShell_Reports:54])
		$readonlystate:=Read only state:C362([xShell_Reports:54])
		ACTcfg_LoadConfigData (8)
		If ($readonlystate)
			READ ONLY:C145([xShell_Reports:54])
		Else 
			READ WRITE:C146([xShell_Reports:54])
		End if 
		GOTO RECORD:C242([xShell_Reports:54];$recNumReport)
		ARRAY TEXT:C222(atACT_DocsPopup;0)
		ARRAY LONGINT:C221(alACT_DocsIDs;0)
		ARRAY TEXT:C222(atACT_DocsIDsCats;0)
		For ($i;1;Size of array:C274(aiACT_Tipo))
			  //20160831 AOQ 165435-166420-166980
			  //If (aiACT_Tipo{$i}=1)
			AT_Insert (0;1;->atACT_DocsPopup;->alACT_DocsIDs)
			atACT_DocsPopup{Size of array:C274(atACT_DocsPopup)}:=atACT_NombreDoc{$i}
			alACT_DocsIDs{Size of array:C274(alACT_DocsIDs)}:=alACT_IDDT{$i}
			APPEND TO ARRAY:C911(atACT_DocsIDsCats;String:C10(alACT_IDCat{$I})+";"+String:C10(Num:C11(abACT_Afecta{$I})))
			  //End if 
		End for 
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vt_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))
		vl_Añom:=Year of:C25(Current date:C33(*))
		vd_Fecha1:=Current date:C33(*)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		IT_SetButtonState (False:C215;->vb_Hoy;->vb_Mes;->vb_Año;->vb_Rango;->bCalendar1;->bCalendar2;->bMes;->bAccept)
		OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
		OBJECT SET ENTERABLE:C238(vl_Añom;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha1;False:C215)
		OBJECT SET ENTERABLE:C238(vt_Fecha2;False:C215)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
