  // Método: [xShell_Reports].Repositorio.SearchPicker
  //
  // 
  // creado por Alberto Bachler Klein
  // el 14/02/18, 17:21:32
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_LONGINT:C283($l_tipoComparacion)
C_POINTER:C301($y_palabrasCompletas;$y_search;$y_tipoComparacion)
C_TEXT:C284($t_items;$t_objectName;$t_refMenu;$t_textoEditado)

Case of 
	: (Form event:C388=20000)
		
	: (Form event:C388=On Load:K2:1)
		$t_objectName:=OBJECT Get name:C1087(Object current:K67:2)
		SearchPicker SET HELP TEXT ($t_objectName;"Nombre del informe")
		
	: (Form event:C388=On After Keystroke:K2:26)
		
End case 



