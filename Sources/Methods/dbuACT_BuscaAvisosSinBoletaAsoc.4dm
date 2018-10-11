//%attributes = {}
  //dbuACT_BuscaAvisosSinBoletaAsoc

If (Application type:C494#4D Server:K5:6)
	If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		C_LONGINT:C283($i;vQR_Long1)
		ARRAY LONGINT:C221(aQR_Longint1;0)
		READ ONLY:C145([ACT_Transacciones:178])
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=0)
		SELECTION TO ARRAY:C260([ACT_Transacciones:178]No_Comprobante:10;aQR_Longint1)
		AT_DistinctsArrayValues (->aQR_Longint1)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando avisos no asociados a boletas..."))
		For ($i;Size of array:C274(aQR_Longint1);1;-1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;vQR_Long1)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=aQR_Longint1{$i};*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (vQR_Long1>0)
				AT_Delete ($i;1;->aQR_Longint1)
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;(Size of array:C274(aQR_Longint1)-$i)/$i;__ ("Buscando avisos no asociados a boletas..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		QRY_QueryWithArray (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->aQR_Longint1)
		CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
		ARRAY LONGINT:C221(aQR_Longint1;0)
	Else 
		CD_Dlog (0;__ ("Ejecutar desde Avisos de Cobranza"))
	End if 
End if 