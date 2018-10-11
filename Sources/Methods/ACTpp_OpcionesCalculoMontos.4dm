//%attributes = {}
  //ACTpp_OpcionesCalculoMontos
C_LONGINT:C283($vl_idApdo;$vl_idTercero)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4)
C_POINTER:C301(${2})
C_BOOLEAN:C305($vb_done)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 

Case of 
	: ($vt_accion="CalculaDesdeArreglosIdsApdoTerceros")
		$vl_idApdo:=$vy_pointer1->
		$vl_idTercero:=$vy_pointer2->
		ACTpp_OpcionesCalculoMontos ("CreaTareaApdo";->$vl_idApdo)
		ACTpp_OpcionesCalculoMontos ("CreaTareaTercero";->$vl_idTercero)
		
	: ($vt_accion="CreaTareaApdo")
		$vl_idApdo:=$vy_pointer1->
		If ($vl_idApdo#0)
			BM_CreateRequest ("ACT_CalculaMontosProtApdo";String:C10($vl_idApdo);String:C10($vl_idApdo))
		End if 
		
	: ($vt_accion="CreaTareaTercero")
		$vl_idTercero:=$vy_pointer1->
		If ($vl_idTercero#0)
			BM_CreateRequest ("ACT_CalculaMontosProtTercero";String:C10($vl_idTercero);String:C10($vl_idTercero))
		End if 
		
	: ($vt_accion="CalculaDesdeArreglosRecalculoCtas")
		For ($i;1;Size of array:C274(alACTpp_idsPersonas))
			ACTpp_OpcionesCalculoMontos ("CreaTareaApdo";->alACTpp_idsPersonas{$i})
		End for 
		
		For ($i;1;Size of array:C274(alACTter_idsTerceros))
			ACTpp_OpcionesCalculoMontos ("CreaTareaTercero";->alACTter_idsTerceros{$i})
		End for 
		
	: ($vt_accion="CalculaMontoApdo")
		$vl_idApdo:=$vy_pointer1->
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$vl_idApdo;True:C214)
		If (ok=1)
			$vb_done:=ACTpp_OpcionesCalculoMontos ("CalculaMontoDocumentos";->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]No:1;->[Personas:7]ACT_monto_a_fecha:97;->[Personas:7]ACT_mon_prot_no_reemp:96)
		Else 
			If (Records in selection:C76([Personas:7])=0)
				$vb_done:=True:C214
			End if 
		End if 
		
	: ($vt_accion="CalculaMontoTercero")
		$vl_idTercero:=$vy_pointer1->
		KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$vl_idTercero;True:C214)
		If (ok=1)
			$vb_done:=ACTpp_OpcionesCalculoMontos ("CalculaMontoDocumentos";->[ACT_Pagos:172]ID_Tercero:26;->[ACT_Terceros:138]Id:1;->[ACT_Terceros:138]Monto_a_fecha:60;->[ACT_Terceros:138]Monto_prot_no_reemp:59)
		Else 
			If (Records in selection:C76([ACT_Terceros:138])=0)
				$vb_done:=True:C214
			End if 
		End if 
		
	: ($vt_accion="CalculaMontoDocumentos")
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		READ ONLY:C145([ACT_Pagares:184])
		
		QUERY:C277([ACT_Pagos:172];$vy_pointer1->=$vy_pointer2->;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
		KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
		CREATE SET:C116([ACT_Documentos_de_Pago:176];"setDctoPagoApdo")
		QUERY SELECTION BY FORMULA:C207([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Fecha:13>[ACT_Documentos_de_Pago:176]FechaPago:4)
		QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=False:C215;*)
		QUERY SELECTION:C341([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Protestado:36=False:C215;*)
		QUERY SELECTION:C341([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]En_cartera:34=True:C214)
		
		$vy_pointer3->:=Sum:C1([ACT_Documentos_de_Pago:176]MontoPago:6)  // total a fecha
		
		USE SET:C118("setDctoPagoApdo")
		QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Protestado:36=True:C214)
		$vy_pointer4->:=Sum:C1([ACT_Documentos_de_Pago:176]MontoPago:6)  //total protestado
		
		  //monto protestado en pagares...
		Case of 
			: (Table:C252($vy_pointer2)=Table:C252(->[Personas:7]))
				QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Apdo:17=$vy_pointer2->)
			: (Table:C252($vy_pointer2)=Table:C252(->[ACT_Terceros:138]))
				QUERY:C277([ACT_Pagares:184];[ACT_Pagares:184]ID_Tercero:22=$vy_pointer2->)
		End case 
		QUERY SELECTION:C341([ACT_Pagares:184];[ACT_Pagares:184]ID_Estado:6=-101)
		$vy_pointer4->:=$vy_pointer4->+Sum:C1([ACT_Pagares:184]Monto:8)
		
		SAVE RECORD:C53(Table:C252(Table:C252($vy_pointer2))->)
		SET_ClearSets ("setDctoPagoApdo")
		$vb_done:=True:C214
		
End case 
$0:=$vb_done