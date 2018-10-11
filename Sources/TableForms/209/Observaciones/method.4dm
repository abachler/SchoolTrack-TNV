  // [Alumnos_ComplementoEvaluacion].Observaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 24-12-15, 12:09:27
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_observacionesEditables;$b_usarObservacionesPredefinidas)
C_LONGINT:C283($i;$i_Categorias)
C_POINTER:C301($y_asignadas_Categoria;$y_asignadas_observacion;$y_asignadas_recNum;$y_campo;$y_listaCategorias;$y_Objeto;$y_objetoCategoria;$y_observaciones;$y_observacionesEditables;$y_pagina)
C_TEXT:C284($t_Categoria;$t_categorías;$t_llave;$t_llaveObjeto;$t_observacion)
C_OBJECT:C1216($ob_Objeto;$ob_undefined)

ARRAY POINTER:C280($ay_arreglos;0)
ARRAY TEXT:C222($at_Observaciones;0)
ARRAY OBJECT:C1221($ao_Categorias;0)
ARRAY OBJECT:C1221($ao_Observaciones;0)

$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objetoCategoria:=OBJECT Get pointer:C1124(Object named:K67:5;"objetoCategoria")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")

$y_asignadas_Categoria:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_categoria")
$y_asignadas_observacion:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_observacion")
$y_asignadas_recNum:=OBJECT Get pointer:C1124(Object named:K67:5;"asignadas_recnum")

$y_pagina:=OBJECT Get pointer:C1124(Object named:K67:5;"observaciones.pagina")
$y_observacionesEditables:=OBJECT Get pointer:C1124(Object named:K67:5;"observaciones.editables")

If (Form event:C388=On Load:K2:1)
	START TRANSACTION:C239  //20181001 ASM Ticket 217547 
	If (<>viSTR_UtilizarObservaciones=1)
		AT_Initialize ($y_listaCategorias;$y_objetoCategoria;$y_observaciones)
		$ob_Objeto:=KRL_GetObjectFieldData (->[xxSTR_Materias:20]Materia:2;->[Asignaturas:18]Asignatura:3;->[xxSTR_Materias:20]ob_Observaciones:7)
		$t_llaveObjeto:=String:C10([Asignaturas:18]Numero_del_Nivel:6)+".categorias"
		OB_GET ($ob_Objeto;->$ao_Categorias;$t_llaveObjeto)
		CLEAR VARIABLE:C89($ob_Objeto)
		$ob_Objeto:=OB_Create 
		OB_SET ($ob_Objeto;->$ao_Categorias;"categorias")
		
		For ($i_Categorias;1;Size of array:C274($ao_Categorias))
			$t_Categoria:=""
			OB_GET ($ao_Categorias{$i_Categorias};->$t_Categoria;"title")
			OB_GET ($ao_Categorias{$i_Categorias};->$at_Observaciones;"children")
			If (Size of array:C274($at_Observaciones)>0)
				$t_Categoria:=Choose:C955($t_Categoria="none";__ ("(sin categoría)");$t_Categoria)
				APPEND TO ARRAY:C911($y_listaCategorias->;$t_categoria)
				APPEND TO ARRAY:C911($y_objetoCategoria->;$ao_Categorias{$i_Categorias})
			End if 
		End for 
		
		
		If (Size of array:C274($y_listaCategorias->)>0)
			$y_objetoCategoria->:=1
			LISTBOX SELECT ROW:C912(*;"lb_Categoria";1)
			OB_GET ($y_objetoCategoria->{$y_objetoCategoria->};->$ao_Observaciones;"children")
			For ($i;1;Size of array:C274($ao_Observaciones))
				OB_GET ($ao_Observaciones{$i};->$t_observacion;"title")
				APPEND TO ARRAY:C911($y_observaciones->;$t_observacion)
			End for 
			$y_pagina->:=2
		Else 
			$y_pagina->:=1
		End if 
	Else 
		$y_pagina->:=1
	End if 
End if 



Case of 
	: ((Form event:C388=On Load:K2:1) | (Form event:C388=On Load Record:K2:38))
		
		Case of 
			: ($y_pagina->=1)
				$y_campo:=Choose:C955(vlSTR_PeriodoSeleccionado;->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;\
					->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;\
					->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;\
					->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;\
					->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34;\
					->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39)
				OBJECT SET DATA SOURCE:C1264(*;"observaciones.observacion";$y_campo)
				OBJECT SET TITLE:C194(*;"titulo";__ ("Observaciones para ")+[Alumnos:2]Nombres:2+"\r"+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+"\r"+vt_periodo)
				
			: ($y_pagina->=2)
				$t_llave:=KRL_MakeStringAccesKey (->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;->[Asignaturas:18]Numero:1;->vlSTR_PeriodoObservaciones)
				QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Key:9=$t_llave)
				ORDER BY:C49([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]Categoría:4;>;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;>)
				
				SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30];$y_asignadas_recNum->;[Alumnos_ObservacionesEvaluacion:30]Categoría:4;$y_asignadas_Categoria->;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;$y_asignadas_observacion->)
				APPEND TO ARRAY:C911($ay_arreglos;$y_asignadas_Categoria)
				APPEND TO ARRAY:C911($ay_arreglos;$y_asignadas_observacion)
				LISTBOX SET HIERARCHY:C1098(*;"lb_observacionesAsignadas";True:C214;$ay_arreglos)
		End case 
		
		OBJECT SET TITLE:C194(*;"titulo";__ ("Observaciones para ")+[Alumnos:2]Nombres:2+"\r"+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+"\r"+vt_periodo)
		OBJECT SET TITLE:C194(*;"bloqueo";Choose:C955(<>vd_FechaBloqueoSchoolTrack=!00-00-00!;"";__ ("Registro de información bloqueado a contar del ")+"<<>vd_FechaBloqueoSchoolTrack>"))
		
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$b_observacionesEditables:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
		$b_observacionesEditables:=$b_observacionesEditables & ((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
		$b_observacionesEditables:=$b_observacionesEditables | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
		$b_observacionesEditables:=$b_observacionesEditables & Not:C34(<>vb_BloquearModifSituacionFinal)
		OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";<>vb_BloquearModifSituacionFinal)
		OBJECT SET TITLE:C194(*;"bloqueo";"Registro de información bloqueado a contar del <◊vd_FechaBloqueoSchoolTrack>")
		HIGHLIGHT TEXT:C210(*;"observaciones.observacion";MAXLONG:K35:2;MAXLONG:K35:2)
		
		$y_observacionesEditables->:=Num:C11($b_observacionesEditables)
		
		OBJECT SET ENTERABLE:C238(*;"observaciones.observacion";$y_observacionesEditables->=1)
		OBJECT SET ENABLED:C1123(*;"guardar";$y_observacionesEditables->=1)
		
		FORM GOTO PAGE:C247($y_pagina->)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 