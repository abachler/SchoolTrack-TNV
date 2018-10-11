$vt_Date2Gen:=Substring:C12(String:C10(vd_fecha;8);1;10)

If (op1=0)
	CD_Dlog (0;__ ("Debe estar en el estado automático para programar una fecha de generación del cono de ventas"))
Else 
	If (vd_fecha<Current date:C33(*))
		CD_Dlog (0;__ ("La fechas anterioriores a hoy no son válidas debido a que ya fueron ejecutas las tareas de inicio de día de hoy"))
	Else 
		
		If (($vt_Date2Gen#"") & ($vt_Date2Gen#"0000-00-00"))
			PREF_Set (-555;"ConodeVentasFechaGen";$vt_Date2Gen)
			PREF_Set (-555;"ConodeVentasCicloGen";vt_ciclo)
			$vt_eventlog:="Configuración para Generación del Cono de Ventas Fecha: "+$vt_Date2Gen+"."
			LOG_RegisterEvt ($vt_eventlog;-1;-1;<>lUSR_CurrentUserID;"Schootrack")
			QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Description:5="Configuración para Generación del Cono de Ventas@")
			ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
			REDUCE SELECTION:C351([xShell_Logs:37];1)
			If ([xShell_Logs:37]Module:8="Webservice")
				[xShell_Logs:37]UserName:2:="Usuario Web"
			End if 
			$vt_statusCono:=PREF_fGet (-555;"ConodeVentasStatus")
			vt_lastconfiggenCV:=$vt_statusCono+"\r"+"Fecha del Cono: "+$vt_Date2Gen+"\r"+"Configurado por: "+[xShell_Logs:37]UserName:2+" el "+String:C10([xShell_Logs:37]Event_Date:3)+" a las "+String:C10([xShell_Logs:37]Event_Time:4)+"\r"+"Desde: "+[xShell_Logs:37]Module:8
			
		Else 
			CD_Dlog (0;__ ("Los parámetros de Fecha y/o Ciclo no son correctos"))
		End if 
		
	End if 
End if 
