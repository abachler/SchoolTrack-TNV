//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 04/10/17, 16:53:42
  // ----------------------------------------------------
  // Método: QR_filtroBusqueda
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

  //para manejo de filtro de busqueda 12.3


C_TEXT:C284($t_accion)
C_BOOLEAN:C305($b_titulo;$b_tags;$b_Descripcion)
C_OBJECT:C1216($ob)
C_TEXT:C284($t_menu)

$t_accion:=$1
$y_ob:=$2
$y_resultado:=$3

Case of 
	: ($t_accion="CreaObjeto")
		$ob:=OB_Create 
		$b_titulo:=True:C214
		$b_Descripcion:=True:C214
		$b_tags:=True:C214
		OB_SET ($ob;->$b_titulo;"Titulo")
		OB_SET ($ob;->$b_Descripcion;"Descripcion")
		OB_SET ($ob;->$b_tags;"Tag")
		$y_resultado->:=$ob
		
	: ($t_accion="CreaMenu")
		
		$ob:=OB_Create 
		$ob:=$y_ob->
		OB_GET ($ob;->$b_titulo;"Titulo")
		OB_GET ($ob;->$b_Descripcion;"Descripcion")
		OB_GET ($ob;->$b_tags;"Tag")
		
		$t_menu:=Create menu:C408
		APPEND MENU ITEM:C411($t_menu;"Titulo")
		SET MENU ITEM PARAMETER:C1004($t_menu;1;"Titulo")
		If ($b_titulo)
			SET MENU ITEM MARK:C208($t_menu;1;Char:C90(18))
		Else 
			SET MENU ITEM MARK:C208($t_menu;1;"")
		End if 
		APPEND MENU ITEM:C411($t_menu;"Descripción")
		SET MENU ITEM PARAMETER:C1004($t_menu;2;"Descripción")
		If ($b_Descripcion)
			SET MENU ITEM MARK:C208($t_menu;2;Char:C90(18))
		Else 
			SET MENU ITEM MARK:C208($t_menu;2;"")
		End if 
		APPEND MENU ITEM:C411($t_menu;"Tags")
		SET MENU ITEM PARAMETER:C1004($t_menu;3;"Tags")
		If ($b_tags)
			SET MENU ITEM MARK:C208($t_menu;3;Char:C90(18))
		Else 
			SET MENU ITEM MARK:C208($t_menu;3;"")
		End if 
		$y_resultado->:=$t_menu
End case 

