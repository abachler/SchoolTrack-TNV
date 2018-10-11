//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 29-01-16, 18:41:19
  // ----------------------------------------------------
  // Método: STR_eliminaAtrasos
  // Descripción
  // metodo utilizado para eliminar los atrasos se creo para ser usado 
  // en la configuracion de las tablas de atrasos y recalculo totales 
  // para la visualizacion en el explorador
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_procesoProgreso;$i;$l_atrasosEliminados)

QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=<>gyear)
$l_atrasosEliminados:=Records in selection:C76([Alumnos_Atrasos:55])

KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;"")
KRL_DeleteSelection (->[Alumnos_Atrasos:55])
LOG_RegisterEvt ("Fueron eliminados "+String:C10($l_atrasosEliminados)+" del año "+String:C10(<>gyear)+" por cambio en la configuración de atrasos en Conducta y Asistencia")
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_alumnos;"")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"")
For ($x;1;Size of array:C274($al_alumnos))
	GOTO RECORD:C242([Alumnos:2];$al_alumnos{$x})
	AL_CuentaEventosConducta ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($al_alumnos);"Recalculando totales...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



