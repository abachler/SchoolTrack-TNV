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
		SearchPicker SET HELP TEXT ($t_objectName;"Nombre del informe")
		
	: (Form event:C388=On After Keystroke:K2:26)
		
End case 
