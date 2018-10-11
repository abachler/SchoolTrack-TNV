//%attributes = {}
  // LB_OnEventMethod()
  //
  //
  // creado por: Alberto Bachler Klein: 14-11-16, 12:06:51
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($l_columna;$l_filas;$l_filaSeleccionada;$l_modifiers)
C_POINTER:C301($y_listboxControl)
C_TEXT:C284($t_atajo;$t_nombreColumna;$t_nombreListBox;$t_nombreObjeto)

$y_listboxControl:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxControl")

$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
OBJECT GET SHORTCUT:C1186(*;$t_nombreObjeto;$t_atajo;$l_modifiers)
If (($t_atajo=Shortcut with Down arrow:K75:30) | ($t_atajo=Shortcut with Up arrow:K75:29) | ($t_atajo=Shortcut with Enter:K75:17))
	$t_nombreListBox:=OBJECT Get name:C1087(Object with focus:K67:3)
	
	$t_nombreColumna:=OB Get:C1224($y_ListboxControl->;"nombreColumnaActual")
	$l_columna:=OB Get:C1224($y_ListboxControl->;"celda_columna")
	
	$l_filaSeleccionada:=OB Get:C1224($y_ListboxControl->;"celda_fila")
	$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada=0;1;$l_filaSeleccionada)
	
	$l_filas:=LISTBOX Get number of rows:C915(*;"lbSituacionFinal")
	$b_editable:=OBJECT Get enterable:C1067(*;$t_nombreColumna)
	
	
	Case of 
		: (($t_atajo=Shortcut with Down arrow:K75:30) | ($t_atajo=Shortcut with Enter:K75:17))
			$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada<$l_filas;$l_filaSeleccionada+1;1)
		: ($t_atajo=Shortcut with Up arrow:K75:29)
			$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada=1;$l_filas;$l_filaSeleccionada-1)
	End case 
	
	If ($b_editable)
		EDIT ITEM:C870(*;$t_nombreColumna;$l_filaSeleccionada)
	Else 
		LISTBOX SELECT ROW:C912(*;$t_nombreListBox;$l_filaSeleccionada;lk replace selection:K53:1)
		OBJECT SET SCROLL POSITION:C906(*;$t_nombreListBox;$l_filaSeleccionada)
	End if 
	
	OB SET:C1220($y_ListboxControl->;"celda_fila";$l_filaSeleccionada)
	OB SET:C1220($y_ListboxControl->;"celda_columna";$l_columna)
End if 