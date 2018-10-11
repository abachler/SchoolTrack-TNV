  // [STR_Medicos].Editor.SearchPicker()
  // Por: Alberto Bachler K.: 01-07-14, 19:21:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_search)
C_TEXT:C284($t_objectName;$t_textoEditado)

Case of 
		
	: (Form event:C388=On Load:K2:1)
		$t_objectName:=OBJECT Get name:C1087(Object current:K67:2)
		SearchPicker SET HELP TEXT ($t_objectName;"Nombre o apellido")
		
	: (Form event:C388=On After Keystroke:K2:26)
		$y_search:=OBJECT Get pointer:C1124(Object named:K67:5;"SearchPicker")
		$t_textoEditado:="@"+Get edited text:C655+"@"
		READ ONLY:C145([STR_Medicos:89])
		If ($t_textoEditado#"")
			QUERY:C277([STR_Medicos:89];[STR_Medicos:89]Nombres:1=$t_textoEditado;*)
			QUERY:C277([STR_Medicos:89]; | ;[STR_Medicos:89]Apellidos:7=$t_textoEditado)
			ORDER BY:C49([STR_Medicos:89];[STR_Medicos:89]Apellidos:7;>;[STR_Medicos:89]Nombres:1;>)
		End if 
		
End case 
