  // bTareasSesiones()
  // Por: Alberto Bachler: 29/05/13, 15:02:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_DATE:C307($d_SesionSeleccionada)
C_LONGINT:C283($l_error;$l_filaSeleccionada;$l_IdNuevoProfesor;$l_itemSeleccionado;$l_opcionSeleccionada)
C_POINTER:C301($y_Nil)
C_TEXT:C284($t_asignatura;$t_FechaSesion;$t_ItemsPopupMenu;$t_NuevoProfesor;$t_profesorActual;$t_TextoLog)


$l_filaSeleccionada:=LB_GetSelectedRows (->lb_sesiones)
If ($l_filaSeleccionada=-1)
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Cambiar profesor responsable....")
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";(-;"
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Imprimir sesión...")
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";"
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Imprimir todas las sesiones...")
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";(-;"
	If (Not:C34(vb_SesionesAñosAnteriores))
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Mostrar sesiones de años anteriores")
	Else 
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Mostrar sesiones del año actual")
	End if 
Else 
	$d_SesionSeleccionada:=adSTK_SesionFecha{$l_filaSeleccionada}
	If ((USR_IsGroupMember_by_GrpID (-15001)) & (Size of array:C274(alSTK_sesionRecNum)>0) & (Not:C34(vb_SesionesAñosAnteriores)))
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Cambiar profesor responsable....")
	Else 
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Cambiar profesor responsable....")
	End if 
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";(-;"
	If ((USR_IsGroupMember_by_GrpID (-15001)) & (Size of array:C274(alSTK_sesionRecNum)>0))
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Imprimir sesión del "+String:C10($d_SesionSeleccionada;System date long:K1:3)+"...")
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";"
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Imprimir todas las sesiones...")
	Else 
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Imprimir sesión del "+String:C10($d_SesionSeleccionada;System date long:K1:3)+"...")
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";"
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("(Imprimir todas las sesiones...")
	End if 
	$t_ItemsPopupMenu:=$t_ItemsPopupMenu+";(-;"
	If (Not:C34(vb_SesionesAñosAnteriores))
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Mostrar sesiones de años anteriores")
	Else 
		$t_ItemsPopupMenu:=$t_ItemsPopupMenu+__ ("Mostrar sesiones del año actual")
	End if 
End if 


$l_itemSeleccionado:=Pop up menu:C542($t_ItemsPopupMenu)



Case of 
	: ($l_itemSeleccionado=1)  // cambio de profesor asignado
		ARRAY TEXT:C222(at_nombreProf;0)
		ARRAY LONGINT:C221(al_idProf;0)
		READ ONLY:C145([Profesores:4])
		QUERY:C277([Profesores:4];[Profesores:4]Es_docente:76=True:C214;*)
		QUERY:C277([Profesores:4]; & ;[Profesores:4]Numero:1#[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10)
		SELECTION TO ARRAY:C260([Profesores:4]Numero:1;al_IdProfesores;[Profesores:4]Apellidos_y_nombres:28;at_NombreProfesores)
		
		SORT ARRAY:C229(at_NombreProfesores;al_IdProfesores;>)
		
		ARRAY POINTER:C280(<>aChoicePtrs;0)
		ARRAY POINTER:C280(<>aChoicePtrs;2)
		<>aChoicePtrs{1}:=->at_NombreProfesores
		<>aChoicePtrs{2}:=->al_IdProfesores
		TBL_ShowChoiceList (1;__ ("Seleccione profesor...");1;->$y_Nil;False:C215)
		
		$t_profesorActual:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10;->[Profesores:4]Apellidos_y_nombres:28)
		$t_NuevoProfesor:=at_NombreProfesores{choiceIdx}
		$l_IdNuevoProfesor:=al_IdProfesores{choiceIdx}
		$t_FechaSesion:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;System date long:K1:3)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
		$t_asignatura:=[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5
		
		If (Ok=1)
			IT_Confirmacion_Inicializa 
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("21/Encabezado"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("22/btn1_SoloHoy"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("23/btn2_DesdeHoyEnAdelante"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("24/btn3_DesdeInicioHastaHoy"))
			$l_error:=IT_Confirmacion_AgregaElemento (MSG_TextoMensaje ("25/btn4_CancelarCambio"))
			
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_profesorActual";$t_profesorActual)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_profesorActual";$t_profesorActual)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_NuevoProfesor";$t_NuevoProfesor)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_asignatura";$t_asignatura)
			$l_error:=IT_Confirmacion_AgregaTagValor ("$t_FechaSesion";$t_FechaSesion)
			
			$t_TextoLog:=__ ("Cambio de profesor responsable de sesión de clases.")
			$l_opcionSeleccionada:=IT_Confirmacion_MuestraMensaje ($t_TextoLog)
			Case of 
				: ($l_opcionSeleccionada=1)  // cambiar profesor sesion actual
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$t_NuevoProfesor)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$l_IdNuevoProfesor)
					AS_PaginaSesiones 
					
				: ($l_opcionSeleccionada=2)  // cambiar profesor sesion actual y siguientes
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$t_NuevoProfesor)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$l_IdNuevoProfesor)
					AS_PaginaSesiones 
					
				: ($l_opcionSeleccionada=3)  // cambiar profesor sesion actual y anteriores
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=vdSTR_Periodos_InicioEjercicio;*)
					QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$t_NuevoProfesor)
					APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$l_IdNuevoProfesor)
					AS_PaginaSesiones 
					
				: ($l_opcionSeleccionada=4)  // cancelar
					
			End case 
		End if 
		
		
		
		
	: ($l_itemSeleccionado=3)  // imprimir sesión actual
		FORM SET OUTPUT:C54([Asignaturas_RegistroSesiones:168];"Informe")
		PRINT RECORD:C71([Asignaturas_RegistroSesiones:168])
		AS_PaginaSesiones 
		
		
	: ($l_itemSeleccionado=4)  // imprimir todas las sesiones
		PAGE SETUP:C299([Asignaturas_RegistroSesiones:168];"Informe")
		PRINT SETTINGS:C106
		If (ok=1)
			CREATE SELECTION FROM ARRAY:C640([Asignaturas_RegistroSesiones:168];alSTK_sesionRecNum)
			ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<;[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;>)
			BREAK LEVEL:C302(1;1)
			ACCUMULATE:C303([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			FORM SET OUTPUT:C54([Asignaturas_RegistroSesiones:168];"Informe")
			PRINT SELECTION:C60([Asignaturas_RegistroSesiones:168];>)
			AS_PaginaSesiones 
		End if 
		
		
	: ($l_itemSeleccionado=6)  // mostrar sesiones de años anteriores
		If (vb_SesionesAñosAnteriores)
			ASrs_CargaArreglos 
		Else 
			ASrs_CargaArreglos (True:C214)
		End if 
		
End case 