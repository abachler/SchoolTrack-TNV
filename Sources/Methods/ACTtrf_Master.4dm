//%attributes = {}
  //ACTtrf_Master

If (False:C215)
	  //metodo para ser utiliado en la creacion de archivos de transferencia
	  //parametro 1 del método es la accion SIEMPRE LONGINT. Parámetro 2 es un parámetro SIEMPRE TEXTO
	  //1 inicializar varialbes
	  //2 cargar variables
	  //3 buscar el valor y devolverlo en cuenta contabilidad
	  //4 buscar el valor y devolverlo en contra cuenta contabilidad
	  //5 da formato a los campos fomra de llamar al método  ACTTrf_Master(5;"FORMATO";"TEXTOAFORMATEAR")
	  //6 descripciones fijas. Las descripciones particulares están en cada método de exportación que llama a este método
End if 


C_LONGINT:C283($vl_Pref)  //para orden de alumnos y cuentas
$vl_Pref:=Num:C11(PREF_fGet (0;"ACT_OrdenAlumnosEnAC";String:C10($vl_Pref)))
  //PREF_Set (0;"ACT_OrdenAlumnosEnAC";"1")

C_LONGINT:C283($1;$accion)
C_TEXT:C284($2;$parametro1;$3;$parametro2;$4;$parametro3;$0)
Case of   //parametros
	: (Count parameters:C259=1)
		$accion:=$1
	: (Count parameters:C259=2)
		$accion:=$1
		$parametro1:=$2
	: (Count parameters:C259=3)
		$accion:=$1
		$parametro1:=$2
		$parametro2:=$3
	: (Count parameters:C259=4)
		$accion:=$1
		$parametro1:=$2
		$parametro2:=$3
		$parametro3:=$4
