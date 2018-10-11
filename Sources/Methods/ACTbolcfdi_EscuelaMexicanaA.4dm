//%attributes = {}
  //ACTbolcfdi_EscuelaMexicanaA
  //se exporta en UTF-8

C_TEXT:C284(vtACTdte_errorGen;vtACTdte_rutaArchivo)
C_TEXT:C284($vt_refxml;$vt_ref)
C_LONGINT:C283($i)
C_POINTER:C301($var1;$var2;$var3;$var4)
C_REAL:C285($vr_monto)
C_TEXT:C284($vt_cantidad5;$vt_ciuCliente15;$vt_codigo2;$vt_codigoRef2;$vt_codInterno10;$vt_comCliente14;$vt_descLarga11;$vt_descripcion3;$vt_descripcionDR3;$vt_dirCliente13)
C_TEXT:C284($vt_DR2;$vt_email16;$vt_exento2;$vt_fechaEm3;$vt_fechaVenc8;$vt_folio2;$vt_giroCliente12;$vt_indExen4;$vt_indMntNeto5;$vt_indServ4)
C_TEXT:C284($vt_iva3;$vt_mes;$vt_montoNF5;$vt_neto1;$vt_noLinea1;$vt_noLineaDR1;$vt_noLineaRef1;$vt_observacion1;$vt_periodoDesde6;$vt_periodoHasta7)
C_TEXT:C284($vt_precio6;$vt_razonRef3;$vt_rsCliente11;$vt_rutCliente9;$vt_saldoAnterior7;$vt_separador;$vt_text;$vt_tipo1;$vt_tipoCod9;$vt_tipoDR4)
C_TEXT:C284($vt_tipoExento6DR;$vt_total4;$vt_totalPeriodo6;$vt_uniMed10;$vt_valor8;$vt_valorAPagar8;$vt_valorDR5;$vt_valorExento7;$vt_year)
C_TIME:C306($ref)
C_TEXT:C284($vt_fileName)
C_LONGINT:C283($vl_idBoleta)

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY LONGINT:C221(aQR_Longint3;0)

READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ ONLY:C145([ACT_Pagos:172])

SRACTbol_InitPrintingVariables 
ACTcfg_LoadConfigData (8)

  //el registro viene cargado
  //TRACE
  //QUERY([ACT_Boletas];[ACT_Boletas]Numero=126448)
vtACTdte_errorGen:=""

If (vtACT_rutaCliente="")
	$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
	vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
End if 

