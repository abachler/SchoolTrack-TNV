//%attributes = {}
  // UD_v20160621_Bonificaciones()
  // 
  //
  // creado por: Alberto Bachler Klein: 21-06-16, 16:30:02
  // -----------------------------------------------------------

ALL RECORDS:C47([Asignaturas:18])


$y_tabla:=->[Asignaturas:18]
ARRAY LONGINT:C221($al_recNum;0)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
	If (OK=1)
		$x_blob:=[Asignaturas:18]OpcionesControles_y_Examenes:106
		$l_otRef:=OT BLOBToObject ($x_blob)
		
		  // ponderación bonificaciones
		OT PutLong ($l_otRef;"vi_UsarBonificacion";0)
		OT PutReal ($l_otRef;"bonificacionP1";0)
		OT PutReal ($l_otRef;"bonificacionP2";0)
		OT PutReal ($l_otRef;"bonificacionP3";0)
		OT PutReal ($l_otRef;"bonificacionP4";0)
		OT PutReal ($l_otRef;"bonificacionP5";0)
		
		$x_blob:=OT ObjectToNewBLOB ($l_otRef)
		[Asignaturas:18]OpcionesControles_y_Examenes:106:=$x_blob
		SAVE RECORD:C53($y_Tabla->)
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212($y_tabla->)
