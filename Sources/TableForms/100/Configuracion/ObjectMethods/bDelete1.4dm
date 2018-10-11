$selected:=Selected list items:C379(hl_Configuraciones)
GET LIST ITEM:C378(hl_Configuraciones;$selected;$itemRef;$itemText)
If ($itemRef>0)
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
	If (Records in selection:C76([xxSTR_Niveles:6])>0)
		$ignore:=CD_Dlog (0;__ ("Esta configuración de Períodos escolares es utilizada en algunos niveles.\r\rLa configuración seleccionada no puede ser eliminada.");__ ("");__ ("Aceptar"))
	Else 
		$answer:=CD_Dlog (0;__ ("¿Desea realmente eliminar la configuración de Períodos escolares seleccionada?");__ ("");__ ("Si");__ ("No"))
		If ($answer=1)
			READ WRITE:C146([xxSTR_Periodos:100])
			DELETE RECORD:C58([xxSTR_Periodos:100])
			DELETE FROM LIST:C624(hl_Configuraciones;$itemRef)
			Case of 
				: ($selected>1)
					SELECT LIST ITEMS BY POSITION:C381(hl_Configuraciones;1)
					CFG_STR_PeriodosEscolares_NEW ("LoadConfig")
				: ($selected>Count list items:C380(hl_Configuraciones))
					SELECT LIST ITEMS BY POSITION:C381(hl_Configuraciones;Count list items:C380(hl_Configuraciones))
					CFG_STR_PeriodosEscolares_NEW ("LoadConfig")
			End case 
			_O_REDRAW LIST:C382(hl_Configuraciones)
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("La configuración seleccionada es la configuración principal.\r\rLa configuración principal de Períodos Escolares no puede ser eliminada.");__ ("Aceptar"))
End if 