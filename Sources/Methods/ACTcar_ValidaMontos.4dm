//%attributes = {}
C_TEXT:C284($vt_accion;$1)
C_LONGINT:C283($vl_idPago)
C_BOOLEAN:C305($vbHayProblema;$vb_mostrarThermo;$0)
C_POINTER:C301($ptr1;$ptr2)
C_POINTER:C301(${2})
C_POINTER:C301($y_arrayRecNum;$y_mostrarThermo)

$vt_accion:=$1
If (Count parameters:C259>1)
	$ptr1:=$2
End if 
If (Count parameters:C259>2)
	$ptr2:=$3
End if 
Case of 
	: ($vt_accion="VerificaCargosDePagoConProblema")
		$vb_mostrarThermo:=False:C215
		ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->alACTpgs_idsAvisosConProblemas;->$vb_mostrarThermo)
		ACTcar_ValidaMontos ("DeclaraArreglo")
		
	: ($vt_accion="DeclaraArreglo")
		ARRAY LONGINT:C221(alACTpgs_idsAvisosConProblemas;0)
		
	: ($vt_accion="ValidaCargosDelPago")
		ACTcar_ValidaMontos ("DeclaraArreglo")
		$vl_idPago:=$ptr1->
		$vbHayProblema:=dbuACT_VerificaIntegridadPagos ("ValidaDesdeNumeroPago";$vl_idPago)
		If ($vbHayProblema)
			READ ONLY:C145([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago)
			DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;alACTpgs_idsAvisosConProblemas)
		End if 
		
	: ($vt_accion="ValidaDesdeArrayRecNumAvisos")
		$y_arrayRecNum:=$ptr1
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vb_mostrarThermo:=$ptr2->
		End if 
		
		ARRAY LONGINT:C221($al_idsAvisos;0)
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$ptr1->;"")
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos)
		ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->$al_idsAvisos;->$vb_mostrarThermo)
		
	: ($vt_accion="ValidaDesdeIdsAvisos")
		READ ONLY:C145([ACT_Transacciones:178])
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Pagos:172])
		
		ARRAY LONGINT:C221($aQR_Longint2;0)
		
		$y_arrayRecNum:=$ptr1
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vb_mostrarThermo:=$ptr2->
		End if 
		
		CREATE EMPTY SET:C140([ACT_Cargos:173];"cargos2P")
		CREATE EMPTY SET:C140([ACT_Cargos:173];"cargos2P2")
		If ($vb_mostrarThermo)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando cargos asociados a avisos..."))
		End if 
		For ($i;1;Size of array:C274($y_arrayRecNum->))
			  //GOTO RECORD([ACT_Avisos_de_Cobranza];$y_arrayRecNum->{$i})
			  //KRL_RelateSelection (->[ACT_Transacciones]No_Comprobante;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
			If ($y_arrayRecNum->{$i}>0)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$y_arrayRecNum->{$i})
				KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				If (Records in selection:C76([ACT_Pagos:172])=0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8#0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagadosMPago:52#0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16>0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16>=-100)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						CREATE SET:C116([ACT_Cargos:173];"cargos2P2")
						UNION:C120("cargos2P";"cargos2P2";"cargos2P")
						APPEND TO ARRAY:C911($aQR_Longint2;$y_arrayRecNum->{$i})
					End if 
				Else 
					  //saco los cargos asociados a otros pagos
					CREATE SET:C116([ACT_Cargos:173];"setCargosPagos")
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					CREATE SET:C116([ACT_Cargos:173];"setCargosPagos2")
					DIFFERENCE:C122("setCargosPagos";"setCargosPagos2";"cargos2P2")
					USE SET:C118("cargos2P2")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8#0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagadosMPago:52#0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16>0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16>=-100)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						UNION:C120("cargos2P";"cargos2P2";"cargos2P")
						If (Records in set:C195("cargos2P2")>0)
							APPEND TO ARRAY:C911($aQR_Longint2;$y_arrayRecNum->{$i})
						End if 
					End if 
					SET_ClearSets ("setCargosPagos";"setCargosPagos2")
				End if 
				If ($vb_mostrarThermo)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($y_arrayRecNum->);__ ("Buscando cargos asociados a avisos..."))
				End if 
			End if 
		End for 
		If ($vb_mostrarThermo)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		READ WRITE:C146([ACT_Cargos:173])
		USE SET:C118("cargos2P")
		ACTcar_ValidaMontos ("AplicaCambiosPagados")
		
		ARRAY LONGINT:C221($aQR_recNumsAvisos;0)
		For ($i;1;Size of array:C274($aQR_Longint2))
			$vl_idAviso:=$aQR_Longint2{$i}
			APPEND TO ARRAY:C911($aQR_recNumsAvisos;Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$vl_idAviso))
		End for 
		
		AT_DistinctsArrayValues (->$aQR_recNumsAvisos)
		For ($i;1;Size of array:C274($aQR_recNumsAvisos))
			If ($aQR_recNumsAvisos{$i}#-1)
				ACTac_Recalcular ($aQR_recNumsAvisos{$i})
			End if 
		End for 
		
		ACTmnu_RecalcularSaldosAvisos (->$aQR_recNumsAvisos)
		SET_ClearSets ("cargos2P";"cargos2P2")
		
	: ($vt_accion="AplicaCambiosPagados")
		APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8:=0)
		APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]MontosPagadosMPago:52:=0)
		APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Monto_Neto:5*-1)
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
End case 

