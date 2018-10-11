//%attributes = {}
  //ACTbol_GeneraArchivoDigital 

C_TEXT:C284($vt_pais;$vt_rutaXML;$vt_rutaCadena;$vt_codFamilia)
C_LONGINT:C283($vl_idBoleta)
ARRAY LONGINT:C221($alACT_recNumCargo;0)

READ ONLY:C145([Personas:7])
  //20120907 RCH Se hacen cambios para soportar boletas emitidas para terceros
READ ONLY:C145([ACT_Terceros:138])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Pago:176])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
READ ONLY:C145([Alumnos:2])

  //20130314 RCH ticket 118454
ARRAY LONGINT:C221($alACTcfg_IdItemReinsc;0)
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="@Reinscripción@")
If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=[xxACT_ItemsCategorias:98]ID:2)
	SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACTcfg_IdItemReinsc)
End if 

$vl_idBoleta:=$1

  //busco boleta
READ WRITE:C146([ACT_Boletas:181])  // se escribira ruta y estado
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$vl_idBoleta)

If (Records in selection:C76([ACT_Boletas:181])=1)
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		If (Not:C34([ACT_Boletas:181]Nula:15))
			  //busco el pago mas nuevo ingresado
			
			Case of 
				: (<>gCountryCode="mx")
					ACTcfdi_OpcionesGenerales ("OnLoadConf";->[ACT_Boletas:181]ID_RazonSocial:25)
					$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
					vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
					
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
					ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]FechaIngreso:24;<;[ACT_Pagos:172]ID:1;<)
					KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
					
					ACTcfdi_OpcionesGenerales ("LeeRutasCertificados";->[ACT_Boletas:181]ID_RazonSocial:25)
					$vl_resultado:=Num:C11(ACTcfdi_OpcionesGenerales ("PathFileValidate"))
					
					If ($vl_resultado=1)
						  // busco al receptor
						QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
						QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=[ACT_Boletas:181]ID_Tercero:21)
						
						$vt_codFamilia:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]RUT:6;[ACT_Terceros:138]RUT:4)
						  //obtengo texto certificado
						If ((at_proveedores{at_proveedores}="Buzón Fiscal") | (at_proveedores{at_proveedores}="Levicom"))
							C_TEXT:C284($vt_certificado;$vt_beginpem;$vt_endpem)
							C_BLOB:C604($xBlob)
							C_LONGINT:C283($vl_offSet)
							
							$vl_offSet:=0
							$vt_beginpem:="-----BEGIN CERTIFICATE-----"
							$vt_endpem:="-----END CERTIFICATE-----"
							
							DOCUMENT TO BLOB:C525(vtACT_rutaCertificado;$xBlob)
							$vt_certificado:=BLOB to text:C555($xBlob;Mac text without length:K22:10;$vl_offSet)
							$vt_certificado:=Replace string:C233($vt_certificado;$vt_beginpem;"")
							$vt_certificado:=Replace string:C233($vt_certificado;$vt_endpem;"")
							$vt_certificado:=Replace string:C233($vt_certificado;Char:C90(10);"")
						Else 
							$vt_certificado:=""
						End if 
						
						[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Archivo generado para documento "+ST_Boolean2Str ([ACT_Boletas:181]documento_electronico:29;"Digital.";"Impreso.")+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
						
						  //genero XML
						  //LOG_RegisterEvt ("CFDI: Inicio generación XML sin sello.")
						[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Inicio generación XML sin sello."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
						
						_O_C_STRING:C293(16;vRefElem;$vRefxml_Emisor;$vRefxml_expedido;$vRefxml_receptor;$vRefxml_domReceptor)
						_O_C_STRING:C293(16;$vRefxml_conceptos;$vRefxml_concepto;$vRefxml_infoAduanera;$vRefxml_ctaPredial)
						_O_C_STRING:C293(16;$vRefxml_compConc;$vRefxml_parteConc;$vRefxml_infoAdua;$vRefxml_impuestos)
						_O_C_STRING:C293(16;$vRefxml_traslados;$vRefxml_traslado;$vRefxml_complemento;$vRefxml_addenda)
						C_TEXT:C284($Raiz;$Nombreespacio)
						
						  //20120522 RCH Para el Williams...
						  //$Raiz:="cfdi:Comprobante"
						  //$Nombreespacio:="http://www.sat.gob.mx/cfd/3"
						  //vRefElem:=DOM Create XML Ref($Raiz;$Nombreespacio)
						
						$vt_propiedad:="FILE|rutaXSLT"
						$vt_propiedad:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						$vt_tipo:=SYS_Path2FileName ($vt_propiedad)
						$vb_version1:=($vt_tipo="cadenaoriginal_3_0_Col.xslt")
						
						C_TEXT:C284($vtNS1;$vtNS2;$vtNSV1;$vtNSV2)
						$Raiz:="cfdi:Comprobante"
						$Nombreespacio:="http://www.sat.gob.mx/cfd/3"
						
						$vtNS1:="xsi:schemaLocation"
						$vtNS2:="xmlns:xsi"
						
						If ($vb_version1)
							$vtNSV1:="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv3.xsd"
						Else 
							$vtNSV1:="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"
						End if 
						$vtNSV2:="http://www.w3.org/2001/XMLSchema-instance"
						
						vRefElem:=DOM Create XML Ref:C861($Raiz;$Nombreespacio;$vtNS1;$vtNSV1;$vtNS2;$vtNSV2)
						
						If ($vb_version1)
							DOM SET XML ATTRIBUTE:C866(vRefElem;"version";"3.0")
						Else 
							DOM SET XML ATTRIBUTE:C866(vRefElem;"version";"3.2")
						End if 
						
						  // se agrega serie y folio...
						  //$vt_propiedad:="XML|serie"
						  //agrega el  serie según el tipo de documento. (Nota de crédito o Factura)
						$vt_propiedad:=Choose:C955([ACT_Boletas:181]ID_Categoria:12=-4;"XML|serie NC";"XML|serie")
						$vt_serie:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						If ($vt_serie#"")
							DOM SET XML ATTRIBUTE:C866(vRefElem;"serie";$vt_serie)
						End if 
						If ([ACT_Boletas:181]Numero:11#0)
							DOM SET XML ATTRIBUTE:C866(vRefElem;"folio";[ACT_Boletas:181]Numero:11)
						End if 
						  //DOM SET XML ATTRIBUTE(vRefElem;"serie";"")
						  //DOM SET XML ATTRIBUTE(vRefElem;"folio";"")
						DOM SET XML ATTRIBUTE:C866(vRefElem;"fecha";String:C10([ACT_Boletas:181]FechaEmision:3;ISO date:K1:8;DTS_GetTime ([ACT_Boletas:181]DTS_Creacion:22)))
						DOM SET XML ATTRIBUTE:C866(vRefElem;"sello";"")
						$vt_propiedad:="XML|formaDePago"
						DOM SET XML ATTRIBUTE:C866(vRefElem;"formaDePago";ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad))
						DOM SET XML ATTRIBUTE:C866(vRefElem;"noCertificado";ACTxml_GetValidText (vtACT_numeroCertificado))
						DOM SET XML ATTRIBUTE:C866(vRefElem;"certificado";ACTxml_GetValidText ($vt_certificado))
						  //DOM SET XML ATTRIBUTE(vRefElem;"condicionesDePago";"")
						DOM SET XML ATTRIBUTE:C866(vRefElem;"subTotal";[ACT_Boletas:181]Monto_Total:6-[ACT_Boletas:181]Monto_IVA:5)
						  //DOM SET XML ATTRIBUTE(vRefElem;"descuento";"")
						  //DOM SET XML ATTRIBUTE(vRefElem;"motivoDescuento";"")
						
						  //20121128 RCH Para Williams
						$vt_propiedad:="XML|Tipo de cambio"
						DOM SET XML ATTRIBUTE:C866(vRefElem;"TipoCambio";ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad))
						$vt_propiedad:="XML|Moneda"
						DOM SET XML ATTRIBUTE:C866(vRefElem;"Moneda";ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad))
						
						  //DOM SET XML ATTRIBUTE(vRefElem;"TipoCambio";"")
						  //DOM SET XML ATTRIBUTE(vRefElem;"Moneda";"")
						DOM SET XML ATTRIBUTE:C866(vRefElem;"total";[ACT_Boletas:181]Monto_Total:6)
						  //DOM SET XML ATTRIBUTE(vRefElem;"metodosDePago";"")
						$vt_propiedad:="XML|tipoDeComprobante"
						DOM SET XML ATTRIBUTE:C866(vRefElem;"tipoDeComprobante";ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad))
						
						If ($vb_version1)
						Else 
							  //version 3.2
							ARRAY TEXT:C222($atACT_formasDePago;0)
							DISTINCT VALUES:C339([ACT_Pagos:172]FormaDePago:7;$atACT_formasDePago)
							DOM SET XML ATTRIBUTE:C866(vRefElem;"metodoDePago";AT_array2text (->$atACT_formasDePago;" - "))
							
							$vt_propiedad:="XML|LugarExpedicion"
							DOM SET XML ATTRIBUTE:C866(vRefElem;"LugarExpedicion";ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad))
							
							  //20121009 RCH Se agrega num cta pago
							Case of 
								: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-6)
									$vt_numTc:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TC_Numero:17)
									$vt_propiedad:=Substring:C12($vt_numTc;(Length:C16($vt_numTc)-4)+1;4)
								: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4) & ([ACT_Documentos_de_Pago:176]Ch_Cuenta:11#""))  //cheque
									$vt_propiedad:=Substring:C12([ACT_Documentos_de_Pago:176]Ch_Cuenta:11;Length:C16([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)-3;5)
								: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-7) & ([ACT_Documentos_de_Pago:176]R_NoDocumento:33#""))  //td
									$vt_propiedad:=[ACT_Documentos_de_Pago:176]R_NoDocumento:33
								: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-9) | ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-10) | ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-11))  //PAT, PAC, Cuponera
									If ([ACT_Pagos:172]Lugar_de_Pago:18#"")
										$vt_propiedad:=[ACT_Pagos:172]Lugar_de_Pago:18
									Else 
										$vt_propiedad:="No identificado"
									End if 
								Else 
									$vt_propiedad:="No identificado"
							End case 
							DOM SET XML ATTRIBUTE:C866(vRefElem;"NumCtaPago";$vt_propiedad)
							
							  //DOM SET XML ATTRIBUTE(vRefElem;"FolioFiscalOrig";"")
							  //DOM SET XML ATTRIBUTE(vRefElem;"SerieFolioFiscalOrig";"")
							  //DOM SET XML ATTRIBUTE(vRefElem;"FechaFolioFiscalOrig";"")
							  //DOM SET XML ATTRIBUTE(vRefElem;"MontoFolioFiscalOrig";"")
							  //version 3.2
						End if 
						
						  // emisor
						ACTcfg_OpcionesRazonesSociales ("CargaByID";->[ACT_Boletas:181]ID_RazonSocial:25)
						  //$vt_pais:=[Colegio]Pais
						
						  //20130410 RCH No se estaba llenando correctamente el pais
						READ ONLY:C145([Colegio:31])
						ALL RECORDS:C47([Colegio:31])
						FIRST RECORD:C50([Colegio:31])
						$vt_pais:=[Colegio:31]Pais:21
						
						$vRefxml_Emisor:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Emisor")
						DOM SET XML ATTRIBUTE:C866($vRefxml_Emisor;"rfc";ACTxml_GetValidText (<>vsACT_RUT))
						DOM SET XML ATTRIBUTE:C866($vRefxml_Emisor;"nombre";ACTxml_GetValidText (<>vsACT_RazonSocial))
						
						$vRefxml_domFiscal:=DOM_SetElementValueAndAttr ($vRefxml_Emisor;"cfdi:DomicilioFiscal")
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"calle";ACTxml_GetValidText (<>vsACT_Direccion))
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"noExterior";"")
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"noExterior";ACTxml_GetValidText (<>vsACT_Numero))  //20171228 RCH
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"noInterior";"")
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"noInterior";ACTxml_GetValidText (<>vsACT_NumeroInterior))  //20171228 RCH
						
						If (<>vsACT_Comuna#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"colonia";ACTxml_GetValidText (<>vsACT_Comuna))
						End if 
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"localidad";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"referencia";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"municipio";ACTxml_GetValidText (<>vsACT_Comuna))
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"municipio";ACTxml_GetValidText (<>vsACT_Ciudad))
						  //DOM SET XML ATTRIBUTE($vRefxml_domFiscal;"estado";"")
						$vt_propiedad:="XML|estado"
						$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"estado";$vt_valor)
						
						If ($vt_valor="")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"estado";ACTxml_GetValidText (<>vsACT_RegionEstado))  //20171228 RCH
						End if 
						
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"pais";ACTxml_GetValidText ($vt_pais))
						DOM SET XML ATTRIBUTE:C866($vRefxml_domFiscal;"codigoPostal";ACTxml_GetValidText (<>vsACT_CPostal))
						
						If ($vb_version1)
						Else 
							  //version 3.2
							ARRAY TEXT:C222($atACT_regimen;0)
							$vt_propiedad:="XML|RegimenFiscal"
							$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
							AT_Text2Array (->$atACT_regimen;$vt_valor)  // separado por ";" si hay mas de uno
							
							For ($r;1;Size of array:C274($atACT_regimen))
								$vRefxml_regimenFiscal:=DOM_SetElementValueAndAttr ($vRefxml_Emisor;"cfdi:RegimenFiscal")
								DOM SET XML ATTRIBUTE:C866($vRefxml_regimenFiscal;"Regimen";$atACT_regimen{$r})
							End for 
						End if 
						
						  // opcional
						  //$vRefxml_expedido:=DOM_SetElementValueAndAttr ($vRefxml_Emisor;"cfdi:ExpedidoEn")
						  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"calle";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"noExterior";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"noInterior";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"colonia";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"localidad";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"referencia";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"municipio";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"estado";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"pais";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_expedido;"codigoPostal";"")
						
						
						  //receptor
						$vRefxml_receptor:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Receptor")
						$vt_propiedad:="XML|Campo Propio para R.F.C."
						$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						If ($vt_valor#"")
							$vt_valor:=_CampoPropio ($vt_valor)
						Else 
							
							  //20120920 RCH En un colegio el RFC es el identificador nacional 2...
							  //$vt_valor:=Choose([ACT_Boletas]ID_Apoderado#0;[Personas]RUT;[ACT_Terceros]RUT)
							$vt_propiedad:="XML|Identificador Nacional para R.F.C."
							$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
							Case of 
								: ($vt_valor="1")
									$vt_valor:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]RUT:6;[ACT_Terceros:138]RUT:4)
									
								: ($vt_valor="2")
									$vt_valor:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]IDNacional_2:37;[ACT_Terceros:138]Identificador_Nacional2:20)
									
								: ($vt_valor="3")
									$vt_valor:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]IDNacional_3:38;[ACT_Terceros:138]Identificador_Nacional3:21)
									
								: ($vt_valor="4")
									$vt_valor:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Pasaporte:59;[ACT_Terceros:138]Pasaporte:25)
									
								: ($vt_valor="5")
									$vt_valor:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Codigo_interno:22;[ACT_Terceros:138]Codigo_Interno:29)
									
								Else 
									$vt_valor:="CONFIGURACION "+ST_Qte (ST_GetWord ($vt_propiedad;2;"|"))+" NO ESPECIFICADA"
							End case 
							
						End if 
						DOM SET XML ATTRIBUTE:C866($vRefxml_receptor;"rfc";ACTxml_GetValidText ($vt_valor))
						DOM SET XML ATTRIBUTE:C866($vRefxml_receptor;"nombre";ACTxml_GetValidText (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Apellidos_y_nombres:30;[ACT_Terceros:138]Nombre_Completo:9)))
						$vRefxml_domReceptor:=DOM_SetElementValueAndAttr ($vRefxml_receptor;"cfdi:Domicilio")
						
						  //20121114 RCH Maneja direccion E.C.
						$vt_propiedad:="XML|Utilizar dirección E.C."
						$vt_valorPref:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						If ($vt_valorPref="0")
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Direccion:14;[ACT_Terceros:138]Direccion:5)))
						Else 
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_DireccionEC:67;[ACT_Terceros:138]Direccion:5)))
						End if 
						If ($vt_valor#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"calle";$vt_valor)
						End if 
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"noExterior";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"noInterior";"")
						If ($vt_valorPref="0")
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Comuna:16;[ACT_Terceros:138]Comuna:6)))
						Else 
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_ComunaEC:68;[ACT_Terceros:138]Comuna:6)))
						End if 
						If ($vt_valor#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"colonia";$vt_valor)
						End if 
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"localidad";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"referencia";"")
						If ($vt_valorPref="0")
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Ciudad:17;[ACT_Terceros:138]Ciudad:7)))
						Else 
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_CiudadEC:69;[ACT_Terceros:138]Ciudad:7)))
						End if 
						If ($vt_valor#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"municipio";$vt_valor)
						End if 
						
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"estado";ACTxml_GetValidText (Choose([ACT_Boletas]ID_Apoderado#0;[Personas]Ciudad;[ACT_Terceros]ciudad)))
						  //DOM SET XML ATTRIBUTE($vRefxml_domReceptor;"estado";"")
						$vt_propiedad:="XML|estado"
						$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						If ([ACT_Boletas:181]ID_Apoderado:14#0) & ([Personas:7]Region_o_Estado:18#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"estado";[Personas:7]Region_o_Estado:18)
						Else 
							If ($vt_valor#"")
								DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"estado";$vt_valor)
							End if 
						End if 
						
						DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"pais";ACTxml_GetValidText ($vt_pais))
						
						If ($vt_valorPref="0")
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Codigo_postal:15;[ACT_Terceros:138]Codigo_Postal:15)))
						Else 
							$vt_valor:=ACTxml_GetValidText (ST_GetCleanString (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]ACT_CodPostalEC:70;[ACT_Terceros:138]Codigo_Postal:15)))
						End if 
						If ($vt_valor#"")
							DOM SET XML ATTRIBUTE:C866($vRefxml_domReceptor;"codigoPostal";$vt_valor)
						End if 
						
						
						  // Conceptos
						C_REAL:C285($vr_factor;$vr_monto;$vr_afecto;$vr_montoIVA;$vr_unitario;$vr_total)
						C_TEXT:C284($vt_monedaCargo;$vt_glosa)
						C_LONGINT:C283($vl_decimales;$i)
						
						  //20120427 RCH Quito los cargos NC
						  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
						  //CREATE SET([ACT_Transacciones];"setTransaccionesBoleta")
						  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
						  //LONGINT ARRAY FROM SELECTION([ACT_Cargos];$alACT_recNumCargo;"")
						  //transacciones de la boleta
						  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
						  //CREATE SET([ACT_Transacciones];"setTransaccionesBoleta")
						  //  // transacciones de boletas asociadas
						  //QUERY([ACT_Boletas];[ACT_Boletas]ID_DctoAsociado=[ACT_Boletas]ID)
						  //KRL_RelateSelection (->[ACT_Transacciones]No_Boleta;->[ACT_Boletas]ID;"")
						  //CREATE SET([ACT_Transacciones];"Transacciones2")
						  //  // uno para quedarme con todas las transacciones
						  //UNION("setTransaccionesBoleta";"Transacciones2";"setTransaccionesBoleta")
						  //USE SET("setTransaccionesBoleta")
						  //  // busco los cargos de las transacciones asociadas
						  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
						  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item#-127;*)
						  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-128;*)
						  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item#-129)
						  //SET_ClearSets ("Transacciones2")
						  //QUERY([ACT_Boletas];[ACT_Boletas]ID=$vl_idBoleta)
						
						ACTbol_BuscaCargosCargaSet ("setTransaccionesBoleta";$vl_idBoleta)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargo;"")
						
						$vRefxml_conceptos:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Conceptos")
						
						ARRAY LONGINT:C221($alACT_Cantidad;0)
						  //20130626 RCH NF CANTIDAD
						ARRAY REAL:C219($arACT_Cantidad;0)
						ARRAY TEXT:C222($atACT_Desc;0)
						ARRAY REAL:C219($arACT_ValorUnitario;0)
						ARRAY REAL:C219($arACT_Total;0)
						ARRAY REAL:C219($arACT_MontoIva;0)
						ARRAY TEXT:C222($atACT_NombreAl;0)
						ARRAY TEXT:C222($atACT_CURPAl;0)
						ARRAY TEXT:C222($atACT_mes;0)
						ARRAY LONGINT:C221($al_nivelAl;0)  //20120920 RCH
						ARRAY LONGINT:C221($alACT_idCargo;0)  //20130125 RCH Para agrupar por categorias.
						
						For ($i;1;Size of array:C274($alACT_recNumCargo))
							$vRefxml_concepto:=DOM_SetElementValueAndAttr ($vRefxml_conceptos;"cfdi:Concepto")
							GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargo{$i})
							
							APPEND TO ARRAY:C911($alACT_idCargo;[ACT_Cargos:173]ID:1)  //20130125 RCH
							$vr_monto:=ACTbol_GetMontoLinea ("setTransaccionesBoleta")
							
							$vt_monedaCargo:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1))
							$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo))
							
							If ([ACT_Cargos:173]TasaIVA:21#0)
								$vr_factor:=1+([ACT_Cargos:173]TasaIVA:21/100)
								$vr_afecto:=$vr_monto/$vr_factor
								$vr_montoIVA:=Round:C94($vr_afecto*([ACT_Cargos:173]TasaIVA:21/100);$vl_decimales)
							Else 
								$vr_montoIVA:=0
							End if 
							
							DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"cantidad";"1")
							APPEND TO ARRAY:C911($arACT_Cantidad;1)
							
							  // requerido version 3.2
							If ($vb_version1)
							Else 
								$vt_propiedad:="XML|ConceptosUnidad"
								$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
								DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"unidad";$vt_valor)
							End if 
							
							  //DOM SET XML ATTRIBUTE($vRefxml_concepto;"noIdentificacion";"")
							$vt_glosa:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]Glosa_de_Impresión:20)
							$vt_glosa:=ST_Boolean2Str ($vt_glosa#"";$vt_glosa;[ACT_Cargos:173]Glosa:12)
							  //exporta segun formato del proveedor.
							Case of 
								: (at_proveedores{at_proveedores}="Levicom")
									KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
									KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8)
									KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
									KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$vl_idBoleta;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
									KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
									$vt_desc:=""
									If ((Records in selection:C76([xxACT_ItemsCategorias:98])>0) & (cbUsarCategorias=1))
										$vt_desc:=[xxACT_ItemsCategorias:98]Nombre:1
									Else 
										If (Records in selection:C76([xxACT_Items:179])>0)
											$vt_desc:=[xxACT_Items:179]Glosa_de_Impresión:20
										Else 
											$vt_desc:=[ACT_Cargos:173]Glosa:12
										End if 
									End if 
									
									$vt_desc:=$vt_desc+" Mes de "+<>atXS_MonthNames{[ACT_Cargos:173]Mes:13}
									$vt_desc:=$vt_desc+", Alumno: "+[Alumnos:2]apellidos_y_nombres:40
									$vt_desc:=$vt_desc+", Matrícula "+[ACT_CuentasCorrientes:175]Codigo:19
									$vt_desc:=$vt_desc+", Grupo: "+[Alumnos:2]curso:20
									
									  //20121210 RCH En un colegio el RFC es el identificador nacional 2...
									  //$vt_desc:=$vt_desc+", CURP: "+[Alumnos]RUT
									$vt_propiedad:="XML|Identificador Nacional para R.F.C. para Cuentas"
									$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									Case of 
										: ($vt_valor="1")
											$vt_valor:=[Alumnos:2]RUT:5
										: ($vt_valor="2")
											$vt_valor:=[Alumnos:2]IDNacional_2:71
										: ($vt_valor="3")
											$vt_valor:=[Alumnos:2]IDNacional_3:70
										: ($vt_valor="4")
											$vt_valor:=[Alumnos:2]NoPasaporte:87
										: ($vt_valor="5")
											$vt_valor:=[Alumnos:2]Codigo_interno:6
										Else 
											$vt_valor:="CONFIGURACION "+ST_Qte (ST_GetWord ($vt_propiedad;2;"|"))+" NO ESPECIFICADA"
									End case 
									$vt_desc:=$vt_desc+", CURP: "+$vt_valor
									
									  //ticket 111661
									  //$vt_desc:=$vt_desc+", Pago: "+[ACT_Pagos]FormaDePago
									$vt_desc:=Substring:C12($vt_desc;1;250)
									
									DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"descripcion";ACTxml_GetValidText ($vt_desc))
								Else 
									DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"descripcion";ACTxml_GetValidText ($vt_glosa))
							End case 
							  //20120222 RCH Estaba sobreescribiendo en nodo
							  //DOM SET XML ATTRIBUTE($vRefxml_concepto;"descripcion";ACTxml_GetValidText ($vt_glosa))
							APPEND TO ARRAY:C911($atACT_Desc;$vt_glosa)
							$vr_unitario:=Round:C94($vr_monto-$vr_montoIVA;$vl_decimales)
							DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"valorUnitario";$vr_unitario)
							APPEND TO ARRAY:C911($arACT_ValorUnitario;$vr_unitario)
							$vr_total:=Round:C94($vr_monto-$vr_montoIVA;$vl_decimales)
							DOM SET XML ATTRIBUTE:C866($vRefxml_concepto;"importe";$vr_total)
							APPEND TO ARRAY:C911($arACT_Total;$vr_total)
							APPEND TO ARRAY:C911($arACT_MontoIva;$vr_montoIVA)
							
							KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
							KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
							APPEND TO ARRAY:C911($atACT_NombreAl;[Alumnos:2]apellidos_y_nombres:40)
							
							  //20121210 RCH En un colegio el RFC es el identificador nacional 2...
							  //APPEND TO ARRAY($atACT_CURPAl;[Alumnos]RUT)
							$vt_propiedad:="XML|Identificador Nacional para R.F.C. para Cuentas"
							$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
							Case of 
								: ($vt_valor="1")
									$vt_valor:=[Alumnos:2]RUT:5
								: ($vt_valor="2")
									$vt_valor:=[Alumnos:2]IDNacional_2:71
								: ($vt_valor="3")
									$vt_valor:=[Alumnos:2]IDNacional_3:70
								: ($vt_valor="4")
									$vt_valor:=[Alumnos:2]NoPasaporte:87
								: ($vt_valor="5")
									$vt_valor:=[Alumnos:2]Codigo_interno:6
								Else 
									$vt_valor:="CONFIGURACION "+ST_Qte (ST_GetWord ($vt_propiedad;2;"|"))+" NO ESPECIFICADA"
							End case 
							APPEND TO ARRAY:C911($atACT_CURPAl;$vt_valor)
							
							APPEND TO ARRAY:C911($atACT_mes;<>atXS_MonthNames{[ACT_Cargos:173]Mes:13})
							APPEND TO ARRAY:C911($al_nivelAl;[Alumnos:2]nivel_numero:29)
							
						End for 
						
						  //$vRefxml_infoAduanera:=DOM_SetElementValueAndAttr ($vRefxml_conceptos;"cfdi:InformacionAduanera")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAduanera;"numero";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAduanera;"fecha";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAduanera;"aduana";"")
						  //
						  //$vRefxml_ctaPredial:=DOM_SetElementValueAndAttr ($vRefxml_conceptos;"cfdi:CuentaPredial")
						  //DOM SET XML ATTRIBUTE($vRefxml_ctaPredial;"numero";"")
						  //
						  //$vRefxml_compConc:=DOM_SetElementValueAndAttr ($vRefxml_conceptos;"cfdi:ComplementoConcepto")
						  //
						  //
						  //$vRefxml_parteConc:=DOM_SetElementValueAndAttr ($vRefxml_conceptos;"cfdi:Parte")
						  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"cantidad";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"unidad";"")
						  //  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"noIdentificacion";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"descripcion";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"valorUnitario";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_parteConc;"importe";"")
						  //
						  //$vRefxml_infoAdua:=DOM_SetElementValueAndAttr ($vRefxml_parteConc;"cfdi:InformacionAduanera")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAdua;"numero";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAdua;"fecha";"")
						  //DOM SET XML ATTRIBUTE($vRefxml_infoAdua;"aduana";"")
						
						
						  // Impuestos
						  //If ([ACT_Boletas]Monto_IVA>0)
						$vRefxml_impuestos:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Impuestos")
						  //DOM SET XML ATTRIBUTE($vRefxml_impuestos;"totalImpuestosRetenidos";"")
						  //$retenciones:=DOM_SetElementValueAndAttr ($vRefxml_impuestos;"cfdi:Retenciones")
						  //$retencion:=DOM_SetElementValueAndAttr ($retenciones;"cfdi:Retencion")
						  //DOM SET XML ATTRIBUTE($retencion;"impuesto";"")
						  //DOM SET XML ATTRIBUTE($retencion;"importe";"")
						
						DOM SET XML ATTRIBUTE:C866($vRefxml_impuestos;"totalImpuestosTrasladados";[ACT_Boletas:181]Monto_IVA:5)
						$vRefxml_traslados:=DOM_SetElementValueAndAttr ($vRefxml_impuestos;"cfdi:Traslados")
						$vRefxml_traslado:=DOM_SetElementValueAndAttr ($vRefxml_traslados;"cfdi:Traslado")
						DOM SET XML ATTRIBUTE:C866($vRefxml_traslado;"impuesto";"IVA")
						DOM SET XML ATTRIBUTE:C866($vRefxml_traslado;"tasa";[ACT_Boletas:181]TasaIVA:16)
						DOM SET XML ATTRIBUTE:C866($vRefxml_traslado;"importe";[ACT_Boletas:181]Monto_IVA:5)
						  //End if 
						
						  // Complemento
						  //20120525 RCH Se quita por el Williams
						  //$vRefxml_complemento:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Complemento";"";True)
						
						
						  // Addenda
						  //20120525 RCH Se quita por el Williams
						  //$vRefxml_addenda:=DOM_SetElementValueAndAttr (vRefElem;"cfdi:Addenda";"";True)
						
						  //2020920 RCH Si es vacia la lleno con la ruta del cliente
						If (vtACT_rutaCliente="")
							$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
							vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						End if 
						
						  //20120913 RCH verifico que la ruta exista porque aparecia error...
						SYS_CreatePath (vtACT_rutaCliente)
						
						  //definir ruta
						$vt_docName:=<>vsACT_RUT+"_"+String:C10($vl_idBoleta)+".xml"
						$vt_path:=vtACT_rutaCliente+$vt_docName
						DOM EXPORT TO FILE:C862(vRefElem;$vt_path)
						  //DOM EXPORT TO FILE(vRefElem;"")
						
						  //guardo ruta xml generado
						$vt_rutaXML:=document
						
						  //cierro xml
						DOM CLOSE XML:C722(vRefElem)
						  //LOG_RegisterEvt ("CFDI: XML sin sello generado")
						[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: XML sin sello generado"+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
						
						  // almacena en el server
						$vt_propiedad:="FILE|rutaAlmacenamientoArchivosServer"
						
						  //20130218 RCH Cuando el cliente y el server estan y mac y win, podia aparecer errores
						  //$vt_rutaServer:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						C_TEXT:C284($t_valor;$t_reemplazo;$t_reemplazo2)
						$t_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
						$t_reemplazo:=Substring:C12($t_valor;4)  //para evitar quitar el posible c://
						$t_reemplazo2:=Replace string:C233($t_reemplazo;Folder separator:K24:12;SYS_FolderDelimiterOnServer )
						$vt_rutaServer:=Replace string:C233($t_valor;$t_reemplazo;$t_reemplazo2)
						
						SYS_CreateFolderOnServer ($vt_rutaServer)
						If (SYS_TestPathName ($vt_rutaServer;Server)=Is a folder:K24:2)
							  //If (Test path name($vt_rutaServer)#Is a directory)
							$vt_rutaServer:=$vt_rutaServer+$vt_docName
							DOCUMENT TO BLOB:C525($vt_rutaXML;$xBlob)
							KRL_SendFileToServer ($vt_rutaServer;$xBlob;True:C214)
							
							[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
							[ACT_Boletas:181]DTE_estado_id:24:=2
							SAVE RECORD:C53([ACT_Boletas:181])
							
							Case of 
								: ((at_proveedores{at_proveedores}="Buzón Fiscal") | (at_proveedores{at_proveedores}="Levicom"))
									  //genera sello
									  //genera archivo con cadena original y devuelve la ruta del archivo generado
									  //LOG_RegisterEvt ("CFDI: Inicio generación cadena original")
									[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Inicio generación cadena original"+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
									C_TEXT:C284($vt_fuente;$vt_hojaXSL;$vt_documentName;$vt_newName;$vt_rutaCadenaOriginal)
									C_TIME:C306($ref)
									
									$vt_fuente:=$vt_rutaXML  // CFDi_SinTimbrar.xml
									
									$vt_propiedad:="FILE|rutaXSLT"
									$vt_hojaXSL:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									  //$vt_hojaXSL:=xfGetFileName   //cadenaoriginal_3_0.xslt
									
									If (Test path name:C476($vt_hojaXSL)=Is a document:K24:1)
										$vt_parentPath:=SYS_GetParentNme ($vt_hojaXSL)
										  //$vt_documentName:=SYS_Path2FileName ($vt_rutaXML)
										  //COPY DOCUMENT($vt_fuente;$vt_parentPath+$vt_documentName;*)
										
										$vt_documentName:=SYS_Path2FileName ($vt_hojaXSL)
										$vt_documentName:=Substring:C12($vt_documentName;1;Length:C16($vt_documentName)-5)+"_"+DTS_MakeFromDateTime +".txt"
										$vt_newName:=$vt_parentPath+$vt_documentName
										EM_ErrorManager ("Install")
										EM_ErrorManager ("SetMode";"")
										$ref:=Create document:C266($vt_newName;"TEXT")
										CLOSE DOCUMENT:C267($ref)
										If (ok=1)
											_O_XSLT APPLY TRANSFORMATION:C882($vt_fuente;$vt_hojaXSL;document)
										End if 
										EM_ErrorManager ("Clear")
										
										If (ok=1)
											  //LOG_RegisterEvt ("CFDI: Cadena original generada.")
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Cadena original generada."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
											$vt_rutaCadenaOriginal:=document
										Else 
											  //LOG_RegisterEvt ("CFDI: Error al generar la cadena original.")
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error al generar la cadena original."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
											$vt_rutaCadenaOriginal:=""
										End if 
										  //ACTcd_DlogWithShowOnDisk (document;0;"Listo archivo con cadena original.")
										
										  // ejecuta en php firma del documento, pasando las rutas a los archivos necesarios
										If ($vt_rutaCadenaOriginal#"")
											  //LOG_RegisterEvt ("CFDI: Generación de sello iniciada")
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Generación de sello iniciada"+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
											
											C_TEXT:C284($vt_scriptFullPath;$vt_scriptFunction;T_result)
											
											$vt_propiedad:="FILE|rutaCodigoPHP"
											vt_scriptFullPath:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
											  //vt_scriptFullPath:=xfGetFileName   // ruta al archivo php con el codigo para firmar
											
											If (Test path name:C476(vt_scriptFullPath)=Is a document:K24:1)
												
												$vt_scriptFunction:="FirmaCFDI"
												T_result:=""
												  // llamo a funcion php que firma el documento pasando los path de la cadena original, la llave publica y la llave privada del certificado
												If (ok=1)
													$B_executionWasOK:=PHP Execute:C1058(vt_scriptFullPath;$vt_scriptFunction;T_result;$vt_rutaCadenaOriginal;vtACT_llavePubCertificado;vtACT_llavePrivCertificado)
												End if 
												
												If ($B_executionWasOK)
													If (T_result#"ERROR FIRMA@")
														  //LOG_RegisterEvt ("CFDI: Generación de sello ejecutada.")
														[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Generación de sello ejecutada."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
														  // el xml es abierto para asignar al elemento sello el valor obtenido por el llamado a php
														$refxml:=DOM Parse XML source:C719($vt_rutaXML)
														If (ok=1)
															DOM SET XML ATTRIBUTE:C866($refxml;"sello";ACTxml_GetValidText (T_result))
															DOM EXPORT TO FILE:C862($refxml;$vt_rutaXML)
															DOM CLOSE XML:C722($refxml)
															  //ACTcd_DlogWithShowOnDisk ($vt_rutaXML;0;"Listo con sello.")
															
															  // almacena en el server
															SYS_CreateFolderOnServer (SYS_GetParentNme ($vt_rutaServer))
															DOCUMENT TO BLOB:C525($vt_rutaXML;$xBlob)
															KRL_SendFileToServer ($vt_rutaServer;$xBlob;True:C214)
															
															[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
															
															  //LOG_RegisterEvt ("CFDI: XML con sello generado.")
															[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: XML con sello generado."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
															
														Else 
															  //borro xml
															DELETE DOCUMENT:C159($vt_rutaXML)
															
															  //LOG_RegisterEvt ("CFDI: Error al insertar sello a XML.")
															[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error al insertar sello a XML."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
														End if 
													Else 
														  //borro xml
														DELETE DOCUMENT:C159($vt_rutaXML)
														
														  //LOG_RegisterEvt ("CFDI: Sello inválido generado")
														[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Sello inválido generado"+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
														  //CD_Dlog (0;"Se produjo un error al validar la firma. "+T_result)
													End if 
												Else 
													  //borro xml
													DELETE DOCUMENT:C159($vt_rutaXML)
													
													C_TEXT:C284(T_echoBuffer)
													ARRAY TEXT:C222(header4DPHPErrorLabels;0)
													ARRAY TEXT:C222(header4DPHPErrorValues;0)
													ARRAY TEXT:C222(headerHTTPLabels;0)
													ARRAY TEXT:C222(headerHTTPValues;0)
													PHP GET FULL RESPONSE:C1061(T_echoBuffer;header4DPHPErrorLabels;header4DPHPErrorValues;headerHTTPLabels;headerHTTPValues)
													T_echoBuffer:=T_echoBuffer
													header4DPHPErrorLabels:=header4DPHPErrorLabels
													header4DPHPErrorValues:=header4DPHPErrorValues
													headerHTTPLabels:=headerHTTPLabels
													headerHTTPValues:=headerHTTPValues
													  //LOG_RegisterEvt ("CFDI: Error al generar sello de documento.")
													[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error al generar sello de documento. Proveedor "+at_proveedores{at_proveedores}+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
													  //CD_Dlog (0;"Se produjo un error al ejecutar el código para firmar el documento.")
												End if 
											End if 
										Else 
											  //borro xml
											DELETE DOCUMENT:C159($vt_rutaXML)
											
											vtACT_ErrorString:=__ ("Error archivo PHP no encontrado.")
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: "+vtACT_ErrorString+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
										End if 
										
										  // elimina cadena original
										DELETE DOCUMENT:C159($vt_parentPath+$vt_documentName)
										
									Else 
										  //borro xml
										DELETE DOCUMENT:C159($vt_rutaXML)
										
										vtACT_ErrorString:=__ ("Error archivo XSLT no encontrado.")
										[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: "+vtACT_ErrorString+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
									End if 
									
								: (at_proveedores{at_proveedores}="ClickBalance")  // MAGUEN DAVID
									C_TEXT:C284($vt_cadena;$vt_valor)
									$vt_refxml:=DOM Parse XML source:C719($vt_rutaXML)
									If (ok=1)
										
										  //obtengo tasa impuesto y monto iva
										$vt_tasa:="0"
										$vt_impuesto:=""
										$vt_montoIVA:="0"
										$refElement:=DOM Find XML element:C864($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados")
										If ($refElement#"0000000000000000")
											For ($i;1;DOM Count XML elements:C726($refElement;"cfdi:Traslado"))
												$vt_impuesto:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado["+String:C10($i)+"]";"impuesto")
												If ($vt_impuesto="IVA")
													$vt_tasa:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado["+String:C10($i)+"]";"tasa")
													$vt_montoIVA:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Impuestos/cfdi:Traslados/cfdi:Traslado["+String:C10($i)+"]";"importe")
												End if 
											End for 
										Else 
											$vt_impuesto:=""
											$vt_tasa:="0"
											$vt_montoIVA:="0"
										End if 
										
										$vt_propiedad:="XML|plaza"
										$vt_propiedad:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
										  //$vt_cadena:="1"+<>crlf  
										$vt_cadena:=$vt_propiedad+"\r\n"
										$vt_propiedad:="XML|Tipo documento "+String:C10([ACT_Boletas:181]ID_Categoria:12)
										$vt_propiedad:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
										  //$vt_cadena:=$vt_cadena+"32726"+<>crlf
										$vt_cadena:=$vt_cadena+$vt_propiedad+"\r\n"
										
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"rfc")+"\r\n"
										
										  //20120807 RCH Ticket 112557
										$vt_cadena:=$vt_cadena+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]eMail:34;[ACT_Terceros:138]EMail:13)+"\r\n"
										
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"nombre")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"calle")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"noExterior")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"noInterior")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"colonia")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"codigoPostal")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"localidad")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"municipio")+"\r\n"
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"estado")+"\r\n"
										  //pais
										$vt_cadena:=$vt_cadena+"261"+"\r\n"
										
										  //$vr_subtotal:=Num(DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"subTotal"))
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"subTotal")+"\r\n"
										
										  //$vr_descuento:=Num(DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"descuento"))
										$vt_descuento:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"descuento")
										$vt_cadena:=$vt_cadena+ST_Boolean2Str ($vt_descuento="";"0";$vt_descuento)+"\r\n"
										
										  //ieps
										$vt_cadena:=$vt_cadena+"0"+"\r\n"
										
										  //iva
										$vt_cadena:=$vt_cadena+$vt_montoIVA+"\r\n"
										
										  //isr retenido
										$vt_cadena:=$vt_cadena+"0"+"\r\n"
										
										  //iva retenido
										$vt_cadena:=$vt_cadena+"0"+"\r\n"
										
										  //monto total
										  //$vr_total:=Num(DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"total"))
										  //$vt_cadena:=$vt_cadena+String($vr_total-$vr_subtotal-$vr_descuento)+<>crlf
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"total")+"\r\n"
										
										  //moneda
										$vt_moneda:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"Moneda")
										$vt_cadena:=$vt_cadena+ST_Boolean2Str ($vt_moneda#"";$vt_moneda;"1")+"\r\n"
										
										  //tipo cambio
										$vt_tipoCambio:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"TipoCambio")
										$vt_cadena:=$vt_cadena+ST_Boolean2Str ($vt_tipoCambio#"";$vt_tipoCambio;"1")+"\r\n"
										
										  //forma de pago
										$vt_cadena:=$vt_cadena+[ACT_Pagos:172]FormaDePago:7+"\r\n"
										
										  //forma de pagoc
										C_TEXT:C284($vt_banco)
										$vt_banco:=""
										Case of 
												  //: ([ACT_Documentos_de_Pago]Tipodocumento="Tarjeta de Crédito")
											: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-6)
												  //20110120 RCH Se solictan los ultimos 4 caracteres de la tarjeta. Ticket 107445.
												  //$vt_cadena:=$vt_cadena+ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago]TC_Numero)+<>crlf
												$vt_numTc:=ACTpp_CRYPTTC ("xxACT_GetDecryptTCWithFormat";->[ACT_Documentos_de_Pago:176]TC_Numero:17)
												  //$vt_cadena:=$vt_cadena+Substring($vt_numTc;(Length($vt_numTc)-4)+1;4)+<>crlf
												$vt_banco:=[ACT_Documentos_de_Pago:176]TC_BancoEmisor:23
												
												  //20120907 RCH Se agregan cheques y TD
											: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4) & ([ACT_Documentos_de_Pago:176]Ch_Cuenta:11#""))  //cheque
												  //$vt_cadena:=$vt_cadena+Substring([ACT_Documentos_de_Pago]Ch_Cuenta;Length([ACT_Documentos_de_Pago]Ch_Cuenta)-4;4)+<>crlf
												$vt_banco:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
												
											: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-7) & ([ACT_Documentos_de_Pago:176]R_NoDocumento:33#""))  //td
												  //$vt_cadena:=$vt_cadena+[ACT_Documentos_de_Pago]R_NoDocumento+<>crlf
												If ([ACT_Pagos:172]Lugar_de_Pago:18#"")
													$vt_banco:=[ACT_Pagos:172]Lugar_de_Pago:18
												End if 
												
											: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-9) | ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-10) | ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-11))  //PAT, PAC, Cuponera
												If ([ACT_Pagos:172]Lugar_de_Pago:18#"")
													$vt_banco:=[ACT_Pagos:172]Lugar_de_Pago:18
												End if 
												  //$vt_cadena:=$vt_cadena+"No identificado"+<>crlf
												
											Else 
												  //20120124 RCH Según mail de Olivia
												  //$vt_cadena:=$vt_cadena+[ACT_Documentos_de_Pago]NoSerie+<>crlf
												  //20120907 RCH Se quita forma de pago porque cuando era efectivo aparecia Efectivo 2 veces en el archivo
												  //$vt_cadena:=$vt_cadena+"No identificado"+<>crlf
												  //$vt_cadena:=$vt_cadena+[ACT_Documentos_de_Pago]forma_de_pago_new+<>crlf
												
										End case 
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"formaDePago")+"\r\n"
										
										  //20120920 RCH SE comenta por tema del Cedros...
										  //codigo familia
										  //$vt_cadena:=$vt_cadena+$vt_codFamilia+<>crlf
										
										  //20120920 RCH Se deja configurable porque no se sabe que es...
										  //aut_rvoe
										$vt_propiedad:="XML|aut_rvoe"
										$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
										$vt_cadena:=$vt_cadena+$vt_valor+"\r\n"
										
										  //20120920 10 CAMPOS ADICIONALES
										  //1: cod familia. Viene de formato anterior
										  //2: banco. Banco cuando se paga con cheque; Lugar de pago cuando es PAT, PAC o CUP
										  //3: codigo interno ST
										  //4: codigo interno ACT
										  //5: Lugar de pago
										  //6: Numero de matricula
										ARRAY TEXT:C222($atACT_codIntACT;0)
										ARRAY TEXT:C222($atACT_codIntST;0)
										ARRAY TEXT:C222($atACT_lugarPago;0)
										ARRAY TEXT:C222($atACT_numeroMatricula;0)
										ARRAY TEXT:C222($atACT_apellidosYNombres;0)
										ARRAY TEXT:C222($atACT_idNacional;0)
										ARRAY LONGINT:C221($alACT_idNivel;0)
										ARRAY LONGINT:C221($alACT_meses;0)
										ARRAY TEXT:C222($atACT_meses;0)
										ARRAY LONGINT:C221($alACT_idsAl;0)
										CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_recNumCargo;"")
										KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
										KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
										DISTINCT VALUES:C339([ACT_CuentasCorrientes:175]Codigo:19;$atACT_codIntACT)
										DISTINCT VALUES:C339([Alumnos:2]Codigo_interno:6;$atACT_codIntST)
										DISTINCT VALUES:C339([Alumnos:2]numero_de_matricula:51;$atACT_numeroMatricula)
										DISTINCT VALUES:C339([Alumnos:2]apellidos_y_nombres:40;$atACT_apellidosYNombres)
										DISTINCT VALUES:C339([Alumnos:2]numero:1;$alACT_idsAl)
										$vt_propiedad:="XML|Identificador Nacional para R.F.C. para Cuentas"
										$vt_valor:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
										Case of 
											: ($vt_valor="1")
												vQR_Pointer1:=->[Alumnos:2]RUT:5
											: ($vt_valor="2")
												vQR_Pointer1:=->[Alumnos:2]IDNacional_2:71
											: ($vt_valor="3")
												vQR_Pointer1:=->[Alumnos:2]IDNacional_3:70
											: ($vt_valor="4")
												vQR_Pointer1:=->[Alumnos:2]NoPasaporte:87
											: ($vt_valor="5")
												vQR_Pointer1:=->[Alumnos:2]Codigo_interno:6
											Else 
												vQR_Pointer1:=->[Alumnos:2]RUT:5
										End case 
										DISTINCT VALUES:C339(vQR_Pointer1->;$atACT_idNacional)
										
										DISTINCT VALUES:C339([Alumnos:2]nivel_numero:29;$alACT_idNivel)
										DISTINCT VALUES:C339([ACT_Cargos:173]Mes:13;$alACT_meses)
										For ($r;1;Size of array:C274($alACT_meses))
											APPEND TO ARRAY:C911($atACT_meses;<>atXS_MonthNames{$alACT_meses{$r}})
										End for 
										
										USE SET:C118("setTransaccionesBoleta")
										KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
										  //KRL_RelateSelection (->[ACT_Documentos_de_Pago]ID;->[ACT_Pagos]ID_DocumentodePago;"")
										DISTINCT VALUES:C339([ACT_Pagos:172]Lugar_de_Pago:18;$atACT_lugarPago)
										
										  //20130314 RCH ticket 118454. Si esta pagando reinscripcion mostrar el nivel superior del alumno
										  //debe estar configurada la categoria reinscripcion
										$l_noNivel:=0
										$b_nivelSuperior:=False:C215
										If (Size of array:C274($alACT_idNivel)>0)
											$l_noNivel:=$alACT_idNivel{1}
											
											  //20130820 RCH Si se tenemos un nivel retirado o egresado, tomamos el ultimo nivel activo
											If ($l_noNivel<Nivel_Egresados)
												
												If ((Find in array:C230($alACT_idNivel;-1)#-1) | (Find in array:C230($alACT_idNivel;6)#-1))
													If (Size of array:C274($alACTcfg_IdItemReinsc)>0)
														ARRAY LONGINT:C221($alACT_refsItems;0)
														ARRAY LONGINT:C221($alACT_DAReturn;0)
														DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_refsItems)
														AT_intersect (->$alACT_refsItems;->$alACTcfg_IdItemReinsc;->$alACT_DAReturn)
														If (Size of array:C274($alACT_DAReturn)>0)
															$l_noNivel:=$l_noNivel+1
															If ($l_noNivel=0)
																$l_noNivel:=$l_noNivel+1
															End if 
															$b_nivelSuperior:=True:C214
														End if 
													End if 
												End if 
												
											Else 
												If (Size of array:C274($alACT_idsAl)>0)
													READ ONLY:C145([Alumnos_SintesisAnual:210])
													
													QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=Abs:C99($alACT_idsAl{1});*)
													QUERY:C277([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]ID_Alumno:4=Abs:C99($alACT_idsAl{1})*-1)
													ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<)
													
													If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
														If ([Alumnos_SintesisAnual:210]NumeroNivel:6<Nivel_Egresados)
															$l_noNivel:=[Alumnos_SintesisAnual:210]NumeroNivel:6
														End if 
													End if 
												End if 
											End if 
											
										End if 
										
										  //campos adicionales
										  //20121206 RCH
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"metodoDePago")+"\r\n"  //1 forma de pago
										$vt_cadena:=$vt_cadena+DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"NumCtaPago")+"\r\n"  //2: cuenta de pago
										$vt_cadena:=$vt_cadena+$vt_banco+"\r\n"  //3: banco
										$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_apellidosYNombres;", ")+"\r\n"  //4: alumno
										$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_idNacional;", ")+"\r\n"  //5: CURP
										$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_numeroMatricula;", ")+"\r\n"  //6: Matricula Alumno
										If (Size of array:C274($alACT_idNivel)>0)
											  //$vt_cadena:=$vt_cadena+KRL_GetTextFieldData (->[xxSTR_Niveles]NoNivel;->$alACT_idNivel{1};->[xxSTR_Niveles]Nivel)+<>crlf  //7: Grado
											$vt_cadena:=$vt_cadena+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_noNivel;->[xxSTR_Niveles:6]Nivel:1)+"\r\n"  //7: Grado
										Else 
											$vt_cadena:=$vt_cadena+"\r\n"
										End if 
										$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_meses;", ")+"\r\n"  //8: Periodo pago
										  //20130104 RCH
										  //$vt_cadena:=$vt_cadena+(<>crlf*2)  //los demas...
										  //20131118 ASM Ticket 126673
										FIRST RECORD:C50([ACT_Pagos:172])
										If (ST_GetCleanString ([ACT_Pagos:172]Observaciones:13)="@Importado desde archivo@")
											$t_Observaciones:=""
										Else 
											$t_Observaciones:=[ACT_Pagos:172]Observaciones:13
										End if 
										  //$vt_cadena:=$vt_cadena+ST_GetCleanString ([ACT_Pagos]Observaciones)+<>crlf  //9: observacion pago
										$vt_cadena:=$vt_cadena+ST_GetCleanString ($t_Observaciones)+"\r\n"  //9: observacion pago
										$vt_cadena:=$vt_cadena+("\r\n"*1)  //los demas...
										
										  //$vt_cadena:=$vt_cadena+$vt_codFamilia+<>crlf  //1
										  //$vt_cadena:=$vt_cadena+$vt_banco+<>crlf  //2: banco para pagos con cheque
										  //$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_codIntST;", ")+<>crlf  //3: Codigo interno ST
										  //$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_codIntACT;", ")+<>crlf  //4: Codigo interno Cta Cte
										  //$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_lugarPago;", ")+<>crlf  //5: Lugar de Pago
										  //$vt_cadena:=$vt_cadena+AT_array2text (->$atACT_numeroMatricula;", ")+<>crlf  //6: Numero de matricula
										  //$vt_cadena:=$vt_cadena+(<>crlf*4)  //los demas...
										  //20120920 10 CAMPOS ADICIONALES
										
										  //detalle
										  //verificar porque asumimos que todos los cargos tienen la misma tasa de iva y puede ser que algunos cargos sean exentos dentro del documento...
										$vt_sep:="|"
										$refElement:=DOM Find XML element:C864($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos")
										
										  //20130125 RCH Para agrupar por categorias
										  //For ($i;1;DOM Count XML elements($refElement;"cfdi:Concepto"))
										If (cbUsarCategorias=1)
											ARRAY TEXT:C222($at_referencia;0)
											ARRAY LONGINT:C221($alACT_idsCategorias;0)
											ARRAY REAL:C219($arACT_Cantidad2;0)
											ARRAY TEXT:C222($atACT_Desc2;0)
											ARRAY REAL:C219($arACT_ValorUnitario2;0)
											ARRAY REAL:C219($arACT_MontoIva2;0)
											ARRAY TEXT:C222($atACT_NombreAl2;0)
											ARRAY TEXT:C222($atACT_CURPAl2;0)
											ARRAY TEXT:C222($atACT_mes2;0)
											ARRAY LONGINT:C221($al_nivelAl2;0)
											C_TEXT:C284($vt_referencia;$vt_cat)
											  //For ($i;1;DOM Count XML elements($refElement;"cfdi:Concepto"))
											For ($i;1;Size of array:C274($arACT_Cantidad))
												$vl_idCargo:=$alACT_idCargo{$i}
												$vl_refItem:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargo;->[ACT_Cargos:173]Ref_Item:16)
												$vl_idCategoria:=KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->$vl_refItem;->[xxACT_Items:179]ID_Categoria:8)
												$vt_referencia:=String:C10($vl_idCategoria)+$atACT_NombreAl{$i}+String:C10($arACT_MontoIva{$i})+$atACT_mes{$i}
												$vl_pos:=Find in array:C230($at_referencia;$vt_referencia)
												If ($vl_pos=-1)
													APPEND TO ARRAY:C911($at_referencia;$vt_referencia)
													APPEND TO ARRAY:C911($arACT_Cantidad2;$arACT_Cantidad{$i})
													$vt_cat:=KRL_GetTextFieldData (->[xxACT_ItemsCategorias:98]ID:2;->$vl_idCategoria;->[xxACT_ItemsCategorias:98]Nombre:1)
													APPEND TO ARRAY:C911($atACT_Desc2;Choose:C955($vt_cat#"";$vt_cat;$atACT_Desc{$i}))
													APPEND TO ARRAY:C911($arACT_ValorUnitario2;$arACT_ValorUnitario{$i})
													APPEND TO ARRAY:C911($arACT_MontoIva2;$arACT_MontoIva{$i})
													APPEND TO ARRAY:C911($atACT_NombreAl2;$atACT_NombreAl{$i})
													APPEND TO ARRAY:C911($atACT_CURPAl2;$atACT_CURPAl{$i})
													APPEND TO ARRAY:C911($atACT_mes2;$atACT_mes{$i})
													APPEND TO ARRAY:C911($al_nivelAl2;$al_nivelAl{$i})
												Else 
													$arACT_ValorUnitario2{$vl_pos}:=$arACT_ValorUnitario2{$vl_pos}+$arACT_ValorUnitario{$i}
													$arACT_MontoIva2{$vl_pos}:=$arACT_MontoIva2{$vl_pos}+$arACT_MontoIva{$i}
												End if 
											End for 
											COPY ARRAY:C226($arACT_Cantidad2;$arACT_Cantidad)
											COPY ARRAY:C226($atACT_Desc2;$atACT_Desc)
											COPY ARRAY:C226($arACT_ValorUnitario2;$arACT_ValorUnitario)
											COPY ARRAY:C226($arACT_MontoIva2;$arACT_MontoIva)
											COPY ARRAY:C226($atACT_NombreAl2;$atACT_NombreAl)
											COPY ARRAY:C226($atACT_CURPAl2;$atACT_CURPAl)
											COPY ARRAY:C226($atACT_mes2;$atACT_mes)
											COPY ARRAY:C226($al_nivelAl2;$al_nivelAl)
										End if 
										
										For ($i;1;Size of array:C274($arACT_Cantidad))
											
											  //$vt_cantidad:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto["+String($i)+"]";"cantidad")
											  //$vt_desc:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto["+String($i)+"]";"descripcion")
											  //$vt_valUnitario:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos/cfdi:Concepto["+String($i)+"]";"valorUnitario")
											
											$vt_cantidad:=String:C10($arACT_Cantidad{$i})
											$vt_desc:=$atACT_Desc{$i}
											$vt_valUnitario:=String:C10($arACT_ValorUnitario{$i})
											
											$vt_valUnitario:=Replace string:C233(String:C10($arACT_ValorUnitario{$i});<>tXS_RS_DecimalSeparator;".")
											
											$vt_tasa2:=ST_Boolean2Str ($arACT_MontoIva{$i}>0;$vt_tasa;"0")
											
											$vt_nombre:=$atACT_NombreAl{$i}
											$vt_rut:=$atACT_CURPAl{$i}
											$vt_mes:=$atACT_mes{$i}
											$vl_nivelNum:=$al_nivelAl{$i}
											
											  //20130314 RCH
											If ($b_nivelSuperior)
												$vl_nivelNum:=$vl_nivelNum+1
												If ($vl_nivelNum=0)
													$vl_nivelNum:=$vl_nivelNum+1
												End if 
											Else 
												If ($l_noNivel#0)
													$vl_nivelNum:=$l_noNivel
												End if 
											End if 
											
											  //$vt_cadena:=$vt_cadena+"CTODET"+$vt_sep+$vt_cantidad+$vt_sep+$vt_desc+$vt_sep+$vt_valUnitario+$vt_sep+"0"+$vt_sep+"0"+$vt_sep+$vt_tasa2+<>crlf
											$vt_cadena:=$vt_cadena+"CTODET"+$vt_sep
											$vt_cadena:=$vt_cadena+$vt_cantidad+$vt_sep
											
											  //$vt_cadena:=$vt_cadena+$vt_desc+"-"
											  //$vt_cadena:=$vt_cadena+$vt_nombre+"-"
											  //$vt_cadena:=$vt_cadena+$vt_rut+"-"
											  //$vt_cadena:=$vt_cadena+$vt_mes+$vt_sep
											  //$vt_cadena:=$vt_cadena+$vt_valUnitario+$vt_sep
											  //$vt_cadena:=$vt_cadena+"0"+$vt_sep
											  //$vt_cadena:=$vt_cadena+"0"+$vt_sep
											  //$vt_cadena:=$vt_cadena+$vt_tasa2+<>crlf
											
											  //20120920 RCH
											$vt_cadena:=$vt_cadena+$vt_desc+"-"
											$vt_cadena:=$vt_cadena+$vt_mes+$vt_sep
											$vt_cadena:=$vt_cadena+$vt_valUnitario+$vt_sep
											$vt_cadena:=$vt_cadena+"0"+$vt_sep
											$vt_cadena:=$vt_cadena+"0"+$vt_sep
											$vt_cadena:=$vt_cadena+$vt_tasa2+$vt_sep
											$vt_cadena:=$vt_cadena+$vt_nombre+", "
											$vt_cadena:=$vt_cadena+$vt_rut+", "
											$vt_cadena:=$vt_cadena+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$vl_nivelNum;->[xxSTR_Niveles:6]Sección:9)
											$vt_cadena:=$vt_cadena+"\r\n"
											
										End for 
										DOM CLOSE XML:C722($vt_refxml)
										
										USE CHARACTER SET:C205("UTF-8";0)
										C_BLOB:C604($xBlob)
										
										$vt_newName:=Substring:C12($vt_rutaXML;1;Length:C16($vt_rutaXML)-4)+".txt"
										
										[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
										[ACT_Boletas:181]DTE_estado_id:24:=2
										SAVE RECORD:C53([ACT_Boletas:181])
										
										$refDoc:=Create document:C266($vt_newName;"TEXT")
										If (OK=1)  // Si un documento ha sido creado
											IO_SendPacket ($refDoc;$vt_cadena)
											CLOSE DOCUMENT:C267($refDoc)  // No necesitamos mantenerlo abierto
											  //ACTcd_DlogWithShowOnDisk (document;0;"Listo")
											
											  // almacena en el server
											$vt_rutaServer:=Substring:C12($vt_rutaServer;1;Length:C16($vt_rutaServer)-4)+".txt"
											SYS_CreateFolderOnServer (SYS_GetParentNme ($vt_rutaServer))
											DOCUMENT TO BLOB:C525($vt_newName;$xBlob)
											KRL_SendFileToServer ($vt_rutaServer;$xBlob;True:C214)
											
											[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
											[ACT_Boletas:181]DTE_estado_id:24:=2
											SAVE RECORD:C53([ACT_Boletas:181])
											
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Archivo de texto generado. Proveedor "+at_proveedores{at_proveedores}+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
											
											  //borro xml en el cliente (esta en el server)
											DELETE DOCUMENT:C159($vt_rutaXML)
											
										End if 
										USE CHARACTER SET:C205(*;0)
										
									End if 
									
									
								: (at_proveedores{at_proveedores}="Sae")  // sae. YAOCALLI Por ahora no se usa. Se integra para no perder el codigo.
									C_TEXT:C284($vt_cadena;$vt_valor)
									$vt_refxml:=DOM Parse XML source:C719($vt_rutaXML)
									If (ok=1)
										
										  //$vt_cadena:=$vt_cadena+"OBSPAR=."+<>crlf
										ARRAY TEXT:C222(<>atXS_MonthNames;0)
										ARRAY LONGINT:C221($alACT_recNumCargo;0)
										C_BLOB:C604($xBlob)
										C_TEXT:C284($vt_RefNewXML;$vt_refDTField;$vt_refDTFieldRow;$vt_categoria;$rootRef;$vt_ref;$vt_RefRowData;$vt_refNodo;$vt_msj)
										C_REAL:C285($vr_totalItem)
										
										READ ONLY:C145([Personas:7])
										READ ONLY:C145([ACT_Terceros:138])
										READ ONLY:C145([ACT_CuentasCorrientes:175])
										READ ONLY:C145([Alumnos:2])
										READ ONLY:C145([xxACT_Items:179])
										READ ONLY:C145([xxACT_ItemsCategorias:98])
										READ ONLY:C145([ACT_Transacciones:178])
										
										$xBlob:=PREF_fGetBlob (0;"ACT_CFDI_XMLBASE";$xBlob)
										If (BLOB size:C605($xBlob)>0)
											QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$vl_idBoleta)
											KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
											SELECTION TO ARRAY:C260([ACT_Cargos:173];$alACT_recNumCargo)
											
											KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
											KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)
											ACTbol_BuscaCargosCargaSet ("Transacciones";$vl_idBoleta)
											
											$vt_RefNewXML:=DOM Create XML Ref:C861("ROW")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"RowState";"4")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"CVE_CLPV";ST_RigthChars ((" "*10)+String:C10(Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]No:1;[ACT_Terceros:138]Id:1));10))
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"NUM_ALMA";"1")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"CVE_PEDI";"")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"ESQUEMA";"9")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"DES_TOT";"0")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"DES_FIN";"0")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"CVE_VEND";"")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"COM_TOT";"0")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"NUM_MONED";"1")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"TIPCAMB";"1")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"STR_OBS";[ACT_Boletas:181]Observacion:18)
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"MODULO";"FACT")
											DOM SET XML ATTRIBUTE:C866($vt_RefNewXML;"CONDICION";"")
											
											$vt_refDTField:=DOM_SetElementValueAndAttr ($vt_RefNewXML;"dtfield")
											For ($i;1;Size of array:C274($alACT_recNumCargo))
												$vt_refDTFieldRow:=DOM_SetElementValueAndAttr ($vt_refDTField;"ROWdtfield")
												
												GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargo{$i})
												KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16)
												KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8)
												
												KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
												KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
												
												USE SET:C118("Transacciones")
												QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
												QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
												QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=[ACT_Transacciones:178]ID_Pago:4)
												
												If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
													$vt_categoria:=[xxACT_ItemsCategorias:98]Nombre:1
													Case of 
														: ($vt_categoria="Inscripciones")
															$vt_categoria:="01"
														: ($vt_categoria="Colegiatura")
															$vt_categoria:="02"
														Else 
															$vt_categoria:="03"
													End case 
												Else 
													$vt_categoria:="03"
												End if 
												$vr_totalItem:=ACTbol_GetMontoLinea ("transacciones")
												
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"RowState";"4")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"CANT";"1")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"CVE_ART";$vt_categoria)
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"DESC1";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"DESC2";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"DESC3";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMPU1";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMPU2";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMPU3";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMPU4";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"COMI";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"PREC";$vr_totalItem)
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"NUM_ALM";"1")
												
												$vt_msj:=ST_Uppercase (<>atXS_MonthNames{[ACT_Cargos:173]Mes:13})+" "+String:C10([ACT_Cargos:173]Año:14)+" "
												$vt_msj:=$vt_msj+ST_Uppercase (KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Sección:9))+" "
												$vt_msj:=$vt_msj+"FORMA DE PAGO: "+ST_ReplaceAccentedChars (ST_Uppercase ([ACT_Pagos:172]FormaDePago:7))+" "
												$vt_msj:=$vt_msj+"NOMBRE ALUMNO(A): "+ST_ReplaceAccentedChars (ST_Uppercase ([Alumnos:2]apellidos_y_nombres:40))
												$vt_msj:=Substring:C12($vt_msj;1;255)
												
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"STR_OBS";$vt_msj)
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"REG_GPOPROD";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"COSTO";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"TIPO_PROD";"S")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"TIPO_ELEM";"N")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"TIP_CAM";"1")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMP1APLA";"4")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMP2APLA";"4")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMP3APLA";"4")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"IMP4APLA";"4")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"PREC_SINREDO";$vr_totalItem)
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"COST_SINREDO";"0")
												DOM SET XML ATTRIBUTE:C866($vt_refDTFieldRow;"LINK_FIELD";"1")
											End for 
											SET_ClearSets ("transacciones")
											
											$rootRef:=DOM Parse XML variable:C720($xBlob)
											$vt_ref:="/DATAPACKET/ROWDATA/"
											$vt_RefRowData:=DOM Find XML element:C864($rootRef;$vt_ref)
											$vt_refNodo:=DOM Append XML element:C1082($vt_RefRowData;$vt_RefNewXML)
											
											USE CHARACTER SET:C205("UTF-8";0)
											
											  //***** genera archivo de texto *****
											DOM CLOSE XML:C722($vt_RefNewXML)
											C_TIME:C306($ref)
											DOM EXPORT TO VAR:C863($rootRef;$vt_cadena)
											DOM CLOSE XML:C722($rootRef)
											DOM CLOSE XML:C722($vt_refxml)
											  //***** genera archivo de texto *****
											
											C_BLOB:C604($xBlob)
											$vt_docName:=String:C10([ACT_Boletas:181]ID_RazonSocial:25)+"_"+String:C10($vl_idBoleta)+".mod"
											  //$vt_newName:=$vt_rutaServerProp+$vt_docName
											  //20120831 RCH
											$vt_newName:=Substring:C12($vt_rutaServer;1;Length:C16($vt_rutaServer)-4)+".mod"
											
											$refDoc:=Create document:C266($vt_newName;"TEXT")
											If (OK=1)  // Si un documento ha sido creado
												IO_SendPacket ($refDoc;$vt_cadena)
												CLOSE DOCUMENT:C267($refDoc)  // No necesitamos mantenerlo abierto
												  //ACTcd_DlogWithShowOnDisk (document;0;"Listo")
												
												  // almacena en el server
												  //$vt_rutaServer:=Substring($vt_rutaServer;1;Length($vt_rutaServer)-4)+".mod"
												$vt_rutaServer:=$vt_newName
												SYS_CreateFolderOnServer (SYS_GetParentNme ($vt_rutaServer))
												DOCUMENT TO BLOB:C525($vt_newName;$xBlob)
												KRL_SendFileToServer ($vt_rutaServer;$xBlob;True:C214)
												
												[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
												[ACT_Boletas:181]DTE_estado_id:24:=2
												SAVE RECORD:C53([ACT_Boletas:181])
												
												[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Archivo de texto generado. Proveedor "+at_proveedores{at_proveedores}+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
												
												  //borro xml en el cliente (esta en el server)
												DELETE DOCUMENT:C159($vt_rutaXML)
												
											End if 
										Else 
											[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error. No fue encontrado el archivo XML base. Proveedor "+at_proveedores{at_proveedores}+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
										End if 
										USE CHARACTER SET:C205(*;0)
									End if 
									
								: (at_proveedores{at_proveedores}="BuzonE")  // Escuela Mexicana Americana EMA
									ACTbolcfdi_EscuelaMexicanaA 
									
								: (at_proveedores{at_proveedores}="Levicom txt")  // Escuela Mexicana Americana EMA
									
									  //20121126 Williams
									
									$vt_refxml:=DOM Parse XML source:C719($vt_rutaXML)
									
									C_TEXT:C284($vt_propiedad)
									C_TEXT:C284($vt_id;$vt_Serie;$vt_Folio;$vt_Fecha_CFD;$vt_Forma_de_Pago;$vt_Condiciones_de_Pago;$vt_Funcion;$vt_Tipo_Docto;$vt_pct_Desc_1;$vt_Motivo_Desc_1;$vt_Monto_Desc_1;$vt_No_Interno;$vt_No_Proveedor;$vt_Metodo_de_Pago;$vt_Moneda;$vt_Tipo_de_Cambio;$vt_Observaciones_1;$vt_Observaciones_2;$vt_Importe_Con_Letra;$vt_Tipo_Impresion;$vt_Tipo_Envio;$vt_Etiqueta_1_Fecha_de_Pago;$vt_Lugar_de_Expedicion;$vt_Numero_de_Cuenta)
									$vt_id:="H1"
									$vt_Serie:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"serie")
									$vt_Folio:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"folio")
									$vt_Fecha_CFD:=Replace string:C233(Substring:C12(DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"fecha");1;10);"-";"")
									$vt_Forma_de_Pago:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"formaDePago")
									$vt_Condiciones_de_Pago:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"condicionesDePago")
									$vt_Funcion:=""
									$vt_propiedad:="XML|Tipo documento "+String:C10([ACT_Boletas:181]ID_Categoria:12)
									$vt_Tipo_Docto:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									$vt_pct_Desc_1:="0"
									$vt_Motivo_Desc_1:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"motivoDescuento")
									$vt_Monto_Desc_1:="0"
									$vt_No_Interno:=""
									$vt_No_Proveedor:=""
									$vt_Metodo_de_Pago:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"metodoDePago")
									$vt_Moneda:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"Moneda")
									$vt_Tipo_de_Cambio:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"TipoCambio")
									$vt_Observaciones_1:=""
									$vt_Observaciones_2:=""
									$vt_Importe_Con_Letra:="("+ST_Uppercase (ST_Num2Text2 (Int:C8([ACT_Boletas:181]Monto_Total:6);"es"))+" PESOS "+String:C10(Dec:C9([ACT_Boletas:181]Monto_Total:6)*100;"00")+"/100 MN.)"
									$vt_propiedad:="XML|Tipo impresión"
									$vt_Tipo_Impresion:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									$vt_propiedad:="XML|Tipo envío"
									$vt_Tipo_Envio:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
									$vt_Etiqueta_1_Fecha_de_Pago:=$vt_Fecha_CFD
									$vt_Lugar_de_Expedicion:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"LugarExpedicion")
									$vt_Numero_de_Cuenta:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante";"NumCtaPago")
									$vt_text:=$vt_id+"|"+$vt_Serie+"|"+$vt_Folio+"|"+$vt_Fecha_CFD+"|"+$vt_Forma_de_Pago+"|"+$vt_Condiciones_de_Pago+"|"+$vt_Función+"|"+$vt_Tipo_Docto+"|"+$vt_pct_Desc_1+"|"+$vt_Motivo_Desc_1+"|"+$vt_Monto_Desc_1+"|"+$vt_No_Interno+"|"+$vt_No_Proveedor+"|"+$vt_Método_de_Pago+"|"+$vt_Moneda+"|"+$vt_Tipo_de_Cambio+"|"+$vt_Observaciones_1+"|"+$vt_Observaciones_2+"|"+$vt_Importe_Con_Letra+"|"+$vt_Tipo_Impresión+"|"+$vt_Tipo_Envío+"|"+$vt_Etiqueta_1_Fecha_de_Pago+"|"+$vt_Lugar_de_Expedición+"|"+$vt_Número_de_Cuenta+"|"+"\r\n"
									
									
									C_TEXT:C284($vt_id;$vt_Nombre;$vt_RFC;$vt_Calle;$vt_Colonia;$vt_Localidad;$vt_Municipio;$vt_Estado;$vt_Pais;$vt_CP;$vt_Telefono)
									$vt_id:="H2"
									$vt_Nombre:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor";"nombre")
									$vt_RFC:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor";"rfc")
									$vt_Calle:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"calle")
									$vt_Colonia:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"colonia")
									$vt_Localidad:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"localidad")
									$vt_Municipio:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"municipio")
									$vt_Estado:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"estado")
									$vt_Pais:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"pais")
									$vt_CP:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Emisor/cfdi:DomicilioFiscal";"codigoPostal")
									$vt_Telefono:=""
									$vt_text:=$vt_text+$vt_id+"|"+$vt_Nombre+"|"+$vt_RFC+"|"+$vt_Calle+"|"+$vt_Colonia+"|"+$vt_Localidad+"|"+$vt_Municipio+"|"+$vt_Estado+"|"+$vt_Pais+"|"+$vt_CP+"|"+$vt_Telefono+"|"+"\r\n"
									
									C_TEXT:C284($vt_id;$vt_Nombre;$vt_RFC;$vt_Calle;$vt_Colonia;$vt_Localidad;$vt_Municipio;$vt_Estado;$vt_Pais;$vt_CP;$vt_Telefono)
									$vt_id:="H4"
									$vt_Nombre:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"nombre")
									$vt_RFC:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor";"rfc")
									$vt_Calle:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"calle")
									$vt_Colonia:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"colonia")
									$vt_Localidad:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"localidad")
									$vt_Municipio:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"municipio")
									$vt_Estado:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"estado")
									$vt_Pais:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"pais")
									$vt_CP:=DOM_GetAttributeValue ($vt_refxml;"/cfdi:Comprobante/cfdi:Receptor/cfdi:Domicilio";"codigoPostal")
									$vt_Telefono:=""
									$vt_text:=$vt_text+$vt_id+"|"+$vt_Nombre+"|"+$vt_RFC+"|"+$vt_Calle+"|"+$vt_Colonia+"|"+$vt_Localidad+"|"+$vt_Municipio+"|"+$vt_Estado+"|"+$vt_Pais+"|"+$vt_CP+"|"+$vt_Telefono+"|"+"\r\n"
									
									C_TEXT:C284($vt_id;$vt_Concepto;$vt_Alumno;$vt_Cantidad;$vt_Unidad_Medida;$vt_Precio;$vt_pct_Desc_1;$vt_Monto_desc_1;$vt_Precio_Neto;$vt_pct_IVA;$vt_Matricula_Alumno;$vt_Costo_Total;$vt_Importe;$vt_Monto_IVA;$vt_Etiqueta_1_Fecha_Serv;$vt_Etiqueta_2_Grado_y_Grupo;$vt_Etiqueta_3_Monto_recargo;$vt_Etiqueta_4_CURP)
									ARRAY REAL:C219($arACT_IVA;0)
									ARRAY REAL:C219($arACT_TasaIVA;0)
									$refElement:=DOM Find XML element:C864($vt_refxml;"/cfdi:Comprobante/cfdi:Conceptos")
									For ($i;1;DOM Count XML elements:C726($refElement;"cfdi:Concepto"))
										GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargo{$i})
										KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
										KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
										
										If ($arACT_MontoIva{$i}>0)
											APPEND TO ARRAY:C911($arACT_IVA;$arACT_ValorUnitario{$i})
											APPEND TO ARRAY:C911($arACT_TasaIVA;[ACT_Cargos:173]TasaIVA:21)
										End if 
										
										$vt_id:="D"
										$vt_Concepto:=$atACT_Desc{$i}
										$vt_Alumno:=$atACT_NombreAl{$i}
										$vt_Cantidad:=String:C10($arACT_Cantidad{$i})
										$vt_propiedad:="XML|ConceptosUnidad"
										$vt_Unidad_Medida:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
										$vt_Precio:=String:C10($arACT_ValorUnitario{$i})
										$vt_Precio:=Replace string:C233(String:C10($vt_Precio);<>tXS_RS_DecimalSeparator;".")
										$vt_pct_Desc_1:="0"
										$vt_Monto_desc_1:="0"
										$vt_Precio_Neto:=$vt_Precio
										$vt_pct_IVA:=ST_Boolean2Str ($arACT_MontoIva{$i}>0;String:C10([ACT_Cargos:173]TasaIVA:21);"0")
										$vt_Matricula_Alumno:=[Alumnos:2]numero_de_matricula:51
										$vt_Costo_Total:=String:C10($arACT_Total{$i})
										$vt_Costo_Total:=Replace string:C233($vt_Costo_Total;<>tXS_RS_DecimalSeparator;".")
										$vt_Importe:=$vt_Costo_Total
										$vt_Monto_IVA:=String:C10($arACT_MontoIva{$i})
										$vt_Monto_IVA:=Replace string:C233($vt_Monto_IVA;<>tXS_RS_DecimalSeparator;".")
										$vt_Etiqueta_1_Fecha_Serv:=$atACT_mes{$i}
										$vt_Etiqueta_2_Grado_y_Grupo:=ST_Uppercase (KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$al_nivelAl{$i};->[xxSTR_Niveles:6]Sección:9))
										$vt_Etiqueta_3_Monto_recargo:="0"
										$vt_Etiqueta_4_CURP:=$atACT_CURPAl{$i}
										
										$vt_text:=$vt_text+$vt_id+"|"+$vt_Concepto+"|"+$vt_Alumno+"|"+$vt_Cantidad+"|"+$vt_Unidad_Medida+"|"+$vt_Precio+"|"+$vt_pct_Desc_1+"|"+$vt_Monto_desc_1+"|"+$vt_Precio_Neto+"|"+$vt_pct_IVA+"|"+$vt_Matricula_Alumno+"|"+$vt_Costo_Total+"|"+$vt_Importe+"|"+$vt_Monto_IVA+"|"+$vt_Etiqueta_1_Fecha_Serv+"|"+$vt_Etiqueta_2_Grado_y_Grupo+"|"+$vt_Etiqueta_3_Monto_recargo+"|"+$vt_Etiqueta_4_CURP+"|"+"\r\n"
									End for 
									
									C_TEXT:C284($vt_id;$vt_SubTotal;$vt_Monto_desc_1;$vt_IVA;$vt_Total;$vt_Subtotal_2;$vt_pct_IVA;$vt_Monto_Total_Descuent;$vt_SubTotal_3;$vt_SubTotal_4)
									$vt_id:="S"
									$vt_SubTotal:=String:C10([ACT_Boletas:181]Monto_Exento:30+[ACT_Boletas:181]Monto_Afecto:4)
									$vt_SubTotal:=Replace string:C233($vt_SubTotal;<>tXS_RS_DecimalSeparator;".")
									$vt_Monto_desc_1:=""
									$vt_IVA:=String:C10([ACT_Boletas:181]Monto_IVA:5)
									$vt_IVA:=Replace string:C233($vt_IVA;<>tXS_RS_DecimalSeparator;".")
									$vt_Total:=String:C10([ACT_Boletas:181]Monto_Total:6)
									$vt_Total:=Replace string:C233($vt_Total;<>tXS_RS_DecimalSeparator;".")
									$vt_Subtotal_2:=String:C10(AT_GetSumArray (->$arACT_IVA))
									$vt_Subtotal_2:=Replace string:C233($vt_Subtotal_2;<>tXS_RS_DecimalSeparator;".")
									AT_DistinctsArrayValues (->$arACT_TasaIVA)
									If (Size of array:C274($arACT_TasaIVA)>0)
										$vt_pct_IVA:=String:C10($arACT_TasaIVA{1})
									Else 
										$vt_pct_IVA:="0"
									End if 
									$vt_Monto_Total_Descuent:="0"
									$vt_SubTotal_3:=$vt_SubTotal
									$vt_SubTotal_4:=$vt_SubTotal
									$vt_text:=$vt_text+$vt_id+"|"+$vt_SubTotal+"|"+$vt_Monto_desc_1+"|"+$vt_IVA+"|"+$vt_Total+"|"+$vt_Subtotal_2+"|"+$vt_pct_IVA+"|"+$vt_Monto_Total_Descuent+"|"+$vt_SubTotal_3+"|"+$vt_SubTotal_4+"|"+"\r\n"
									
									$vt_newName:=Substring:C12($vt_rutaXML;1;Length:C16($vt_rutaXML)-4)+".txt"
									
									If (Test path name:C476($vt_newName)=Is a document:K24:1)
										DELETE DOCUMENT:C159($vt_newName)
									End if 
									
									USE CHARACTER SET:C205("Windows-1252";0)
									
									$refDoc:=Create document:C266($vt_newName;"TEXT")
									If (OK=1)  // Si un documento ha sido creado
										IO_SendPacket ($refDoc;$vt_text)
										CLOSE DOCUMENT:C267($refDoc)  // No necesitamos mantenerlo abierto
										  //ACTcd_DlogWithShowOnDisk (document;0;"Listo")
										
										  // almacena en el server
										$vt_rutaServer:=Substring:C12($vt_rutaServer;1;Length:C16($vt_rutaServer)-4)+".txt"
										SYS_CreateFolderOnServer (SYS_GetParentNme ($vt_rutaServer))
										DOCUMENT TO BLOB:C525($vt_newName;$xBlob)
										KRL_SendFileToServer ($vt_rutaServer;$xBlob;True:C214)
										
										[ACT_Boletas:181]MX_pathFile:32:=$vt_rutaServer
										[ACT_Boletas:181]DTE_estado_id:24:=2
										SAVE RECORD:C53([ACT_Boletas:181])
										
										[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Archivo de texto generado. Proveedor "+at_proveedores{at_proveedores}+"."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
										
										  //borro xml en el cliente (esta en el server)
										DELETE DOCUMENT:C159($vt_rutaXML)
										
									End if 
									
									DOM CLOSE XML:C722($vt_refxml)
									
									USE CHARACTER SET:C205(*;0)
								Else 
									
									ACTdte_OpcionesGenerales ("EjecutaCodigo";->$vl_idBoleta)
									
							End case 
						Else 
							vtACT_ErrorString:=__ ("Error al leer ruta para almacenar archivo en el servidor.")
							[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": "+vtACT_ErrorString+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
						End if 
					Else 
						  //LOG_RegisterEvt ("CFDI: Error al leer rutas de certificados.")
						[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error al leer rutas de certificados."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
					End if 
					
					SET_ClearSets ("setTransaccionesBoleta")
					
				: (<>gCountryCode="cl")
					ACTdte_OpcionesGenerales ("EjecutaCodigo";->$vl_idBoleta)
					
			End case 
			ACTdte_OpcionesGenerales ("CopiaDocumentosACarpetas";->$vl_idBoleta)
		Else 
			[ACT_Boletas:181]DTE_log:26:=DTS_MakeFromDateTime +": CFDI: Error. Documento nulo."+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")+[ACT_Boletas:181]DTE_log:26
		End if 
		SAVE RECORD:C53([ACT_Boletas:181])
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Boletas:181])