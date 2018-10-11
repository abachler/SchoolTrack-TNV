//%attributes = {}
  // MÉTODO: `ASsev_EditaSubAsignatura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/12/11, 15:12:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // ASsev_OpenSubEval()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_GuardarRegistro)
_O_C_INTEGER:C282($i_alumnos)
C_LONGINT:C283($l_columnaSubEvaluacion;$l_errorALP;$l_IdAsignaturaMadre;$l_itemEncontrado;$l_Periodo;$l_progressProcID;$l_recNumSubasignatura;$l_RecrearSubasignatura)
C_POINTER:C301($y_ArregloCalificacion_Literal;$y_ArregloCalificacion_Real;$y_campoCalificaciones_literal;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_real;$y_campoCalificaciones_simbolo)
C_REAL:C285($r_valorEditadoReal)
C_TEXT:C284($t_textoMensaje;$t_TituloVentana)

ARRAY LONGINT:C221($al_IdAlumnos;0)
ARRAY REAL:C219($ar_Calificacion_Real;0)
ARRAY TEXT:C222($at_arrayNames;0)
ARRAY TEXT:C222($at_Calificacion_Literal;0)
If (False:C215)
	C_LONGINT:C283(ASsev_EditaSubAsignatura ;$1)
	C_LONGINT:C283(ASsev_EditaSubAsignatura ;$2)
	C_LONGINT:C283(ASsev_EditaSubAsignatura ;$3)
End if 

  // CODIGO PRINCIPAL
$l_IdAsignaturaMadre:=$1
$l_Periodo:=$2
$l_columnaSubEvaluacion:=$3
vi_Parcial:=$l_columnaSubEvaluacion

  // verifico que la configuración de subasignaturas no esté corrupta
