//%attributes = {}
  //ACTmnu_RecalcularCartera

If (USR_GetMethodAcces (Current method name:C684))
	ARRAY LONGINT:C221(abrSelect;0)
	$rslt:=AL_GetSelect (xALP_Browser;abrSelect)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando fechas de documentos en cartera..."))
	ARRAY LONGINT:C221($alACT_RecNumCheques;Size of array:C274(abrSelect))
	For ($j;1;Size of array:C274(abrSelect))
		$alACT_RecNumCheques{$j}:=alBWR_RecordNumber{abrSelect{$j}}
	End for 
	CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_en_Cartera:182];$alACT_RecNumCheques)
	QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182]; | ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-8)
	ARRAY LONGINT:C221($alACT_RecNumCheques;0)
	SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182];$alACT_RecNumCheques)
	$iterations:=Size of array:C274($alACT_RecNumCheques)
	For ($i;1;Size of array:C274($alACT_RecNumCheques))
		ACTdc_EstadoCheque ($alACT_RecNumCheques{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$iterations;__ ("Recalculando fechas de documentos en cartera..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 