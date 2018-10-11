//%attributes = {}
  // MÉTODO: AL_PaginaConducta_y_Asistencia
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 10:14:18
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_PaginaConducta_y_Asistencia()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($l_InasistenciaPorAtrasos;$l_minutosPorAtraso;$l_modoRegistroAsistencia;$l_modoRegistroAtrasos)

If (False:C215)
	C_LONGINT:C283(AL_PaginaConducta_y_Asistencia ;$0)
End if 





  // CODIGO PRINCIPAL
C_LONGINT:C283(lastCdcta;vJustified)
C_LONGINT:C283(vl_AnotacionesNegativas;vl_AnotacionesPositivas;vl_PuntosNegativos;vl_PuntosPositivos;vl_Castigos;vl_suspensiones;vl_AnotacionesNeutras;vl_TotalRetardoAcumulado)
C_LONGINT:C283(vl_inasistencias;vl_InasistenciasJustificadas;vl_HorasInasistencia;vl_AtrasosJornada;vl_AtrasosSesion)
C_REAL:C285(vr_FaltasPorAtrasosJornada;vr_FaltasPorAtrasosSesion;vr_PorcentajeAsistencia)

AL_CiclosEscolares_Completo ([Alumnos:2]numero:1)

$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
$l_modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Lates_Mode:16)

IT_SetButtonState (((USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36) & (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite")) & (vl_Year=<>gYear)));->bAddLine)

OBJECT SET ENTERABLE:C238(vd_fechaCondicionalidad;(bCondicional=1))
OBJECT SET ENTERABLE:C238(vt_motivoCondicionalidad;(bCondicional=1))

$l_minutosPorAtraso:=Num:C11(PREF_fGet (0;"RegistrarMinutosEnAtrasos";"0"))
$l_InasistenciaPorAtrasos:=Num:C11(PREF_fGet (0;"RegistrarInasistenciasPorAtrasos";"0"))
OBJECT SET VISIBLE:C603(*;"AL_Atraso@";$l_minutosPorAtraso#0)
OBJECT SET VISIBLE:C603(*;"AL_Inasist@";($l_minutosPorAtraso#0) & ($l_InasistenciaPorAtrasos#0))

AL_InitCdtaArr 

  //If (lastCdcta<4)
If (lastCdcta<3)  //20160608 RCH la pagina 3 es licencias y cuando se salia desde ahi siempre entraba a la 1 o 2
	Case of 
		: (($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4))
			If (vl_Year=<>gYear)
				SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;2)
				vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion)+" horas"
				lastCdcta:=2
			Else 
				SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;1)
				vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion)+" horas"
				lastCdcta:=1
			End if 
			
		: ($l_modoRegistroAsistencia=1)
			lastCdcta:=1
			SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;1)
			OBJECT SET VISIBLE:C603(*;"AsistenciaHoraria@";False:C215)
			vs_FaltasPorAtrasos:=String:C10(vr_FaltasPorAtrasosSesion+vr_FaltasPorAtrasosJornada)+" días"
			
		Else 
			lastCdcta:=3
			SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;5)
			
	End case 
	AL_LeeRegistrosConducta 
	
Else 
	
	SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;lastCdcta)
	AL_LeeRegistrosConducta 
	SELECT LIST ITEMS BY POSITION:C381(vlTab_conducta;lastCdcta)
End if 
SET LIST ITEM PROPERTIES:C386(vlTab_conducta;2;(($l_modoRegistroAsistencia=2) | ($l_modoRegistroAsistencia=4));0;0)
SET LIST ITEM PROPERTIES:C386(vlTab_conducta;1;(($l_modoRegistroAsistencia#3) & ($l_modoRegistroAsistencia#4));0;0)
SET LIST ITEM PROPERTIES:C386(vlTab_conducta;4;($l_modoRegistroAtrasos=1);0;0)
OBJECT SET VISIBLE:C603(*;"filtroCdta@";AL_CdtaBehaviourFilter ("mostrarFiltro"))
_O_REDRAW LIST:C382(vlTab_conducta)

If ((vl_Year=<>gYear) & (vl_NivelSeleccionado=[Alumnos:2]nivel_numero:29) & ((vl_PeriodoSeleccionado=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)) | (vl_PeriodoSeleccionado=0)))
	OBJECT SET VISIBLE:C603(*;"back2Now@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"back2Now@";True:C214)
End if 

$0:=1

