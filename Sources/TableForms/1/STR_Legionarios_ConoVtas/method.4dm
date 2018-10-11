
Case of 
	: (Form event:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(at_ciclos;0)
		C_TEXT:C284(vt_lastconfiggenCV;vt_ciclo;vt_fecha;$vt_statusCono;vt_WsFecha)
		C_LONGINT:C283($i;$año)
		
		vt_lastconfiggenCV:=""
		vt_fecha:=""
		vd_fecha:=!00-00-00!
		
		$vt_statusCono:=PREF_fGet (-555;"ConodeVentasStatus")
		If ($vt_statusCono="Auto@")
			op1:=1
			op2:=0
		Else 
			If ($vt_statusCono="")
				PREF_Set (-555;"ConodeVentasStatus";"Manual "+String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*)))
				$vt_statusCono:=PREF_fGet (-555;"ConodeVentasStatus")
			End if 
			op1:=0
			op2:=1
		End if 
		
		vt_lastconfiggenCV:="Estado del Cono de Ventas: "+$vt_statusCono+"\r"
		
		QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Event_Description:5="Configuración para Generación del Cono de Ventas@")
		ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]DTS:12;<;[xShell_Logs:37]SequenceID:10;<)
		REDUCE SELECTION:C351([xShell_Logs:37];1)
		If ([xShell_Logs:37]Module:8="Webservice")
			[xShell_Logs:37]UserName:2:="Usuario Web"
		End if 
		$vt_Date2Gen:=PREF_fGet (-555;"ConodeVentasFechaGen")
		  //$vt_Ciclo2Gen:=PREF_fGet (-555;"ConodeVentasCicloGen")
		vt_WsFecha:=PREF_fGet (-555;"WSMXLEG_Fecha")
		
		If (Records in selection:C76([xShell_Logs:37])=0)
			vt_lastconfiggenCV:=vt_lastconfiggenCV+"No existe ninguna configuración establecida para la generación del Cono de Ventas"
		Else 
			vt_lastconfiggenCV:=vt_lastconfiggenCV+"Fecha del Cono: "+$vt_Date2Gen+"\r"+"Configurado por: "+[xShell_Logs:37]UserName:2+" el "+String:C10([xShell_Logs:37]Event_Date:3)+" a las "+String:C10([xShell_Logs:37]Event_Time:4)+"\r"+"Desde: "+[xShell_Logs:37]Module:8
		End if 
		
		  //utilizado para el ciclo manual
		  //$año:=Year of(Current date(*))-2
		  //For ($i;1;4)
		  //APPEND TO ARRAY(at_ciclos;String($año)+"-"+String($año+1))
		  //$año:=$año+1
		  //End for 
		
End case 