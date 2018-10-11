  //Searchpicker sample code

Case of 
		
	: (Form event:C388=On Load:K2:1)
		
		  // Init the var itself
		  // this can be done anywhere else in your code
		  //C_TEXT(vSearch)
		
		  // the let's customise the SearchPicker (if needed)
		
		C_BOOLEAN:C305($Customise)
		$Customise:=True:C214
		
		C_TEXT:C284($ObjectName)
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		
		  // The exemple below shows how to set a label (ex : "name") inside the search zone
		If ($Customise)
			SearchPicker SET HELP TEXT ($ObjectName;"Subsector")
		End if 
		
		
	: (Form event:C388=On Data Change:K2:15)
		$y_search:=OBJECT Get pointer:C1124(Object named:K67:5;"SearchPicker")
		READ ONLY:C145([xxSTR_Materias:20])
		If ($y_search->#"")
			QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2="@"+$y_search->+"@")
		Else 
			ALL RECORDS:C47([xxSTR_Materias:20])
		End if 
		
		POST KEY:C465(Character code:C91("y");Command key mask:K16:1+Shift key mask:K16:3)
		
		LISTBOX SELECT ROW:C912(*;"lb_Materias";0;lk remove from selection:K53:3)
		OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("MateriasSeleccionadas")>0)
End case 
