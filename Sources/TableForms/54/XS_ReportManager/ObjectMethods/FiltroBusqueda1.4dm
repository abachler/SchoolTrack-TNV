
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 04/10/17, 16:50:38
  // ----------------------------------------------------
  // Método: [xShell_Reports].XS_ReportManager.FiltroBusqueda1
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

  //ABC
  //despliego el mnu de seleccion
C_TEXT:C284($t_seleccion)
C_OBJECT:C1216($ob_pref)
C_OBJECT:C1216($ob)
C_BOOLEAN:C305($b_titulo;$b_tags;$b_Descripcion)
QR_filtroBusqueda ("CreaObjeto";->$ob;->$ob)
$ob_pref:=PREF_fGetObject (<>lUSR_CurrentUserID;"MenuBusquedaInformes";$ob)
OB_GET ($ob_pref;->$b_titulo;"Titulo")
OB_GET ($ob_pref;->$b_Descripcion;"Descripcion")
OB_GET ($ob_pref;->$b_tags;"Tag")
$t_seleccion:=Dynamic pop up menu:C1006(MenuBusqueda)
Case of 
	: ($t_seleccion="Titulo")
		  //If ($b_titulo)
		  //$b_titulo:=False
		  //SET MENU ITEM MARK(MenuBusqueda;1;"")
		  //Else 
		  //siempre debe quedar marcado Titulo.
		$b_titulo:=True:C214
		SET MENU ITEM MARK:C208(MenuBusqueda;1;Char:C90(18))
		  //End if 
	: ($t_seleccion="Descripcion")
		If ($b_Descripcion)
			$b_Descripcion:=False:C215
			SET MENU ITEM MARK:C208(MenuBusqueda;2;"")
		Else 
			$b_Descripcion:=True:C214
			SET MENU ITEM MARK:C208(MenuBusqueda;2;Char:C90(18))
		End if 
	: ($t_seleccion="Tags")
		If ($b_tags)
			$b_tags:=False:C215
			SET MENU ITEM MARK:C208(MenuBusqueda;3;"")
		Else 
			$b_tags:=True:C214
			SET MENU ITEM MARK:C208(MenuBusqueda;3;Char:C90(18))
		End if 
End case 
OB_SET ($ob_pref;->$b_titulo;"Titulo")
OB_SET ($ob_pref;->$b_Descripcion;"Descripcion")
OB_SET ($ob_pref;->$b_tags;"Tag")
PREF_SetObject (<>lUSR_CurrentUserID;"MenuBusquedaInformes";$ob_pref)
