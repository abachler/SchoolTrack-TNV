//%attributes = {}
  //AL_CargaEventosConducta

C_POINTER:C301($yfield_IDAlumno;$yfield_Fecha;$yfield_Año;$yVariable_Count;$2;$3;$4)
C_TEXT:C284($tipoEvento)

$tipoEvento:=$1
$yfield_IDAlumno:=$2
$yfield_Fecha:=$3
$yfield_Año:=$4




$yTable_Evento:=Table:C252(Table:C252($yfield_IDAlumno))

C_LONGINT:C283($err)
READ ONLY:C145($yTable_Evento->)
vt_alerta:=""
If (vl_year<<>gYear)
	QUERY:C277($yTable_Evento->;$yField_IDAlumno->;=;-[Alumnos:2]numero:1)
Else 
	QUERY:C277($yTable_Evento->;$yField_IDAlumno->=[Alumnos:2]numero:1)
End if 
CREATE SET:C116($yTable_Evento->;"eventos")


GET LIST ITEM:C378(hl_ciclosEscolares_Completo;*;vl_referenciaCicloCompleto;$nombreCiclo)
$nombreAño:=ST_ClearSpaces (ST_GetWord ($nombreCiclo;1;": "))
$nivelNombre:=ST_ClearSpaces (ST_GetWord ($nombreCiclo;2;": "))

If ((vl_PeriodoSeleccionado>0) & (Size of array:C274(atSTR_Periodos_Nombre)>0))
	$desde:=adSTR_Periodos_Desde{vl_PeriodoSeleccionado}
	$hasta:=adSTR_Periodos_hasta{vl_PeriodoSeleccionado}
	If (($desde#!00-00-00!) & ($hasta#!00-00-00!))
		QUERY SELECTION:C341($yTable_Evento->; & ;$yField_Fecha->>=$desde;*)
		QUERY SELECTION:C341($yTable_Evento->; & ;$yField_Fecha-><=$hasta)
		vt_alerta:=""
		AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;vl_PeriodoSeleccionado)
	Else 
		vt_alerta:="No hay fechas de inicio y término de los períodos en "+ST_ClearSpaces ($nombreCiclo)+". Se muestran todos los eventos registrados en "+$nombreAño
		QUERY SELECTION:C341($yTable_Evento->;$yField_Año->=vl_year)
		
		vl_referenciaCicloCompleto:=-Num:C11(String:C10(vl_year;"0000")+String:C10(vl_NivelSeleccionado;"00")+"0")
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ciclosEscolares_Completo;vl_referenciaCicloCompleto)
		AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;0)
	End if 
Else 
	If (vl_PeriodoSeleccionado>0)
		$desde:=adSTR_Periodos_Desde{1}
		$hasta:=adSTR_Periodos_hasta{Size of array:C274(adSTR_Periodos_hasta)}
		If (($desde#!00-00-00!) & ($hasta#!00-00-00!))
			QUERY SELECTION:C341($yTable_Evento->; & ;$yField_Fecha->>=$desde;*)
			QUERY SELECTION:C341($yTable_Evento->; & ;$yField_Fecha-><=$hasta)
			AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;vl_PeriodoSeleccionado)
		Else 
			QUERY SELECTION:C341($yTable_Evento->;$yField_Año->=vl_year)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_ciclosEscolares_Completo;vl_referenciaCicloCompleto)
			AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;0)
		End if 
	Else 
		QUERY SELECTION:C341($yTable_Evento->;$yField_Año->=vl_year)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ciclosEscolares_Completo;vl_referenciaCicloCompleto)
		AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;0)
	End if 
End if 

Case of 
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Anotaciones:11]))
		$counter:=vl_AnotacionesNeutras+vl_AnotacionesNegativas+vl_AnotacionesPositivas
	: (Table:C252($yTable_Evento)=Table:C252(->[Asignaturas_Inasistencias:125]))
		$counter:=vl_HorasInasistencia
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Inasistencias:10]))
		$counter:=vl_inasistencias
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Atrasos:55]))
		$counter:=vl_TotalAtrasos
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Castigos:9]))
		$counter:=vl_Castigos
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Suspensiones:12]))
		$counter:=vl_Suspensiones
	: (Table:C252($yTable_Evento)=Table:C252(->[Alumnos_Licencias:73]))
		$counter:=Records in selection:C76([Alumnos_Licencias:73])
End case 


$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
Case of 
	: ($l_modoRegistroAsistencia=2)
		vt_alerta:=""
		AL_CiclosEscolares_Completo ([Alumnos:2]numero:1)
		PERIODOS_LoadData (vl_NivelSeleccionado)
		
	: ((Records in selection:C76($yTable_Evento->)=0) & ($counter>0))
		vt_alerta:="No existen registros detallados de "+$tipoEvento+" en "+$nivelNombre+" para el año "+$nombreAño+". Se muestra solo el total de eventos de "+$tipoEvento+" registrados en "+$nombreAño
		vl_referenciaCicloCompleto:=-Num:C11(String:C10(vl_year;"0000")+String:C10(vl_NivelSeleccionado;"00")+"0")
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ciclosEscolares_Completo;vl_referenciaCicloCompleto)
		AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;0)
	: ((Records in selection:C76($yTable_Evento->)#$counter) & (vl_PeriodoSeleccionado#0))
		vt_alerta:="Hay inconsistencia entre el total de "+$tipoEvento+" de "+ST_ClearSpaces (ST_GetWord ($nombreCiclo;3;":"))+" y los registros de "+$tipoEvento+" registrados. Se muestran todos los eventos registrados en "+$nombreAño
		vl_referenciaCicloCompleto:=-Num:C11(String:C10(vl_year;"0000")+String:C10(vl_NivelSeleccionado;"00")+"0")
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ciclosEscolares_Completo;vl_referenciaCicloCompleto)
		AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;0)
		USE SET:C118("eventos")
		QUERY SELECTION:C341($yTable_Evento->;$yField_Año->=vl_year)
End case 
CLEAR SET:C117("Eventos")



