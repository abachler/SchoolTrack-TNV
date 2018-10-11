//%attributes = {}
  // UD_v20130625_SesionesInasist()
  // Por: Alberto Bachler: 25/06/13, 12:00:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_fechaInicioAño;$d_fechaSesion;$d_fechaTerminoAño)
_O_C_INTEGER:C282($i;$i_inasistencias;$i_sesiones)
C_LONGINT:C283($l_IdAlumno;$l_IdmensajeProceso;$l_invalidosEliminados;$l_numeroDia_ISO;$l_progressProcess;$l_sesionesEliminadas;$l_ultimoNivel;$recnumIndex)

ARRAY LONGINT:C221($al_recNumInasistencias;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_recNumSesionesInvalidas;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY LONGINT:C221($aRecNumsSesiones;0)

UD_v20130529_NormalizaSesiones 
UD_v20130613_TipoHorasHorario 
UD_v20130625_HoraInasistClases 




  // ELIMINACION DE SESIONES DE CLASES INVALIDAS
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas:18])

  // obtengo las fechas de inicio y termino del año escolar actual
  // (buscando en las configuraciones de período la fecha de inicio mas temprana y la fecha de término más tardía)
PERIODOS_Init 
$d_fechaInicioAño:=PERIODOS_InicioAñoSTrack 
$d_fechaTerminoAño:=PERIODOS_FinAñoPeriodosSTrack 
  // creo un conjunto vacío en el que pondré los registros inválidos
CREATE EMPTY SET:C140([Asignaturas_RegistroSesiones:168];"$SesionesInvalidas")

  // FASE 1. Busco los registro de sesiones de clases del año actual no relacionados con ninguna asignatura
$l_IdmensajeProceso:=IT_UThermometer (0;$l_IdmensajeProceso;__ ("Verificando paridad de registros de Sesiones de clases con registros de Asignaturas..."))
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_RegistroSesiones:168];"$todos")
ALL RECORDS:C47([Asignaturas:18])
KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1)
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_RegistroSesiones:168];"$validos")
DIFFERENCE:C122("$todos";"$validos";"$huerfanos")
If (Records in set:C195("$huerfanos")>0)
	UNION:C120("$SesionesInvalidas";"$huerfanos";"$SesionesInvalidas")
End if 
$l_IdmensajeProceso:=IT_UThermometer (-2;$l_IdmensajeProceso)
  // .FASE 1


  // FASE 2. Busco los registro de sesiones de clases del año actual no relacionados con ninguna asignación de horario
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)
CREATE EMPTY SET:C140([Asignaturas_RegistroSesiones:168];"$SesionesfueraHorario")
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
$l_progressProcess:=IT_Progress (1;0;0;"Buscando registros de sesiones de clases en horario inválido...")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i})
	$l_numeroDia_ISO:=DT_GetDayNumber_ISO8601 ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=$l_numeroDia_ISO;*)
	QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=[Asignaturas_RegistroSesiones:168]Hora:4)
	If (Records in selection:C76([TMT_Horario:166])=0)
		ADD TO SET:C119([Asignaturas_RegistroSesiones:168];"$SesionesfueraHorario")
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$i/Size of array:C274($al_RecNums);"Buscando registros de sesiones de clases en horario inválido...")
End for 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)
If (Records in set:C195("$SesionesfueraHorario")>0)
	UNION:C120("$SesionesInvalidas";"$SesionesfueraHorario";"$SesionesInvalidas")
End if 
  // .FASE 2

  // FASE 3. Busco los registros de sesiones fuera de períodos
$l_progressProcess:=IT_Progress (1;0;0;"Buscando registros de sesiones de clases con fechas inválidas...")
ALL RECORDS:C47([Asignaturas:18])
SELECTION TO ARRAY:C260([Asignaturas:18];$aRecNums)
READ WRITE:C146([Asignaturas:18])
CREATE EMPTY SET:C140([Asignaturas_RegistroSesiones:168];"$sesionesFueraDePeriodos")
For ($recnumIndex;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$recNumIndex})
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$aRecNumsSesiones;"")
	For ($i_sesiones;1;Size of array:C274($aRecNumsSesiones))
		GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$aRecNumsSesiones{$i_sesiones})
		If (Not:C34(DateIsValid ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;0)))
			ADD TO SET:C119([Asignaturas_RegistroSesiones:168];"$sesionesFueraDePeriodos")
		End if 
	End for 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$recnumIndex/Size of array:C274($aRecNums);"Buscando registros de sesiones de clases con fechas inválidas...")
