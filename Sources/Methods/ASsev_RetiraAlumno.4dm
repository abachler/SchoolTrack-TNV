//%attributes = {}
  //ASsev_RetiraAlumno

C_LONGINT:C283($idAlumno)
C_OBJECT:C1216($o_data)

$recNumAsignatura:=$1
$aIdAlumnosPointer:=$2

READ ONLY:C145([Asignaturas:18])
GOTO RECORD:C242([Asignaturas:18];$recNumAsignatura)
If (Size of array:C274(aRecNum2Transfer)>=1)
	For ($i;1;Size of array:C274($aIdAlumnosPointer->))
		$idAlumno:=$aIdAlumnosPointer->{$i}
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			For ($periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
				AS_PropEval_Lectura ("";$periodo)
				For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
					If (alAS_EvalPropSourceID{$k}<0)
						$registrosEliminados:=False:C215
						atSTR_Periodos_Nombre:=$periodo
						$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$k;False:C215)
						$el:=Find in array:C230(aSubEvalID;$idAlumno)
						If ($el>0)
							  //elimino registro de notas de la subasignatura correspondiente al alumno retirado
							$registrosEliminados:=True:C214
							AT_Delete ($el;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
							For ($i_Parciales;1;12)
								AT_Delete ($el;1;aRealSubEvalArrPtr{$i_Parciales})
							End for 
							READ WRITE:C146([xxSTR_Subasignaturas:83])
							LOAD RECORD:C52([xxSTR_Subasignaturas:83])
							  //SET BLOB SIZE([xxSTR_Subasignaturas]Data;0)
							  //ARRAY REAL(aRealTemp;0)
							  //$offset:=0
							$o_data:=OB_Create   //MONO TICKET 187315
							OB_SET ($o_data;->aSubEvalID;"aSubEvalID")
							OB_SET ($o_data;->aSubEvalStdNme;"aSubEvalStdNme")
							OB_SET ($o_data;->aSubEvalCurso;"aSubEvalCurso")
							OB_SET ($o_data;->aSubEvalStatus;"aSubEvalStatus")
							OB_SET ($o_data;->aSubEvalOrden;"aSubEvalOrden")
							  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
							For ($j;1;Size of array:C274(aSubEvalArrPtr))
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
								
								  //20180222 RCH Ticket 198048
								  //OB_SET ($ob_subAsig;aRealSubEvalArrPtr{$j};"aRealSubEval"+String($j))
								OB_SET ($o_data;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
							End for 
							  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
							  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
							  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentación)
							  //COMPRESS BLOB([xxSTR_Subasignaturas]Data;1)
							OB_SET ($o_data;->aRealSubEvalP1;"aRealSubEvalP1")
							OB_SET ($o_data;->aRealSubEvalControles;"aRealSubEvalControles")
							OB_SET ($o_data;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
							OB_SET ($o_data;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
							[xxSTR_Subasignaturas:83]o_Data:21:=$o_data
							SAVE RECORD:C53([xxSTR_Subasignaturas:83])
							UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
						End if 
					End if 
				End for 
			End for 
		Else 
			AS_PropEval_Lectura 
			For ($i;1;Size of array:C274($aIdAlumnosPointer->))
				$idAlumno:=$aIdAlumnosPointer->{$i}
				For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
					If (alAS_EvalPropSourceID{$k}<0)
						For ($periodo;1;Size of array:C274(atSTR_Periodos_Nombre))
							atSTR_Periodos_Nombre:=$periodo
							$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$k;False:C215)
							$el:=Find in array:C230(aSubEvalID;$idAlumno)
							If ($el>0)
								  //elimino registro de notas de la subasignatura correspondiente al alumno retirado
								$registrosEliminados:=True:C214
								AT_Delete ($el;1;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden;->aRealSubEvalP1;->aRealSubEvalControles;->aRealSubEvalPresentacion)
								For ($i_Parciales;1;12)
									AT_Delete ($el;1;aRealSubEvalArrPtr{$i_Parciales})
								End for 
								READ WRITE:C146([xxSTR_Subasignaturas:83])
								LOAD RECORD:C52([xxSTR_Subasignaturas:83])
								  //$offset:=0
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
								$o_data:=OB_Create   //MONO TICKET 187315
								OB_SET ($o_data;->aSubEvalID;"aSubEvalID")
								OB_SET ($o_data;->aSubEvalStdNme;"aSubEvalStdNme")
								OB_SET ($o_data;->aSubEvalCurso;"aSubEvalCurso")
								OB_SET ($o_data;->aSubEvalStatus;"aSubEvalStatus")
								OB_SET ($o_data;->aSubEvalOrden;"aSubEvalOrden")
								For ($j;1;Size of array:C274(aSubEvalArrPtr))
									  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
									
									  //20180222 RCH Ticket 198048
									  //OB_SET ($ob_subAsig;aRealSubEvalArrPtr{$j};"aRealSubEval"+String($j))
									OB_SET ($o_data;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
								End for 
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentación)
								  //COMPRESS BLOB([xxSTR_Subasignaturas]Data;1)
								OB_SET ($o_data;->aRealSubEvalP1;"aRealSubEvalP1")
								OB_SET ($o_data;->aRealSubEvalControles;"aRealSubEvalControles")
								OB_SET ($o_data;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
								OB_SET ($o_data;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
								[xxSTR_Subasignaturas:83]o_Data:21:=$o_data
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
							End if 
						End for 
					End if 
				End for 
			End for 
		End if 
	End for 
End if 