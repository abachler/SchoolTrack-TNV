//%attributes = {}
  //ACTcar_RecalculaRXA

ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
ARRAY LONGINT:C221(al_IdsCuentas;0)
C_LONGINT:C283($1;$vl_idAviso;$vl_recargosXA)
C_TEXT:C284($set2recalc)
C_LONGINT:C283($2;$3;$vl_mes;$vl_agno)

$vl_idApdo:=$1
$vl_mes:=$2
$vl_agno:=$3
$vd_fecha:=Current date:C33(*)

  //20120718 ASM Para solucionar el problema de emision de cuentas distintas con el mismo apoderado ticket 111078

If (Count parameters:C259=4)
	$ptr1:=$4
	COPY ARRAY:C226($ptr1->;al_IdsCuentas)
End if 

ACTcfg_pctsXFechaPago (2)
ACTcfg_LoadCargosEspeciales (2)
If (vr_montoEnPctIE=1)
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Cargos:173])
	
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=$vl_idApdo;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Mes:13=$vl_mes;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Año:14=$vl_agno;*)
	QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaEmision:21=!00-00-00!)
	
	If (Size of array:C274(al_IdsCuentas)#0)
		QRY_QueryWithArray (->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;->al_IdsCuentas;True:C214)
	End if 
	
	
	If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		CREATE SET:C116([ACT_Cargos:173];"todos")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recargosXA)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($vl_recargosXA>0)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#vl_idIE)
			$set2recalc:="cargos2Calc"
			CREATE SET:C116([ACT_Cargos:173];$set2recalc)
			$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$set2recalc;->[ACT_Cargos:173]Monto_Neto:5;$vd_fecha)
			$vr_monto:=Round:C94($vr_monto*(vr_montoIE/100);Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->vt_monedaIE)))
			USE SET:C118("todos")
			READ WRITE:C146([ACT_Cargos:173])
			READ WRITE:C146([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			If ($vl_recargosXA>1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
				REDUCE SELECTION:C351([ACT_Cargos:173];Records in selection:C76([ACT_Cargos:173])-1)
				  //KRL_DeleteSelection (->[ACT_Cargos])
				$l_eliminado:=0  //20130730 RCH
				While ($l_eliminado=0)
					$l_eliminado:=KRL_DeleteSelection (->[ACT_Cargos:173])
				End while 
				USE SET:C118("todos")
			End if 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
			$vb_continuar:=True:C214
			If ([ACT_Cargos:173]Saldo:23=0) & ([ACT_Cargos:173]MontosPagados:8>0)
				$vb_continuar:=False:C215
			End if 
			If ($vb_continuar)
				[ACT_Cargos:173]Monto_Neto:5:=$vr_monto
				[ACT_Cargos:173]Monto_Moneda:9:=$vr_monto
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				SAVE RECORD:C53([ACT_Cargos:173])
				$recNum:=KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				$vl_idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
				If ($recNum#-1)
					$montoDoc:=ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
					If ($montoDoc=0)
						$done:=ACTcc_BorrarDocdeCargo (String:C10($vl_idDocCargo))
						If (Not:C34($done))
							BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10($vl_idDocCargo))
						End if 
					End if 
				End if 
			End if 
			KRL_UnloadReadOnly (->[xxACT_Items:179])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
			CLEAR SET:C117("cargos2Calc")
		End if 
		CLEAR SET:C117("todos")
	End if 
End if 