Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (lb_reemplazo>0)
			WDW_OpenFormWindow (->[xShell_Dialogs:114];"PopCalendar";-1;32;__ ("Calendario");"wdw_CloseDlog")
			DIALOG:C40([xShell_Dialogs:114];"PopCalendar")
			CLOSE WINDOW:C154
			If (oK=1)
				$d_fechaDesde:=dDate
			Else 
				$d_fechaDesde:=!00-00-00!
			End if 
			If ($d_fechaDesde#!00-00-00!)
				If ($d_fechaDesde>adSTWA2_fechahasta{lb_reemplazo})
					CD_Dlog (0;"La fecha de inicio debe ser menor o igual a la fecha de termino.")
				Else 
					adSTWA2_fechadesde{lb_reemplazo}:=$d_fechaDesde
				End if 
			End if 
		End if 
End case 