Case of 
	: (Form event:C388=On Load:K2:1)
		ACTdte_EnvioPDFXMail ("InicializaVariables")
		ARRAY TEXT:C222($atACTdte_eMail;0)
		C_LONGINT:C283($l_indice)
		
		ARRAY LONGINT:C221($alACT_idsApdos;0)
		ARRAY LONGINT:C221($alACT_idsTerceros;0)
		
		SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;alACTdte_ID;[ACT_Boletas:181]Numero:11;alACTdte_Folio;[ACT_Boletas:181]ID_Apoderado:14;$alACT_idsApdos;[ACT_Boletas:181]ID_Tercero:21;$alACT_idsTerceros)
		
		For ($l_indice;1;Size of array:C274(alACTdte_ID))
			If ($alACT_idsApdos{$l_indice}#0)
				APPEND TO ARRAY:C911(atACTdte_Nombre;KRL_GetTextFieldData (->[Personas:7]No:1;->$alACT_idsApdos{$l_indice};->[Personas:7]Apellidos_y_nombres:30))
				APPEND TO ARRAY:C911(atACTdte_Tipo;"Apoderado")
				APPEND TO ARRAY:C911($atACTdte_eMail;KRL_GetTextFieldData (->[Personas:7]No:1;->$alACT_idsApdos{$l_indice};->[Personas:7]ACT_DTE_Enviar_Mail_Cuenta:111))
			Else 
				APPEND TO ARRAY:C911(atACTdte_Nombre;KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$alACT_idsTerceros{$l_indice};->[ACT_Terceros:138]Nombre_Completo:9))
				APPEND TO ARRAY:C911(atACTdte_Tipo;"Tercero")
				APPEND TO ARRAY:C911($atACTdte_eMail;KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$alACT_idsTerceros{$l_indice};->[ACT_Terceros:138]DTE_email_envio_dte:75))
			End if 
		End for 
		
		For ($l_indice;1;Size of array:C274($atACTdte_eMail))
			
			  //If (SMTP_VerifyEmailAddress ($atACTdte_eMail{$l_indice
			  //APPEND TO ARRAY(alACTdte_Colores;16711680)
			  //APPEND TO ARRAY(abACTdte_Enviar;False)
			  //Else 
			  //APPEND TO ARRAY(alACTdte_Colores;0)
			  //APPEND TO ARRAY(abACTdte_Enviar;True)
			  //End if };False)="")
			  //20150107 RCH validaciones más de una cuenta de correo.
			$atACTdte_eMail{$l_indice}:=ACTdte_VerificaEmail ($atACTdte_eMail{$l_indice};False:C215)
			If ($atACTdte_eMail{$l_indice}="")
				APPEND TO ARRAY:C911(alACTdte_Colores;16711680)
				APPEND TO ARRAY:C911(abACTdte_Enviar;False:C215)
			Else 
				APPEND TO ARRAY:C911(alACTdte_Colores;0)
				APPEND TO ARRAY:C911(abACTdte_Enviar;True:C214)
			End if 
		End for 
		
		  //ARRAY TEXT(atACTecc_Informes;0)
		ARRAY TEXT:C222(atACTbol_Informes;0)
		ARRAY LONGINT:C221(alACTbol_Informes;0)
		C_TEXT:C284($t_nombre)
		READ ONLY:C145([xShell_Reports:54])
		
		$t_nombre:="Factura Electrónica@"
		
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=(Table:C252(->[ACT_Boletas:181]));*)
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]Modulo:41="AccountTrack";*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportType:2="gSR2";*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportName:26=$t_nombre)
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
		ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
		SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACTbol_Informes;[xShell_Reports:54]ID:7;alACTbol_Informes)
		If (Size of array:C274(atACTbol_Informes)=0)
			APPEND TO ARRAY:C911(atACTbol_Informes;"No hay modelos llamados "+ST_Qte ($t_nombre)+".")
			APPEND TO ARRAY:C911(alACTbol_Informes;-1)
		End if 
		atACTbol_Informes:=1
		vr_idInformeSeleccionado:=alACTbol_Informes{atACTbol_Informes}
		
		  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, habilita pestaña para UY
		  //OBJECT SET VISIBLE(*;"fear_@";(<>gCountryCode="ar"))
		OBJECT SET VISIBLE:C603(*;"fear_@";(<>gCountryCode="ar") | (<>gCountryCode="uy"))
		
		ACTdte_EnvioPDFXMail ("SetEstadoObjetos")
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		ACTdte_EnvioPDFXMail ("SetEstadoObjetos")
		
End case 