If (Records in selection:C76([ACT_Boletas:181])=1)
	If (Not:C34([ACT_Boletas:181]Nula:15))
		$vl_idBoleta:=[ACT_Boletas:181]ID:1
		  //$vt_fileName:=String([ACT_Boletas]ID)+"_"+String([ACT_Boletas]Numero)+".txt"
		$vt_fileName:=<>vsACT_RUT+"_"+String:C10([ACT_Boletas:181]ID:1)+"_"+String:C10([ACT_Boletas:181]Numero:11)+".txt"
		KRL_ReloadInReadWriteMode (->[ACT_Boletas:181])
		If ([ACT_Boletas:181]codigo_SII:33="")
			ACTbol_AsignaCodigoSII 
			SAVE RECORD:C53([ACT_Boletas:181])
		End if 
		
		
		$vt_fileName:=vtACT_rutaCliente+$vt_fileName
		$ref:=Create document:C266($vt_fileName)
		  //$ref:=ACTabc_CreaArchivo ([ACT_Boletas]codigo_SII;$vt_fileName;"DTE_Archivos")
		If (document#"")
			vtACTdte_rutaArchivo:=document
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
			
			ACTbol_BuscaCargosCargaSet ("setTransacciones";[ACT_Boletas:181]ID:1)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint3;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)
			ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2;>;[ACT_Cargos:173]FechaEmision:22;>;[ACT_Cargos:173]ID:1;>)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
			AT_Difference (->aQR_Longint3;->aQR_Longint1;->aQR_Longint2)
			
			FIRST RECORD:C50([ACT_Cargos:173])
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
			
			  //##### procesamiento pagos
			SRACTbol_CargaPagos ([ACT_Boletas:181]ID:1;1)
			  //##### procesamiento pagos
			
			C_TEXT:C284($vt_rutaXML)
			$vt_rutaXML:=[ACT_Boletas:181]MX_pathFile:32
			  //20121114 RCH Se parsea el blob obtenido desde el server no la ruta que esta en el server
			$xBlob:=KRL_GetFileFromServer ($vt_rutaXML;True:C214)
			  //$vt_refxml:=DOM Parse XML source([ACT_Boletas]MX_pathFile)
			$vt_refxml:=DOM Parse XML variable:C720($xBlob)
			If (ok=1)
				
				$vt_separador:="|"
				
				$vt_text:="START"+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="CFDI"+$vt_separador
				C_TEXT:C284($vt_td_1;$vt_s_2;$vt_f_3;$vt_fdp_4;$vt_cdp_5;$vt_tdc_6;$vt_mdp_7;$vt_lde_8;$vt_ndcdp_9;$vt_ffo_10;$vt_sffo_11;$vt_fffo_12;$vt_mffo_13;$vt_ac_14;$vt_cc_15;$vt_ndde_16;$vt_e1_17;$vt_ve1_18;$vt_e2_18_1;$vt_ve2_18_2;$vt_e3_18_3;$vt_ve3_18_4;$vt_e4_18_5;$vt_ve4_18_6;$vt_e5_18_7;$vt_ve5_18_8;$vt_e6_18_9;$vt_ve6_18_10;$vt_e7_18_11;$vt_ve7_18_12;$vt_e8_18_13;$vt_ve8_18_14;$vt_e9_18_15;$vt_ve9_18_16;$vt_e10_18_17;$vt_ve10_18_18)
				$vt_td_1:="FA"
				$vt_s_2:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"serie")
				$vt_f_3:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"folio")
				$vt_fdp_4:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"formaDePago")
				$vt_cdp_5:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"condicionesDePago")
				$vt_tdc_6:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"tipoDeComprobante")
				$vt_mdp_7:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"metodoDePago")
				$vt_lde_8:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"LugarExpedicion")
				$vt_ndcdp_9:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"NumCtaPago")
				$vt_ffo_10:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"FolioFiscalOrig")
				$vt_sffo_11:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"SerieFolioFiscalOrig")
				$vt_fffo_12:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"FechaFolioFiscalOrig")
				$vt_mffo_13:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"MontoFolioFiscalOrig")
				$vt_ac_14:=""
				$vt_cc_15:=""
				$vt_ndde_16:=""
				$vt_e1_17:=""
				$vt_ve1_18:=""
				$vt_e2_18_1:=""
				$vt_ve2_18_2:=""
				$vt_e3_18_3:=""
				$vt_ve3_18_4:=""
				$vt_e4_18_5:=""
				$vt_ve4_18_6:=""
				$vt_e5_18_7:=""
				$vt_ve5_18_8:=""
				$vt_e6_18_9:=""
				$vt_ve6_18_10:=""
				$vt_e7_18_11:=""
				$vt_ve7_18_12:=""
				$vt_e8_18_13:=""
				$vt_ve8_18_14:=""
				$vt_e9_18_15:=""
				$vt_ve9_18_16:=""
				$vt_e10_18_17:=""
				$vt_ve10_18_18:=""
				$vt_text:=$vt_text+$vt_td_1+$vt_separador+$vt_s_2+$vt_separador+$vt_f_3+$vt_separador+$vt_fdp_4+$vt_separador+$vt_cdp_5+$vt_separador+$vt_tdc_6+$vt_separador+$vt_mdp_7+$vt_separador+$vt_lde_8+$vt_separador+$vt_ndcdp_9+$vt_separador+$vt_ffo_10+$vt_separador+$vt_sffo_11+$vt_separador+$vt_fffo_12+$vt_separador+$vt_mffo_13+$vt_separador+$vt_ac_14+$vt_separador+$vt_cc_15+$vt_separador+$vt_ndde_16+$vt_separador+$vt_e1_17+$vt_separador+$vt_ve1_18+$vt_separador+$vt_e2_18_1+$vt_separador+$vt_ve2_18_2+$vt_separador+$vt_e3_18_3+$vt_separador+$vt_ve3_18_4+$vt_separador+$vt_e4_18_5+$vt_separador+$vt_ve4_18_6+$vt_separador+$vt_e5_18_7+$vt_separador+$vt_ve5_18_8+$vt_separador+$vt_e6_18_9+$vt_separador+$vt_ve6_18_10+$vt_separador+$vt_e7_18_11+$vt_separador+$vt_ve7_18_12+$vt_separador+$vt_e8_18_13+$vt_separador+$vt_ve8_18_14+$vt_separador+$vt_e9_18_15+$vt_separador+$vt_ve9_18_16+$vt_separador+$vt_e10_18_17+$vt_separador+$vt_ve10_18_18+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="EMSR"+$vt_separador
				C_TEXT:C284($vt_rfc_19;$vt_n_20;$vt_rf_21;$vt_c_22;$vt_ne_23;$vt_ni_24;$vt_c_25;$vt_l_26;$vt_r_27;$vt_m_28;$vt_e_29;$vt_p_30;$vt_cp_31;$vt_e1_32;$vt_ve1_33;$vt_e2_34;$vt_ve2_35;$vt_e3_36;$vt_ve3_37;$vt_e4_38;$vt_ve4_39;$vt_e5_40;$vt_ve5_41;$vt_e6_41_1;$vt_ve6_41_2;$vt_e7_41_3;$vt_ve7_41_4;$vt_e8_41_5;$vt_ve8_41_6;$vt_e9_41_7;$vt_ve9_41_8;$vt_e10_41_9;$vt_ve10_41_10)
				$vt_rfc_19:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor";"rfc")
				$vt_n_20:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor";"nombre")
				$vt_rf_21:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:RegimenFiscal";"Regimen")
				$vt_c_22:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"calle")
				$vt_ne_23:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"noExterior")
				$vt_ni_24:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"noInterior")
				$vt_c_25:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"colonia")
				$vt_l_26:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"localidad")
				$vt_r_27:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"referencia")
				$vt_m_28:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"municipio")
				$vt_e_29:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"estado")
				$vt_p_30:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"pais")
				$vt_cp_31:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"codigoPostal")
				$vt_e1_32:=""
				$vt_ve1_33:=""
				$vt_e2_34:=""
				$vt_ve2_35:=""
				$vt_e3_36:=""
				$vt_ve3_37:=""
				$vt_e4_38:=""
				$vt_ve4_39:=""
				$vt_e5_40:=""
				$vt_ve5_41:=""
				$vt_e6_41_1:=""
				$vt_ve6_41_2:=""
				$vt_e7_41_3:=""
				$vt_ve7_41_4:=""
				$vt_e8_41_5:=""
				$vt_ve8_41_6:=""
				$vt_e9_41_7:=""
				$vt_ve9_41_8:=""
				$vt_e10_41_9:=""
				$vt_ve10_41_10:=""
				
				$vt_text:=$vt_text+$vt_rfc_19+$vt_separador+$vt_n_20+$vt_separador+$vt_rf_21+$vt_separador+$vt_c_22+$vt_separador+$vt_ne_23+$vt_separador+$vt_ni_24+$vt_separador+$vt_c_25+$vt_separador+$vt_l_26+$vt_separador+$vt_r_27+$vt_separador+$vt_m_28+$vt_separador+$vt_e_29+$vt_separador+$vt_p_30+$vt_separador+$vt_cp_31+$vt_separador+$vt_e1_32+$vt_separador+$vt_ve1_33+$vt_separador+$vt_e2_34+$vt_separador+$vt_ve2_35+$vt_separador+$vt_e3_36+$vt_separador+$vt_ve3_37+$vt_separador+$vt_e4_38+$vt_separador+$vt_ve4_39+$vt_separador+$vt_e5_40+$vt_separador+$vt_ve5_41+$vt_separador+$vt_e6_41_1+$vt_separador+$vt_ve6_41_2+$vt_separador+$vt_e7_41_3+$vt_separador+$vt_ve7_41_4+$vt_separador+$vt_e8_41_5+$vt_separador+$vt_ve8_41_6+$vt_separador+$vt_e9_41_7+$vt_separador+$vt_ve9_41_8+$vt_separador+$vt_e10_41_9+$vt_separador+$vt_ve10_41_10+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="R"+$vt_separador
				C_TEXT:C284($vt_rfc_58;$vt_n_59;$vt_c_60;$vt_ne_61;$vt_ni_62;$vt_c_63;$vt_l_64;$vt_r_65;$vt_m_66;$vt_e_67;$vt_p_68;$vt_cp_69;$vt_c_70;$vt_e1_71;$vt_ve1_72;$vt_e2_73;$vt_ve2_74;$vt_e3_75;$vt_ve3_76;$vt_e4_77;$vt_ve4_78;$vt_e5_79;$vt_ve5_80;$vt_e6_80_1;$vt_ve6_80_2;$vt_e7_80_3;$vt_ve7_80_4;$vt_e8_80_5;$vt_ve8_80_6;$vt_e9_80_7;$vt_ve9_80_8;$vt_e10_80_9;$vt_ve10_80_10;$vt_e11_80_11;$vt_ve11_80_12;$vt_e12_80_13;$vt_ve12_80_14;$vt_e13_80_15;$vt_ve13_80_16;$vt_e14_80_17;$vt_ve14_80_18;$vt_e15_80_19;$vt_ve15_80_20)
				$vt_rfc_58:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"rfc")
				$vt_n_59:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"nombre")
				$vt_c_60:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"calle")
				$vt_ne_61:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"noExterior")
				$vt_ni_62:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"noInterior")
				$vt_c_63:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"colonia")
				$vt_l_64:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"localidad")
				$vt_r_65:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"referencia")
				$vt_m_66:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"municipio")
				$vt_e_67:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"estado")
				$vt_p_68:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"pais")
				$vt_cp_69:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"codigoPostal")
				$vt_c_70:=""
				$vt_e1_71:=""
				$vt_ve1_72:=""
				$vt_e2_73:=""
				$vt_ve2_74:=""
				$vt_e3_75:=""
				$vt_ve3_76:=""
				$vt_e4_77:=""
				$vt_ve4_78:=""
				$vt_e5_79:=""
				$vt_ve5_80:=""
				$vt_e6_80_1:=""
				$vt_ve6_80_2:=""
				$vt_e7_80_3:=""
				$vt_ve7_80_4:=""
				$vt_e8_80_5:=""
				$vt_ve8_80_6:=""
				$vt_e9_80_7:=""
				$vt_ve9_80_8:=""
				$vt_e10_80_9:=""
				$vt_ve10_80_10:=""
				$vt_e11_80_11:=""
				$vt_ve11_80_12:=""
				$vt_e12_80_13:=""
				$vt_ve12_80_14:=""
				$vt_e13_80_15:=""
				$vt_ve13_80_16:=""
				$vt_e14_80_17:=""
				$vt_ve14_80_18:=""
				$vt_e15_80_19:=""
				$vt_ve15_80_20:=""
				
				$vt_text:=$vt_text+$vt_rfc_58+$vt_separador+$vt_n_59+$vt_separador+$vt_c_60+$vt_separador+$vt_ne_61+$vt_separador+$vt_ni_62+$vt_separador+$vt_c_63+$vt_separador+$vt_l_64+$vt_separador+$vt_r_65+$vt_separador+$vt_m_66+$vt_separador+$vt_e_67+$vt_separador+$vt_p_68+$vt_separador+$vt_cp_69+$vt_separador+$vt_c_70+$vt_separador+$vt_e1_71+$vt_separador+$vt_ve1_72+$vt_separador+$vt_e2_73+$vt_separador+$vt_ve2_74+$vt_separador+$vt_e3_75+$vt_separador+$vt_ve3_76+$vt_separador+$vt_e4_77+$vt_separador+$vt_ve4_78+$vt_separador+$vt_e5_79+$vt_separador+$vt_ve5_80+$vt_separador+$vt_e6_80_1+$vt_separador+$vt_ve6_80_2+$vt_separador+$vt_e7_80_3+$vt_separador+$vt_ve7_80_4+$vt_separador+$vt_e8_80_5+$vt_separador+$vt_ve8_80_6+$vt_separador+$vt_e9_80_7+$vt_separador+$vt_ve9_80_8+$vt_separador+$vt_e10_80_9+$vt_separador+$vt_ve10_80_10+$vt_separador+$vt_e11_80_11+$vt_separador+$vt_ve11_80_12+$vt_separador+$vt_e12_80_13+$vt_separador+$vt_ve12_80_14+$vt_separador+$vt_e13_80_15+$vt_separador+$vt_ve13_80_16+$vt_separador+$vt_e14_80_17+$vt_separador+$vt_ve14_80_18+$vt_separador+$vt_e15_80_19+$vt_separador+$vt_ve15_80_20+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				ARRAY TEXT:C222(aQR_Text1;0)
				$vt_ref:=DOM Find XML element:C864($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto";aQR_Text1)
				For ($i;1;Size of array:C274(aQR_Text1))
					$vt_text:="PTDA"+$vt_separador
					C_TEXT:C284($vt_c_81;$vt_u_82;$vt_ni_83;$vt_d_84;$vt_pu_85;$vt_i_86;$vt_n_87;$vt_f_88;$vt_a_89;$vt_n_90;$vt_e1_91;$vt_ve1_92;$vt_e2_93;$vt_ve2_94;$vt_e3_95;$vt_ve3_96;$vt_e4_97;$vt_ve4_98;$vt_e5_99;$vt_ve5_100;$vt_e6_100_1;$vt_ve6_100_2;$vt_e7_100_3;$vt_ve7_100_4;$vt_e8_100_5;$vt_ve8_100_6;$vt_e9_100_7;$vt_ve9_100_8;$vt_e10_100_9;$vt_ve10_100_10;$vt_e11_100_11;$vt_ve11_100_12;$vt_e12_100_13;$vt_ve12_100_14;$vt_e13_100_15;$vt_ve13_100_16;$vt_e14_100_17;$vt_ve14_100_18;$vt_e15_100_19;$vt_ve15_100_20;$vt_e16_100_21;$vt_ve16_100_22;$vt_e17_100_23;$vt_ve17_100_24;$vt_e18_100_25;$vt_ve18_100_26;$vt_e19_100_27;$vt_ve19_100_28;$vt_e20_10_29;$vt_ve20_100_30;$vt_e21_100_31;$vt_ve21_100_32;$vt_e22_100_33;$vt_ve22_100_34;$vt_e23_100_35;$vt_ve23_100_36;$vt_e24_100_37;$vt_ve24_100_38;$vt_e25_100_39;$vt_ve25_100_40;$vt_e26_100_41;$vt_ve26_100_42;$vt_e27_100_43;$vt_ve27_100_44;$vt_e28_100_45;$vt_ve28_100_46;$vt_e29_100_47;$vt_ve29_100_48;$vt_e30_100_49;$vt_ve30_100_50;$vt_e31_100_51;$vt_ve31_100_52;$vt_e32_100_53;$vt_ve32_100_54;$vt_e33_100_55;$vt_ve33_100_56;$vt_e34_100_57;$vt_ve34_100_58;$vt_e35_100_59;$vt_ve35_100_60;$vt_e36_100_61;$vt_ve36_100_62;$vt_e37_100_63;$vt_ve37_100_64;$vt_e38_100_65;$vt_ve38_100_66;$vt_e39_100_67;$vt_ve39_100_68;$vt_e40_100_69;$vt_ve40_100_70;$vt_e41_10_71;$vt_ve41_100_72;$vt_e42_100_73;$vt_ve42_100_74;$vt_e43_100_75;$vt_ve43_100_76;$vt_e44_100_77;$vt_ve44_100_78;$vt_e45_100_79;$vt_ve45_100_80;$vt_e46_100_81;$vt_ve46_100_82;$vt_e47_100_83;$vt_ve47_100_84;$vt_e48_100_85;$vt_ve48_100_86;$vt_e49_100_87;$vt_ve49_100_88;$vt_e50_100_89;$vt_ve50_100_90)
					
					$vt_c_81:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"cantidad")
					$vt_u_82:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"unidad")
					$vt_ni_83:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"noIdentificacion")
					$vt_d_84:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"descripcion")
					$vt_pu_85:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"valorUnitario")
					$vt_i_86:=DOM_GetAttributeValue (aQR_Text1{$i};"/cfdi:Concepto";"importe")
					$vt_n_87:=""
					$vt_f_88:=""
					$vt_a_89:=""
					$vt_n_90:=""
					$vt_e1_91:=""
					$vt_ve1_92:=""
					$vt_e2_93:=""
					$vt_ve2_94:=""
					$vt_e3_95:=""
					$vt_ve3_96:=""
					$vt_e4_97:=""
					$vt_ve4_98:=""
					$vt_e5_99:=""
					$vt_ve5_100:=""
					$vt_e6_100_1:=""
					$vt_ve6_100_2:=""
					$vt_e7_100_3:=""
					$vt_ve7_100_4:=""
					$vt_e8_100_5:=""
					$vt_ve8_100_6:=""
					$vt_e9_100_7:=""
					$vt_ve9_100_8:=""
					$vt_e10_100_9:=""
					$vt_ve10_100_10:=""
					$vt_e11_100_11:=""
					$vt_ve11_100_12:=""
					$vt_e12_100_13:=""
					$vt_ve12_100_14:=""
					$vt_e13_100_15:=""
					$vt_ve13_100_16:=""
					$vt_e14_100_17:=""
					$vt_ve14_100_18:=""
					$vt_e15_100_19:=""
					$vt_ve15_100_20:=""
					$vt_e16_100_21:=""
					$vt_ve16_100_22:=""
					$vt_e17_100_23:=""
					$vt_ve17_100_24:=""
					$vt_e18_100_25:=""
					$vt_ve18_100_26:=""
					$vt_e19_100_27:=""
					$vt_ve19_100_28:=""
					$vt_e20_10_29:=""
					$vt_ve20_100_30:=""
					$vt_e21_100_31:=""
					$vt_ve21_100_32:=""
					$vt_e22_100_33:=""
					$vt_ve22_100_34:=""
					$vt_e23_100_35:=""
					$vt_ve23_100_36:=""
					$vt_e24_100_37:=""
					$vt_ve24_100_38:=""
					$vt_e25_100_39:=""
					$vt_ve25_100_40:=""
					$vt_e26_100_41:=""
					$vt_ve26_100_42:=""
					$vt_e27_100_43:=""
					$vt_ve27_100_44:=""
					$vt_e28_100_45:=""
					$vt_ve28_100_46:=""
					$vt_e29_100_47:=""
					$vt_ve29_100_48:=""
					$vt_e30_100_49:=""
					$vt_ve30_100_50:=""
					$vt_e31_100_51:=""
					$vt_ve31_100_52:=""
					$vt_e32_100_53:=""
					$vt_ve32_100_54:=""
					$vt_e33_100_55:=""
					$vt_ve33_100_56:=""
					$vt_e34_100_57:=""
					$vt_ve34_100_58:=""
					$vt_e35_100_59:=""
					$vt_ve35_100_60:=""
					$vt_e36_100_61:=""
					$vt_ve36_100_62:=""
					$vt_e37_100_63:=""
					$vt_ve37_100_64:=""
					$vt_e38_100_65:=""
					$vt_ve38_100_66:=""
					$vt_e39_100_67:=""
					$vt_ve39_100_68:=""
					$vt_e40_100_69:=""
					$vt_ve40_100_70:=""
					$vt_e41_10_71:=""
					$vt_ve41_100_72:=""
					$vt_e42_100_73:=""
					$vt_ve42_100_74:=""
					$vt_e43_100_75:=""
					$vt_ve43_100_76:=""
					$vt_e44_100_77:=""
					$vt_ve44_100_78:=""
					$vt_e45_100_79:=""
					$vt_ve45_100_80:=""
					$vt_e46_100_81:=""
					$vt_ve46_100_82:=""
					$vt_e47_100_83:=""
					$vt_ve47_100_84:=""
					$vt_e48_100_85:=""
					$vt_ve48_100_86:=""
					$vt_e49_100_87:=""
					$vt_ve49_100_88:=""
					$vt_e50_100_89:=""
					$vt_ve50_100_90:=""
					
					$vt_text:=$vt_text+$vt_c_81+$vt_separador+$vt_u_82+$vt_separador+$vt_ni_83+$vt_separador+$vt_d_84+$vt_separador+$vt_pu_85+$vt_separador+$vt_i_86+$vt_separador+$vt_n_87+$vt_separador+$vt_f_88+$vt_separador+$vt_a_89+$vt_separador+$vt_n_90+$vt_separador+$vt_e1_91+$vt_separador+$vt_ve1_92+$vt_separador+$vt_e2_93+$vt_separador+$vt_ve2_94+$vt_separador+$vt_e3_95+$vt_separador+$vt_ve3_96+$vt_separador+$vt_e4_97+$vt_separador+$vt_ve4_98+$vt_separador+$vt_e5_99+$vt_separador+$vt_ve5_100+$vt_separador+$vt_e6_100_1+$vt_separador+$vt_ve6_100_2+$vt_separador+$vt_e7_100_3+$vt_separador+$vt_ve7_100_4+$vt_separador+$vt_e8_100_5+$vt_separador+$vt_ve8_100_6+$vt_separador+$vt_e9_100_7+$vt_separador+$vt_ve9_100_8+$vt_separador+$vt_e10_100_9+$vt_separador+$vt_ve10_100_10+$vt_separador+$vt_e11_100_11+$vt_separador+$vt_ve11_100_12+$vt_separador+$vt_e12_100_13+$vt_separador+$vt_ve12_100_14+$vt_separador+$vt_e13_100_15+$vt_separador+$vt_ve13_100_16+$vt_separador+$vt_e14_100_17+$vt_separador+$vt_ve14_100_18+$vt_separador+$vt_e15_100_19+$vt_separador+$vt_ve15_100_20+$vt_separador+$vt_e16_100_21+$vt_separador+$vt_ve16_100_22+$vt_separador+$vt_e17_100_23+$vt_separador+$vt_ve17_100_24+$vt_separador+$vt_e18_100_25+$vt_separador+$vt_ve18_100_26+$vt_separador+$vt_e19_100_27+$vt_separador+$vt_ve19_100_28+$vt_separador+$vt_e20_10_29+$vt_separador+$vt_ve20_100_30+$vt_separador+$vt_e21_100_31+$vt_separador+$vt_ve21_100_32+$vt_separador+$vt_e22_100_33+$vt_separador+$vt_ve22_100_34+$vt_separador+$vt_e23_100_35+$vt_separador+$vt_ve23_100_36+$vt_separador+$vt_e24_100_37+$vt_separador+$vt_ve24_100_38+$vt_separador+$vt_e25_100_39+$vt_separador+$vt_ve25_100_40+$vt_separador+$vt_e26_100_41+$vt_separador+$vt_ve26_100_42+$vt_separador+$vt_e27_100_43+$vt_separador+$vt_ve27_100_44+$vt_separador+$vt_e28_100_45+$vt_separador+$vt_ve28_100_46+$vt_separador+$vt_e29_100_47+$vt_separador+$vt_ve29_100_48+$vt_separador+$vt_e30_100_49+$vt_separador+$vt_ve30_100_50+$vt_separador+$vt_e31_100_51+$vt_separador+$vt_ve31_100_52+$vt_separador+$vt_e32_100_53+$vt_separador+$vt_ve32_100_54+$vt_separador+$vt_e33_100_55+$vt_separador+$vt_ve33_100_56+$vt_separador+$vt_e34_100_57+$vt_separador+$vt_ve34_100_58+$vt_separador+$vt_e35_100_59+$vt_separador+$vt_ve35_100_60+$vt_separador+$vt_e36_100_61+$vt_separador+$vt_ve36_100_62+$vt_separador+$vt_e37_100_63+$vt_separador+$vt_ve37_100_64+$vt_separador+$vt_e38_100_65+$vt_separador+$vt_ve38_100_66+$vt_separador+$vt_e39_100_67+$vt_separador+$vt_ve39_100_68+$vt_separador+$vt_e40_100_69+$vt_separador+$vt_ve40_100_70+$vt_separador+$vt_e41_10_71+$vt_separador+$vt_ve41_100_72+$vt_separador+$vt_e42_100_73+$vt_separador+$vt_ve42_100_74+$vt_separador+$vt_e43_100_75+$vt_separador+$vt_ve43_100_76+$vt_separador+$vt_e44_100_77+$vt_separador+$vt_ve44_100_78+$vt_separador+$vt_e45_100_79+$vt_separador+$vt_ve45_100_80+$vt_separador+$vt_e46_100_81+$vt_separador+$vt_ve46_100_82+$vt_separador+$vt_e47_100_83+$vt_separador+$vt_ve47_100_84+$vt_separador+$vt_e48_100_85+$vt_separador+$vt_ve48_100_86+$vt_separador+$vt_e49_100_87+$vt_separador+$vt_ve49_100_88+$vt_separador+$vt_e50_100_89+$vt_separador+$vt_ve50_100_90+$vt_separador+"\r\n"
					IO_SendPacket ($ref;$vt_text)
				End for 
				
				$vt_text:="IE"+$vt_separador
				C_TEXT:C284($vt_v_110;$vt_na_111;$vt_c_112;$vt_ne_113;$vt_a_114;$vt_r_115)
				
				$vt_v_110:="1.0"
				$vt_na_111:=[Alumnos:2]apellidos_y_nombres:40
				$vt_c_112:=[Alumnos:2]RUT:5
				$vt_ne_113:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Sección:9)
				$vt_a_114:=""
				$vt_r_115:=""
				
				$vt_text:=$vt_text+$vt_v_110+$vt_separador+$vt_na_111+$vt_separador+$vt_c_112+$vt_separador+$vt_ne_113+$vt_separador+$vt_a_114+$vt_separador+$vt_r_115+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="T"+$vt_separador
				C_TEXT:C284($vt_s_188;$vt_e1_189;$vt_ve1_190;$vt_e2_191;$vt_ve2_192;$vt_d_193;$vt_md_194;$vt_e3_195;$vt_ve3_196;$vt_e4_197;$vt_ve4_198;$vt_e5_199;$vt_ve5_200;$vt_it_201;$vt_tit_202;$vt_iit_203;$vt_tsit_204;$vt_ir_205;$vt_iir_206;$vt_tdir_207;$vt_e6_208;$vt_ve6_209;$vt_t_210;$vt_tc_211;$vt_m_212;$vt_e7_213;$vt_ve7_214;$vt_e8_215;$vt_ve8_216;$vt_e9_217;$vt_ve9_218;$vt_e10_219;$vt_ve10_220;$vt_e11_220_1;$vt_ve11_220_2;$vt_e12_220_3;$vt_ve12_220_4;$vt_e13_220_5;$vt_ve13_220_6;$vt_e14_220_7;$vt_ve14_220_8;$vt_e15_220_9;$vt_ve15_220_10)
				
				$vt_s_188:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"subTotal")
				$vt_e1_189:=""
				$vt_ve1_190:=""
				$vt_e2_191:=""
				$vt_ve2_192:=""
				$vt_d_193:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"descuento")
				$vt_md_194:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"motivoDescuento")
				$vt_e3_195:=""
				$vt_ve3_196:=""
				$vt_e4_197:=""
				$vt_ve4_198:=""
				$vt_e5_199:=""
				$vt_ve5_200:=""
				$vt_it_201:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado";"impuesto")
				$vt_tit_202:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado";"tasa")
				$vt_iit_203:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado";"importe")
				$vt_tsit_204:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos";"totalImpuestosTrasladados")
				$vt_ir_205:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion";"impuesto")
				$vt_iir_206:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Retenciones/cfdi:Retencion";"importe")
				$vt_tdir_207:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos";"totalImpuestosRetenidos")
				$vt_e6_208:=""
				$vt_ve6_209:=""
				$vt_t_210:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"total")
				$vt_tc_211:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"TipoCambio")
				$vt_m_212:=Choose:C955(DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"Moneda")="";"MXN";DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"Moneda"))
				$vt_e7_213:=""
				$vt_ve7_214:=""
				$vt_e8_215:=""
				$vt_ve8_216:=""
				$vt_e9_217:=""
				$vt_ve9_218:=""
				$vt_e10_219:=""
				$vt_ve10_220:=""
				$vt_e11_220_1:=""
				$vt_ve11_220_2:=""
				$vt_e12_220_3:=""
				$vt_ve12_220_4:=""
				$vt_e13_220_5:=""
				$vt_ve13_220_6:=""
				$vt_e14_220_7:=""
				$vt_ve14_220_8:=""
				$vt_e15_220_9:=""
				$vt_ve15_220_10:=""
				
				$vt_text:=$vt_text+$vt_s_188+$vt_separador+$vt_e1_189+$vt_separador+$vt_ve1_190+$vt_separador+$vt_e2_191+$vt_separador+$vt_ve2_192+$vt_separador+$vt_d_193+$vt_separador+$vt_md_194+$vt_separador+$vt_e3_195+$vt_separador+$vt_ve3_196+$vt_separador+$vt_e4_197+$vt_separador+$vt_ve4_198+$vt_separador+$vt_e5_199+$vt_separador+$vt_ve5_200+$vt_separador+$vt_it_201+$vt_separador+$vt_tit_202+$vt_separador+$vt_iit_203+$vt_separador+$vt_tsit_204+$vt_separador+$vt_ir_205+$vt_separador+$vt_iir_206+$vt_separador+$vt_tdir_207+$vt_separador+$vt_e6_208+$vt_separador+$vt_ve6_209+$vt_separador+$vt_t_210+$vt_separador+$vt_tc_211+$vt_separador+$vt_m_212+$vt_separador+$vt_e7_213+$vt_separador+$vt_ve7_214+$vt_separador+$vt_e8_215+$vt_separador+$vt_ve8_216+$vt_separador+$vt_e9_217+$vt_separador+$vt_ve9_218+$vt_separador+$vt_e10_219+$vt_separador+$vt_ve10_220+$vt_separador+$vt_e11_220_1+$vt_separador+$vt_ve11_220_2+$vt_separador+$vt_e12_220_3+$vt_separador+$vt_ve12_220_4+$vt_separador+$vt_e13_220_5+$vt_separador+$vt_ve13_220_6+$vt_separador+$vt_e14_220_7+$vt_separador+$vt_ve14_220_8+$vt_separador+$vt_e15_220_9+$vt_separador+$vt_ve15_220_10+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				DOM CLOSE XML:C722($vt_refxml)
				
				If (Test path name:C476($vt_rutaXML)=Is a document:K24:1)
					DELETE DOCUMENT:C159($vt_rutaXML)
				End if 
				
				C_TEXT:C284($vt_rutaCliente)
				$vt_rutaCliente:=vtACT_rutaCliente+SYS_Path2FileName ($vt_rutaXML)
				If (Test path name:C476($vt_rutaCliente)=Is a document:K24:1)
					DELETE DOCUMENT:C159($vt_rutaCliente)
				End if 
				
				C_BLOB:C604(vQR_Blob1)
				DOCUMENT TO BLOB:C525(vtACTdte_rutaArchivo;vQR_Blob1)
				C_TEXT:C284($vt_rutaServer)
				$vt_rutaServer:=SYS_GetParentNme ([ACT_Boletas:181]MX_pathFile:32)+SYS_Path2FileName (vtACTdte_rutaArchivo)
				KRL_SendFileToServer ($vt_rutaServer;vQR_Blob1;True:C214)
				
				KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$vl_idBoleta;True:C214)
				[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
				SAVE RECORD:C53([ACT_Boletas:181])
				
				vtACTdte_errorGen:="1"
				
			Else 
				CD_Dlog (0;"Documento no parseado.")
			End if 
			
			CLOSE DOCUMENT:C267($ref)
		Else 
			vtACTdte_errorGen:="-4"
			LOG_RegisterEvt ("Documento de texto no pudo ser creado para el documento id "+String:C10([ACT_Boletas:181]ID:1)+". Archivo no generado")
		End if 
		
	Else 
		vtACTdte_errorGen:="-2"  // registro nulo
		LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" nulo. Archivo no generado")
	End if 
Else 
	vtACTdte_errorGen:="-1"  // registro no encontrado
	LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" no encontrado. Archivo no generado")
End if 