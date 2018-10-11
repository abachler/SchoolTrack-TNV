  // [xxSTR_Constants].STR_InasistenciasSesiones()
  // Por: Alberto Bachler K.: 16-06-14, 09:53:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_AltoArea;$l_anchoActual;$l_AnchoArea;$l_AnchoCeldasAsistencia;$l_anchoColumnaAlumnos;$l_anchoDisponibleParaCeldas;$l_anchoMaximo;$l_anchoMinimo;$l_anchoReservado)
C_LONGINT:C283($l_anchoScrollBar;$l_columnasHoras;$l_elemento)
C_POINTER:C301($y_pestaña)


Case of 
	: (Form event:C388=On Load:K2:1)
		DISABLE MENU ITEM:C150(1;0)
		ENABLE MENU ITEM:C149(1;4)
		DISABLE MENU ITEM:C150(3;0)
		DISABLE MENU ITEM:C150(4;0)
		DISABLE MENU ITEM:C150(5;0)
		DISABLE MENU ITEM:C150(6;0)
		SET WINDOW TITLE:C213(__ ("Inasistencia a clases del ")+String:C10(dFrom;3))
		xALSet_STR_InasistenciaSesiones 
		ALabs_UpdateForm 
		_O_C_INTEGER:C282(vi_AsistClases)
		vi_AsistClases:=Num:C11(PREF_fGet (0;"LogAsistClases"))
		OBJECT SET RGB COLORS:C628(hl_cursosAsistenciaSesiones;Foreground color:K23:1;0x00F3F6FA)
		$l_elemento:=Find in list:C952(hl_cursosAsistenciaSesiones;vs_SelectedClass;0)
		SELECT LIST ITEMS BY POSITION:C381(hl_cursosAsistenciaSesiones;$l_elemento)
		OBJECT SET SCROLL POSITION:C906(hl_cursosAsistenciaSesiones;$l_elemento)
		SET LIST PROPERTIES:C387(hl_cursosAsistenciaSesiones;_o_Ala Macintosh:K28:1;_o_Macintosh node:K28:5;24)
		  //GOTO OBJECT(hl_cursosAsistenciaSesiones)
		OBJECT SET TITLE:C194(bCalendario;String:C10(dFrom;System date long:K1:3))
		
		$y_pestaña:=OBJECT Get pointer:C1124(Object named:K67:5;"pestana")
		If (Is a list:C621($y_pestaña->))
			CLEAR LIST:C377($y_pestaña->)
		End if 
		$y_pestaña->:=New list:C375
		APPEND TO LIST:C376($y_pestaña->;__ ("Registro de asistencia");1)
		APPEND TO LIST:C376($y_pestaña->;__ ("Supervisión");2)
		
		If ((Not:C34(USR_IsGroupMember_by_GrpID (-15001))) & (Not:C34(USR_GetMethodAcces ("Supervisión de asistencia a clases";0))))
			SET LIST ITEM PROPERTIES:C386($y_pestaña->;2;False:C215;0;0)
			OBJECT SET HELP TIP:C1181(*;"pestana";__ ("Para poder acceder a Supervisión, debe pertenecer al grupo Administración o su grupo debe poseer el permiso de Supervisión de asistencia a clases."))
		End if 
		
		Case of 
			: (SYS_IsWindows )
				IT_AlineaObjetos (4;0;"barra";"pestaña")
		End case 
		
	: (Form event:C388=On Activate:K2:9)
		SET WINDOW TITLE:C213(__ ("Registro de Inasistencia a Clases"))
		
	: (Form event:C388=On Resize:K2:27)
		$l_anchoScrollBar:=16
		$l_anchoColumnaAlumnos:=220
		$l_AnchoArea:=IT_Objeto_Ancho ("areaInasistencias")
		$l_AltoArea:=IT_Objeto_Alto ("areaInasistencias")
		$l_anchoDisponibleParaCeldas:=$l_AnchoArea-$l_anchoScrollBar-$l_anchoColumnaAlumnos
		$l_columnasHoras:=Count in array:C907(alSTR_Horario_RefTipoHora;1)
		$l_AnchoCeldasAsistencia:=Int:C8($l_anchoDisponibleParaCeldas/$l_columnasHoras)
		$l_anchoColumnaAlumnos:=$l_anchoColumnaAlumnos+$l_anchoDisponibleParaCeldas-($l_AnchoCeldasAsistencia*$l_columnasHoras)
		AL_SetWidths (xALP_Inasistencias;1;1;$l_anchoColumnaAlumnos)
		For ($i;1;$l_columnasHoras)
			AL_SetWidths (xALP_Inasistencias;$i+1;1;$l_AnchoCeldasAsistencia)
		End for 
		
		$l_AnchoArea:=IT_Objeto_Ancho ("listaSesiones")
		$l_anchoActual:=LISTBOX Get column width:C834(*;"profesor";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoMaximo
		$l_anchoActual:=$l_anchoActual+LISTBOX Get column width:C834(*;"fecha";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoReservado+$l_anchoMaximo
		$l_anchoActual:=$l_anchoActual+LISTBOX Get column width:C834(*;"hora";$l_anchoMinimo;$l_anchoMaximo)
		$l_anchoReservado:=$l_anchoReservado+$l_anchoMaximo
		$l_anchoReservado:=$l_anchoReservado+16
		LISTBOX SET COLUMN WIDTH:C833(*;"asignatura";$l_AnchoArea-$l_anchoReservado)
		
	: (Form event:C388=On Unload:K2:2)
		$y_pestaña:=OBJECT Get pointer:C1124(Object named:K67:5;"pestana")
		If (Is a list:C621($y_pestaña->))
			CLEAR LIST:C377($y_pestaña->)
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