End for 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)
If (Records in set:C195("$sesionesFueraDePeriodos")>0)
	UNION:C120("$SesionesInvalidas";"$sesionesFueraDePeriodos";"$SesionesInvalidas")
End if 
  // .FASE 3.

  // FASE 4.
If (Current date:C33(*)<$d_fechaTerminoAño)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>Current date:C33(*))
	CREATE SET:C116([Asignaturas_RegistroSesiones:168];"$SesionesFuturo")
	UNION:C120("$SesionesInvalidas";"$SesionesFuturo";"$SesionesInvalidas")
End if 

  // elimino las sesiones invalidas
If (Records in set:C195("$SesionesInvalidas")>0)
	USE SET:C118("$SesionesInvalidas")
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_recNumSesionesInvalidas)
	$l_sesionesEliminadas:=ASrs_EliminaSesiones (->$al_recNumSesionesInvalidas)
End if 
  //.ELIMINACION DE SESIONES DE CLASES INVALIDAS
SET_ClearSets ("$SesionesInvalidas";"$SesionesFuturo";"$sesionesFueraDePeriodos";"$SesionesfueraHorario";"$huerfanos")






  // ELIMINACION DE INASISTENCIAS A CLASES INVALIDAS
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ ONLY:C145([Asignaturas:18])

  // obtengo las fechas de inicio y termino del año escolar actual
  // (buscando en las configuraciones de período la fecha de inicio mas temprana y la fecha de término más tardía)
PERIODOS_Init 
$d_fechaInicioAño:=PERIODOS_InicioAñoSTrack 
$d_fechaTerminoAño:=PERIODOS_FinAñoPeriodosSTrack 

  // creo un conjunto vacío en el que pondré los registros inválidos
CREATE EMPTY SET:C140([Asignaturas_Inasistencias:125];"$InasistenciasInvalidas")

  // FASE 1. Busco los registro de inasistencias del ano actual no relacionados con ninguna sesion de clases
$l_IdmensajeProceso:=IT_UThermometer (1;0;__ ("Verificando paridad de registros de Inasistencias a clases con registros de Sesiones a clases..."))
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$todos")
QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$d_fechaTerminoAño)
KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$validos")
DIFFERENCE:C122("$todos";"$validos";"$huerfanos")
If (Records in set:C195("$huerfanos")>0)
	UNION:C120("$InasistenciasInvalidas";"$huerfanos";"$InasistenciasInvalidas")
End if 
  // .FASE 1

  // FASE 2. Busco  los registro de inasistencias del año actual no relacionados con ninguna asignatura
$l_IdmensajeProceso:=IT_UThermometer (0;$l_IdmensajeProceso;__ ("Verificando paridad de registros de Inasistencias a clases con registros de Asignaturas..."))
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$todos")
ALL RECORDS:C47([Asignaturas:18])
KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero:1)
QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$validos")
DIFFERENCE:C122("$todos";"$validos";"$huerfanos")
If (Records in set:C195("$huerfanos")>0)
	UNION:C120("$InasistenciasInvalidas";"$huerfanos";"$InasistenciasInvalidas")
End if 
  // .FASE 2

  // FASE 3. Busco los registro de inasistencias del año actual no relacionados con ningún alumno
$l_IdmensajeProceso:=IT_UThermometer (0;$l_IdmensajeProceso;__ ("Verificando paridad de registros de Inasistencias a clases con registros de Asignaturas..."))
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$todos")
ALL RECORDS:C47([Alumnos:2])
KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]numero:1)
QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$validos")
DIFFERENCE:C122("$todos";"$validos";"$huerfanos")
If (Records in set:C195("$huerfanos")>0)
	UNION:C120("$InasistenciasInvalidas";"$huerfanos";"$InasistenciasInvalidas")
