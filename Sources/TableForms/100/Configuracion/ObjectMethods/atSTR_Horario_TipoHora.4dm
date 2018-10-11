  // [xxSTR_Periodos].Configuracion.atSTR_Horario_TipoHora()
  // Por: Alberto Bachler: 13/06/13, 19:17:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Contextual click:C713)
	$t_itemsPopUp:=AT_array2text (-><>atSTR_Horario_TipoHora)
	$l_eleccionUsuario:=Pop up menu:C542($t_itemsPopUp;0)
	
	If ($l_eleccionUsuario>0)
		$l_tipoHora:=<>alSTR_Horario_RefTipoHora{$l_eleccionUsuario}
		If ($l_tipoHora<=0)
			READ ONLY:C145([xxSTR_Niveles:6])
			READ ONLY:C145([TMT_Horario:166])
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=[xxSTR_Periodos:100]ID:1)
			SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_numeroNiveles)
			QUERY WITH ARRAY:C644([TMT_Horario:166]Nivel:10;$al_numeroNiveles)
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5>0;*)
			QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=aiSTR_Horario_HoraNo{aiSTR_Horario_HoraNo})
			If (Records in selection:C76([TMT_Horario:166])>0)
				CD_Dlog (0;__ ("Hay asignaturas asignadas a este bloque horario.\r\rNo es posible cambiar el tipo de hora."))
			Else 
				alSTR_Horario_RefTipoHora{atSTR_Horario_TipoHora}:=<>alSTR_Horario_RefTipoHora{$l_eleccionUsuario}
				atSTR_Horario_TipoHora{atSTR_Horario_TipoHora}:=<>atSTR_Horario_TipoHora{$l_eleccionUsuario}
			End if 
		Else 
			  //MONO no se podia seleccionar hora de clases
			alSTR_Horario_RefTipoHora{atSTR_Horario_TipoHora}:=<>alSTR_Horario_RefTipoHora{$l_eleccionUsuario}
			atSTR_Horario_TipoHora{atSTR_Horario_TipoHora}:=<>atSTR_Horario_TipoHora{$l_eleccionUsuario}
		End if 
	End if 
End if 