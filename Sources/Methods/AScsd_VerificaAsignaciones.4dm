//%attributes = {}
  // MÉTODO: AScsd_VerificaAsignaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 12:51:25
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Verifica un eventual cambio de asignacion de propiedades de la asignatura, 
  // solicita confirmación al usuario e inicializa los campos correspondientes
  // a la columna asignada en la tabla [Alumnos_Calificaciones] cuando es necesario
  //
  // PARÁMETROS
  // AScsd_VerificaAsignaciones(ID_asignacionActual;ID_nuevaAsignación;numeroColumna)
  // $1: ID_asignacionActual
  // $2: ID_nuevaAsignación
  // $3: numeroColumna
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_InicializaCalificaciones)
C_LONGINT:C283($l_Columna;$l_IdAsignacionActual;$l_IdNuevaAsignacion;$l_periodo;$l_registrosCalificaciones)
C_POINTER:C301($y_PunteroCampoCalificaciones;$y_PunteroCampoCalificaciones1;$y_PunteroCampoCalificaciones2;$y_PunteroCampoCalificaciones3;$y_PunteroCampoCalificaciones4;$y_PunteroCampoCalificaciones5)
C_REAL:C285($r_ValorNuloCalificaciones)
_O_C_STRING:C293(255;$t_TextoMensaje)
If (False:C215)
	C_BOOLEAN:C305(AScsd_VerificaAsignaciones ;$0)
	C_LONGINT:C283(AScsd_VerificaAsignaciones ;$1)
	C_LONGINT:C283(AScsd_VerificaAsignaciones ;$2)
End if 





  // CODIGO PRINCIPAL
$0:=True:C214
$b_InicializaCalificaciones:=False:C215
$l_IdAsignacionActual:=$1
$l_IdNuevaAsignacion:=$2
$l_Columna:=$3
$l_periodo:=atSTR_Periodos_Nombre

EV2_RegistrosDeLaAsignatura (lConsID)
Case of 
	: (Not:C34(vb_CsdVariable))
		$y_PunteroCampoCalificaciones1:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P01_Eval"+String:C10($l_Columna;"00")+"_Real")
		$y_PunteroCampoCalificaciones2:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P02_Eval"+String:C10($l_Columna;"00")+"_Real")
		$y_PunteroCampoCalificaciones3:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P03_Eval"+String:C10($l_Columna;"00")+"_Real")
		$y_PunteroCampoCalificaciones4:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P04_Eval"+String:C10($l_Columna;"00")+"_Real")
		$y_PunteroCampoCalificaciones5:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P05_Eval"+String:C10($l_Columna;"00")+"_Real")
		READ ONLY:C145([Alumnos_Calificaciones:208])
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones1->#-10;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | $y_PunteroCampoCalificaciones2->#-10;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | $y_PunteroCampoCalificaciones3->#-10;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | $y_PunteroCampoCalificaciones4->#-10;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | $y_PunteroCampoCalificaciones5->#-10)
	: (atSTR_Periodos_Nombre=1)
		$y_PunteroCampoCalificaciones:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P01_Eval"+String:C10($l_Columna;"00")+"_Real")
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones->#-10)
	: (atSTR_Periodos_Nombre=2)
		$y_PunteroCampoCalificaciones:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P02_Eval"+String:C10($l_Columna;"00")+"_Real")
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones->#-10)
	: (atSTR_Periodos_Nombre=3)
		$y_PunteroCampoCalificaciones:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P03_Eval"+String:C10($l_Columna;"00")+"_Real")
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones->#-10)
	: (atSTR_Periodos_Nombre=4)
		$y_PunteroCampoCalificaciones:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P04_Eval"+String:C10($l_Columna;"00")+"_Real")
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones->#-10)
	: (atSTR_Periodos_Nombre=5)
		$y_PunteroCampoCalificaciones:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P05_Eval"+String:C10($l_Columna;"00")+"_Real")
		EV2_RegistrosDeLaAsignatura (lConsID)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];$y_PunteroCampoCalificaciones->#-10)
End case 
$l_registrosCalificaciones:=Records in selection:C76([Alumnos_Calificaciones:208])

