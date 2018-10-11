//%attributes = {}
  //UD_v20110530_ACT_FechasT
  //existia un defecto que producia que frente a un cambio de fecha de pago, las transacciones asociadas no se actualizaran...

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($i;$vl_records;$vl_records2;$vl_pos)
	ARRAY LONGINT:C221($aQR_Longint1;0)
	ARRAY LONGINT:C221($aQR_Longint2;0)
	ARRAY DATE:C224($aQR_Date1;0)
	
	READ ONLY:C145([ACT_Pagos:172])
	
	  //20120504 RCH Hay bases que tienen pago id 0
	  //ALL RECORDS([ACT_Pagos])
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1>0)
	SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$aQR_Longint1;[ACT_Pagos:172]Fecha:2;$aQR_Date1)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando fechas de pagos en transacciones...")
	For ($i;1;Size of array:C274($aQR_Longint1))
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$aQR_Longint1{$i})
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records2)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$aQR_Longint1{$i};*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Fecha:5=$aQR_Date1{$i})
		If ($vl_records>0)
			If ($vl_records#$vl_records2)
				APPEND TO ARRAY:C911($aQR_Longint2;$aQR_Longint1{$i})
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aQR_Longint1))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando fechas de pagos en transacciones...")
	For ($i;1;Size of array:C274($aQR_Longint2))
		$vl_pos:=Find in array:C230($aQR_Longint1;$aQR_Longint2{$i})
		If (($aQR_Longint1{$vl_pos}>0) & ($aQR_Date1{$vl_pos}#!00-00-00!))
			READ WRITE:C146([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$aQR_Longint1{$vl_pos})
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5:=$aQR_Date1{$vl_pos})
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aQR_Longint2))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	AT_Initialize (->$aQR_Longint1;->$aQR_Longint2;->$aQR_Date1)
End if 