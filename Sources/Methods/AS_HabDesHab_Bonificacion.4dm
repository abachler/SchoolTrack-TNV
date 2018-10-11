//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 30-07-18, 15:31:17
  // ----------------------------------------------------
  // Método: AS_HabDesHab_Bonificacion
  // Descripción
  // 
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($t_msg;$t_accion)
C_LONGINT:C283($l_res;$l_habilitar;$l_otRef;$i_registros;$l_ProgressProcID)
C_BLOB:C604($x_blob)

If (yBWR_currentTable=->[Asignaturas:18])
	
	If (Size of array:C274(alBWR_recordNumber)>0)
		$t_msg:=__ ("Desea habilitar o deshabilitar la columna de bonificación para las asignaturas listadas en el explorador")
		$l_res:=CD_Dlog (0;$t_msg;"";__ ("Cancelar");__ ("Habilitar");__ ("Deshabilitar"))
		If ($l_res>1)
			If ($l_res=2)  //Habilitar
				$l_habilitar:=1
				$t_accion:=__ ("habilitado")
			Else 
				$t_accion:=__ ("deshabilitado")
			End if 
			
			$l_ProgressProcID:=IT_Progress (1;0;0;__ ("Configurando Bonificación"))
			For ($i_registros;1;Size of array:C274(alBWR_recordNumber))
				READ WRITE:C146([Asignaturas:18])
				GOTO RECORD:C242([Asignaturas:18];alBWR_recordNumber{$i_registros})
				If (Not:C34(Locked:C147([Asignaturas:18])))
					SET BLOB SIZE:C606($x_blob;0)
					$x_blob:=[Asignaturas:18]OpcionesControles_y_Examenes:106
					$l_otRef:=OT BLOBToObject ($x_blob)
					OT PutLong ($l_otRef;"vi_UsarBonificacion";$l_habilitar)
					  //la ponderación bonificaciones no las voy a tocar, dejaré comentado esto si el requerimiento se amplía
					  //OT PutReal ($l_otRef;"bonificacionP1";0)
					  //OT PutReal ($l_otRef;"bonificacionP2";0)
					  //OT PutReal ($l_otRef;"bonificacionP3";0)
					  //OT PutReal ($l_otRef;"bonificacionP4";0)
					  //OT PutReal ($l_otRef;"bonificacionP5";0)
					
					$x_blob:=OT ObjectToNewBLOB ($l_otRef)
					[Asignaturas:18]OpcionesControles_y_Examenes:106:=$x_blob
					SAVE RECORD:C53([Asignaturas:18])
					$t_msg:=__ ("La asignatura ^0 ^1, ha ^2 la columna de bonificacion correspondiente a controles y exámenes, desde herramientas, ejecutar.";[Asignaturas:18]denominacion_interna:16;[Asignaturas:18]Curso:5;$t_accion)
				Else 
					$t_msg:=__ ("La columna de bonificación no pudo ser ^0, debido a que la el registro de la asignatura ^1 ^2, estaba siendo utilizado en otro proceso.";$t_accion;[Asignaturas:18]denominacion_interna:16;[Asignaturas:18]Curso:5)
				End if 
				LOG_RegisterEvt ($t_msg)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274(alBWR_recordNumber))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
		End if 
	Else 
		CD_Dlog (0;__ ("Debe haber al menos una Asignatura en el explorador"))
	End if 
Else 
	CD_Dlog (0;__ ("Esta Herramienta debe ejecutarse desde el panel de Asignaturas"))
End if 