If ($l_registrosCalificaciones>0)
	Case of 
		: ((($l_IdAsignacionActual>0) | ($l_IdAsignacionActual<0)) & ($l_IdNuevaAsignacion>0))  //cambio de asignatura    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura o sub-asignatura). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por el resultado de la asignatura seleccionada.\r¿Desea Ud."+" continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=0) & ($l_IdNuevaAsignacion>0))  //la columna era evaluación directa y cambia por consolidable    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (ingresadas directamente). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por el resultado de la asignatura o sub-asignatura seleccionada.\r¿Desea Ud. conti"+"nuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=-1) & ($l_IdNuevaAsignacion>0))  //la columna era ingresable directamente y cambia por consolidable    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (ingreso bloqueado). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por la asignatura o sub-asignatura seleccionada\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=-2) & ($l_IdNuevaAsignacion>0))  //la columna era no ingresable y cambia por consolidable    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (ingreso bloqueado). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por la asignatura o sub-asignatura seleccionada\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=-2) & ($l_IdNuevaAsignacion=-1))  //la columna era no ingresable y cambia por evaluacion directa    
			$t_TextoMensaje:=__ ("Esta columna está configurada como no ingresable.\rSi continúa con esta operación será posible ingresar notas directamente.\r¿Desea Ud. continuar?")
		: (($l_IdAsignacionActual>0) & ($l_IdNuevaAsignacion=-1))  //la columna era consolidante y cambia por evaluación directa    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura). \rSi continúa con esta operación ellas serán eliminadas para permitir el ingreso directo de evaluaciones.\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=-1) & ($l_IdNuevaAsignacion=-2))  //la columna era evaluacion directa y cambia por no ingresable    
			$t_TextoMensaje:=__ ("Esta columna está configurada para ingresar la evaluación directamente.\rSi continúa con esta operación no será posible ingresar notas directamente.\r¿Desea Ud. continuar?")
		: (($l_IdAsignacionActual>0) & ($l_IdNuevaAsignacion=-2))  //la columna era consolidante y cambia por no ingresable    
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura). \rSi continúa con esta operación ellas serán eliminadas para permitir el ingreso directo de evaluaciones.\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual>0) & ($l_IdNuevaAsignacion=-3))  //la columna era consolidante y cambia por subasigantura  
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura o sub-asignatura). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por el resultado de la asignatura seleccionada.\r¿Desea Ud."+" continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual=0) & ($l_IdNuevaAsignacion=-3))  //la columna era evaluación directa o no ingresable y cambia por subasigantura  
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (ingresadas directamente). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por el resultado de la asignatura o sub-asignatura seleccionada.\r¿Desea Ud. conti"+"nuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual<0) & ($l_IdNuevaAsignacion=-3))  //la columna era subasignatura  y cambia por otra subasigantura  
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura o sub-asignatura). \rSi continúa con esta operación ellas serán eliminadas para ser posteriormente remplazadas por el resultado de la asignatura seleccionada.\r¿Desea Ud."+" continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual<0) & ($l_IdNuevaAsignacion=-1))  //la columna era subasignatura  y cambia por cualquier otra cosa
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de otra asignatura). \rSi continúa con esta operación ellas serán eliminadas para permitir el ingreso directo de evaluaciones.\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
		: (($l_IdAsignacionActual<0) & ($l_IdNuevaAsignacion=-2))  //la columna era subasignatura  y  ahora es no ingrsable
			$t_TextoMensaje:=__ ("Ya existen evaluaciones parciales en esta columna (resultados de una Subasignatura). \rSi continúa con esta operación ellas serán eliminadas y no será posible ingresar notas directamente.\r¿Desea Ud. continuar?")
			$b_InicializaCalificaciones:=True:C214
	End case 
End if 

If ($b_InicializaCalificaciones)
	ok:=CD_Dlog (0;$t_TextoMensaje;__ ("");__ ("No");__ ("Continuar"))
	REDRAW WINDOW:C456
	If (ok=2)
		If ($b_InicializaCalificaciones)
			EV2_RegistrosDeLaAsignatura (lConsID)
			$r_ValorNuloCalificaciones:=-10
			ARRAY REAL:C219($aReal;Records in selection:C76([Alumnos_Calificaciones:208]))
			AT_Populate (->$aReal;->$r_ValorNuloCalificaciones)
			Case of 
				: (Not:C34(vb_CsdVariable))
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones1->;$aReal;$y_PunteroCampoCalificaciones2->;$aReal;$y_PunteroCampoCalificaciones3->;$aReal;$y_PunteroCampoCalificaciones4->;$aReal;$y_PunteroCampoCalificaciones5->)
				: (atSTR_Periodos_Nombre=1)
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones->)
				: (atSTR_Periodos_Nombre=2)
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones->)
				: (atSTR_Periodos_Nombre=3)
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones->)
				: (atSTR_Periodos_Nombre=4)
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones->)
				: (atSTR_Periodos_Nombre=5)
					ARRAY TO SELECTION:C261($aReal;$y_PunteroCampoCalificaciones->)
			End case 
			UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
			READ ONLY:C145([Alumnos_Calificaciones:208])
			UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
			READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
			vbRecalcPromedios:=True:C214
		End if 
	Else 
		$0:=False:C215
	End if 
End if 

