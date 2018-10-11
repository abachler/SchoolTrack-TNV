  // b_Evaluar()
  // Por: Alberto Bachler K.: 12-08-15, 10:35:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_evaluacionPosible;$b_promedioEditable;$b_usuarioAutorizado)
C_LONGINT:C283($l_columna;$l_filaSeleccionada;$l_recNum;$l_scrollHorizonal;$l_scrollVertical)
C_TEXT:C284($t_marcaPromedioEditable;$t_parametroMenu;$t_refMenu)

LISTBOX GET CELL POSITION:C971(*;"lbSituacionFinal";$l_columna;$l_filaSeleccionada)
$b_usuarioAutorizado:=((USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID )) | USR_checkRights ("M";->[Cursos:3]))
$b_promedioEditable:=((<>vtXS_CountryCode="uy") & $b_usuarioAutorizado)
$b_evaluacionPosible:=Not:C34(<>vb_BloquearModifSituacionFinal) & ($b_usuarioAutorizado)
$t_marcaPromedioEditable:=Char:C90(18)*Num:C11(OBJECT Get enterable:C1067(*;"sitFinal_promedio"))


$t_refMenu:=Create menu:C408
MNU_Append ($t_refMenu;__ ("Re-evaluar situación final de todos los alumnos del curso");"evaluarTodos";$b_evaluacionPosible)
MNU_Append ($t_refMenu;"(-")
MNU_Append ($t_refMenu;__ ("Editar promedio general del alumno");"editarPromedio";$b_promedioEditable;$t_marcaPromedioEditable)
$t_parametroMenu:=Dynamic pop up menu:C1006($t_refMenu)
RELEASE MENU:C978($t_refMenu)

Case of 
	: ($t_parametroMenu="evaluarTodos")
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Alumnos_Conducta:8])
		READ ONLY:C145([Alumnos_Inasistencias:10])
		READ ONLY:C145([xxSTR_Niveles:6])
		
		  //193361 
		  //Agrego el curso para que leea la configuracion si esta especifica sino el Nivel.
		ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
		CU_SituacionFinal_Evaluar (-1;[Cursos:3]Curso:1)
		CU_PgSituacion 
		
	: ($t_parametroMenu="editarPromedio")
		OBJECT SET ENTERABLE:C238(*;"sitFinal_promedio";Not:C34(OBJECT Get enterable:C1067(*;"sitFinal_promedio")))
		If (OBJECT Get enterable:C1067(*;"sitFinal_promedio"))
			LISTBOX GET CELL POSITION:C971(*;"lbSituacionFinal";$l_columna;$l_filaSeleccionada)
			EDIT ITEM:C870(*;"sitFinal_promedio";$l_filaSeleccionada)
		Else 
			LISTBOX SELECT ROW:C912(*;"lbSituacionFinal";$l_filaSeleccionada;lk replace selection:K53:1)
			OBJECT SET VISIBLE:C603(*;"fondoEdicion";False:C215)
			OBJECT SET VISIBLE:C603(*;"rectanguloEntrada";False:C215)
			LISTBOX SET ROW FONT STYLE:C1268(*;"sitFinal@";$l_filaSeleccionada;Plain:K14:1)
			LISTBOX SET ROW COLOR:C1270(*;"lbSituacionFinal";$l_filaSeleccionada;lk inherited:K53:26;lk background color:K53:25)
			LISTBOX SET ROW COLOR:C1270(*;"lbSituacionFinal";$l_filaSeleccionada;lk inherited:K53:26;lk font color:K53:24)
		End if 
End case 


