//%attributes = {}
  //UD_v20150604_ACT_Tramos

If (ACT_AccountTrackInicializado )
	ARRAY LONGINT:C221($aQR_Longint1;0)
	C_TEXT:C284($vt_llave)
	C_LONGINT:C283($l_indice)
	C_BOOLEAN:C305($b_mostrarThermo)
	
	  //borro cargos por tramo generados para cargos proyectados
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_RecargoTramo:63#"")
	DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$aQR_Longint1)
	ACTcc_EliminaCargosLoop 
	ACTcc_OpcionesCalculoCtaCte ("InitArrays")
	COPY ARRAY:C226($aQR_Longint1;alACTpp_idsPersonas)
	$b_mostrarThermo:=True:C214
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$b_mostrarThermo)
	
	  //asigno ids de AC a referencias de multas
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_RecargoTramo:63="0000000000@")
	If (Records in selection:C76([ACT_Cargos:173])>0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aQR_Longint1;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Reparando referencia recargos por tabla...")
		For ($l_indice;1;Size of array:C274($aQR_Longint1))
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$aQR_Longint1{$l_indice})
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			$vt_llave:=Substring:C12([ACT_Cargos:173]Ref_RecargoTramo:63;11;Length:C16([ACT_Cargos:173]Ref_RecargoTramo:63))
			[ACT_Cargos:173]Ref_RecargoTramo:63:=ST_RigthChars (("0")*10+String:C10([ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15);10)+$vt_llave
			SAVE RECORD:C53([ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($aQR_Longint1))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 