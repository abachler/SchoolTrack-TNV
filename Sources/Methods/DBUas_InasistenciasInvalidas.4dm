//%attributes = {}
  // DBU_InasistenciasInvalidas()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/12/12, 10:14:29
  // ---------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_OpcionEliminar)
C_DATE:C307($d_fechaInicioAño;$d_fechaTerminoAño)
C_LONGINT:C283($i;$l_IdmensajeProceso;$l_inasistenciasInvalidas;$l_invalidosEliminados;$l_numeroDia_ISO;$l_progressProcess)
C_TEXT:C284($t_contenidoTexto;$t_descripcion;$t_Encabezado;$t_mensajeEliminacion;$t_mensajeExito;$t_mensajeFalla;$t_uuid)

ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)
ARRAY LONGINT:C221($al_NumeroNivel;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_Alumnos;0)
ARRAY TEXT:C222($at_Asignaturas;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY TEXT:C222($at_Errores;0)
ARRAY TEXT:C222($at_Fecha_y_NoHora;0)
ARRAY TEXT:C222($at_Nivel;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)
If (False:C215)
	C_TEXT:C284(DBUas_InasistenciasInvalidas ;$1)
End if 

  // CODIGO
If (Count parameters:C259=1)
	$b_OpcionEliminar:=($1="True")
End if 

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
QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$d_fechaInicioAño;*)
QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$d_fechaTerminoAño)
CREATE SET:C116([Asignaturas_Inasistencias:125];"$validos")
DIFFERENCE:C122("$todos";"$validos";"$huerfanos")

If (Records in set:C195("$huerfanos")>0)
	UNION:C120("$InasistenciasInvalidas";"$huerfanos";"$InasistenciasInvalidas")
	USE SET:C118("$huerfanos")
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Asignaturas_Inasistencias:125];$aRecNums{$i})
		APPEND TO ARRAY:C911($at_Errores;__ ("Inasistencia a clases sin relación con ninguna sesión de clases"))
		APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
		APPEND TO ARRAY:C911($al_NumeroNivel;KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero_del_Nivel:6))
		APPEND TO ARRAY:C911($at_Asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16))
		APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40))
		APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Nivel:30))
		APPEND TO ARRAY:C911($at_Curso;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Curso:5))
		APPEND TO ARRAY:C911($at_Fecha_y_NoHora;String:C10([Asignaturas_Inasistencias:125]dateSesion:4;System date long:K1:3)+", "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+__ ("ª hora"))
	End for 
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
	USE SET:C118("$huerfanos")
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Asignaturas_Inasistencias:125];$aRecNums{$i})
		APPEND TO ARRAY:C911($at_Errores;__ ("Inasistencia a clases sin relación con ninguna asignatura."))
		APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
		APPEND TO ARRAY:C911($al_NumeroNivel;KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero_del_Nivel:6))
		APPEND TO ARRAY:C911($at_Asignaturas;"Asignatura inexistente")
		APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40))
		APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Asignaturas:18]Nivel:30))
		APPEND TO ARRAY:C911($at_Curso;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Asignaturas:18]Curso:5))
		APPEND TO ARRAY:C911($at_Fecha_y_NoHora;String:C10([Asignaturas_Inasistencias:125]dateSesion:4;System date long:K1:3)+", "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+__ ("ª hora"))
	End for 
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
	USE SET:C118("$huerfanos")
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Asignaturas_Inasistencias:125];$aRecNums{$i})
		APPEND TO ARRAY:C911($at_Errores;__ ("Inasistencia a clases sin relación con ninguna asignatura."))
		APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
		APPEND TO ARRAY:C911($al_NumeroNivel;KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero_del_Nivel:6))
		APPEND TO ARRAY:C911($at_Asignaturas;"Asignatura inexistente")
		APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40))
		APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Asignaturas:18]Nivel:30))
		APPEND TO ARRAY:C911($at_Curso;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Asignaturas:18]Curso:5))
		APPEND TO ARRAY:C911($at_Fecha_y_NoHora;String:C10([Asignaturas_Inasistencias:125]dateSesion:4;System date long:K1:3)+", "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+__ ("ª hora"))
	End for 
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
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroDia:1=[Asignaturas_RegistroSesiones:168]NumeroDia:15;*)
		QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]NumeroHora:2=[Asignaturas_RegistroSesiones:168]Hora:4)
		If (Records in selection:C76([TMT_Horario:166])=0)
			ADD TO SET:C119([Asignaturas_Inasistencias:125];"$InasistenciasfueraHorario")
			APPEND TO ARRAY:C911($at_Errores;__ ("Inasistencia a clases fuera de horario"))
			APPEND TO ARRAY:C911($al_colores;Red:K11:4)
			APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
			APPEND TO ARRAY:C911($al_NumeroNivel;KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero_del_Nivel:6))
			APPEND TO ARRAY:C911($at_Asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16))
			APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40))
			APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Nivel:30))
			APPEND TO ARRAY:C911($at_Curso;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Curso:5))
			APPEND TO ARRAY:C911($at_Fecha_y_NoHora;String:C10([Asignaturas_Inasistencias:125]dateSesion:4;System date long:K1:3)+", "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+__ ("ª hora"))
		End if 
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$i/Size of array:C274($al_RecNums);"Buscando registros de sesiones de clases en horario inválido...")
End for 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)

If (Records in set:C195("$InasistenciasfueraHorario")>0)
	UNION:C120("$InasistenciasInvalidas";"$InasistenciasfueraHorario";"$InasistenciasInvalidas")