End if 
$l_IdmensajeProceso:=IT_UThermometer (-2;$l_IdmensajeProceso)
  // .FASE 3.

  // FASE 4. Busco los registro de inasistencias del año actual no relacionados con ninguna asignación de horario
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE EMPTY SET:C140([Asignaturas_Inasistencias:125];"$InasistenciasfueraHorario")
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$al_RecNums;"")
$l_progressProcess:=IT_Progress (1;0;0;"Buscando registros de inasistencias a clase en horario inválido...")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Asignaturas_Inasistencias:125];$al_RecNums{$i})
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=[Asignaturas_Inasistencias:125]ID_Sesión:1)
	If (Records in selection:C76([Asignaturas_RegistroSesiones:168])=1)
		QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas_Inasistencias:125]ID_Asignatura:6;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=[Asignaturas_RegistroSesiones:168]NumeroDia:15;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=[Asignaturas_RegistroSesiones:168]Hora:4)
		If (Records in selection:C76([TMT_Horario:166])=0)
			ADD TO SET:C119([Asignaturas_Inasistencias:125];"$InasistenciasfueraHorario")
		End if 
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$i/Size of array:C274($al_RecNums);"Buscando registros de sesiones de clases en horario inválido...")
End for 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)
If (Records in set:C195("$InasistenciasfueraHorario")>0)
	UNION:C120("$InasistenciasInvalidas";"$InasistenciasfueraHorario";"$InasistenciasInvalidas")
End if 
  // .FASE 4

  // FASE 5. Busco los registros de inasistencia a clases con fechas inválidas
$l_progressProcess:=IT_Progress (1;0;0;"Buscando registro de inasistencias a clase con fechas inválidas...")
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125];$aRecNums)
READ WRITE:C146([Asignaturas_Inasistencias:125])
CREATE EMPTY SET:C140([Asignaturas_Inasistencias:125];"$InasistenciasFueraDePeriodos")
$l_ultimoNivel:=0
For ($recnumIndex;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas_Inasistencias:125];$aRecNums{$recNumIndex})
	RELATE ONE:C42([Asignaturas_Inasistencias:125]ID_Asignatura:6)
	If ([Asignaturas:18]Numero_del_Nivel:6#$l_ultimoNivel)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$l_ultimoNivel:=[Asignaturas:18]Numero_del_Nivel:6
	End if 
	If (Not:C34(DateIsValid ([Asignaturas_Inasistencias:125]dateSesion:4;0)))
		ADD TO SET:C119([Asignaturas_Inasistencias:125];"$InasistenciasFueraDePeriodos")
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$recnumIndex/Size of array:C274($aRecNums);"Buscando registro de inasistencias a clase con fechas inválidas...")
End for 
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])
If (Records in set:C195("$InasistenciasFueraDePeriodos")>0)
	UNION:C120("$InasistenciasInvalidas";"$InasistenciasFueraDePeriodos";"$InasistenciasInvalidas")
End if 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)
  // FASE .5

  // Elimino los registros de inasistencias inválidos.
USE SET:C118("$InasistenciasInvalidas")
LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$al_recNumInasistencias)
For ($i_inasistencias;1;Size of array:C274($al_recNumInasistencias))
	KRL_GotoRecord (->[Asignaturas_Inasistencias:125];$al_recNumInasistencias{$i_inasistencias})
	$l_IdAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
	$d_fechaSesion:=[Asignaturas_Inasistencias:125]dateSesion:4
	$l_invalidosEliminados:=KRL_DeleteRecord (->[Asignaturas_Inasistencias:125])
	If ($l_invalidosEliminados=1)
		AL_InasistenciaDiariaPorHoras ($l_IdAlumno;$d_fechaSesion)
	Else 
		$i_inasistencias:=Size of array:C274($al_recNumInasistencias)
	End if 
End for 
  //.ELIMINACION DE INASISTENCIAS A CLASES INVALIDAS



SET_ClearSets ("$InasistenciasInvalidas";"$InasistenciasFueraDePeriodos";"$InasistenciasfueraHorario";"$huerfanos")




QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
KRL_RelateSelection (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_RecNums;"")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos:2];$al_RecNums{$i_registros})
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1)
	DISTINCT VALUES:C339([Asignaturas_Inasistencias:125]dateSesion:4;$ad_fechaSesion)
	$l_idalumno:=[Alumnos:2]numero:1
	For ($i_inasistencias;1;Size of array:C274($ad_fechaSesion))
		AL_InasistenciaDiariaPorHoras ($l_idalumno;$ad_fechaSesion{$i_inasistencias})
	End for 
End for 