$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ($l_IdAsignaturaMadre;$l_Periodo;$l_columnaSubEvaluacion)
Case of 
	: ($l_recNumSubasignatura=-2)
		$t_textoMensaje:=__ ("El vínculo entre la Asignatura ")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+__ (" y la subasignatura asociada a la columna Nº ")+String:C10($l_columnaSubEvaluacion)+__ (" está corrupto.")
		$t_textoMensaje:=$t_textoMensaje+__ ("\r\rEl vínculo puede ser reconstruido pero las evaluaciones existentes en la subasignatura no podrán ser recuperadas.\rSi desea recosntruir el vínculo presione el botón Reparar.")
		$l_RecrearSubasignatura:=CD_ReportProblem ("*";$t_textoMensaje)
		If ($l_RecrearSubasignatura=1)
			CREATE RECORD:C68([xxSTR_Subasignaturas:83])
			[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
			[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
			[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$l_columnaSubEvaluacion}
			[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodo
			[xxSTR_Subasignaturas:83]Columna:13:=$l_columnaSubEvaluacion
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
			KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
			$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ($l_IdAsignaturaMadre;$l_Periodo;$l_columnaSubEvaluacion)
		End if 
		
	: ($l_recNumSubasignatura=-1)
		$t_textoMensaje:=__ ("La subasignatura asociada a la columna ")+String:C10($l_columnaSubEvaluacion)+__ (" en las propiedades de evaluación de la Asignatura ")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+__ (" no existe.\rSi desea crear la subasignatura presione el botón Reparar.")
		$l_RecrearSubasignatura:=CD_ReportProblem ("*";$t_textoMensaje)
		If ($l_RecrearSubasignatura=1)
			$t_textoMensaje:=__ ("La subasignatura asociada a la columna ")+String:C10($l_columnaSubEvaluacion)+__ (" en las propiedades de evaluación de la Asignatura ")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+__ (" no existía. La subasignatura fue recreada a petición del usuario ")+<>tUSR_CurrentUserName
			LOG_RegisterEvt ($t_textoMensaje)
			CREATE RECORD:C68([xxSTR_Subasignaturas:83])
			[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
			[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
			[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$l_columnaSubEvaluacion}
			[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodo
			[xxSTR_Subasignaturas:83]Columna:13:=$l_columnaSubEvaluacion
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
			KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
			$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ($l_IdAsignaturaMadre;$l_Periodo;$l_columnaSubEvaluacion)
		Else 
			$t_textoMensaje:=__ ("La subasignatura asociada a la columna")+String:C10($l_columnaSubEvaluacion)+__ (" en las propiedades de evaluación de la Asignatura")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+__ (" no existe en la base de datos.\rEl usuario ")+<>tUSR_CurrentUserName+__ (" tomó la decisión de no recrearla")
			LOG_RegisterEvt ($t_textoMensaje)
		End if 
End case 

If ($l_recNumSubasignatura>=0)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	ASsev_UpdateList (Record number:C243([xxSTR_Subasignaturas:83]))
	
	$y_Real:=Get pointer:C304("aRealNta"+String:C10($l_columnaSubEvaluacion))
	$y_Literal:=Get pointer:C304("aNta"+String:C10($l_columnaSubEvaluacion))
	  // si no hay notas en la sub-asignatura a causa del traslado del alumno desde otra asignatura madre copio la evaluación de la columna parcial en la madre a la subasignatura
	  // eliminando así la inconsistencia que podíá producirse en el calculo de promedio
	For ($i;1;Size of array:C274(aNtaIDAlumno))
		$l_posicion:=Find in array:C230(aSubEvalID;aNtaIDAlumno{$i})
		$r_evaluacionEnMadre:=$y_Real->{$i}
		$t_evaluacionEnMadre:=$y_Literal->{$i}
		If ($l_posicion>0)
			If ((aRealSubEvalP1{$l_posicion}=-10) & ($r_evaluacionEnMadre#aRealSubEvalP1{$l_posicion}))
				aRealSubEvalP1{$l_posicion}:=$r_evaluacionEnMadre
				aRealSubEval1{$l_posicion}:=$r_evaluacionEnMadre
				aSubEval1{$l_posicion}:=$t_evaluacionEnMadre
				ASsev_Average ($l_posicion)
			End if 
		End if 
	End for 
	
	ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
	$l_recNumSubasignatura:=ASsev_LeeDatosSubasignatura ($l_IdAsignaturaMadre;$l_Periodo;$l_columnaSubEvaluacion)
	
	
	modSubEvals:=False:C215
	ARRAY LONGINT:C221(al_IdAlumnoNotasModificadas;0)
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	LOAD RECORD:C52([xxSTR_Subasignaturas:83])
	$t_TituloVentana:=Substring:C12(__ ("Sub-asignatura: ")+[Asignaturas:18]denominacion_interna:16+": "+[xxSTR_Subasignaturas:83]Name:2;1;254)
	WDW_OpenFormWindow (->[Asignaturas:18];"Sub_evaluaciones";-1;8;$t_TituloVentana)
	KRL_ModifyRecord (->[Asignaturas:18];"Sub_evaluaciones")
	CLOSE WINDOW:C154
	KRL_ReloadAsReadOnly (->[xxSTR_Subasignaturas:83])
	
	If (modSubEvals)
		modNotas:=True:C214
	End if 
	COPY ARRAY:C226(aSubEvalP1;$at_Calificacion_Literal)
	COPY ARRAY:C226(aRealSubEvalP1;$ar_Calificacion_Real)
	COPY ARRAY:C226(aSubEvalId;$al_IdAlumnos)
	ASsev_InitArrays 
	
	
	  // obtengo punteros sobre los campos en los que almacenarán las calificaciones
	$y_campoCalificaciones_real:=ASev2_punteroReal ("aNta"+String:C10($l_columnaSubEvaluacion);aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_nota:=ASev2_punteroNota ("aNta"+String:C10($l_columnaSubEvaluacion);aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_puntos:=ASev2_punteroPuntos ("aNta"+String:C10($l_columnaSubEvaluacion);aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_simbolo:=ASev2_punteroSimbolo ("aNta"+String:C10($l_columnaSubEvaluacion);aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	$y_campoCalificaciones_literal:=ASev2_punteroLiteral ("aNta"+String:C10($l_columnaSubEvaluacion);aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
	
	
	$y_ArregloCalificacion_Literal:=Get pointer:C304("aNta"+String:C10($l_columnaSubEvaluacion))
	$y_ArregloCalificacion_Real:=Get pointer:C304("aRealNta"+String:C10($l_columnaSubEvaluacion))
	
	
	If (AS_PromediosSonCalculados )
		  // si los promedios son calculados guardo el resultado de la subasignatura en la columna correspondiente a la subasignatura
		  // y calculo los promedios de la asignatura
		$l_progressProcID:=IT_Progress (1;0;0;__ ("Calculando promedios de la asignatura..."))
		For ($i_alumnos;1;Size of array:C274(al_IdAlumnoNotasModificadas))
			$l_itemEncontrado:=Find in array:C230(aIdAlumnos_a_Recalcular;al_IdAlumnoNotasModificadas{$i_alumnos})
			If ($l_itemEncontrado<0)
				APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;al_IdAlumnoNotasModificadas{$i_alumnos})  // agrego el id del alumno para la creación de tarea de calculo de promedio general del alumno en EV2_TareasPostEdicion
			End if 
			$l_itemEncontrado:=Find in array:C230(aNtaIDAlumno;al_IdAlumnoNotasModificadas{$i_alumnos})
			If (($l_itemEncontrado>0) & (aNtaStatus{$l_itemEncontrado}#"Retirado@"))
				$l_posicionCalificacion:=Find in array:C230($al_IdAlumnos;al_IdAlumnoNotasModificadas{$i_alumnos})
				$y_ArregloCalificacion_Literal->{$l_itemEncontrado}:=$at_Calificacion_Literal{$l_posicionCalificacion}
				$y_ArregloCalificacion_Real->{$l_itemEncontrado}:=$ar_Calificacion_Real{$l_posicionCalificacion}
				$r_valorEditadoReal:=$y_ArregloCalificacion_Real->{$l_itemEncontrado}
				$l_recNumCalificaciones:=aNtaRecNum{$l_itemEncontrado}
				If ($l_itemEncontrado>0)
					$b_GuardarRegistro:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Consolidacion_ConSubasignaturas:31
					ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
					EV2_Calculos ($l_recNumCalificaciones;$l_Periodo)  //aNtaRecNum{$i_alumnos}
				End if 
			End if 
			IT_Progress (0;$l_progressProcID;$i_alumnos/Size of array:C274(al_IdAlumnoNotasModificadas);__ ("Guardando calificaciones..."))
		End for 
		IT_Progress (-1;$l_progressProcID)
		ARRAY LONGINT:C221(al_IdAlumnoNotasModificadas;0)
		
		
	Else 
		  // si los promedios de la asignatura no son calculados sólo guardo el resultado de la subasignatura en la columna correspondiente a la subasignatura sin recalcular promedios
		$l_progressProcID:=IT_Progress (1;0;0;__ ("Guardando calificaciones..."))
		For ($i_alumnos;1;Size of array:C274(al_IdAlumnoNotasModificadas))
			$l_itemEncontrado:=Find in array:C230(aNtaIDAlumno;al_IdAlumnoNotasModificadas{$i_alumnos})
			If ($l_itemEncontrado>0)
				$l_posicionCalificacion:=Find in array:C230($al_IdAlumnos;al_IdAlumnoNotasModificadas{$i_alumnos})
				$y_ArregloCalificacion_Literal->{$l_itemEncontrado}:=$at_Calificacion_Literal{$l_posicionCalificacion}
				$y_ArregloCalificacion_Real->{$l_itemEncontrado}:=$ar_Calificacion_Real{$l_posicionCalificacion}
				$r_valorEditadoReal:=$y_ArregloCalificacion_Real->{$l_itemEncontrado}
				$b_GuardarRegistro:=True:C214
				$l_recNumCalificaciones:=aNtaRecNum{$l_itemEncontrado}
				ASev2_RegistraCalificacion ($l_recNumCalificaciones;$r_valorEditadoReal;$y_campoCalificaciones_literal;$y_campoCalificaciones_real;$y_campoCalificaciones_nota;$y_campoCalificaciones_puntos;$y_campoCalificaciones_simbolo;$b_GuardarRegistro)
			End if 
			IT_Progress (0;$l_progressProcID;$i_alumnos/Size of array:C274(al_IdAlumnoNotasModificadas))
		End for 
		IT_Progress (-1;$l_progressProcID)
	End if 
	
	If (modNotas)
		EV2_ResultadosAsignatura 
	End if 
	
	
	  //fuerzo el atributo para circunvenir un error no detectado en el que esta propiedad puede perderse
	If ([Asignaturas:18]Consolidacion_EsConsolidante:35=False:C215)
		READ WRITE:C146([Asignaturas:18])
		LOAD RECORD:C52([Asignaturas:18])
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=True:C214
		[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=True:C214
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ReloadAsReadOnly (->[Asignaturas:18])
	End if 
	
	AS_PaginaEvaluacion 
	
	
	
End if 

