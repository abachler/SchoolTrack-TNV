//%attributes = {}
  // MÉTODO: EV2_InicializaPromedios
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 31/01/12, 19:28:18
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_InicializaPromedios()
  // ----------------------------------------------------
C_BLOB:C604($x_ArreglosRecalculos)
C_BOOLEAN:C305($b_Promediosmodificados)
C_LONGINT:C283($i;$l_ProgresProcID;$l_PromediosModificados;$l_serverProcess)
C_REAL:C285($real)
C_TEXT:C284($t_Literal)

ARRAY LONGINT:C221($al_AlumnosRecalculo;0)
ARRAY LONGINT:C221($al_AsignaturaRecalculo;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY TEXT:C222($at_CursosRecalculo;0)


  // CODIGO PRINCIPAL
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]denominacion_interna:16;>)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$aRecNums;"")

<>vb_ImportHistoricos_STX:=True:C214
$l_ProgresProcID:=IT_Progress (1;0;0;"Inicializando promedios......")
$l_ID_asignaturaActual:=0
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Alumnos_Calificaciones:208])
	GOTO RECORD:C242([Alumnos_Calificaciones:208];$aRecNums{$i})
	
	If ($l_ID_asignaturaActual#[Alumnos_Calificaciones:208]ID_Asignatura:5)
		RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Asignatura:5)
		$l_ID_asignaturaActual:=[Alumnos_Calificaciones:208]ID_Asignatura:5
	End if 
	
	$b_Promediosmodificados:=EV2_BorraPromedios ($aRecNums{$i})
	
	  // si hubo modificación de promedios agrego los elementos actuales a los arreglos para la creación de tareas de recalculo de promedios generales
	If ($b_PromediosModificados)
		$l_PromediosModificados:=$l_PromediosModificados+1
		If (Find in array:C230($al_AlumnosRecalculo;[Alumnos_Calificaciones:208]ID_Alumno:6)<0)
			APPEND TO ARRAY:C911($al_AlumnosRecalculo;[Alumnos_Calificaciones:208]ID_Alumno:6)
			RELATE ONE:C42([Alumnos_Calificaciones:208]ID_Alumno:6)
			If (Find in array:C230($at_CursosRecalculo;[Alumnos:2]curso:20)<0)
				APPEND TO ARRAY:C911($at_CursosRecalculo;[Alumnos:2]curso:20)
			End if 
		End if 
		If (Find in array:C230($al_AsignaturaRecalculo;[Alumnos_Calificaciones:208]ID_Asignatura:5)<0)
			APPEND TO ARRAY:C911($al_AsignaturaRecalculo;[Alumnos_Calificaciones:208]ID_Asignatura:5)
		End if 
	End if 
	
	$l_ProgresProcID:=IT_Progress (0;$l_ProgresProcID;$i/Size of array:C274($aRecNums);"Inicializando promedios...\r"+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
End for 
<>vb_ImportHistoricos_STX:=False:C215
$l_ProgresProcID:=IT_Progress (-1;$l_ProgresProcID)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])

  // se crean las tareas de recalculo de promedios generales
If ((Size of array:C274($al_AsignaturaRecalculo)+Size of array:C274($al_AlumnosRecalculo)+Size of array:C274($at_CursosRecalculo))>0)
	BLOB_Variables2Blob (->$x_ArreglosRecalculos;0;->$al_AsignaturaRecalculo;->$al_AlumnosRecalculo;->$at_CursosRecalculo)
	$l_serverProcess:=Execute on server:C373("EV2_TareasRecalculosPromedios";128000;"TareasRecalculoPromediosGenerales";$x_ArreglosRecalculos)
End if 
$0:=$l_PromediosModificados  // retorno el numero de registros [Alumnos_Calificaciones] con modificaciones en promedios

