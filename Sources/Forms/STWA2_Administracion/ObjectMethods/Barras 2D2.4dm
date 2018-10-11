Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (lb_reemplazo>0)
			WDW_OpenFormWindow (->[xShell_Dialogs:114];"PopCalendar";-1;32;__ ("Calendario");"wdw_CloseDlog")
			DIALOG:C40([xShell_Dialogs:114];"PopCalendar")
			CLOSE WINDOW:C154
			If (oK=1)
				$d_fechaHasta:=dDate
			Else 
				$d_fechaHasta:=!00-00-00!
			End if 
			
			If ($d_fechaHasta#!00-00-00!)
				If ($d_fechaHasta<adSTWA2_fechadesde{lb_reemplazo})
					CD_Dlog (0;"La fecha de termino debe ser mayor o igual a la fecha de inicio.")
				Else 
					adSTWA2_fechahasta{lb_reemplazo}:=$d_fechaHasta
				End if 
			End if 
		End if 
End case 