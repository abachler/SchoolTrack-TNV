  // [Asignaturas].Input.$botonMenu_Periodos()
  // Por: Alberto Bachler K.: 03-02-14, 18:35:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_columnas;$l_BloqueoColumna;$l_posicionBloqueo;$l_colorConFoco;$l_ColorSinFoco)
C_TEXT:C284($t_items)

ARRAY LONGINT:C221($al_Ordenamientos;0)
ARRAY LONGINT:C221($al_visible;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_Items;0)
ARRAY LONGINT:C221($al_columnas;0)
$l_colorConFoco:=0x0000
$l_ColorSinFoco:=0x0000 | (120 << 16) | (120 << 8) | 120

AL_ExitCell (xALP_ASNotas)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_colorConFoco;Background color none:K23:10)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_ColorSinFoco;Background color none:K23:10)
		
	: (Form event:C388=On Clicked:K2:4)
		$t_itemsPopupPeriodos:=""
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			Case of 
				: (($i=vlSTR_PeriodoSeleccionado) & (viSTR_PeriodoActual_Numero=$i))
					$t_itemsPopupPeriodos:=$t_itemsPopupPeriodos+"!"+Char:C90(18)+"<B"+atSTR_Periodos_Nombre{$i}+";"
				: ($i=vlSTR_PeriodoSeleccionado)
					$t_itemsPopupPeriodos:=$t_itemsPopupPeriodos+"!"+Char:C90(18)+atSTR_Periodos_Nombre{$i}+";"
				: (viSTR_PeriodoActual_Numero=$i)
					$t_itemsPopupPeriodos:=$t_itemsPopupPeriodos+"<B"+atSTR_Periodos_Nombre{$i}+";"
				Else 
					$t_itemsPopupPeriodos:=$t_itemsPopupPeriodos+atSTR_Periodos_Nombre{$i}+";"
			End case 
			
		End for 
		$result:=Pop up menu:C542(Replace string:C233($t_itemsPopupPeriodos;"/";" | ");0)
		
		If ($result>0)
			$periodo:=aiSTR_Periodos_Numero{$result}
			ALP_RemoveAllArrays (xALP_ASNotas)
			sPeriodo:=Replace string:C233(atSTR_Periodos_Nombre{$result};" ";"")
			If (modNotas)
				AS_TareasPostEdicionNotas 
				vlSTR_PeriodoSeleccionado:=$periodo
				AS_PaginaEvaluacion 
				modNotas:=True:C214  //forzamos a True para consolidar al salir
			Else 
				vlSTR_PeriodoSeleccionado:=$periodo
				AS_PaginaEvaluacion 
			End if 
		End if 
		AS_OpcionesPaginaEvaluacion 
End case 
