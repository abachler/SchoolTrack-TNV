  // [Actividades].Input.menuConfigPeriodos()
  // Por: Alberto Bachler K.: 03-06-14, 13:38:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_configPeriodo:=OBJECT Get pointer:C1124(Object named:K67:5;"configuracionPeriodos")
$t_configPeriodosActual:=OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2))
READ ONLY:C145([xxSTR_Periodos:100])
QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)
SELECTION TO ARRAY:C260([xxSTR_Periodos:100]Nombre_Configuracion:2;$at_configuraciones;[xxSTR_Periodos:100]ID:1;$al_idPeriodos)
$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_configuraciones;->$t_configPeriodosActual)
If ($l_itemSeleccionado>0)
	[Actividades:29]ID_ConfiguracionPeriodos:13:=$al_idPeriodos{$l_itemSeleccionado}
	$l_resultado:=XCR_CambiaConfiguracionPeriodos ([Actividades:29]ID:1;Old:C35([Actividades:29]ID_ConfiguracionPeriodos:13);[Actividades:29]ID_ConfiguracionPeriodos:13)
	$t_nombreConfigPeriodosActual:=KRL_GetTextFieldData (->[xxSTR_Periodos:100]ID:1;->[Actividades:29]ID_ConfiguracionPeriodos:13;->[xxSTR_Periodos:100]Nombre_Configuracion:2)
	IT_PropiedadesBotonPopup ("configuracionPeriodos";$t_nombreConfigPeriodosActual;300)
	PERIODOS_LoadData (0;[Actividades:29]ID_ConfiguracionPeriodos:13)
End if 

