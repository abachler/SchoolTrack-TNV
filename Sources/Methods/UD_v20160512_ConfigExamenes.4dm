//%attributes = {}
  // UD_v20160512_ConfigExamenes()
  //
  //
  // creado por: Alberto Bachler Klein: 12-05-16, 12:38:12
  // -----------------------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($i_registros;$l_otPeriodoComun;$l_otRef;$l_ProgressProcID)
C_POINTER:C301($y_table)

ARRAY LONGINT:C221($al_recNums;0)
ARRAY LONGINT:C221($al_tipoItems;0)
ARRAY TEXT:C222($at_NombreItems;0)

ALL RECORDS:C47([Asignaturas:18])
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNums)

$y_table:=->[Asignaturas:18]
$l_ProgressProcID:=IT_Progress (1;0;0;"Ajustando configuración de examenes…")
For ($i_registros;1;Size of array:C274($al_recNums))
	KRL_GotoRecord ($y_table;$al_recNums{$i_registros};True:C214)
	If (OK=1)
		  // si no hay información en el blob inicializo la configuración con los valores por defecto
		If (BLOB size:C605([Asignaturas:18]OpcionesControles_y_Examenes:106)=0)
			AS_Examenes_Inicializa_OLD 
			SAVE RECORD:C53([Asignaturas:18])
		Else 
			  // me aseguro que la información almacenada en el blob sea efectivamente un objeto OT
			$x_blob:=[Asignaturas:18]OpcionesControles_y_Examenes:106
			$l_otRef:=OT BLOBToObject ($x_blob)
			If (OT IsObject ($l_otRef)=0)
				AS_Examenes_Inicializa_OLD 
				SAVE RECORD:C53([Asignaturas:18])
				OT Clear ($l_otRef)
			Else 
				  //$l_otRef:=OT BLOBToObject ($x_blob)
				OT GetAllNamedProperties ($l_otRef;"";$at_NombreItems;$al_tipoItems)
				SORT ARRAY:C229($at_NombreItems;$al_tipoItems;>)
				If (OT ItemExists ($l_otRef;"vi_CorreccionNF_EX")=1)
					OT RenameItem ($l_otRef;"vi_CorreccionNF_EX";"vi_CorreccionNFEX")
				End if 
				If (OT ItemExists ($l_otRef;"vi_CorreccionNF_EXX")=1)
					OT RenameItem ($l_otRef;"vi_CorreccionNF_EXX";"vi_CorreccionNFEXX")
				End if 
				
				OT PutLong ($l_otRef;"EXP_ConfiguracionPorPeriodo";0)
				
				  // obtengo la configuracion del examen de fin de periodo
				c1_PonderacionConstante:=OT GetLong ($l_otRef;"c1_PonderacionConstante")
				c2_PonderacionVariable:=OT GetLong ($l_otRef;"c2_PonderacionVariable")
				t1_CTRL_INF_Ponderado:=OT GetLong ($l_otRef;"t1_CTRL_INF_Ponderado")
				t2_CTRL_INF_Control:=OT GetLong ($l_otRef;"t2_CTRL_INF_Control")
				t3_CTRL_INF_Presentacion:=OT GetLong ($l_otRef;"t3_CTRL_INF_Presentacion")
				t4_CTRL_INF_Especifico:=OT GetLong ($l_otRef;"t4_CTRL_INF_Especifico")
				u1_CTRL_SUP_Ponderado:=OT GetLong ($l_otRef;"u1_CTRL_SUP_Ponderado")
				u2_CTRL_SUP_Control:=OT GetLong ($l_otRef;"u2_CTRL_SUP_Control")
				u3_CTRL_SUP_Presentacion:=OT GetLong ($l_otRef;"u3_CTRL_SUP_Presentacion")
				u4_CTRL_SUP_Especifico:=OT GetLong ($l_otRef;"u4_CTRL_SUP_Especifico")
				vr_CTRL_PonderacionConstante:=OT GetReal ($l_otRef;"vr_CTRL_PonderacionConstante")
				vr_CTRL_INF_Ponderacion:=OT GetReal ($l_otRef;"vr_CTRL_INF_Ponderacion")
				vr_CTRL_SUP_Ponderacion:=OT GetReal ($l_otRef;"vr_CTRL_SUP_Ponderacion")
				vr_CTRL_INF_Especifico:=OT GetReal ($l_otRef;"vr_CTRL_INF_Especifico")
				vr_CTRL_SUP_Especifico:=OT GetReal ($l_otRef;"vr_CTRL_SUP_Especifico")
				  // elimino la configuracion de examen de periodo del objeto raiz
				OT DeleteItem ($l_otRef;"c1_PonderacionConstante")
				OT DeleteItem ($l_otRef;"c2_PonderacionVariable")
				OT DeleteItem ($l_otRef;"t1_CTRL_INF_Ponderado")
				OT DeleteItem ($l_otRef;"t2_CTRL_INF_Control")
				OT DeleteItem ($l_otRef;"t3_CTRL_INF_Presentacion")
				OT DeleteItem ($l_otRef;"t4_CTRL_INF_Especifico")
				OT DeleteItem ($l_otRef;"u1_CTRL_SUP_Ponderado")
				OT DeleteItem ($l_otRef;"u2_CTRL_SUP_Control")
				OT DeleteItem ($l_otRef;"u3_CTRL_SUP_Presentacion")
				OT DeleteItem ($l_otRef;"u4_CTRL_SUP_Especifico")
				OT DeleteItem ($l_otRef;"vr_CTRL_PonderacionConstante")
				OT DeleteItem ($l_otRef;"vr_CTRL_INF_Ponderacion")
				OT DeleteItem ($l_otRef;"vr_CTRL_SUP_Ponderacion")
				OT DeleteItem ($l_otRef;"vr_CTRL_INF_Especifico")
				OT DeleteItem ($l_otRef;"vr_CTRL_SUP_Especifico")
				
				
				  // creo un objeto con la configuración del control de fin de periodo
				  // y asigno las propiedades para la configuración comun todos los periodos
				$l_otPeriodoComun:=OT New 
				OT PutLong ($l_otPeriodoComun;"c1_PonderacionConstante";c1_PonderacionConstante)
				OT PutLong ($l_otPeriodoComun;"c2_PonderacionVariable";c2_PonderacionVariable)
				OT PutLong ($l_otPeriodoComun;"t1_CTRL_INF_Ponderado";t1_CTRL_INF_Ponderado)
				OT PutLong ($l_otPeriodoComun;"t2_CTRL_INF_Control";t2_CTRL_INF_Control)
				OT PutLong ($l_otPeriodoComun;"t3_CTRL_INF_Presentacion";t3_CTRL_INF_Presentacion)
				OT PutLong ($l_otPeriodoComun;"t4_CTRL_INF_Especifico";t4_CTRL_INF_Especifico)
				OT PutLong ($l_otPeriodoComun;"u1_CTRL_SUP_Ponderado";u1_CTRL_SUP_Ponderado)
				OT PutLong ($l_otPeriodoComun;"u2_CTRL_SUP_Control";u2_CTRL_SUP_Control)
				OT PutLong ($l_otPeriodoComun;"u3_CTRL_SUP_Presentacion";u3_CTRL_SUP_Presentacion)
				OT PutLong ($l_otPeriodoComun;"u4_CTRL_SUP_Especifico";u4_CTRL_SUP_Especifico)
				OT PutReal ($l_otPeriodoComun;"vr_CTRL_PonderacionConstante";vr_CTRL_PonderacionConstante)
				OT PutReal ($l_otPeriodoComun;"vr_CTRL_INF_Ponderacion";vr_CTRL_INF_Ponderacion)
				OT PutReal ($l_otPeriodoComun;"vr_CTRL_SUP_Ponderacion";vr_CTRL_SUP_Ponderacion)
				OT PutReal ($l_otPeriodoComun;"vr_CTRL_INF_Especifico";vr_CTRL_INF_Especifico)
				OT PutReal ($l_otPeriodoComun;"vr_CTRL_SUP_Especifico";vr_CTRL_SUP_Especifico)
				
				  // agrego el objeto con las propiedades del examen de fin de periodo al objeto raiz
				OT PutObject ($l_otRef;"EXP_ObjPeriodoComun";$l_otPeriodoComun)
				
				
				$x_blob:=OT ObjectToNewBLOB ($l_otRef)
				OT Clear ($l_otRef)
				OT Clear ($l_otPeriodoComun)
				[Asignaturas:18]OpcionesControles_y_Examenes:106:=$x_blob
				SAVE RECORD:C53([Asignaturas:18])
			End if 
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNums);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

