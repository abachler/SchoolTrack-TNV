//%attributes = {}
  //ACTmnu_UtilizarDisponiblePago

  //20080331 RCH Método que es llamado desde la pestaña pagos y que se encarga de comprobar que hayan pagos con disponible y por cada pago con disponible llama al método que prepaga los cargos
C_LONGINT:C283($found;$i)
C_REAL:C285(RNCta;RNApdo)
C_BLOB:C604(xBlob)
C_BOOLEAN:C305(vbACT_ModOrderAvisos;vb_interesBorrado)
C_BOOLEAN:C305(vb_descuentoBorrado)  //20170714 RCH
C_TEXT:C284($vt_set)
ARRAY LONGINT:C221($al_numPagos;0)
RNCta:=-1
RNApdo:=-1
vbACT_ModOrderAvisos:=False:C215
vb_interesBorrado:=False:C215
SET BLOB SIZE:C606(xBlob;0)
READ ONLY:C145([ACT_Pagos:172])
$found:=BWR_SearchRecords 
If ($found#-1)
	QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Saldo:15>0)
	If (Records in selection:C76([ACT_Pagos:172])>0)
		ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
		  //xBlob:=PREF_fGetBlob (0;"SelIngPagos";xBlob)
		  //BLOB_Blob2Vars (->xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;cb_soloCuotasVencidas)
		If (cb_PermitePorCta=0)
			cbDatosApdo:=1
		End if 
		SELECTION TO ARRAY:C260([ACT_Pagos:172];$al_numPagos)
		For ($i;1;Size of array:C274($al_numPagos))
			KRL_GotoRecord (->[ACT_Pagos:172];$al_numPagos{$i})
			ACTac_Prepagar (0;False:C215;True:C214)
		End for 
		SET BLOB SIZE:C606(xBlob;0)
		  // 20111121 RCH Dio error en pruebas en compilado
		  // USE SET("RecordSet_Table"+String(Table(yBWR_currentTable)))
		$vt_set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		SET_UseSet ($vt_set)
		BWR_PanelSettings 
		BWR_SelectTableData 
		
	Else 
		CD_Dlog (0;__ ("No hay pagos con monto disponible dentro de los avisos seleccionados."))
	End if 
Else 
	CD_Dlog (0;__ ("Para utilizar esta opción usted debe seleccionar Pagos con monto disponible en el explorador."))
End if 