$0:=$vbHayProblema

  //C_TEXT($vt_accion;$1)
  //C_LONGINT($vl_idPago)
  //C_BOOLEAN($vbHayProblema;$vb_mostrarThermo;$0)
  //C_POINTER($ptr1;$ptr2)
  //C_POINTER(${2})
  //C_POINTER($y_arrayRecNum;$y_mostrarThermo)
  //
  //$vt_accion:=$1
  //If (Count parameters>1)
  //$ptr1:=$2
  //End if 
  //If (Count parameters>2)
  //$ptr2:=$3
  //End if 
  //Case of 
  //: ($vt_accion="VerificaCargosDePagoConProblema")
  //$vb_mostrarThermo:=False
  //ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->alACTpgs_idsAvisosConProblemas;->$vb_mostrarThermo)
  //ACTcar_ValidaMontos ("DeclaraArreglo")
  //
  //: ($vt_accion="DeclaraArreglo")
  //ARRAY LONGINT(alACTpgs_idsAvisosConProblemas;0)
  //
  //: ($vt_accion="ValidaCargosDelPago")
  //ACTcar_ValidaMontos ("DeclaraArreglo")
  //$vl_idPago:=$ptr1->
  //$vbHayProblema:=dbuACT_VerificaIntegridadPagos ("ValidaDesdeNumeroPago";$vl_idPago)
  //If ($vbHayProblema)
  //READ ONLY([ACT_Transacciones])
  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Pago=$vl_idPago)
  //DISTINCT VALUES([ACT_Transacciones]No_Comprobante;alACTpgs_idsAvisosConProblemas)
  //End if 
  //
  //: ($vt_accion="ValidaDesdeArrayRecNumAvisos")
  //$y_arrayRecNum:=$ptr1
  //If (Not(Nil($ptr2)))
  //$vb_mostrarThermo:=$ptr2->
  //End if 
  //
  //ARRAY LONGINT($al_idsAvisos;0)
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //CREATE SELECTION FROM ARRAY([ACT_Avisos_de_Cobranza];$ptr1->;"")
  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza]ID_Aviso;$al_idsAvisos)
  //ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->$al_idsAvisos;->$vb_mostrarThermo)
  //
  //: ($vt_accion="ValidaDesdeIdsAvisos")
  //READ ONLY([ACT_Transacciones])
  //READ WRITE([ACT_Cargos])
  //READ WRITE([ACT_Pagos])
  //
  //ARRAY LONGINT($aQR_Longint2;0)
  //
  //$y_arrayRecNum:=$ptr1
  //If (Not(Nil($ptr2)))
  //$vb_mostrarThermo:=$ptr2->
  //End if 
  //
  //CREATE EMPTY SET([ACT_Cargos];"cargos2P")
  //CREATE EMPTY SET([ACT_Cargos];"cargos2P2")
  //If ($vb_mostrarThermo)
  //CD_THERMOMETREXSEC (1;0;"Buscando cargos asociados a avisos...")
  //End if 
  //For ($i;1;Size of array($y_arrayRecNum->))
  //  `GOTO RECORD([ACT_Avisos_de_Cobranza];$y_arrayRecNum->{$i})
  //  `KRL_RelateSelection (->[ACT_Transacciones]No_Comprobante;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
  //If ($y_arrayRecNum->{$i}>0)
  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Comprobante=$y_arrayRecNum->{$i})
  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
  //If (Records in selection([ACT_Pagos])=0)
  //CREATE SET([ACT_Cargos];"cargos2P2")
  //UNION("cargos2P";"cargos2P2";"cargos2P")
  //APPEND TO ARRAY($aQR_Longint2;$y_arrayRecNum->{$i})
  //Else 
  //  `saco los cargos asociados a otros pagos
  //CREATE SET([ACT_Cargos];"setCargosPagos")
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Pago;->[ACT_Pagos]ID;"")
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
  //CREATE SET([ACT_Cargos];"setCargosPagos2")
  //DIFFERENCE("setCargosPagos";"setCargosPagos2";"cargos2P2")
  //UNION("cargos2P";"cargos2P2";"cargos2P")
  //If (Records in set("cargos2P2")>0)
  //APPEND TO ARRAY($aQR_Longint2;$y_arrayRecNum->{$i})
  //End if 
  //SET_ClearSets ("setCargosPagos";"setCargosPagos2")
  //End if 
  //If ($vb_mostrarThermo)
  //CD_THERMOMETREXSEC (0;$i/Size of array($y_arrayRecNum->)*100;"Buscando cargos asociados a avisos...")
  //End if 
  //End if 
  //End for 
  //If ($vb_mostrarThermo)
  //CD_THERMOMETREXSEC (-1)
  //End if 
  //
  //READ WRITE([ACT_Cargos])
  //USE SET("cargos2P")
  //ACTcar_ValidaMontos ("AplicaCambiosPagados")
  //
  //ARRAY LONGINT($aQR_recNumsAvisos;0)
  //For ($i;1;Size of array($aQR_Longint2))
  //$vl_idAviso:=$aQR_Longint2{$i}
  //APPEND TO ARRAY($aQR_recNumsAvisos;Find in field([ACT_Avisos_de_Cobranza]ID_Aviso;$vl_idAviso))
  //End for 
  //
  //AT_DistinctsArrayValues (->$aQR_recNumsAvisos)
  //For ($i;1;Size of array($aQR_recNumsAvisos))
  //If ($aQR_recNumsAvisos{$i}#-1)
  //ACTac_Recalcular ($aQR_recNumsAvisos{$i})
  //End if 
  //End for 
  //
  //ACTmnu_RecalcularSaldosAvisos (->$aQR_recNumsAvisos)
  //SET_ClearSets ("cargos2P";"cargos2P2")
  //
  //: ($vt_accion="AplicaCambiosPagados")
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]MontosPagados:=0)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]MontosPagadosMPago:=0)
  //APPLY TO SELECTION([ACT_Cargos];[ACT_Cargos]Saldo:=[ACT_Cargos]Monto_Neto*-1)
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //
  //End case 
  //
  //$0:=$vbHayProblema