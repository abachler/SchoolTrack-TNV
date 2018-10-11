//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 11:09:25
  // ----------------------------------------------------
  // Método: ACTwiz_ImportadorChequesDepo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (USR_GetMethodAcces (Current method name:C684))
	
	C_TEXT:C284($1;$vt_accion)
	
	If (Count parameters:C259=0)
		$vt_accion:="cargaFormulario"
	Else 
		$vt_accion:=$1
	End if 
	
	
	Case of 
		: ($vt_accion="cargaFormulario")
			
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_ImportadorChequesDepo";0;4;__ ("Importación de Cheques Depositados"))
			DIALOG:C40([xxSTR_Constants:1];"ACTwiz_ImportadorChequesDepo")
			CLOSE WINDOW:C154
			
			
		: ($vt_accion="declaraciones")
			
			C_TEXT:C284(vt_nombreArchivo)
			ARRAY TEXT:C222(ACT_ResultadosImportCheques;0)
			
			
			
		: ($vt_accion="BotonImportar")
			
			C_OBJECT:C1216($ob_propiedadesArchivo;$ob_regProcesados)
			C_TIME:C306($ref;$ref2;$vhCreado;$vhModificado)
			C_REAL:C285($vr_montopago)
			C_DATE:C307($vd_fecha_dep;$vdCreadoEn;$vdModificadoEn)
			C_BOOLEAN:C305($lockedCartera;$lockedDPago;$vbBloq;$vbInvisible)
			C_LONGINT:C283($i;$id_alu;$linea;$m;$sum;$vl_idNulo;$vl_idProt;$vl_pos;$vl_turapo;$x;$vl_numFila;$vlTamaño;$vl_dia;$vl_mes;$vl_año)
			C_TEXT:C284($delimiter;$estado;$params;$t_RutaDocumento;$text;$vt_archivo;$vt_id_banco;$vt_id_cheque;$vt_id_cuentas;$vt_no_comprobante;$t_nombreArchivo)
			
			
			
			ARRAY TEXT:C222($at_idBanco;0)
			ARRAY TEXT:C222($at_idCheque;0)
			ARRAY REAL:C219($ar_montoPago;0)
			ARRAY TEXT:C222($at_idCuentas;0)
			ARRAY DATE:C224($ad_fechaDeposito;0)
			ARRAY BOOLEAN:C223($ab_estadoImportacion;0)
			
			
			ARRAY TEXT:C222($at_idBancoCtaBancaria;0)
			ARRAY TEXT:C222($at_nombreBancoCtaBancaria;0)
			ARRAY TEXT:C222($at_numCtaBancaria;0)
			
			
			
			ACTwiz_ImportadorChequesDepo ("declaraciones")
			xBlob:=PREF_fGetBlob (0;"ACT_CtasColegio";xBlob)
			BLOB_Blob2Vars (->xBlob;0;->$at_idBancoCtaBancaria;->$at_nombreBancoCtaBancaria;->$at_numCtaBancaria)
			
			$t_RutaDocumento:=document
			$t_nombreArchivo:=SYS_Path2FileName ($t_RutaDocumento)
			vt_nombreArchivo:=$t_nombreArchivo
			$delimiter:=ACTabc_DetectDelimiter ($t_RutaDocumento)
			$ref:=Open document:C264($t_RutaDocumento;"";Read mode:K24:5)
			
			GET DOCUMENT PROPERTIES:C477($t_RutaDocumento;$vbBloq;$vbInvisible;$vdCreadoEn;$vhCreado;$vdModificadoEn;$vhModificado)
			$vlTamaño:=Get document size:C479($t_RutaDocumento)
			
			
			OB SET:C1220($ob_propiedadesArchivo;"nombreArchivo";$t_nombreArchivo)
			OB SET:C1220($ob_propiedadesArchivo;"fechaCreacion";$vdCreadoEn)
			OB SET:C1220($ob_propiedadesArchivo;"horaCreacion";$vhCreado)
			OB SET:C1220($ob_propiedadesArchivo;"fechaModificacion";$vdModificadoEn)
			OB SET:C1220($ob_propiedadesArchivo;"horaModificacion";$vhModificado)
			OB SET:C1220($ob_propiedadesArchivo;"tamañoArchivoEnByte";$vlTamaño)
			
			$text:=""
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			
			CD_THERMOMETREXSEC (1;0;"Procesando Cheques Depositados...")
			
			$vl_pos:=Position:C15(".";$t_nombreArchivo)
			$vt_no_comprobante:=Substring:C12($t_nombreArchivo;1;$vl_pos-1)
			$vl_numFila:=1
			
			While ($text#"")
				
				$vl_turapo:=Num:C11(Substring:C12($text;1;10))
				$vt_id_cheque:=String:C10(Num:C11(Substring:C12($text;11;10)))
				$vr_montopago:=Num:C11(Substring:C12($text;21;12))
				$vt_id_banco:=Substring:C12($text;33;3)
				$vt_id_cuentas:=String:C10(Num:C11(Substring:C12($text;48;12)))
				$vl_dia:=Num:C11(Substring:C12($text;40;2))
				$vl_mes:=Num:C11(Substring:C12($text;42;2))
				$vl_año:=Num:C11(Substring:C12($text;44;4))
				
				$vd_fecha_dep:=DT_GetDateFromDayMonthYear ($vl_dia;$vl_mes;$vl_año)
				
				READ WRITE:C146([ACT_Documentos_de_Pago:176])
				READ WRITE:C146([ACT_Documentos_en_Cartera:182])
				
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Numero_Doc:6=$vt_id_cheque)
				QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Monto_Doc:7=$vr_montopago)
				QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Doc:5=$vd_fecha_dep)
				
				QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Codigo:2=$vt_id_banco)
				QUERY SELECTION:C341([xxACT_Bancos:129];[xxACT_Bancos:129]Pais:3="cl")
				
				If (Records in selection:C76([ACT_Documentos_en_Cartera:182])>0)
					
					QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
					$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
					$lockedDPago:=Locked:C147([ACT_Documentos_de_Pago:176])
					$estado:=[ACT_Documentos_de_Pago:176]Estado:14
					
					If (Not:C34(($lockedCartera) | ($lockedDPago)))
						
						$vl_idNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
						
						If ([ACT_Documentos_de_Pago:176]id_estado:53#$vl_idNulo)
							
							[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoDepositado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
							[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
							[ACT_Documentos_de_Pago:176]Depositado:35:=True:C214
							[ACT_Documentos_de_Pago:176]En_cartera:34:=False:C215
							[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=$at_nombreBancoCtaBancaria{1}
							[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=$at_idBancoCtaBancaria{1}
							[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=$at_numCtaBancaria{1}
							[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=$vd_fecha_dep
							[ACT_Documentos_de_Pago:176]Depositado_Por:43:=<>tUSR_CurrentUser
							[ACT_Documentos_de_Pago:176]Depositado_no_Comprobante:50:=$vt_no_comprobante
							
							ACTdp_fSave 
							LOG_RegisterEvt ("Depósito de documento Nº "+[ACT_Documentos_de_Pago:176]NoSerie:12+" del banco "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+".")
							KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
							
							DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
							KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
							APPEND TO ARRAY:C911(ACT_ResultadosImportCheques;"Fila Importada OK "+String:C10($vl_numFila)+": cheque con id "+$vt_id_cheque+" del archivo "+$vt_no_comprobante+" con fecha de deposito "+String:C10($vd_fecha_dep)+" fue depositado")
							
							
							APPEND TO ARRAY:C911($at_idCheque;$vt_id_cheque)
							APPEND TO ARRAY:C911($ar_montoPago;$vr_montopago)
							APPEND TO ARRAY:C911($at_idBanco;$vt_id_banco)
							APPEND TO ARRAY:C911($at_idCuentas;$vt_id_cuentas)
							APPEND TO ARRAY:C911($ad_fechaDeposito;$vd_fecha_dep)
							
							APPEND TO ARRAY:C911($ab_estadoImportacion;True:C214)
							
						Else 
							APPEND TO ARRAY:C911(ACT_ResultadosImportCheques;"Fila NO importada "+String:C10($vl_numFila)+": cheque con id "+$vt_id_cheque+" del archivo "+$vt_no_comprobante+" con fecha de deposito "+String:C10($vd_fecha_dep)+" se encuentra nulo")
							
							APPEND TO ARRAY:C911($at_idCheque;$vt_id_cheque)
							APPEND TO ARRAY:C911($ar_montoPago;$vr_montopago)
							APPEND TO ARRAY:C911($at_idBanco;$vt_id_banco)
							APPEND TO ARRAY:C911($at_idCuentas;$vt_id_cuentas)
							APPEND TO ARRAY:C911($ad_fechaDeposito;$vd_fecha_dep)
							
							APPEND TO ARRAY:C911($ab_estadoImportacion;False:C215)
							
						End if 
					Else 
						
						$vl_idProt:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
						If ([ACT_Documentos_de_Pago:176]id_estado:53#$vl_idProt)
							$params:=ST_Concatenate (";";->[ACT_Documentos_en_Cartera:182]ID:1;->[xxACT_Bancos:129]Nombre:1;->$vt_id_banco;->$vt_id_cuentas;->$vd_fecha_dep;-><>tUSR_CurrentUser)
							BM_CreateRequest ("ACT_DepositaCheques";$params)
							APPEND TO ARRAY:C911(ACT_ResultadosImportCheques;"Fila NO importada "+String:C10($vl_numFila)+": cheque con id "+$vt_id_cheque+" del archivo "+$vt_no_comprobante+" con fecha de deposito "+String:C10($vd_fecha_dep)+" se encontro bloqueado , se ha creado tarea batch")
							
							APPEND TO ARRAY:C911($at_idCheque;$vt_id_cheque)
							APPEND TO ARRAY:C911($ar_montoPago;$vr_montopago)
							APPEND TO ARRAY:C911($at_idBanco;$vt_id_banco)
							APPEND TO ARRAY:C911($at_idCuentas;$vt_id_cuentas)
							APPEND TO ARRAY:C911($ad_fechaDeposito;$vd_fecha_dep)
							
							APPEND TO ARRAY:C911($ab_estadoImportacion;False:C215)
							
						End if 
					End if 
					
				Else 
					
					APPEND TO ARRAY:C911(ACT_ResultadosImportCheques;"Fila NO importada "+String:C10($vl_numFila)+": cheque con id "+$vt_id_cheque+" del archivo "+$vt_no_comprobante+" con fecha de deposito "+String:C10($vd_fecha_dep)+" no se encuentra en el sistema")
					
					APPEND TO ARRAY:C911($at_idCheque;$vt_id_cheque)
					APPEND TO ARRAY:C911($ar_montoPago;$vr_montopago)
					APPEND TO ARRAY:C911($at_idBanco;$vt_id_banco)
					APPEND TO ARRAY:C911($at_idCuentas;$vt_id_cuentas)
					APPEND TO ARRAY:C911($ad_fechaDeposito;$vd_fecha_dep)
					
					APPEND TO ARRAY:C911($ab_estadoImportacion;False:C215)
					
				End if 
				
				RECEIVE PACKET:C104($ref;$text;$delimiter)
				CD_THERMOMETREXSEC (0;Get document position:C481($ref)/Get document size:C479($t_RutaDocumento)*100)
				$vl_numFila:=(1+$vl_numFila)
				
			End while 
			
			
			CLOSE DOCUMENT:C267($ref)
			USE CHARACTER SET:C205(*;1)
			
			
			OB SET ARRAY:C1227($ob_regProcesados;"idsCheques";$at_idCheque)
			OB SET ARRAY:C1227($ob_regProcesados;"montosCheques";$ar_montoPago)
			OB SET ARRAY:C1227($ob_regProcesados;"idBancos";$at_idBanco)
			OB SET ARRAY:C1227($ob_regProcesados;"idCuentas";$at_idCuentas)
			OB SET ARRAY:C1227($ob_regProcesados;"estadoImportacion";$ab_estadoImportacion)
			
			ACT_CreaRegistroImportacion ($ob_propiedadesArchivo;-100000;0;$ob_regProcesados;!00-00-00!)
			ACTwiz_ImportadorChequesDepo ("generaTxtResultados")
			
		: ($vt_accion="generaTxtResultados")
			
			If (Size of array:C274(ACT_ResultadosImportCheques)>0)
				
				C_TIME:C306($ref2)
				C_LONGINT:C283($i)
				C_TEXT:C284($vt_ruta;$vt_nombreArch)
				
				If (SYS_IsWindows )
					USE CHARACTER SET:C205("windows-1252";0)
				Else 
					USE CHARACTER SET:C205("MacRoman";0)
				End if 
				
				$vt_ruta:=xfGetDirName ("Detalle importación de Cheques")
				
				If ($vt_ruta#"")
					$vt_nombreArch:="DetalleImportacionChequesDep ["+DTS_Get_GMT_TimeStamp +"].txt"
					$ref2:=Create document:C266($vt_ruta+$vt_nombreArch)
					CD_THERMOMETREXSEC (1;0;"Generando archivo con los resultados de los depositos...")
					For ($i;1;Size of array:C274(ACT_ResultadosImportCheques))
						IO_SendPacket ($ref2;ACT_ResultadosImportCheques{$i}+"\n")
						CD_THERMOMETREXSEC (0;$i/Size of array:C274(ACT_ResultadosImportCheques)*100;"Exportando resultados...")
					End for 
					CD_THERMOMETREXSEC (-1)
					CLOSE DOCUMENT:C267($ref2)
				End if 
				
				USE CHARACTER SET:C205(*;0)
				AT_Initialize (->ACT_ResultadosImportCheques)
				ACTcd_DlogWithShowOnDisk ($vt_ruta+$vt_nombreArch;0;"El archivo "+ST_Qte ($vt_nombreArch)+" fue generado con éxito.\n\nPuede encontrar el archivo en: "+$vt_ruta)
				
			Else 
				CD_Dlog (0;"No hay datos para generar un archivo con el resultado de la importación de los cheques depositados.")
			End if 
			
	End case 
	
End if 