End if 
  // .FASE 4




  // Busco los registros de inasistencia a clases con fechas inválidas
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
		APPEND TO ARRAY:C911($at_Errores;__ ("Inasistencia a clases con fecha inválida"))
		APPEND TO ARRAY:C911($al_colores;Red:K11:4)
		APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
		APPEND TO ARRAY:C911($al_NumeroNivel;KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero_del_Nivel:6))
		APPEND TO ARRAY:C911($at_Asignaturas;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]denominacion_interna:16))
		APPEND TO ARRAY:C911($at_Alumnos;KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40))
		APPEND TO ARRAY:C911($at_Nivel;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Nivel:30))
		APPEND TO ARRAY:C911($at_Curso;KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Curso:5))
		APPEND TO ARRAY:C911($at_Fecha_y_NoHora;String:C10([Asignaturas_Inasistencias:125]dateSesion:4;System date long:K1:3)+", "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+__ ("ª hora"))
	End if 
	$l_progressProcess:=IT_Progress (0;$l_progressProcess;$recnumIndex/Size of array:C274($aRecNums);"Buscando registro de inasistencias a clase con fechas inválidas...")
End for 
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([Asignaturas:18])
If (Records in set:C195("$InasistenciasFueraDePeriodos")>0)
	UNION:C120("$InasistenciasInvalidas";"$InasistenciasFueraDePeriodos";"$InasistenciasInvalidas")
End if 
$l_progressProcess:=IT_Progress (-1;$l_progressProcess)



  // registro en el centro de notificaciones y opción de eliminación de registros inválidos
If (Size of array:C274($at_Errores)>0)
	If ($b_OpcionEliminar)
		$l_inasistenciasInvalidas:=Records in set:C195("$InasistenciasInvalidas")
		$t_mensajeEliminacion:=__ ("Se detectaron ^0 registros de inasistencias de clases inválidos.\r\r¿Desea eliminar los ^1 registros de inasistencias a clase inválidos?";String:C10($l_inasistenciasInvalidas);String:C10($l_inasistenciasInvalidas))
		OK:=CD_Dlog (0;$t_mensajeEliminacion;"";"Eliminar";"No")
		If (OK=1)
			USE SET:C118("$InasistenciasInvalidas")
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Inasistencias:125];$al_recNumInasistencias)
			For ($i_inasistencias;1;Size of array:C274($al_recNumInasistencias))
				KRL_GotoRecord (->[Asignaturas_Inasistencias:125];$al_recNumInasistencias{$i_inasistencias})
				$l_IdAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
				$d_fechaSesion:=[Asignaturas_Inasistencias:125]dateSesion:4
				$l_invalidosEliminados:=KRL_DeleteRecord (->[Asignaturas_Inasistencias:125])
				If ($l_invalidosEliminados=1)
					AL_InasistenciaDiariaPorHoras ($l_IdAlumno;$d_fechaSesion)
					$i_inasistencias:=Size of array:C274($al_recNumInasistencias)
				End if 
			End for 
			For ($i;1;Size of array:C274($al_colores))
				$al_colores{$i}:=Green:K11:9
			End for 
		End if 
	End if 
	
	$t_Encabezado:=__ ("Verificación de la paridad entre registros de inasistencias a clases y Asignaturas, Alumnos, Sesiones de clases y Horario")
	$t_descripcion:=__ ("Los registros de inasistencias a clases deben estar relacionados a una sesión de clases, a un alumno y a una asignatura y deben corresponder a una asignación de horario.\r")
	$t_descripcion:=$t_descripcion+__ ("Esta herramienta permite detectar y eventualmente eliminar los registros inválidos.\r")
	$t_descripcion:=$t_descripcion+__ ("Utilice la lista desplegable bajo la lista para Repetir el análisis. Si se detectan registros inválidos podrá optar por eliminar esos registros.\r")
	If ($l_invalidosEliminados=1)
		$t_descripcion:=$t_descripcion+__ ("Se encontraron registros de inasistencias a clases inválidos.\r\r")
		$t_descripcion:=$t_descripcion+__ ("La lista mas abajo muestra las asignaturas y alumnos para los que se detectaron registros de inasistencia a clases inválidos.\r")
		$t_descripcion:=$t_descripcion+__ ("Los registros de inasistencias a clases inválidos fueron eliminados.\r")
	Else 
		$t_descripcion:=$t_descripcion+__ ("Se encontraron registros de inasistencias a clases inválidos.\r")
		$t_descripcion:=$t_descripcion+__ ("La lista mas abajo muestra las asignaturas y alumnos para los que se detectaron registros de inasistencia a clases inválidos.\r")
	End if 
	AT_MultiLevelSort (">>>>";->$al_NumeroNivel;->$at_Curso;->$at_Asignaturas;->$at_Alumnos;->$at_nivel;->$at_Fecha_y_NoHora;->$at_errores)
	$t_contenidoTexto:=""
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Advertencia o Error")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Nivel")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Curso")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Asignatura")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Alumnos")
	APPEND TO ARRAY:C911($at_TitulosColumnas;"Fecha y hora")
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_errores;->$at_nivel;->$at_Curso;->$at_Asignaturas;->$at_Alumnos;->$at_Fecha_y_NoHora)
	NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	$t_mensajeFalla:=""
	$t_mensajeExito:="No se detectó ninguna inconsistencia entre los registros de inasistencia a clases y las asignaciones de horario."
	NTC_Mensaje_MetodoAsociado ($t_uuid;Current method name:C684+";True";$t_mensajeFalla;$t_mensajeExito)
	$0:=-1
End if 

SET_ClearSets ("$todos";"$validos";"$huerfanos";"$InasistenciasInvalidas";"$InasistenciasfueraHorario")

