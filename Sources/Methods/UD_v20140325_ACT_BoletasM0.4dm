//%attributes = {}
  //UD_v20140325_ACT_BoletasM0

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($l_indiceAC)
	ARRAY LONGINT:C221($aQR_Longint1;0)
	
	READ ONLY:C145([ACT_Boletas:181])
	
	MESSAGES OFF:C175
	
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Monto_Total:6=0;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Estado:20#4)
	
	SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$aQR_Longint1)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando estado de Documentos con monto total 0...")
	For ($l_indiceAC;1;Size of array:C274($aQR_Longint1))
		ACTbol_EstadoBoleta ($aQR_Longint1{$l_indiceAC})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indiceAC/Size of array:C274($aQR_Longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 