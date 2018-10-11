//%attributes = {}
  // UD_v20161227_FixCargos_Id_0()
  //
  //
  // creado por: Alberto Bachler Klein: 27-12-16, 16:03:21
  // -----------------------------------------------------------
C_LONGINT:C283($i_registros;$l_ProgressProcID)
C_POINTER:C301($y_tabla)

ARRAY LONGINT:C221($al_recNum;0)

  //elimino de la tabla ACT Cargos los registros con ID 0 que no debieran existir  y generan errores durante la verificación de base de datos.
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1;=;0;*)
QUERY:C277([ACT_Cargos:173]; & [ACT_Cargos:173]Fecha_de_Vencimiento:7;=;!00-00-00!)
KRL_DeleteSelection (->[ACT_Cargos:173])

  // asigno ID a a Cargos con ID 0
SQ_CargaDatos 
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1;=;0)
$y_tabla:=->[ACT_Cargos:173]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"Reasignado Id a Cargos")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
	If (OK=1)
		[ACT_Cargos:173]ID:1:=SQ_SeqNumber (->[ACT_Cargos:173]ID:1)
		SAVE RECORD:C53($y_Tabla->)
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212($y_tabla->)