End case 
Case of 
	: ($accion=1)  //declara varialbes y arreglos
		ACTtf_DeclareArrays 
		C_BLOB:C604(xBlob)
		C_LONGINT:C283(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2;WTrf_s3)
		C_LONGINT:C283(WTrf_s4)
		C_TEXT:C284(WTrf_s4_CaracterOtro)
		C_LONGINT:C283(cs_encabezado)
		C_LONGINT:C283(cs_registroControl)
		cs_encabezado:=0
		cs_registroControl:=0
		SET BLOB SIZE:C606(xBlob;0)
		
		ARRAY TEXT:C222(at_contabilidadTrf1;0)
		ARRAY TEXT:C222(at_contabilidadTrf2;0)
		ARRAY TEXT:C222(at_contabilidadTrf3;0)
		ARRAY TEXT:C222(at_contabilidadTrf4;0)
		ARRAY TEXT:C222(at_contabilidadTrf5;0)
		ARRAY TEXT:C222(at_contabilidadTrf6;0)
		ARRAY TEXT:C222(at_contabilidadTrf7;0)
		ARRAY TEXT:C222(at_contabilidadTrf8;0)
		ARRAY TEXT:C222(at_contabilidadTrf9;0)
		ARRAY TEXT:C222(at_contabilidadTrf10;0)
		ARRAY TEXT:C222(at_contabilidadTrf11;0)
		ARRAY TEXT:C222(at_contabilidadTrf12;0)
		ARRAY TEXT:C222(at_contabilidadTrf13;0)
		ARRAY TEXT:C222(at_contabilidadTrf14;0)
		ARRAY TEXT:C222(at_contabilidadTrf15;0)
		ARRAY TEXT:C222(at_contabilidadTrf16;0)
		ARRAY TEXT:C222(at_contabilidadTrf17;0)
		ARRAY TEXT:C222(at_contabilidadTrf18;0)
		ARRAY TEXT:C222(at_contabilidadTrf19;0)
		ARRAY TEXT:C222(at_contabilidadTrf20;0)
		ARRAY TEXT:C222(at_contabilidadTrf21;0)
		ARRAY TEXT:C222(at_contabilidadTrf22;0)
		ARRAY TEXT:C222(at_contabilidadTrf23;0)
		ARRAY TEXT:C222(at_contabilidadTrf24;0)
		ARRAY TEXT:C222(at_contabilidadTrf25;0)
		ARRAY TEXT:C222(at_contabilidadTrf26;0)
		ARRAY TEXT:C222(at_contabilidadTrf27;0)
		ARRAY TEXT:C222(at_contabilidadTrf28;0)
		ARRAY TEXT:C222(at_contabilidadTrf29;0)
		ARRAY TEXT:C222(at_contabilidadTrf30;0)
		ARRAY TEXT:C222(at_contabilidadTrf31;0)
		ARRAY TEXT:C222(at_contabilidadTrf32;0)
		ARRAY TEXT:C222(at_contabilidadTrf33;0)
		ARRAY TEXT:C222(at_contabilidadTrf34;0)
		ARRAY TEXT:C222(at_contabilidadTrf35;0)
		ARRAY TEXT:C222(at_contabilidadTrf36;0)
		ARRAY TEXT:C222(at_contabilidadTrf37;0)
		ARRAY TEXT:C222(at_contabilidadTrf38;0)
		ARRAY TEXT:C222(at_contabilidadTrf39;0)
		
		ARRAY TEXT:C222(at_contabilidadTrfCC1;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC2;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC3;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC4;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC5;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC6;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC7;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC8;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC9;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC10;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC11;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC12;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC13;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC14;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC15;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC16;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC17;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC18;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC19;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC20;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC21;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC22;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC23;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC24;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC25;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC26;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC27;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC28;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC29;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC30;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC31;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC32;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC33;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC34;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC35;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC36;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC37;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC38;0)
		ARRAY TEXT:C222(at_contabilidadTrfCC39;0)
		
	: ($accion=2)  //carga variables y arreglos
		$id:=Num:C11($parametro1)
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=$id)
		xBlob:=[xxACT_ArchivosBancarios:118]xData:2
		BLOB_Blob2Vars (->xBlob;0;->al_recordTablePointersExpTemp;->al_recordFieldPointersExpTemp;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_formato;->at_Alineado;->at_Relleno;->at_TextoFijo;->at_HeaderAC;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->WTrf_s4;->WTrf_s4_CaracterOtro)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=[xxACT_ArchivosBancarios:118]xDataHeader:10
		BLOB_Blob2Vars (->xBlob;0;->al_NumeroHe;->at_DescripcionHe;->al_PosIniHe;->al_LargoHe;->al_PosFinalHe;->at_formatoHe;->at_AlineadoHe;->at_RellenoHe;->at_TextoFijoHe;->cs_encabezado)
		SET BLOB SIZE:C606(xBlob;0)
		xBlob:=[xxACT_ArchivosBancarios:118]xDataFooter:11
		BLOB_Blob2Vars (->xBlob;0;->al_NumeroFo;->at_DescripcionFo;->al_PosIniFo;->al_LargoFo;->al_PosFinalFo;->at_formatoFo;->at_AlineadoFo;->at_RellenoFo;->at_TextoFijoFo;->cs_registroControl)
		SET BLOB SIZE:C606(xBlob;0)
	: ($accion=3)  //busca valor en cuentas CONTABILIDAD CUERPO
		REDUCE SELECTION:C351([Personas:7];0)
		REDUCE SELECTION:C351([ACT_Transacciones:178];0)
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
		REDUCE SELECTION:C351([ACT_Pagos:172];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		REDUCE SELECTION:C351([Familia:78];0)
		REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		REDUCE SELECTION:C351([Alumnos:2];0)
		
		C_LONGINT:C283($r;$I;$el)
		C_TEXT:C284($fdPago)
		$r:=Num:C11($parametro1)  //posicion arreglo comparacion
		$i:=Num:C11($parametro2)  //posicion arreglo texto retorno
		$dia:=ST_RigthChars ("00"+String:C10(Day of:C23(Current date:C33(*)));2)
		$mes:=ST_RigthChars ("00"+String:C10(Month of:C24(Current date:C33(*)));2)
		$Agno:=String:C10(Year of:C25(Current date:C33(*)))
		$vt_fechaTemp:=$mes+$dia+$agno
		Case of 
			: (at_Descripcion{$r}="Texto Fijo")
				$0:=at_TextoFijo{$r}
			: (at_Descripcion{$r}="Código Plan de Cuentas")
				$0:=acampo1{$i}
			: (at_Descripcion{$r}="Monto al haber moneda Base")
				$0:=String:C10(acampo3{$i};"|Despliegue_ACT_Pagos")
			: (at_Descripcion{$r}="Monto al debe moneda Base")
				$0:=String:C10(acampo2{$i};"|Despliegue_ACT_Pagos")
			: (at_Descripcion{$r}="Descripción de Movimiento")
				$0:=acampo4{$i}
			: (at_Descripcion{$r}="Código centro de costos")
				$0:=acampo16{$i}
				  //: (at_Descripcion{$r}="Código Auxiliar")
				  //$0:=acampo19{$i}
			: (at_Descripcion{$r}="Monto del concepto")
				If (acampo2{$i}#0)
					$0:=String:C10(acampo2{$i};"|Despliegue_ACT_Pagos")
				Else 
					$0:=String:C10(acampo3{$i};"|Despliegue_ACT_Pagos")
				End if 
			: (at_Descripcion{$r}="Tipo de movimiento")
				$vr_monto:=acampo2{$i}
				$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r};->$vr_monto)
				
				  //INICIO CODIGO INTERNO FROMA DE PAGO
			: (at_Descripcion{$r}="Código Interno Forma de Pago")
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					Case of 
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Cargos:173]))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							If (Records in selection:C76([ACT_Transacciones:178])>0)
								KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
								$fdPago:=[ACT_Pagos:172]FormaDePago:7
								$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
								
								$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
								If ($el>0)
									KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
									If ($vl_idFdPago=-4)
										If ([ACT_Documentos_de_Pago:176]Fecha:13=[ACT_Documentos_de_Pago:176]Depositado_Fecha:42)
											$0:=atACT_FdPCodInterno{$el}
										Else 
											$0:=vtACT_CICAFecha
										End if 
									Else 
										$0:=atACT_FdPCodInterno{$el}
									End if 
								Else 
									$0:=""
								End if 
							Else 
								$0:=""
							End if 
							
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Pagos:172]))
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=aID{$i})
							Case of 
								: (<>gRolBD="92169")  //suizo incidente 66393
									If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-02-01")
										$0:="DE"
									Else 
										$0:=""
									End if 
								Else 
									$fdPago:=[ACT_Pagos:172]FormaDePago:7
									$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
									
									  //$el:=Find in array(atACT_FormasdePago;$fdPago)
									$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
									If ($el>0)
										KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
										If ($vl_idFdPago=-4)
											If ([ACT_Documentos_de_Pago:176]Fecha:13=[ACT_Documentos_de_Pago:176]Depositado_Fecha:42)
												$0:=atACT_FdPCodInterno{$el}
											Else 
												$0:=vtACT_CICAFecha
											End if 
										Else 
											$0:=atACT_FdPCodInterno{$el}
										End if 
									Else 
										$0:=""
									End if 
							End case 
							
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Boletas:181]))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
							If (Records in selection:C76([ACT_Pagos:172])>0)
								$fdPago:=[ACT_Pagos:172]FormaDePago:7
								$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
								
								  //$el:=Find in array(atACT_FormasdePago;$fdPago)
								$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
								
								If ($el>0)
									KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
									If ($vl_idFdPago=-4)
										If ([ACT_Documentos_de_Pago:176]Fecha:13=[ACT_Documentos_de_Pago:176]Depositado_Fecha:42)
											$0:=atACT_FdPCodInterno{$el}
										Else 
											$0:=vtACT_CICAFecha
										End if 
									Else 
										$0:=atACT_FdPCodInterno{$el}
									End if 
								Else 
									$0:=""
								End if 
							Else 
								$0:=""
							End if 
					End case 
				End if 
				  //FIN CODIGO INTERNO FROMA DE PAGO
				
			: (at_Descripcion{$r}="Código Forma de Pago")
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					Case of 
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Cargos:173]))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							If (Records in selection:C76([ACT_Transacciones:178])>0)
								KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
								$fdPago:=[ACT_Pagos:172]FormaDePago:7
								$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
								  //$el:=Find in array(atACT_FormasdePago;$fdPago)
								$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
								If ($el>0)
									$0:=atACT_FdPCodes{$el}
								Else 
									$0:=""
								End if 
							Else 
								$0:=""
							End if 
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Pagos:172]))
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=aID{$i})
							Case of 
								: (<>gRolBD="92169")  //suizo incidente 66393
									If ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-02-01")
										$0:="DE"
									Else 
										$0:=""
									End if 
								Else 
									$fdPago:=[ACT_Pagos:172]FormaDePago:7
									$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
									  //$el:=Find in array(atACT_FormasdePago;$fdPago)
									$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
									If ($el>0)
										$0:=atACT_FdPCodes{$el}
									Else 
										$0:=""
									End if 
							End case 
							
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Boletas:181]))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
							If (Records in selection:C76([ACT_Pagos:172])>0)
								$fdPago:=[ACT_Pagos:172]FormaDePago:7
								$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
								  //$el:=Find in array(atACT_FormasdePago;$fdPago)
								$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
								If ($el>0)
									$0:=atACT_FdPCodes{$el}
								Else 
									$0:=""
								End if 
							Else 
								$0:=""
							End if 
					End case 
				End if 
			: (at_Descripcion{$r}="Tipo documento")  //igual que forma de pago pero incluye pago anticipado
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					QUERY:C277(vp_tabla->;ptr_Id->=aID{$i})
					Case of 
						: (<>gRolBD="88730")  //Villa Maria
							If ([ACT_Pagos:172]No_Cuenta_Contable:16=vtACT_CPCAFecha)
								$0:=ST_Qte ("ch")
							Else 
								$0:=""
							End if 
							
						: (<>gRolBD="92169")  //suizo incidente 66393
							Case of 
								: ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-10")
									$0:="CF"
								: ([ACT_Pagos:172]No_Cuenta_Contable:16="1-1-06-20")
									$0:="LT"
								Else 
									$0:=""
							End case 
							
						Else 
							$el:=Find in array:C230(atACT_FormasdePago;"Colegiatura anticipada")
							If ($el>0)
								$codFormaPago:=atACT_FdPCodes{$el}
								Case of 
									: (Table:C252(vp_tabla)=Table:C252(->[ACT_Cargos:173]))
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
										QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
										QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
										If (Records in selection:C76([ACT_Transacciones:178])>0)
											KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
											Case of 
												: ([ACT_Pagos:172]Fecha:2<[ACT_Cargos:173]FechaEmision:22)
													$0:=$codFormaPago
												Else 
													$fdPago:=[ACT_Pagos:172]FormaDePago:7
													$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
													  //$el:=Find in array(atACT_FormasdePago;$fdPago)
													$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
													If ($el>0)
														$0:=atACT_FdPCodes{$el}
													Else 
														$0:=""
													End if 
											End case 
										Else 
											$0:=""
										End if 
									: (Table:C252(vp_tabla)=Table:C252(->[ACT_Pagos:172]))
										QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=aID{$i})
										KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
										KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
										ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>)
										FIRST RECORD:C50([ACT_Cargos:173])
										Case of 
											: ([ACT_Pagos:172]Fecha:2<[ACT_Cargos:173]FechaEmision:22)
												$0:=$codFormaPago
											Else 
												$fdPago:=[ACT_Pagos:172]FormaDePago:7
												$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
												  //$el:=Find in array(atACT_FormasdePago;$fdPago)
												$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
												If ($el>0)
													$0:=atACT_FdPCodes{$el}
												Else 
													$0:=""
												End if 
										End case 
									: (Table:C252(vp_tabla)=Table:C252(->[ACT_Boletas:181]))
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
										QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
										QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
										KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
										ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;>)
										KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
										ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>)
										If (Records in selection:C76([ACT_Pagos:172])>0)
											Case of 
												: ([ACT_Pagos:172]Fecha:2<[ACT_Cargos:173]FechaEmision:22)
													$0:=$codFormaPago
												Else 
													$fdPago:=[ACT_Pagos:172]FormaDePago:7
													$vl_idFdPago:=[ACT_Pagos:172]id_forma_de_pago:30
													  //$el:=Find in array(atACT_FormasdePago;$fdPago)
													$el:=Find in array:C230(alACT_FormasdePagoID;$vl_idFdPago)
													If ($el>0)
														$0:=atACT_FdPCodes{$el}
													Else 
														$0:=""
													End if 
											End case 
										Else 
											$0:=""
										End if 
								End case 
							End if 
					End case 
				End if 
			: (at_Descripcion{$r}="Correlativo")  //entrega el valor 
				vl_correlativo:=vl_correlativo+1
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					QUERY:C277(vp_tabla->;ptr_Id->=aID{$i})
				End if 
				$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r};->vl_correlativo)
			: (at_Descripcion{$r}="Fecha actual")  //
				$0:=$vt_fechaTemp
			: (at_Descripcion{$r}="Tipo documento conciliación")  //
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					QUERY:C277(vp_tabla->;ptr_Id->=aID{$i})
					$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r})
				End if 
				
			Else   //para los campos directos proximamente
				If ((cbResumidoR=0) | (cbResumidoF=0))  //resumido =0
					Case of 
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Cargos:173]))
							QUERY:C277(vp_tabla->;ptr_Id->=aID{$i})
							
							QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Cargos:173]ID_Apoderado:18)
							
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
							
							KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
							ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]ID:1;>)
							
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							If (Records in selection:C76([ACT_Transacciones:178])>0)
								KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
								
								KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
								ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]FechaPago:4;>)
							End if 
							
							KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
							KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
							  //KRL_FindAndLoadRecordByIndex (->[Familia_RelacionesFamiliares]ID_Alumno;->[Alumnos]Número)
							  //KRL_FindAndLoadRecordByIndex (->[Familia]Numero;->[Familia_RelacionesFamiliares]ID_Familia)
							KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
							
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Pagos:172]))
							QUERY:C277(vp_tabla->;ptr_Id->=aID{$i})
							
							QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
							
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
							
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
							KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
							FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
							KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
							ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]ID:1;>)
							
							If ((Records in selection:C76([Personas:7]))=1)
								KRL_FindAndLoadRecordByIndex (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1)
								KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2)
							End if 
							KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
							KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
							If ($vl_Pref=0)
								ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
							Else 
								ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;>)
							End if 
							ACTcc_OrdenaCtasDesdeAlumnos 
							
						: (Table:C252(vp_tabla)=Table:C252(->[ACT_Boletas:181]))
							If (aID{$i}#0)
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aID{$i})
								
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Cargos:173]ID_Apoderado:18)
								
								QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
								QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
								
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
								
								If (alACT_IdsBoletas{$i}#0)
									QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=alACT_IdsBoletas{$i})
								Else 
									KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
									CREATE SET:C116([ACT_Boletas:181];"ACTBoletasAfectadas")
									INTERSECTION:C121("ACTBoletasAfectadas";"boletas";"ACTBoletasAfectadas")
									USE SET:C118("ACTBoletasAfectadas")
									CLEAR SET:C117("ACTBoletasAfectadas")
								End if 
								
								QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
								If (Records in selection:C76([ACT_Transacciones:178])>0)
									KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
									
									KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
									ORDER BY:C49([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]FechaPago:4;>)
								End if 
								
								KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
								KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
								  //KRL_FindAndLoadRecordByIndex (->[Familia_RelacionesFamiliares]ID_Alumno;->[Alumnos]Número)
								  //KRL_FindAndLoadRecordByIndex (->[Familia]Numero;->[Familia_RelacionesFamiliares]ID_Familia)
								KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
								
							Else 
								QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=alACT_IdsBoletas{$i})
								QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Boletas:181]ID_Apoderado:14)
							End if 
					End case 
					Case of 
						: (at_Descripcion{$r}="Nro. dcto. referencia")
							$0:=ACTtrf_RetornaInfoXColegio ("Nro. dcto. referencia")
						: (at_Descripcion{$r}="Fecha referencia documento")
							$0:=ACTtrf_RetornaInfoXColegio ("Fecha referencia documento")
						: (at_Descripcion{$r}="Fecha vencimiento documento")
							$0:=ACTtrf_RetornaInfoXColegio ("Fecha vencimiento documento")
						: (at_Descripcion{$r}="Código Auxiliar")
							$vt_valor:=acampo19{$i}
							$0:=ACTtrf_RetornaInfoXColegio ("Código Auxiliar";->$vt_valor)
							
						: (at_Descripcion{$r}="Número documento conciliación")
							$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r})
						Else 
							C_POINTER:C301($ptrCampo)
							$ptr:=Get pointer:C304("at_contabilidadTrf"+String:C10($r))
							$ptrCampo:=Field:C253(al_recordTablePointersExpTemp{$r};al_recordFieldPointersExpTemp{$r})
							$type:=Type:C295($ptrCampo->)
							
							  //dar formato a los campos acá
							
							Case of 
								: (($type=Is integer:K8:5) | ($type=Is longint:K8:6))  //1
									$0:=ACTtrf_RetornaInfoXColegio ("CampoNumDirecto";$ptrCampo)
								: ($type=Is real:K8:4)  //2
									$0:=ACTtrf_RetornaInfoXColegio ("CampoNumDirecto";$ptrCampo)
								: ($type=Is date:K8:7)  //3
									C_TEXT:C284($dia;$mes;$año)
									$dia:=String:C10(Day of:C23($ptrCampo->);"00")
									$mes:=String:C10(Month of:C24($ptrCampo->);"00")
									$año:=String:C10(Year of:C25($ptrCampo->);"0000")
									$0:=$mes+$dia+$año
								: (($Type=Is alpha field:K8:1) | ($type=Is text:K8:3))  //4
									$0:=ACTtrf_RetornaInfoXColegio ("CampoTextoDirecto";$ptrCampo)
								: ($type=Is boolean:K8:9)  //5
									$0:=String:C10($ptrCampo->)
								Else 
									$0:="VALOR NO SOPORTADO"
									$FieldValid:=False:C215
									$r:=Size of array:C274(al_Numero)
									CD_Dlog (0;__ ("Type ")+String:C10($type)+__ (" is not supported."))
							End case 
					End case 
				Else 
					$0:=""
				End if 
		End case 
		REDUCE SELECTION:C351([Personas:7];0)
		REDUCE SELECTION:C351([ACT_Transacciones:178];0)
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
		REDUCE SELECTION:C351([ACT_Pagos:172];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];0)
		REDUCE SELECTION:C351([ACT_Cargos:173];0)
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		REDUCE SELECTION:C351([Familia:78];0)
		REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];0)
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		REDUCE SELECTION:C351([Alumnos:2];0)
	: ($accion=4)  //para contracuentas CONTABILIDAD CUERPO
		C_LONGINT:C283($r;$I)
		$r:=Num:C11($parametro1)  //posicion arreglo comparacion
		$i:=Num:C11($parametro2)  //posicion arreglo texto retorno
		$dia:=ST_RigthChars ("00"+String:C10(Day of:C23(Current date:C33(*)));2)
		$mes:=ST_RigthChars ("00"+String:C10(Month of:C24(Current date:C33(*)));2)
		$Agno:=String:C10(Year of:C25(Current date:C33(*)))
		$vt_fechaTemp:=$mes+$dia+$agno
		Case of 
			: (at_Descripcion{$r}="Texto Fijo")
				$0:=at_TextoFijo{$r}
			: (at_Descripcion{$r}="Código Plan de Cuentas")
				$0:=acampocc1{$i}
			: (at_Descripcion{$r}="Monto al haber moneda Base")
				$0:=String:C10(acampocc3{$i};"|Despliegue_ACT_Pagos")
			: (at_Descripcion{$r}="Monto al debe moneda Base")
				$0:=String:C10(acampocc2{$i};"|Despliegue_ACT_Pagos")
			: (at_Descripcion{$r}="Descripción de Movimiento")
				$0:=acampocc4{$i}
			: (at_Descripcion{$r}="Código centro de costos")
				$0:=acampocc16{$i}
			: (at_Descripcion{$r}="Código Auxiliar")
				$0:=acampocc19{$i}
			: (at_Descripcion{$r}="Monto del concepto")
				If (acampocc2{$i}#0)
					$0:=String:C10(acampocc2{$i};"|Despliegue_ACT_Pagos")
				Else 
					$0:=String:C10(acampocc3{$i};"|Despliegue_ACT_Pagos")
				End if 
			: (at_Descripcion{$r}="Tipo de movimiento")
				$vr_monto:=acampocc2{$i}
				$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r};->$vr_monto)
				
				  //If (acampocc2{$i}#0)
				  //$0:="1"
				  //Else 
				  //$0:="2"
				  //End if 
			: (at_Descripcion{$r}="Código Forma de Pago")
				$0:=""
			: (at_Descripcion{$r}="Correlativo")
				vl_correlativo:=vl_correlativo+1
				$0:=ACTtrf_RetornaInfoXColegio (at_Descripcion{$r};->vl_correlativo)
			: (at_Descripcion{$r}="Fecha actual")  //
				$0:=$vt_fechaTemp
				
			: (at_Descripcion{$r}="Día Juliano")  //
				$0:=ACTtrf_Master (6;at_Descripcion{$r};$parametro3)
				
			Else   //
				$0:=""
		End case 
		
	: ($accion=5)  //formatos 1 comparacion. 2 texto final
		Case of 
			: ($parametro1="Texto entre comillas")
				$0:=ST_Qte ($parametro2)
			: ($parametro1="Texto sin puntos ni guiones")
				$0:=Replace string:C233(Replace string:C233(Replace string:C233($parametro2;".";"");"-";"");"_";"")
			: ($parametro1="Entre comillas texto sin puntos ni guiones")
				$0:=ST_Qte (Replace string:C233(Replace string:C233($parametro2;".";"");"-";""))
			: ($parametro1="Texto sin puntos, comas ni guiones")
				$0:=Replace string:C233(Replace string:C233(Replace string:C233($parametro2;".";"");"-";"");",";"")
			: ($parametro1="Entre comillas texto sin puntos, comas ni guiones")
				$0:=ST_Qte (Replace string:C233(Replace string:C233(Replace string:C233($parametro2;".";"");"-";"");",";""))
			: ($parametro1="Texto en mayúsculas")
				$0:=ST_Uppercase ($parametro2)
			: ($parametro1="ddmmaaaa")  //CAMPOS FECHA
				$0:=Substring:C12($parametro2;3;2)+Substring:C12($parametro2;1;2)+Substring:C12($parametro2;5;4)
			: ($parametro1="ddmmaa")  //CAMPOS FECHA
				$0:=Substring:C12($parametro2;3;2)+Substring:C12($parametro2;1;2)+Substring:C12($parametro2;7;2)
			: ($parametro1="aaaammdd")  //CAMPOS FECHA
				$0:=Substring:C12($parametro2;5;4)+Substring:C12($parametro2;1;2)+Substring:C12($parametro2;3;2)
			: ($parametro1="aammdd")  //CAMPOS FECHA
				$0:=Substring:C12($parametro2;7;2)+Substring:C12($parametro2;1;2)+Substring:C12($parametro2;3;2)
			: ($parametro1="mmddaa")  //CAMPOS FECHA
				$0:=Substring:C12($parametro2;1;2)+Substring:C12($parametro2;3;2)+Substring:C12($parametro2;7;2)
			: ($parametro1="mmddaaaa")  //CAMPOS FECHA
				$0:=$parametro2
			: ($parametro1="dd")  //campo fecha
				$0:=Substring:C12($parametro2;3;2)
			: ($parametro1="ddmm")  //campo fecha
				$0:=Substring:C12($parametro2;3;2)+Substring:C12($parametro2;1;2)
			: ($parametro1="mmdd")  //campo fecha
				$0:=Substring:C12($parametro2;1;2)+Substring:C12($parametro2;3;2)
			: ($parametro1="Sin formato")  //para RUT
				$0:=$parametro2
			: ($parametro1="Rut con guión")  //para RUT
				$0:=Substring:C12($parametro2;1;Length:C16($parametro2)-1)+"-"+Substring:C12($parametro2;Length:C16($parametro2);1)
			: ($parametro1="Rut sin Guión")  //CAMPOS RUT
				$0:=$parametro2
			: ($parametro1="Reemplazar guión por espacio")  //CAMPOS RUT
				$0:=Substring:C12($parametro2;1;Length:C16($parametro2)-1)+" "+Substring:C12($parametro2;Length:C16($parametro2);1)
			: ($parametro1="Sólo dígito Verificador")  //CAMPOS RUT
				$0:=Substring:C12($parametro2;Length:C16($parametro2);1)
			: ($parametro1="Entre comillas rut con guión")  //CAMPOS RUT
				$0:=ST_Qte (Substring:C12($parametro2;1;Length:C16($parametro2)-1)+"-"+Substring:C12($parametro2;Length:C16($parametro2);1))
			: ($parametro1="Entre comillas rut sin guión")  //CAMPOS RUT
				$0:=ST_Qte ($parametro2)
			: ($parametro1="Entre comillas reemplazar guión por espacio")  //CAMPOS RUT
				$0:=ST_Qte (Substring:C12($parametro2;1;Length:C16($parametro2)-1)+" "+Substring:C12($parametro2;Length:C16($parametro2);1))
			: ($parametro1="Entre comillas sólo dígito verificador")  //CAMPOS RUT
				$0:=ST_Qte (Substring:C12($parametro2;Length:C16($parametro2);1))
			: ($parametro1="Rut sin dígito verificador")  //CAMPOS RUT
				$0:=Substring:C12($parametro2;1;Length:C16($parametro2)-1)
			: ($parametro1="Entre comillas rut sin dígito verificador")  //CAMPOS RUT
				$0:=ST_Qte (Substring:C12($parametro2;1;Length:C16($parametro2)-1))
			: ($parametro1="Rut con formato")  //CAMPOS RUT
				$0:=SR_FormatoRUT2 ($parametro2)
			: ($parametro1="Entre comillas rut con formato")  //CAMPOS RUT
				$0:=ST_Qte (SR_FormatoRUT2 ($parametro2))
				  //: ($parametro1="Monto con 2 decimales")  `CAMPOS MONTOS 
				  //$0:=$parametro2+"00"
				  //: ($parametro1="Monto con 4 decimales")  `CAMPOS MONTOS 
				  //$0:=$parametro2+"0000"
			: ($parametro1="Monto con 2 decimales")  //CAMPOS MONTOS 
				C_TEXT:C284($vtACT_MontoEntero;$vtACT_MontoDecimal)
				ACTio_Num2Vars (Num:C11($parametro2);11;11;->$vtACT_MontoEntero;->$vtACT_MontoDecimal;False:C215)
				$0:=String:C10(Num:C11($vtACT_MontoEntero))+ST_LeftChars ($vtACT_MontoDecimal+("0"*2);2)
			: ($parametro1="Monto con 4 decimales")  //CAMPOS MONTOS 
				C_TEXT:C284($vtACT_MontoEntero;$vtACT_MontoDecimal)
				ACTio_Num2Vars (Num:C11($parametro2);11;11;->$vtACT_MontoEntero;->$vtACT_MontoDecimal;False:C215)
				$0:=String:C10(Num:C11($vtACT_MontoEntero))+ST_LeftChars ($vtACT_MontoDecimal+("0"*4);4)
			: ($parametro1="Monto con 2 decimales con separador")  //CAMPOS MONTOS 
				C_TEXT:C284($vtACT_MontoEntero;$vtACT_MontoDecimal)
				ACTio_Num2Vars (Num:C11($parametro2);11;11;->$vtACT_MontoEntero;->$vtACT_MontoDecimal;False:C215)
				$0:=String:C10(Num:C11($vtACT_MontoEntero))+<>tXS_RS_DecimalSeparator+ST_LeftChars ($vtACT_MontoDecimal+("0"*2);2)
			: ($parametro1="Monto con 4 decimales con separador")  //CAMPOS MONTOS 
				C_TEXT:C284($vtACT_MontoEntero;$vtACT_MontoDecimal)
				ACTio_Num2Vars (Num:C11($parametro2);11;11;->$vtACT_MontoEntero;->$vtACT_MontoDecimal;False:C215)
				$0:=String:C10(Num:C11($vtACT_MontoEntero))+<>tXS_RS_DecimalSeparator+ST_LeftChars ($vtACT_MontoDecimal+("0"*4);4)
			: ($parametro1="mm+slash+aa")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;1;2)+"/"+Substring:C12($parametro2;5;2)
			: ($parametro1="mm+slash+aaaa")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;1;2)+"/"+Substring:C12($parametro2;3;4)
			: ($parametro1="aa+slash+mm")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;5;2)+"/"+Substring:C12($parametro2;1;2)
			: ($parametro1="aaaa+slash+mm")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;3;4)+"/"+Substring:C12($parametro2;1;2)
			: ($parametro1="mm+guión+aa")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;1;2)+"-"+Substring:C12($parametro2;5;2)
			: ($parametro1="mm+guión+aaaa")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;1;2)+"-"+Substring:C12($parametro2;3;4)
			: ($parametro1="aa+guión+mm")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;5;2)+"-"+Substring:C12($parametro2;1;2)
			: ($parametro1="aaaa+guión+mm")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;3;4)+"-"+Substring:C12($parametro2;1;2)
			: ($parametro1="aamm")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;5;2)+Substring:C12($parametro2;1;2)
			: ($parametro1="mmaa")  //CAMPO AÑO O MES TC
				$0:=Substring:C12($parametro2;1;2)+Substring:C12($parametro2;5;2)
			: ($parametro1="ddmmaaaa Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;3;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;5;4)
				End if 
			: ($parametro1="ddmmaa Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;3;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;7;2)
				End if 
			: ($parametro1="aaaammdd Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;5;4)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;3;2)
				End if 
			: ($parametro1="aammdd Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;7;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;3;2)
				End if 
			: ($parametro1="mmddaa Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;3;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;7;2)
				End if 
			: ($parametro1="mmddaaaa Local")  //CAMPOS FECHA
				If ($parametro2#"")
					$0:=Substring:C12($parametro2;1;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;3;2)+<>tXS_RS_DateSeparator+Substring:C12($parametro2;5;4)
				End if 
			: ($parametro1="DM")  //CAMPOS FECHA sólo el día sin 0
				If ($parametro2#"")
					$0:=String:C10(Num:C11(Substring:C12($parametro2;3;2)))+<>tXS_RS_DateSeparator+Substring:C12($parametro2;1;2)
				End if 
			: ($parametro1="día")
				If ($parametro2#"")
					$0:=String:C10(Num:C11(Substring:C12($parametro2;3;2)))
				End if 
			: ($parametro1="mes")
				If ($parametro2#"")
					$0:=String:C10(Num:C11(Substring:C12($parametro2;1;2)))
				End if 
			: ($parametro1="año")
				If ($parametro2#"")
					$0:=String:C10(Num:C11(Substring:C12($parametro2;5;4)))
				End if 
			Else 
				$0:=$parametro2
		End case 
	: ($accion=6)  //descripciones Fijas ENCABEZADOS, PIES y cuerpos
		C_TEXT:C284($vt_fechaTemp;$dia;$mes;$agno)
		C_DATE:C307(vd_Fecha3;$vd_fecha)
		Case of 
			: ($parametro1="Fecha de información -sólo PAC-")
				$vd_fecha:=vd_Fecha3
				
			: ($parametro1="Fecha vencimiento primer aviso de cobranza")
				$vd_fecha:=Date:C102($parametro2)
				
			Else 
				$vd_fecha:=Current date:C33(*)
		End case 
		$dia:=ST_RigthChars ("00"+String:C10(Day of:C23($vd_fecha));2)
		$mes:=ST_RigthChars ("00"+String:C10(Month of:C24($vd_fecha));2)
		$Agno:=String:C10(Year of:C25($vd_fecha))
		$vt_fechaTemp:=$mes+$dia+$agno
		Case of 
			: (($parametro1="Fecha actual") | ($parametro1="Fecha de información -sólo PAC-"))
				$0:=$vt_fechaTemp
			: ($parametro1="Día actual")
				$0:=Substring:C12($vt_fechaTemp;3;2)
			: ($parametro1="Mes actual")
				$0:=Substring:C12($vt_fechaTemp;1;2)
			: ($parametro1="Año actual")
				$0:=Substring:C12($vt_fechaTemp;5;4)
			: ($parametro1="Número mes inicio período generación")
				Case of 
					: (b1=1)  //hoy
						$0:=String:C10(Month of:C24(Current date:C33(*)))
					: (b3=1)  //mes
						$0:=String:C10(vi_SelectedMonth)
					: (b5=1)  //año
						$0:="1"
					: (b6=1)  //rango fecha
						$0:=String:C10(Month of:C24(vd_Fecha1))
				End case 
			: ($parametro1="Día Juliano")
				C_DATE:C307($vd_fechaJulianoInicio;$vd_fechaJulianoFin)
				C_TEXT:C284($vt_valorInicial)
				  //PREF_Set (0;"ACTcfg_valorInicioJuliano";"2451545") `para día juliano no desde primer día de este año.
				$vt_valorInicial:="0"
				$vt_valorInicial:=PREF_fGet (0;"ACTcfg_valorInicioJuliano";$vt_valorInicial)
				$vd_fechaJulianoFin:=Date:C102($parametro2)
				If ($vt_valorInicial="0")
					$vd_fechaJulianoInicio:=DT_GetDateFromDayMonthYear (1;1;Year of:C25($vd_fechaJulianoFin))
				Else 
					$vd_fechaJulianoInicio:=!2000-01-01!
				End if 
				$0:=String:C10(($vd_fechaJulianoFin-$vd_fechaJulianoInicio)+Num:C11($vt_valorInicial))
				
			: ($parametro1="Fecha vencimiento primer aviso de cobranza")
				$0:=$vt_fechaTemp
				
			Else 
				$0:=""
		End case 
	: ($accion=7)
		$ptr:=Get pointer:C304($parametro1)
		AT_Initialize ($ptr)
		APPEND TO ARRAY:C911($ptr->;"Texto Fijo")
		APPEND TO ARRAY:C911($ptr->;"Código Plan de Cuentas")
		APPEND TO ARRAY:C911($ptr->;"Monto al haber moneda Base")
		APPEND TO ARRAY:C911($ptr->;"Monto al debe moneda Base")
		APPEND TO ARRAY:C911($ptr->;"Descripción de Movimiento")
		APPEND TO ARRAY:C911($ptr->;"Código centro de costos")
		APPEND TO ARRAY:C911($ptr->;"Código Auxiliar")
		APPEND TO ARRAY:C911($ptr->;"Código Forma de Pago")
		APPEND TO ARRAY:C911($ptr->;"Monto del concepto")
		APPEND TO ARRAY:C911($ptr->;"Tipo de movimiento")
		APPEND TO ARRAY:C911($ptr->;"Correlativo")
		APPEND TO ARRAY:C911($ptr->;"Fecha actual")
		APPEND TO ARRAY:C911($ptr->;"Nro. dcto. referencia")
		APPEND TO ARRAY:C911($ptr->;"Tipo documento")
		APPEND TO ARRAY:C911($ptr->;"Fecha referencia documento")
		APPEND TO ARRAY:C911($ptr->;"Fecha vencimiento documento")
		APPEND TO ARRAY:C911($ptr->;"Tipo documento conciliación")
		APPEND TO ARRAY:C911($ptr->;"Número documento conciliación")
		APPEND TO ARRAY:C911($ptr->;"Código Interno Forma de Pago")
		APPEND TO ARRAY:C911($ptr->;"Día Juliano")
		APPEND TO ARRAY:C911($ptr->;"Número de Tarjeta de Crédito")  //20140526 RCH Se habilita como texto fijo puesto que el campo esta oculto en la estructur…
End case 