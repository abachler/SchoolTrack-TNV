//%attributes = {}
  //_0000_TestsEmiteDTConOC
TRACE:C157
C_LONGINT:C283($l_recs;$l_indice;$l_emitido;$l_resp)
C_TEXT:C284($t_param)
C_DATE:C307($vd_fecha)

If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
		If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
			
			C_LONGINT:C283($l_idTercero)
			$l_idTercero:=135
			$l_idTercero:=Num:C11(PREF_fGet (0;"ACT_GENERA_DTE_CON_OC";String:C10($l_idTercero)))
			
			C_TEXT:C284($t_orden1;$t_orden2)
			$t_orden1:="4500300941"
			$t_orden2:="4500315734"
			$t_orden1:=PREF_fGet (0;"ACT_GENERA_DTE_CON_OC_1";$t_orden1)
			$t_orden2:=PREF_fGet (0;"ACT_GENERA_DTE_CON_OC_2";$t_orden2)
			
			C_REAL:C285($r_monto)
			$r_monto:=600000
			$r_monto:=Num:C11(PREF_fGet (0;"ACT_GENERA_DTE_CON_OC_Monto";String:C10($r_monto)))
			
			$l_recs:=BWR_SearchRecords 
			If ($l_recs#-1)
				READ ONLY:C145([ACT_Boletas:181])
				
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0;*)
				QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Tercero:21=$l_idTercero)
				
				QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];[ACT_Boletas:181]DTE_estado_id:24 ?? 1)
				
				If (Records in selection:C76([ACT_Boletas:181])>0)
					
					$l_resp:=CD_Dlog (0;"Se asignará la orden de compra a "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" Documentos Tributarios seleccionados. Se asignará el número "+ST_Qte ($t_orden1)+" a los documentos con monto mayor a "+String:C10($r_monto;"|Despliegue_ACT_Pagos")+" y "+ST_Qte ($t_orden2)+" a los otros documentos."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
					If ($l_resp=1)
						ACTcfg_LoadConfigData (8)
						
						ARRAY LONGINT:C221(aQR_Longint1;0)
						ARRAY REAL:C219(aQR_Real1;0)
						ARRAY DATE:C224(aQR_Date1;0)
						
						SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;aQR_Longint1;[ACT_Boletas:181]Monto_Total:6;aQR_Real1;[ACT_Boletas:181]FechaEmision:3;aQR_Date1)
						
						For ($l_indice;1;Size of array:C274(aQR_Longint1))
							$t_param:=ACTdte_GeneraArchivo ("GeneraDctoTexto";->aQR_Longint1{$l_indice})
							  //SET TEXT TO PASTEBOARD($t_param)
							
							C_TEXT:C284($vt_separador;$vt_text;$vt_ndldr1;$vt_tddr2;$vt_igdr3;$vt_fdr4;$vt_roc5;$vt_fdr6;$vt_cr7;$vt_rdr8)
							$vt_separador:=";"
							
							$vt_ndldr1:="1"
							$vt_tddr2:="801"
							$vt_igdr3:=""
							If (aQR_Real1{$l_indice}>$r_monto)
								$vt_fdr4:=$t_orden1
							Else 
								$vt_fdr4:=$t_orden2
							End if 
							$vt_roc5:=""
							$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->aQR_Date1{$l_indice})
							$vt_cr7:=""
							$vt_rdr8:=""
							
							$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
							$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador
							
							$t_param:=$t_param+$vt_text+Char:C90(9+4)
							  //SET TEXT TO PASTEBOARD($t_param)
							$l_emitido:=ACTdte_EmiteDocumento (aQR_Longint1{$l_indice};$t_param)
							If ($l_emitido=0)
								$l_indice:=Size of array:C274(aQR_Longint1)
								CD_Dlog (0;"Los documentos no pudieron ser emitidos.")
							End if 
						End for 
						
						If ($l_emitido=1)
							CD_Dlog (0;"Script ejecutado.")
						End if 
						
					End if 
				Else 
					CD_Dlog (0;"No hay documentos con folio 0, marcados para enviar, en el explorador.")
				End if 
			Else 
				CD_Dlog (0;"Seleccione los registros en el explorador.")
			End if 
		Else 
			CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios, con los documentos con folio 0 seleccionados.")
		End if 
	End if 
End if 