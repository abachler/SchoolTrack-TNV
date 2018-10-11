//%attributes = {}
  //dbuACT_VerificadorIntegridad

C_BOOLEAN:C305($recalc)
$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	If (Count parameters:C259=1)
		$recalc:=($1=1)
	Else 
		$recalc:=True:C214
	End if 
	ACTinit_LoadPrefs 
	
	  //vamos a eliminar cargos emitidos que no tengan documento de cargo ya que quiere decir que quedaron sin borrar al eliminar un aviso de cobranza.
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Documento_de_Cargo:3=0)
	DELETE SELECTION:C66([ACT_Cargos:173])
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	
	  //vamos a eliminar las transacciones que hayan quedado sin eliminar al eliminar avisos de cobranza
	READ WRITE:C146([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	ALL RECORDS:C47([ACT_Transacciones:178])
	CREATE SET:C116([ACT_Transacciones:178];"todas")
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1)
	CREATE SET:C116([ACT_Transacciones:178];"concargo")
	DIFFERENCE:C122("todas";"concargo";"sincargo")
	USE SET:C118("sincargo")
	DELETE SELECTION:C66([ACT_Transacciones:178])
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	SET_ClearSets ("todas";"concargo";"sincargo")
	
	  //asignamos el numero de aviso a posibles transacciones de descuento que no lo tengan... ticket 91698
	C_LONGINT:C283(vQR_Long1)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-1;*)
	QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-10)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint1;"")
	For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
		READ WRITE:C146([ACT_Transacciones:178])
		GOTO RECORD:C242([ACT_Transacciones:178];aQR_Longint1{vQR_Long1})
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3)
		If (Records in selection:C76([ACT_Cargos:173])=1)
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=1)
				[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
				SAVE RECORD:C53([ACT_Transacciones:178])
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	End for 
	
	  //Eliminación de Documentos de Cargo sin cargos asociados...
	
	READ WRITE:C146([ACT_Documentos_de_Cargo:174])
	ALL RECORDS:C47([ACT_Documentos_de_Cargo:174])
	$iterations:=Records in selection:C76([ACT_Documentos_de_Cargo:174])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando integridad de Documentos de Cargo..."))
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	SET QUERY LIMIT:C395(1)
	While (Not:C34(End selection:C36([ACT_Documentos_de_Cargo:174])))
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		If ($recs=0)
			DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
		End if 
		NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_Documentos_de_Cargo:174])/$iterations)
	End while 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	UNLOAD RECORD:C212([ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	  //Aca se eliminan los cargos asociados a un documento de cargo inexistente... o bien se verifican id de cta y apoderado.
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando integridad de Cargos..."))
	READ WRITE:C146([ACT_Cargos:173])
	ALL RECORDS:C47([ACT_Cargos:173])
	ARRAY LONGINT:C221(aIDDC;0)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->aIDDC;1)
	For ($i;1;Size of array:C274(aIDDC))
		$dc:=Find in field:C653([ACT_Documentos_de_Cargo:174]ID_Documento:1;aIDDC{$i})
		If ($dc=-1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=aIDDC{$i})
			DELETE SELECTION:C66([ACT_Cargos:173])
		Else 
			GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$dc)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
			CREATE SET:C116([ACT_Cargos:173];"LosDelDoc")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=0)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
			USE SET:C118("LosDelDoc")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=0)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12)
			USE SET:C118("LosDelDoc")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22:=[ACT_Documentos_de_Cargo:174]FechaEmision:21)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7:=[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]LastInterestsUpdate:42:=!00-00-00!)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aIDDC))
	End for 
	CLEAR SET:C117("LosDelDoc")
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	READ ONLY:C145([xxACT_Items:179])  //aca eliminamos los cargos proyectados que no tengan un item de cargo de respaldo...
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	CREATE SET:C116([ACT_Cargos:173];"Proyectados")
	CREATE EMPTY SET:C140([ACT_Cargos:173];"SinDef")
	ARRAY LONGINT:C221($aDefsItems;0)
	DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$aDefsItems)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminando cargos proyectados sin definición..."))
	For ($i;1;Size of array:C274($aDefsItems))
		$found:=Find in field:C653([xxACT_Items:179]ID:1;$aDefsItems{$i})
		If ($found=-1)
			USE SET:C118("Proyectados")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$aDefsItems{$i})
			CREATE SET:C116([ACT_Cargos:173];"sinDef")
			DIFFERENCE:C122("Proyectados";"SinDef";"Proyectados")
			ACTcc_EliminaCargosLoop 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aDefsItems))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SET_ClearSets ("Proyectados";"SinDef")
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	UNLOAD RECORD:C212([xxACT_Items:179])
	
	  //********** INICIO VERIFICA QUE NO HAYAN TRANSACCIONES ASOCIADAS A PAGOS QUE NO EXISTEN **********
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Pagos:172])
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
	CREATE SET:C116([ACT_Transacciones:178];"setT1")
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
	CREATE SET:C116([ACT_Transacciones:178];"setT2")
	DIFFERENCE:C122("setT1";"setT2";"setT1")
	READ WRITE:C146([ACT_Transacciones:178])
	
	  //elimino relacion con cargos
	USE SET:C118("setT1")
	ARRAY LONGINT:C221($alACT_idsPagos;0)
	ARRAY LONGINT:C221($al_recNumsAvisos2;0)
	DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Pago:4;$alACT_idsPagos)
	For ($i;1;Size of array:C274($alACT_idsPagos))
		USE SET:C118("setT1")
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$alACT_idsPagos{$i})
		ARRAY LONGINT:C221($aRecNumTransacciones;0)
		ARRAY LONGINT:C221($al_recNumsAvisos;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRecNumTransacciones;"")
		$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->$aRecNumTransacciones;->$al_recNumsAvisos)
		$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->$aRecNumTransacciones)
		For ($j;1;Size of array:C274($al_recNumsAvisos))
			If (Find in array:C230($al_recNumsAvisos2;$al_recNumsAvisos{$j})=-1)
				APPEND TO ARRAY:C911($al_recNumsAvisos2;$al_recNumsAvisos{$j})
			End if 
		End for 
	End for 
	For ($i;1;Size of array:C274($al_recNumsAvisos2))
		ACTac_Recalcular ($al_recNumsAvisos2{$i})
	End for 
	ACTcar_ValidaMontos ("ValidaDesdeArrayRecNumAvisos";->$al_recNumsAvisos2)
	SET_ClearSets ("setT1";"setT2")
	KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	  //********** FIN VERIFICA QUE NO HAYAN TRANSACCIONES ASOCIADAS A PAGOS QUE NO EXISTEN **********
	
	  //********** INICIO VALIDACION DE DOCUMENTOS EN CARTERA **********
	READ ONLY:C145([ACT_Pagos:172])
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	ALL RECORDS:C47([ACT_Documentos_en_Cartera:182])
	CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera1")
	KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
	KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
	CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera2")
	DIFFERENCE:C122("setDocCartera1";"setDocCartera2";"setDocCartera1")
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	USE SET:C118("setDocCartera1")
	DELETE SELECTION:C66([ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	SET_ClearSets ("setDocCartera1";"setDocCartera2")
	  //********** FIN **********
	
	
	If ($recalc)
		  //Finalmente recalculamos las cuentas corrientes por si acaso borramos cargos mas arriba...
		ACTbw_RecalculaCtasCtes 
	End if 
End if 