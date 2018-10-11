//%attributes = {}
  // UD_v20160624_InitCamposBonif()
  // 
  //
  // creado por: Alberto Bachler Klein: 24-06-16, 20:14:49
  // -----------------------------------------------------------

<>vb_ImportHistoricos_STX:=True:C214
ALL RECORDS:C47([Alumnos_Calificaciones:208])
$y_tabla:=->[Alumnos_Calificaciones:208]
ARRAY LONGINT:C221($al_recNum;0)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"Inicializando campos para bonificación extra-académica")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
	If (OK=1)
		For ($i;510;534;5)
			Field:C253(208;$i)->:=-10
			Field:C253(208;$i+1)->:=-10
			Field:C253(208;$i+2)->:=-10
			Field:C253(208;$i+3)->:=""
			Field:C253(208;$i+4)->:=""
		End for 
		SAVE RECORD:C53($y_Tabla->)
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212($y_tabla->)
<>vb_ImportHistoricos_STX:=False:C215