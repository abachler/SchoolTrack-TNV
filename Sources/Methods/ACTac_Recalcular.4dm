//%attributes = {}
  //ACTac_Recalcular

C_DATE:C307($vd_fecha)
C_LONGINT:C283($vl_idAviso)
C_BLOB:C604($xBlob)
C_BOOLEAN:C305($done)
C_BOOLEAN:C305($vb_filtrarAvisosXFecha;$vb_recalcularSiempre)
C_BOOLEAN:C305($b_noEliminarDcto)
C_BOOLEAN:C305($b_hecho)  //20180801 RCH Ticket 213280


$b_hecho:=True:C214
If (Count parameters:C259>=2)
	$vd_fecha:=$2
End if 
If (Count parameters:C259>=3)
	$vb_filtrarAvisosXFecha:=$3
End if 
If (Count parameters:C259>=4)
	$vb_recalcularSiempre:=$4  //en determinados casos es necesario recalcular forzadamente. Ejemplo, cuando se ingresa un pago con dcto en caja
End if 

If (Count parameters:C259>=5)
	$b_noEliminarDcto:=$5  //en determinados casos es necesario recalcular forzadamente. Ejemplo, cuando se ingresa un pago con dcto en caja
End if 

If ($vd_fecha=!00-00-00!)
	$vd_fecha:=Current date:C33(*)
End if 

If ((Not:C34($vb_filtrarAvisosXFecha)) | ($vb_recalcularSiempre) | (($vb_filtrarAvisosXFecha) & ([ACT_Avisos_de_Cobranza:124]LastDateRecalc:23#$vd_fecha)) & ($1#-1))
	If ((Record number:C243([ACT_Avisos_de_Cobranza:124])#$1) | (Read only state:C362([ACT_Avisos_de_Cobranza:124])))
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$1)
	End if 
	
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	
	If (Not:C34($b_noEliminarDcto))
		ACTpgs_DescuentosXTramo ("ValidaEliminaAnulaPago")  //20170714 RCH
	End if 
	
	KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$1;True:C214)
	
	If (ok#1)  //20180801 RCH Ticket 213280 Si esta en uso, se avisa pero se intenta recalcular igual
		$b_hecho:=False:C215
	End if 
	
	$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
	If ($vr_monto>0) | ($vb_recalcularSiempre)
		$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		BLOB_Variables2Blob (->$xBlob;0;->$vl_idAviso;->$vd_fecha)
		$done:=ACTac_CalculaMontos ($xBlob)
		If (Not:C34($done))
			BM_CreateRequest ("calculaMontosAvisos";"";String:C10($vl_idAviso);$xBlob)
		End if 
	Else 
		KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		ARRAY REAL:C219($ar_montos;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Moneda:9;$ar_montos)
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->$ar_montos;">";->$DA_Return)
		
		  //20170628 RCH Verifica AC con responsable asociado
		C_LONGINT:C283($l_recsResponsables)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recsResponsables)
		QUERY SELECTION BY ATTRIBUTE:C1424([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_aviso_asociado";"=";$vl_idAviso)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ((Sum:C1([ACT_Cargos:173]Monto_Moneda:9)<=0) & (Size of array:C274($DA_Return)=0) & (Sum:C1([ACT_Cargos:173]Total_Desctos:45)=0) & ($l_recsResponsables=0))
			
			ACTac_OpcionesGenerales ("CreaRegistroActividadesEliminaciónAviso")
			$abort:=ACTcc_DesEmitirCargos 
			LOAD RECORD:C52([ACT_Avisos_de_Cobranza:124])
			KRL_ReloadInReadWriteMode (->[ACT_Avisos_de_Cobranza:124])
			DELETE RECORD:C58([ACT_Avisos_de_Cobranza:124])
			
		Else 
			$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
			BLOB_Variables2Blob (->$xBlob;0;->$vl_idAviso;->$vd_fecha)
			$done:=ACTac_CalculaMontos ($xBlob)
			If (Not:C34($done))
				BM_CreateRequest ("calculaMontosAvisos";"";String:C10($vl_idAviso);$xBlob)
			End if 
		End if 
		
	End if 
	
	
	
	SET BLOB SIZE:C606($xBlob;0)
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
End if 

$0:=$b_hecho