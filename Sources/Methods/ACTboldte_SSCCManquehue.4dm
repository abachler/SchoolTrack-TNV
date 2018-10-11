//%attributes = {}
ALERT:C41("1")
  //ACTboldte_SSCCManquehue
  //se exporta en UTF-8
ALERT:C41("2")

C_TEXT:C284(vtACTdte_errorGen;vtACTdte_rutaArchivo)
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

ARRAY LONGINT:C221($alACT_recNumCargos;0)
ARRAY LONGINT:C221($alACT_recNumDctos;0)
ARRAY LONGINT:C221($alACT_recNumTodos;0)

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

If (Records in selection:C76([ACT_Boletas:181])=1)
	If (Not:C34([ACT_Boletas:181]Nula:15))
		$vt_fileName:=String:C10([ACT_Boletas:181]ID:1)+"_"+String:C10([ACT_Boletas:181]Numero:11)+".txt"
		KRL_ReloadInReadWriteMode (->[ACT_Boletas:181])
		If ([ACT_Boletas:181]codigo_SII:33="")
			Case of 
				: (([ACT_Boletas:181]ID_Categoria:12=-1) | ([ACT_Boletas:181]ID_Categoria:12>0))
					If ([ACT_Boletas:181]TasaIVA:16=0)
						[ACT_Boletas:181]codigo_SII:33:="41"
					Else 
						[ACT_Boletas:181]codigo_SII:33:="39"
					End if 
					
				: ([ACT_Boletas:181]ID_Categoria:12=-3)  // factura
					If ([ACT_Boletas:181]TasaIVA:16=0)
						[ACT_Boletas:181]codigo_SII:33:="34"
					Else 
						[ACT_Boletas:181]codigo_SII:33:="33"
					End if 
					
				: ([ACT_Boletas:181]ID_Categoria:12=-4)  // nc
					[ACT_Boletas:181]codigo_SII:33:="61"
					
			End case 
		End if 
		If ([ACT_Boletas:181]TasaIVA:16=0)
			[ACT_Boletas:181]Monto_Exento:30:=[ACT_Boletas:181]Monto_Total:6
		End if 
		
		SAVE RECORD:C53([ACT_Boletas:181])
		
		If (([ACT_Boletas:181]codigo_SII:33="39") | ([ACT_Boletas:181]codigo_SII:33="41"))
			$ref:=ACTabc_CreaDocumento ("DTE_Archivos"+Folder separator:K24:12+[ACT_Boletas:181]codigo_SII:33;$vt_fileName)
			If (vtACT_document#"")
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
				CREATE SET:C116([ACT_Transacciones:178];"setTransacciones")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumTodos;"")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)
				ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2;>;[ACT_Cargos:173]FechaEmision:22;>;[ACT_Cargos:173]ID:1;>)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
				AT_Difference (->$alACT_recNumTodos;->$alACT_recNumCargos;->$alACT_recNumDctos)
				
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
				KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
				
				  //##### procesamiento pagos
				SRACTbol_CargaPagos ([ACT_Boletas:181]ID:1;1)
				  //##### procesamiento pagos
				
				$vt_separador:=";"
				
				$vt_text:="->Boleta<-"+"\r\n"
				$vt_tipo1:=[ACT_Boletas:181]codigo_SII:33
				$vt_folio2:=String:C10([ACT_Boletas:181]Numero:11)
				$vt_fechaEm3:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3))+"-"+String:C10(Month of:C24([ACT_Boletas:181]FechaEmision:3);"00")+"-"+String:C10(Day of:C23([ACT_Boletas:181]FechaEmision:3);"00")
				$vt_indServ4:="3"
				$vt_indMntNeto5:="0"
				$vt_periodoDesde6:=""
				$vt_periodoHasta7:=""
				$vt_fechaVenc8:=""
				$vt_rutCliente9:=Replace string:C233(SR_FormatoRUT2 ([Personas:7]RUT:6);".";"")
				$vt_codInterno10:=String:C10([Personas:7]No:1)
				$vt_rsCliente11:=[Personas:7]Apellidos_y_nombres:30
				$vt_giroCliente12:="Apoderado"
				$vt_dirCliente13:=[Personas:7]Direccion:14
				$vt_comCliente14:=[Personas:7]Comuna:16
				$vt_ciuCliente15:=[Personas:7]Ciudad:17
				$vt_email16:=[Personas:7]eMail:34
				$vt_text:=$vt_text+$vt_tipo1+$vt_separador+$vt_folio2+$vt_separador+$vt_fechaEm3+$vt_separador+$vt_indServ4+$vt_separador+$vt_indMntNeto5+$vt_separador+$vt_periodoDesde6+$vt_separador+$vt_periodoHasta7+$vt_separador+$vt_fechaVenc8+$vt_separador+$vt_rutCliente9+$vt_separador+$vt_codInterno10+$vt_separador+$vt_rsCliente11+$vt_separador+$vt_giroCliente12+$vt_separador+$vt_dirCliente13+$vt_separador+$vt_comCliente14+$vt_separador+$vt_ciuCliente15+$vt_separador+$vt_email16+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="->BoletaTotales<-"+"\r\n"
				$vt_neto1:=String:C10([ACT_Boletas:181]Monto_Afecto:4)
				$vt_exento2:=String:C10([ACT_Boletas:181]Monto_Exento:30)
				$vt_iva3:=String:C10([ACT_Boletas:181]Monto_IVA:5)
				$vt_total4:=String:C10([ACT_Boletas:181]Monto_Total:6)
				$vt_montoNF5:="0"
				$vt_totalPeriodo6:="0"
				$vt_saldoAnterior7:="0"
				$vt_valorAPagar8:="0"
				$vt_text:=$vt_text+$vt_neto1+$vt_separador+$vt_exento2+$vt_separador+$vt_iva3+$vt_separador+$vt_total4+$vt_separador+$vt_montoNF5+$vt_separador+$vt_totalPeriodo6+$vt_separador+$vt_saldoAnterior7+$vt_separador+$vt_valorAPagar8+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				$vt_text:="->BoletaDetalle<-"+"\r\n"
				For ($i;1;Size of array:C274($alACT_recNumCargos))
					GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargos{$i})
					$vr_monto:=ACTbol_GetMontoLinea ("setTransacciones")
					$vt_noLinea1:=String:C10($i)
					$vt_codigo2:=String:C10([ACT_Cargos:173]Ref_Item:16)+"_"+String:C10([ACT_Cargos:173]ID:1)
					KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
					If (Records in selection:C76([xxACT_Items:179])>0)
						$vt_descripcion3:=[xxACT_Items:179]Glosa_de_Impresión:20
					Else 
						$vt_descripcion3:=[ACT_Cargos:173]Glosa:12
					End if 
					$vt_indExen4:=ST_Boolean2Str ([ACT_Cargos:173]TasaIVA:21#0;"0";"1")
					$vt_cantidad5:="1"
					$vt_precio6:=String:C10($vr_monto)
					$vt_valorExento7:=String:C10($vr_monto)
					$vt_valor8:=String:C10($vr_monto)
					$vt_tipoCod9:="INT1"
					$vt_uniMed10:="UN"
					
					$var1:=Get pointer:C304("vtACT_SRbolPGS_Forma"+String:C10($i)+"1")
					$var2:=Get pointer:C304("vtACT_SRbolPGS_DatoPago1"+String:C10($i)+"1")
					$var3:=Get pointer:C304("vtACT_SRbolPGS_DatoPago2"+String:C10($i)+"1")
					$var4:=Get pointer:C304("vtACT_SRbolPGS_Fecha"+String:C10($i)+"1")
					$vt_mes:=<>atXS_MonthNames{[ACT_Cargos:173]Mes:13}
					$vt_year:=String:C10([ACT_Cargos:173]Año:14;"0000")
					If ($var1->#"")
						$vt_descLarga11:=$var1->+" "+$var2->+" "+$var3->+" "+$var4->+" "
					Else 
						$vt_descLarga11:=""
					End if 
					$vt_descLarga11:=$vt_descLarga11+$vt_mes+" "+$vt_year
					
					$vt_text:=$vt_text+$vt_noLinea1+$vt_separador+$vt_codigo2+$vt_separador+$vt_descripcion3+$vt_separador+$vt_indExen4+$vt_separador+$vt_cantidad5+$vt_separador+$vt_precio6+$vt_separador+$vt_valorExento7+$vt_separador+$vt_valor8+$vt_separador+$vt_tipoCod9+$vt_separador+$vt_uniMed10+$vt_separador+$vt_descLarga11+$vt_separador+"\r\n"
				End for 
				IO_SendPacket ($ref;$vt_text)
				
				If (Size of array:C274($alACT_recNumDctos)>0)
					$vt_text:="->BoletaDescRec<-"+"\r\n"
					For ($i;1;Size of array:C274($alACT_recNumDctos))
						GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumDctos{$i})
						$vr_monto:=ACTbol_GetMontoLinea ("setTransacciones")
						$vt_noLineaDR1:=String:C10($i)
						$vt_DR2:="D"
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
						If (Records in selection:C76([xxACT_Items:179])>0)
							$vt_descripcionDR3:=[xxACT_Items:179]Glosa_de_Impresión:20
						Else 
							$vt_descripcionDR3:=[ACT_Cargos:173]Glosa:12
						End if 
						$vt_tipoDR4:="$"
						$vt_valorDR5:=String:C10(Abs:C99($vr_monto))
						$vt_tipoExento6DR:=ST_Boolean2Str ([ACT_Cargos:173]TasaIVA:21#0;"0";"1")
						$vt_text:=$vt_text+$vt_noLineaDR1+$vt_separador+$vt_DR2+$vt_separador+$vt_descripcionDR3+$vt_separador+$vt_tipoDR4+$vt_separador+$vt_valorDR5+$vt_separador+$vt_tipoExento6DR+$vt_separador+"\r\n"
					End for 
					IO_SendPacket ($ref;$vt_text)
				End if 
				SET_ClearSets ("setTransacciones")
				
				
				$vt_text:="->Observacion<-"+"\r\n"
				$vt_observacion1:="FAMILIA "+[Familia:78]Nombre_de_la_familia:3
				$vt_text:=$vt_text+$vt_observacion1+$vt_separador+"\r\n"
				IO_SendPacket ($ref;$vt_text)
				
				vtACTdte_errorGen:="1"  //proceso ok
				vtACTdte_rutaArchivo:=document
				
				CLOSE DOCUMENT:C267($ref)
			Else 
				vtACTdte_errorGen:="-4"
				LOG_RegisterEvt ("Documento de texto no pudo ser creado para el documento id "+String:C10([ACT_Boletas:181]ID:1)+". Archivo no generado")
			End if 
		Else 
			vtACTdte_errorGen:="-3"  // no es boleta
			LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" no es boleta. Archivo no generado")
		End if 
	Else 
		vtACTdte_errorGen:="-2"  // registro nulo
		LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" nulo. Archivo no generado")
	End if 
Else 
	vtACTdte_errorGen:="-1"  // registro no encontrado
	LOG_RegisterEvt ("Documento id "+String:C10([ACT_Boletas:181]ID:1)+" no encontrado. Archivo no generado")
End if 
