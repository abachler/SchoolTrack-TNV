//%attributes = {}
  //AL_HorasInasistencia

C_TEXT:C284($1;$selector)
C_LONGINT:C283($2;$idAlumno)
$selector:=$1
$idAlumno:=$2

$size:=0
ARRAY INTEGER:C220(al_AbsencesTerm1;$size)
ARRAY INTEGER:C220(al_AbsencesTerm2;$size)
ARRAY INTEGER:C220(al_AbsencesTerm3;$size)
ARRAY INTEGER:C220(al_AbsencesTerm4;$size)
ARRAY INTEGER:C220(al_AbsencesTotal;$size)
ARRAY INTEGER:C220(al_AbsencesPercent;$size)
ARRAY REAL:C219(ar_AbsencesPercent;$size)

READ ONLY:C145([Alumnos:2])


QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$idAlumno)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;al_SubjectID;[Asignaturas:18]denominacion_interna:16;at_subjectName;[Asignaturas:18]Horas_Semanales:51;al_HorasSemanales;[Asignaturas:18]Horas_de_clases_efectivas:52;al_HorasEfectivas;[Asignaturas:18]Incide_en_Asistencia:45;ab_IncideEnAsistencia;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas)

CREATE EMPTY SET:C140([Asignaturas_Inasistencias:125];"INA_ALU")

For ($x;1;Size of array:C274(adSTR_Periodos_Desde))
	
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$idAlumno;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=adSTR_Periodos_Desde{$x};*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=adSTR_Periodos_Hasta{$x};*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
	CREATE SET:C116([Asignaturas_Inasistencias:125];"INA")
	UNION:C120("INA_ALU";"INA";"INA_ALU")
	
End for 

USE SET:C118("INA_ALU")
SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Asignatura:6;$al_SubjectID;[Asignaturas_Inasistencias:125]Justificacion:3;$aJustificacion;[Asignaturas_Inasistencias:125]dateSesion:4;$aDate)
SET_ClearSets ("INA_ALU";"INA")
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

$totalHorasIncidencia:=0
$totalHorasGeneral:=0
For ($i;1;Size of array:C274(at_subjectName))
	$totalHorasGeneral:=$totalHorasGeneral+al_HorasEfectivas{$i}
	If (ab_IncideEnAsistencia{$i})
		$totalHorasIncidencia:=$totalHorasIncidencia+al_HorasEfectivas{$i}
	End if 
End for 

$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)

Case of 
	: ($selector="Total")
		$totalPointer:=$3
		$percentPointer:=$4
		$totalHorasEfectivasPointer:=$5
		Case of 
			: ($modoRegistroAsistencia=2)
				$totalHorasEfectivasPointer->:=$totalHorasIncidencia
				$totalPointer->:=Size of array:C274($al_SubjectID)
				$percentPointer->:=Round:C94(($totalHorasIncidencia-$totalPointer->)/$totalHorasIncidencia*100;1)
			: ($modoRegistroAsistencia=4)
				$totalHorasEfectivasPointer->:=$totalHorasIncidencia
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)
				$totalPointer->:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
				$percentPointer->:=Round:C94(($totalHorasIncidencia-$totalPointer->)/$totalHorasIncidencia*100;1)
		End case 
		
		
	: ($selector="Mensual")
		$arrayPointer:=$3  //arreglo de punteros sobre los arreglos meses
		$arrayIndexPointer:=$4  // linea de los arreglos meses a las que se asigna el numero de horas
		Case of 
			: ($modoRegistroAsistencia=2)
				For ($i;1;Size of array:C274($arrayPointer->))
					$monthPointer:=$arrayPointer->{$i}
					$monthPointer->{$arrayIndexPointer->}:=0
				End for 
				For ($i;1;Size of array:C274($aDate))
					$mes:=Find in array:C230(ai_NumerosMes;Month of:C24($aDate{$i}))
					If ($mes>0)
						$monthPointer:=$arrayPointer->{$mes}
						$monthPointer->{$arrayIndexPointer->}:=$monthPointer->{$arrayIndexPointer->}+1
					End if 
				End for 
				
			: ($modoRegistroAsistencia=2)
				For ($i;1;Size of array:C274($arrayPointer->))
					$monthPointer:=$arrayPointer->{$i}
					$monthPointer->{$arrayIndexPointer->}:=0
				End for 
		End case 
		
		
		
	: ($selector="Periodos")
		$arrayPointer:=$3  //arreglo de punteros sobre los arreglos periodos
		$arrayIndexPointer:=$4  // linea de los arreglos periodos a las que se asigna el numero de horas
		
		Case of 
			: ($modoRegistroAsistencia=2)
				For ($i;1;Size of array:C274($arrayPointer->))
					$periodoPointer:=$arrayPointer->{$i}
					$periodoPointer->{$arrayIndexPointer->}:=0
				End for 
				For ($i;1;Size of array:C274($al_SubjectID))
					If ($aDate{$i}#!00-00-00!)
						Case of 
							: (($aDate{$i}>=adSTR_Periodos_Desde{1}) & ($aDate{$i}<=adSTR_Periodos_Hasta{1}))
								$periodo:=1
							: (($aDate{$i}>=adSTR_Periodos_Desde{2}) & ($aDate{$i}<=adSTR_Periodos_Hasta{2}))
								$periodo:=2
						End case 
						If (Size of array:C274(adSTR_Periodos_Desde)>2)
							If (($aDate{$i}>=adSTR_Periodos_Desde{3}) & ($aDate{$i}<=adSTR_Periodos_Hasta{3}))
								$periodo:=3
							End if 
						End if 
						If (Size of array:C274(adSTR_Periodos_Desde)>3)
							If (($aDate{$i}>=adSTR_Periodos_Desde{4}) & ($aDate{$i}<=adSTR_Periodos_Hasta{4}))
								$periodo:=4
							End if 
						End if 
						$periodoPointer:=$arrayPointer->{$periodo}
						$periodoPointer->{$arrayIndexPointer->}:=$periodoPointer->{$arrayIndexPointer->}+1
					End if 
				End for 
				
				
				
			: ($modoRegistroAsistencia=4)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10($idAlumno)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210];->$key;False:C215)
				$arrayPointer->{1}:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
				$arrayPointer->{2}:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
				$arrayPointer->{3}:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
				$arrayPointer->{4}:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
				$arrayPointer->{5}:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
		End case 
		
	: ($selector="asignaturas")
		$arrayPointer:=$3  //arreglo de punteros sobre los arreglos nombres de asignatura, horas semanales, 
		  //horas efectuadas y horas de inasistencia
		$arrayIndexPointer:=$4  // linea de los arreglos asignaturas a las que se asigna el numero de horas de 
		  //inasistencia
		
		  //For ($i;1;Size of array($al_SubjectID))
		  //$element:=Find in array(al_SubjectID;$al_SubjectID{$i})
		  //If ($element>0)
		
		  //End if 
		  //End for 
End case 

