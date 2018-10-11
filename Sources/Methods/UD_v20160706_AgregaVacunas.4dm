//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 06-07-16, 15:49:19
  // ----------------------------------------------------
  // Método: UD_v20160706_AgregaVacunas
  // Descripción
  // Método creado para configurar el nuevo calendario de vacunas, actualmente son arreglos
  //
  // Parámetros
  // ----------------------------------------------------

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Vacunas:101])
QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="activo")
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_recnumalu)
READ WRITE:C146([Alumnos_Vacunas:101])
QUERY WITH ARRAY:C644([Alumnos_Vacunas:101]Numero_Alumno:1;$al_recnumalu)
QUERY SELECTION:C341([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Vacunado:5=False:C215)
  //se eliminan las vacunas que no esten validadas en la BD
ok:=KRL_DeleteSelection (->[Alumnos_Vacunas:101])
If (ok=1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando vacunas...")
	  //se crean los registros de vacunas nuevos
	For ($i;1;Size of array:C274($al_recnumalu))
		AL_CreaRegistrosVacunacion ($al_recnumalu{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recnumalu);"Verificando vacunas")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Vacunas:101])