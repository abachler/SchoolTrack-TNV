  //Searchpicker sample code
C_BOOLEAN:C305($Customise)
C_TEXT:C284($ObjectName;$t_Objeto)


Case of 
		
	: (Form event:C388=On Load:K2:1)
		
		  // Init the var itself
		  // this can be done anywhere else in your code
		C_TEXT:C284(vSearch)
		
		  // the let's customise the SearchPicker (if needed)
		
		$Customise:=True:C214
		
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		
		  // The exemple below shows how to set a label (ex : "name") inside the search zone
		
		If ($Customise)
			SearchPicker SET HELP TEXT ($ObjectName;"Name")
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		
		READ ONLY:C145([xShell_MensajesAplicacion:244])
		If (vSearch#"")
			QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]Mensaje:4=vSearch;*)
			QUERY:C277([xShell_MensajesAplicacion:244]; & ;[xShell_MensajesAplicacion:244]Componente:2=$t_Objeto)
		Else 
			ALL RECORDS:C47([xShell_MensajesAplicacion:244])
		End if 
End case 
