
Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283(vl_IDLogs)
		vl_IDLogs:=0
		C_LONGINT:C283($vl_Column;$vl_row)
		C_POINTER:C301($vy_pointer1)
		C_BOOLEAN:C305($vb_calculaMontos)
		LISTBOX GET CELL POSITION:C971(lb_log;$vl_Column;$vl_row;$vy_pointer1)
		SELECTION TO ARRAY:C260([xxBBL_Logs:41]ID:4;$al_IDLogs)
		CUT NAMED SELECTION:C334([xxBBL_Logs:41];"Logs")
		QUERY:C277([xxBBL_Logs:41];[xxBBL_Logs:41]ID:4=$al_IDLogs{$vl_row})
		vl_IDLogs:=[xxBBL_Logs:41]ID:4
		If ([xxBBL_Logs:41]ID_TipoEvento:5=Prestamo)
			OBJECT SET ENABLED:C1123(bPrint_Informe;True:C214)
		Else 
			OBJECT SET ENABLED:C1123(bPrint_Informe;False:C215)
		End if 
		USE NAMED SELECTION:C332("Logs")
		
End case 