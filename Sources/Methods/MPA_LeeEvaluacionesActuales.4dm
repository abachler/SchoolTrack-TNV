//%attributes = {}
  // MÉTODO: MPA_LeeEvaluacionesActuales
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 19:06:18
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_LeeEvaluacionesActuales()
  // ----------------------------------------------------
C_BOOLEAN:C305($b_calculosSobreCompetencias)
C_LONGINT:C283($l_elemento;$l_recNum)



  // CODIGO PRINCIPAL
ALP_RemoveAllArrays (xALP_Aprendizajes)
ARRAY TEXT:C222(atEVLG_Competencia;0)
ARRAY TEXT:C222(atEVLG_Indicador;0)
ARRAY TEXT:C222(atEVLG_Observacion;0)
ARRAY TEXT:C222(atEVLG_Muestra;0)
ARRAY REAL:C219(arEVLG_Indicador;0)
ARRAY LONGINT:C221(alEVLG_TipoEvaluación;0)
ARRAY LONGINT:C221(alEVLG_RefEstiloEvaluacion;0)
ARRAY LONGINT:C221(alEVLG_RecNum;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY LONGINT:C221(alEVLG_IdCompetencia;0)
ARRAY LONGINT:C221(alEVLG_IdDimension;0)
ARRAY LONGINT:C221(alEVLG_IdEje;0)
ARRAY TEXT:C222(atMPA_FechaLogro;0)
ARRAY TEXT:C222(atMPA_FechaEstimada;0)
  //MONO TICKET 211799
ARRAY TEXT:C222(atMPA_uuidRegistro;0)
ARRAY DATE:C224(adEVLG_FechaLogro;0)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;vl_NivelSeleccionado)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]EVAPR_IdMatriz:91#0)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;aNtaIdAsignatura;[Asignaturas:18]denominacion_interna:16;aNtaAsignatura)

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
vtEVLG_VistaActual:=__ ("Alumnos")

If (Size of array:C274(aNtaIdAsignatura)>0)
	$l_elemento:=Find in array:C230(aNtaIdAsignatura;vlEVLG_AsignaturaSeleccionada)
	If ($l_elemento>0)
		aNtaIdAsignatura:=$l_elemento
	End if 
	If ((aNtaIdAsignatura=0) & (Size of array:C274(aNtaIdAsignatura)>0))
		aNtaIdAsignatura:=1
		vlEVLG_AsignaturaSeleccionada:=aNtaIdAsignatura{1}
	End if 
	LISTBOX DELETE COLUMN:C830(*;"lb_Asignaturas";1)
	LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";1;"Asignaturas";aNtaAsignatura;"HeaderAsignaturas";vlb_Header)
	OBJECT SET ENTERABLE:C238(*;"lb_Asignaturas";False:C215)
	OBJECT SET FONT SIZE:C165(*;"lb_Asignaturas";9)
	OBJECT SET RGB COLORS:C628(*;"lb_Asignaturas";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
	LISTBOX SELECT ROW:C912(*;"lb_Asignaturas";aNtaIdAsignatura)
	OBJECT SET SCROLL POSITION:C906(*;"lb_Asignaturas";aNtaIdAsignatura)
	aNtaAsignatura:=aNtaIdAsignatura
	
	PERIODOS_LoadData (vl_NivelSeleccionado)
	
	  //xALP_Set_Aprendizajes_AS 
	$l_recNum:=Find in field:C653([Asignaturas:18]Numero:1;aNtaIdAsignatura{aNtaIdAsignatura})
	KRL_GotoRecord (->[Asignaturas:18];$l_recNum)
	If ([Asignaturas:18]EVAPR_IdMatriz:91>0)
		$l_recNum:=Find in field:C653([MPA_AsignaturasMatrices:189]ID_Matriz:1;[Asignaturas:18]EVAPR_IdMatriz:91)
		If ($l_recNum>=0)
			EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;[Alumnos:2]numero:1;[Asignaturas:18]EVAPR_IdMatriz:91)
		End if 
		vtEVLG_AsignaturaSeleccionada:="Aprendizajes esperados en "+[Asignaturas:18]denominacion_interna:16
	End if 
	OBJECT SET VISIBLE:C603(xALP_Aprendizajes;True:C214)
	OBJECT SET VISIBLE:C603(*;"lb_Asignaturas";True:C214)
	If ([Alumnos:2]Status:50#"Retirado@") & ([Alumnos:2]Status:50#"Promovido anticipadamente@") & ([Alumnos:2]Status:50#"Egresado")
		OBJECT SET ENTERABLE:C238(vtObservaciones;True:C214)
	Else 
		OBJECT SET ENTERABLE:C238(vtObservaciones;False:C215)
	End if 
Else 
	LISTBOX DELETE COLUMN:C830(*;"lb_Asignaturas";1)
	ALP_RemoveAllArrays (xALP_Aprendizajes)
	xALP_Set_Aprendizajes_AS 
	vtEVLG_AsignaturaSeleccionada:=""
	OBJECT SET VISIBLE:C603(xALP_Aprendizajes;True:C214)
	OBJECT SET VISIBLE:C603(*;"lb_Asignaturas";True:C214)
	OBJECT SET ENTERABLE:C238(vtObservaciones;False:C215)
End if 


$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
If ($b_calculosSobreCompetencias)
	vtEvalProperties:="Los resultados en calificaciones de esta asignatura son calculados sobre la base "+"de la evaluación de competencias.\rNo es posible registrar calificaciones parciale"+"s ni configurar propiedades de evaluación."
	OBJECT SET ENTERABLE:C238([Asignaturas:18]Resultado_no_calculado:47;False:C215)
	OBJECT SET VISIBLE:C603(*;"Propiedades@";False:C215)
	OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes@";True:C214)
Else 
	OBJECT SET ENTERABLE:C238([Asignaturas:18]Resultado_no_calculado:47;True:C214)
	OBJECT SET VISIBLE:C603(*;"Propiedades@";True:C214)
	OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes@";False:C215)
End if 
OBJECT SET COLOR:C271(*;"year@";-15)