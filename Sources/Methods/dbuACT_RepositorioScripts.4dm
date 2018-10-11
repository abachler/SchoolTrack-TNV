//%attributes = {}
  //dbuACT_RepositorioScripts
C_POINTER:C301($ptr1)

If (Count parameters:C259>=1)
	C_TEXT:C284($vt_accion)
	$vt_accion:=$1
	If (Count parameters:C259>=2)
		$ptr1:=$2
	End if 
	Case of 
		: ($vt_accion="EmiteNotaDeDebito")
			  //emite NC
			ACTdte_EmiteND 
			
			  //dbuACT_RepositorioScripts ("CreaDteNulo")
		: ($vt_accion="CreaDteNulo")
			C_LONGINT:C283($l_id;$l_folio)
			ACTdte_CreaDctoNulo ($l_id;$l_folio)
			
			  //dbuACT_RepositorioScripts ("limpiaCampoPagadosDesdeAvisos")
		: ($vt_accion="limpiaCampoPagadosDesdeAvisos")
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						ARRAY LONGINT:C221(aQR_Longint1;0)
						C_LONGINT:C283($vl_records;$i)
						$vl_records:=BWR_SearchRecords (->[ACT_Avisos_de_Cobranza:124])
						LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
						If ($vl_records#-1)
							ACTcar_ValidaMontos ("ValidaDesdeArrayRecNumAvisos";->aQR_Longint1)
							CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
							BWR_SelectTableData 
							
							ARRAY LONGINT:C221(aQR_Longint1;0)
						End if 
					End if 
				End if 
			End if 
			
		: ($vt_accion="AplicaCambiosPagados")
			ACTcar_ValidaMontos ("AplicaCambiosPagados")
			
		: ($vt_accion="limpiaCampoPagados")
			  //limpia campos montos pagados en cargos
			READ WRITE:C146([ACT_Cargos:173])
			ALL RECORDS:C47([ACT_Cargos:173])
			dbuACT_RepositorioScripts ("AplicaCambiosPagados")
			
		: ($vt_accion="RecalculaTodosAvisos")
			  //Recalucla todos los avisos de cobranza de la base de datos
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
			ARRAY LONGINT:C221(aQR_Longint1;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1)
			ACTmnu_RecalcularSaldosAvisos (->aQR_Longint1)
			AT_Initialize (->aQR_Longint1)
			
		: ($vt_accion="CargaPanel")
			
		: ($vt_accion="BuscaYCargaBoletasConDecimales")
			  //Carga boletas con decimales
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
						READ ONLY:C145([ACT_Boletas:181])
						READ ONLY:C145([ACT_Transacciones:178])
						ARRAY LONGINT:C221(aQR_Longint1;0)
						ARRAY LONGINT:C221(aQR_Longint2;0)
						ARRAY REAL:C219(aQR_Real1;0)
						C_LONGINT:C283($i;$existe)
						C_TEXT:C284($vt_entero;$vt_decimal;$vt_monto;$vt_formato)
						
						$vt_formato:=ACTutl_GetDecimalFormat ("Despliegue_ACT")
						ALL RECORDS:C47([ACT_Boletas:181])
						SELECTION TO ARRAY:C260([ACT_Boletas:181];aQR_Longint1;[ACT_Boletas:181]Monto_Total:6;aQR_Real1)
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando boletas con problemas...")
						For ($i;1;Size of array:C274(aQR_Longint1))
							$vt_monto:=String:C10(aQR_Real1{$i})
							$existe:=Position:C15(<>tXS_RS_DecimalSeparator;$vt_monto)
							If ($existe>0)
								$vt_entero:=Substring:C12($vt_monto;1;$existe-1)
								$vt_decimal:=Substring:C12($vt_monto;$existe+1)
								If (Length:C16($vt_decimal)><>vlACT_Decimales)
									APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
								End if 
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1);"Buscando boletas con problemas...")
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						CREATE SELECTION FROM ARRAY:C640([ACT_Boletas:181];aQR_Longint2;"")
						CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
						BWR_SelectTableData 
					End if 
				End if 
			End if 
			
		: ($vt_accion="AplicaDecimalesMonedaXPais")
			C_REAL:C285($vr_decimales)
			C_LONGINT:C283(vQR_long1;vQR_Long2;vQR_Long3;vQR_Long4;$proc)
			C_TEXT:C284($vt_moneda)
			ARRAY LONGINT:C221(aQR_Longint1;0)  //rec nums de avisos
			ARRAY LONGINT:C221(aQR_Longint2;0)  //ids documentos de cargo para buscar ids de avisos
			
			READ WRITE:C146([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
			$vr_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda))
			$proc:=IT_UThermometer (1;0;"Aplicando número de decimales a monedas por defecto.")
			
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=$vt_moneda;*)
			QUERY:C277([ACT_Cargos:173]; | ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=False:C215)
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_Documento_de_Cargo:3;aQR_Longint2)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]Saldo:23)  //para ejecutar trigger
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			For (vQR_long1;1;Size of array:C274(aQR_Longint2))
				vQR_Long2:=aQR_Longint2{vQR_long1}
				vQR_Long3:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->vQR_Long2;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				vQR_Long4:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;vQR_Long3)
				If (vQR_Long4#-1)
					APPEND TO ARRAY:C911(aQR_Longint1;vQR_Long4)
				End if 
			End for 
			IT_UThermometer (-2;$proc)
			ACTmnu_RecalcularSaldosAvisos (->aQR_Longint1)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			
		: ($vt_accion="BuscaBoletasConProblemasDeEmision")
			  //dbuACT_RepositorioScripts("BuscaBoletasConProblemasDeEmision")
			If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				If (Application type:C494#4D Server:K5:6)
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
					C_REAL:C285($vr_montoBoleta;$vr_montoEnNC)
					C_LONGINT:C283($i;$x)
					
					READ ONLY:C145([ACT_Boletas:181])
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=!2009-01-01!)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];aQR_Longint1;"")
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando Documentos Tributarios con problemas...")
					For ($i;1;Size of array:C274(aQR_Longint1))
						GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$i})
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
						CREATE SET:C116([ACT_Transacciones:178];"transacciones")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						ARRAY LONGINT:C221(aQR_Longint3;0)
						SELECTION TO ARRAY:C260([ACT_Cargos:173];aQR_Longint3)
						$vr_montoBoleta:=0
						$vr_montoEnNC:=0
						For ($x;1;Size of array:C274(aQR_Longint3))
							GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint3{$x})
							$vr_montoBoleta:=$vr_montoBoleta+ACTbol_GetMontoLinea ("transacciones")
						End for 
						CLEAR SET:C117("transacciones")
						$vr_montoTotal:=[ACT_Boletas:181]Monto_Total:6
						
						If ([ACT_Boletas:181]ID_Categoria:12=-4)
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
							KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
							QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7="Nota de Crédito";*)
							QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
							$vr_montoEnNC:=$vr_montoEnNC-Sum:C1([ACT_Pagos:172]Monto_Pagado:5)
						End if 
						
						
						QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1)
						$vr_montoEnNC:=$vr_montoEnNC+Sum:C1([ACT_Boletas:181]Monto_Total:6)
						
						
						
						If ($vr_montoTotal#($vr_montoBoleta+$vr_montoEnNC))
							APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1);"Buscando Documentos Tributarios con problemas...")
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					CREATE SELECTION FROM ARRAY:C640([ACT_Boletas:181];aQR_Longint2;"")
					dbuACT_RepositorioScripts ("CargaDatosExplorador")
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
				End if 
			Else 
				CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios.")
			End if 
			
		: ($vt_accion="CargaDatosExplorador")
			CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
			BWR_SelectTableData 
			
			
		: ($vt_accion="ReparaConfiguraciónDTS")
			C_TEXT:C284($vt_cat)
			C_LONGINT:C283($i)
			ACTcfg_LoadConfigData (8)
			ACTbol_LeeListaDocsTribs ("LeeLista")
			
			If (Size of array:C274(alACT_CategoriasDctos)>0)
				$vt_cat:="Recibo@"
				atACT_Categorias{0}:=$vt_cat
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACT_Categorias;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)=0)
					$vt_cat:="Boleta@"
					atACT_Categorias{0}:=$vt_cat
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->atACT_Categorias;"=";->$DA_Return)
				End if 
				If (Size of array:C274($DA_Return)>0)
					ARRAY LONGINT:C221($DA_Return2;0)
					atACT_Cats{0}:=$vt_cat
					AT_SearchArray (->atACT_Cats;"=";->$DA_Return2)
					For ($i;1;Size of array:C274($DA_Return2))
						alACT_IDCat{$DA_Return2{$i}}:=alACT_CategoriasDctos{1}
						atACT_Cats{$DA_Return2{$i}}:=atACT_CategoriasDctos{1}
					End for 
					For ($i;1;Size of array:C274($DA_Return))
						alACT_IDsCats{$DA_Return{$i}}:=alACT_CategoriasDctos{1}
						atACT_Categorias{$DA_Return{$i}}:=atACT_CategoriasDctos{1}
					End for 
				End if 
				
				$vt_cat:="Letra@"
				atACT_Categorias{0}:=$vt_cat
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACT_Categorias;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					ARRAY LONGINT:C221($DA_Return2;0)
					atACT_Cats{0}:=$vt_cat
					AT_SearchArray (->atACT_Cats;"=";->$DA_Return2)
					For ($i;1;Size of array:C274($DA_Return2))
						alACT_IDCat{$DA_Return2{$i}}:=alACT_CategoriasDctos{2}
						atACT_Cats{$DA_Return2{$i}}:=atACT_CategoriasDctos{2}
					End for 
					For ($i;1;Size of array:C274($DA_Return))
						alACT_IDsCats{$DA_Return{$i}}:=alACT_CategoriasDctos{2}
						atACT_Categorias{$DA_Return{$i}}:=atACT_CategoriasDctos{2}
					End for 
				End if 
				
				$vt_cat:="Factura@"
				atACT_Categorias{0}:=$vt_cat
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACT_Categorias;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					ARRAY LONGINT:C221($DA_Return2;0)
					atACT_Cats{0}:=$vt_cat
					AT_SearchArray (->atACT_Cats;"=";->$DA_Return2)
					For ($i;1;Size of array:C274($DA_Return2))
						alACT_IDCat{$DA_Return2{$i}}:=alACT_CategoriasDctos{3}
						atACT_Cats{$DA_Return2{$i}}:=atACT_CategoriasDctos{3}
					End for 
					For ($i;1;Size of array:C274($DA_Return))
						alACT_IDsCats{$DA_Return{$i}}:=alACT_CategoriasDctos{3}
						atACT_Categorias{$DA_Return{$i}}:=atACT_CategoriasDctos{3}
					End for 
				End if 
				
				$vt_cat:="Nota de Cr@"
				atACT_Categorias{0}:=$vt_cat
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACT_Categorias;"=";->$DA_Return)
				If (Size of array:C274($DA_Return)>0)
					ARRAY LONGINT:C221($DA_Return2;0)
					atACT_Cats{0}:=$vt_cat
					AT_SearchArray (->atACT_Cats;"=";->$DA_Return2)
					For ($i;1;Size of array:C274($DA_Return2))
						alACT_IDCat{$DA_Return2{$i}}:=alACT_CategoriasDctos{4}
						atACT_Cats{$DA_Return2{$i}}:=atACT_CategoriasDctos{4}
					End for 
					For ($i;1;Size of array:C274($DA_Return))
						alACT_IDsCats{$DA_Return{$i}}:=alACT_CategoriasDctos{4}
						atACT_Categorias{$DA_Return{$i}}:=atACT_CategoriasDctos{4}
					End for 
				End if 
				ACTcfg_SaveConfig (8)
			End if 
			
		: ($vt_accion="ReparaCategoriasEnItems")
			READ ONLY:C145([xxACT_ItemsCategorias:98])
			READ ONLY:C145([xxACT_Items:179])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8#0)
			CREATE SET:C116([xxACT_Items:179];"setItems1")
			KRL_RelateSelection (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;"")
			KRL_RelateSelection (->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]ID:2;"")
			CREATE SET:C116([xxACT_Items:179];"setItems2")
			DIFFERENCE:C122("setItems1";"setItems2";"setItems1")
			If (Records in set:C195("setItems1")>0)
				READ WRITE:C146([xxACT_Items:179])
				USE SET:C118("setItems1")
				APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8:=0)
				KRL_UnloadReadOnly (->[xxACT_Items:179])
			End if 
			SET_ClearSets ("setItems1";"setItems2")
			
		: ($vt_accion="CreaCtasCtesDesdeAlumnos")
			  //script que crea cuentas corrientes a alumnos para los cuales la cuenta no fue creada debido a que eran egresados
			If (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				READ WRITE:C146([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Alumnos:2])
				ARRAY LONGINT:C221(al_rnAlumnos;0)
				C_LONGINT:C283($i;$records)
				ACTcfg_LoadConfigData (1)
				$records:=BWR_SearchRecords 
				If ($records>0)
					LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];al_rnAlumnos;"")
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"En Proceso")
					For ($i;1;Size of array:C274(al_rnAlumnos))
						GOTO RECORD:C242([Alumnos:2];al_rnAlumnos{$i})
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
						If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
							If ([Alumnos:2]numero:1#0)
								CREATE RECORD:C68([ACT_CuentasCorrientes:175])
								[ACT_CuentasCorrientes:175]ID_Alumno:3:=[Alumnos:2]numero:1
								[ACT_CuentasCorrientes:175]ID_Familia:2:=[Alumnos:2]Familia_Número:24
								[ACT_CuentasCorrientes:175]ID_Apoderado:9:=[Alumnos:2]Apoderado_Cuentas_Número:28
								[ACT_CuentasCorrientes:175]Estado:4:=True:C214
								[ACT_CuentasCorrientes:175]Numero_Hijo:10:=0
								[ACT_CuentasCorrientes:175]AfectoIntereses:28:=False:C215
								SAVE RECORD:C53([ACT_CuentasCorrientes:175])
								UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
							End if 
						End if 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_rnAlumnos))
					End for 
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				Else 
					CD_Dlog (0;"Debe seleccionar al menos un alumno.")
				End if 
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				AT_Initialize (->al_rnAlumnos)
			End if 
			
		: ($vt_accion="BuscaAvisosConProblemasEnPagos")
			  //dbuACT_RepositorioScripts ("BuscaAvisosConProblemasEnPagos")
			If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				C_LONGINT:C283($vl_numeroT;$i)
				C_REAL:C285($neto)
				ACTcfg_LeeBlob ("ACTcfg_MonedasYTasas")
				READ ONLY:C145([ACT_Cargos:173])
				READ ONLY:C145([ACT_Transacciones:178])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=!2009-01-01!)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23=0)
				ARRAY LONGINT:C221(aQR_Longint1;0)
				ARRAY LONGINT:C221(aQR_Longint2;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando cargos...")
				For ($i;1;Size of array:C274(aQR_Longint2))
					GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint2{$i})
					SET QUERY LIMIT:C395(1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_numeroT)
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					SET QUERY LIMIT:C395(0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($vl_numeroT>0)
						$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						If ([ACT_Cargos:173]MontosPagadosMPago:52<Round:C94($neto;0))
							APPEND TO ARRAY:C911(aQR_Longint1;aQR_Longint2{$i})
						End if 
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint2);"Buscando cargos...")
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aQR_Longint1;"")
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				dbuACT_RepositorioScripts ("CargaDatosExplorador")
				ARRAY LONGINT:C221(aQR_Longint1;0)
				ARRAY LONGINT:C221(aQR_Longint2;0)
			End if 
			
		: ($vt_accion="ReparaMontoMonedaPagoEnTransacciones")
			  //en greenland encontré 2 transacciones que tenían montos con decimales en este campo...
			  //dbuACT_RepositorioScripts("ReparaMontoMonedaPagoEnTransacciones")
			C_LONGINT:C283(vQR_Long1;vQR_Long2;vQR_Long3)
			C_TEXT:C284(vQR_Text1)
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			READ ONLY:C145([ACT_Transacciones:178])
			vQR_Text1:=ST_GetWord (ACT_DivisaPais ;1;";")
			vQR_Long2:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->vQR_Text1))
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]MontoMonedaPago:14#0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]MontoMonedaPago:14;aQR_Real1;[ACT_Transacciones:178];aQR_Longint1)
			For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
				APPEND TO ARRAY:C911(aQR_Text1;String:C10(aQR_Real1{vQR_Long1}))
			End for 
			vQR_Long3:=IT_UThermometer (1;0;"Ejecutando script")
			aQR_Text1{0}:=<>tXS_RS_DecimalSeparator
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->aQR_Text1;"@";->$DA_Return)
			For (vQR_Long1;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$DA_Return{vQR_Long1}})
			End for 
			READ WRITE:C146([ACT_Transacciones:178])
			CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];aQR_Longint2;"")
			
			  //20130513 RCH recalcular AC...
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]No_Comprobante:10;$al_idsAC)
			
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94(([ACT_Transacciones:178]Debito:6*[ACT_Transacciones:178]ValorMoneda:13);vQR_Long2))
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			
			IT_UThermometer (0;vQR_Long3;"Recalculando Avisos...")
			
			  //20130513 RCH recalcular AC...
			AT_DistinctsArrayValues (->$al_idsAC)
			For ($l_indiceAC;1;Size of array:C274($al_idsAC))
				$l_recNumAC:=KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$al_idsAC{$l_indiceAC})
				ACTac_Recalcular ($l_recNumAC)
			End for 
			IT_UThermometer (-2;vQR_Long3)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			
		: ($vt_accion="AsignaIdsXDefectoABoletas")
			  //dbuACT_RepositorioScripts ("AsignaIdsXDefectoABoletas")  `asignaCategoríasDctosXDefectoABoletasEmitidas
			C_LONGINT:C283($el)
			C_BOOLEAN:C305($ok)
			ACTcfg_LoadConfigData (8)
			
			$el:=Find in array:C230(alACT_IDsCats;-1)
			If ($el=-1)
				$el:=Find in array:C230(atACT_Categorias;"Boleta@")
				If ($el=-1)
					$el:=Find in array:C230(atACT_Categorias;"Recibo@")
				End if 
			End if 
			If ($el#-1)
				$ok:=ACTcfg_SearchCatDocs (alACT_IDsCats{$el})
				If ($ok)
					READ WRITE:C146([ACT_Boletas:181])
					Case of 
						: (<>gCountryCode="mx")
							ALL RECORDS:C47([ACT_Boletas:181])
							APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13:=alACT_IDDT{vlACT_IndexExenta1})
						Else 
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Monto_IVA:5>0)
							APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13:=alACT_IDDT{vlACT_IndexAfecta1})
							
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Monto_IVA:5=0)
							APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13:=alACT_IDDT{vlACT_IndexExenta1})
					End case 
					KRL_UnloadReadOnly (->[ACT_Boletas:181])
				Else 
					CD_Dlog (0;"Las categorías de documentos no están correctamente configuradas.")
				End if 
			End if 
			
		: ($vt_accion="ReparaIDSCatEnItems")
			  //dbuACT_RepositorioScripts ("ReparaIDSCatEnItems")  `quita ids inexistentes de categorias en items
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([xxACT_ItemsCategorias:98])
			QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8#0)
			CREATE SET:C116([xxACT_Items:179];"xxACT_ItemsConID")
			KRL_RelateSelection (->[xxACT_ItemsCategorias:98]ID:2;->[xxACT_Items:179]ID_Categoria:8;"")
			KRL_RelateSelection (->[xxACT_Items:179]ID_Categoria:8;->[xxACT_ItemsCategorias:98]ID:2;"")
			CREATE SET:C116([xxACT_Items:179];"xxACT_ItemsConID2")
			DIFFERENCE:C122("xxACT_ItemsConID";"xxACT_ItemsConID2";"xxACT_ItemsConID")
			READ WRITE:C146([xxACT_Items:179])
			USE SET:C118("xxACT_ItemsConID")
			APPLY TO SELECTION:C70([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8:=0)
			KRL_UnloadReadOnly (->[xxACT_Items:179])
			CLEAR SET:C117("xxACT_ItemsConID")
			CLEAR SET:C117("xxACT_ItemsConID2")
			
		: ($vt_accion="BuscaDTConProblemasXPeríodo")
			  //dbuACT_RepositorioScripts ("BuscaDTConProblemasXPeríodo")
			If (Application type:C494#4D Server:K5:6)
				If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
					C_REAL:C285($vr_montoBoleta)
					C_LONGINT:C283($i;$x)
					
					READ ONLY:C145([ACT_Boletas:181])
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					
					SRACT_SelFecha (4)
					If (ok=1)
						QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=vd_fecha1;*)
						QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=vd_fecha2)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];aQR_Longint1;"")
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando Documentos Tributarios con problemas...")
						For ($i;1;Size of array:C274(aQR_Longint1))
							GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$i})
							KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"transacciones")
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							ARRAY LONGINT:C221(aQR_Longint3;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173];aQR_Longint3)
							$vr_montoBoleta:=0
							For ($x;1;Size of array:C274(aQR_Longint3))
								GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint3{$x})
								If ([ACT_Cargos:173]Ref_Item:16#-129)
									$vr_montoBoleta:=$vr_montoBoleta+ACTbol_GetMontoLinea ("transacciones")
								End if 
							End for 
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1)
							$vr_montoBoleta:=$vr_montoBoleta+Sum:C1([ACT_Boletas:181]Monto_Total:6)
							GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$i})
							CLEAR SET:C117("transacciones")
							If ([ACT_Boletas:181]Monto_Total:6#$vr_montoBoleta)
								APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1);"Buscando Documentos Tributarios con problemas...")
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						CREATE SELECTION FROM ARRAY:C640([ACT_Boletas:181];aQR_Longint2;"")
						dbuACT_RepositorioScripts ("CargaDatosExplorador")
						ARRAY LONGINT:C221(aQR_Longint1;0)
						ARRAY LONGINT:C221(aQR_Longint2;0)
						ARRAY LONGINT:C221(aQR_Longint3;0)
					End if 
				Else 
					CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios.")
				End if 
			End if 
			
		: ($vt_accion="BuscaAvisosNoCompletosEnDTXPeríodo")
			  //dbuACT_RepositorioScripts ("BuscaAvisosNoCompletosEnDTXPeríodo")
			If (Application type:C494#4D Server:K5:6)
				If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
					SRACT_SelFecha (4)
					If (ok=1)
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_Boletas:181])
						
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=vd_fecha1;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=vd_fecha2)
						CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"SetAvisosCobranza")
						QR_DeclareGenericArrays 
						AT_DistinctsFieldValues (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->aQR_Longint1)
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Ejecutando script...")
						For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
							USE SET:C118("SetAvisosCobranza")
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint1{vQR_Long1})
							SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aQR_Longint2)
							KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
							KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
							CREATE SET:C116([ACT_Boletas:181];"ACT_Boletas1")
							QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7="Boleta@")
							vQR_Real2:=Sum:C1([ACT_Boletas:181]Monto_Total:6)
							USE SET:C118("ACT_Boletas1")
							QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7="Nota de @")
							vQR_Real3:=Sum:C1([ACT_Boletas:181]Monto_Total:6)
							vQR_Real3:=0
							CLEAR SET:C117("ACT_Boletas1")
							vQR_Real2:=vQR_Real2-vQR_Real3
							vQR_Real1:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->aQR_Longint2;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							If (vQR_Real1#vQR_Real2)
								APPEND TO ARRAY:C911(aQR_Longint3;aQR_Longint1{vQR_Long1})
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_Long1/Size of array:C274(aQR_Longint1);"Ejecutando script...")
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						USE SET:C118("SetAvisosCobranza")
						QRY_QueryWithArray (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->aQR_Longint3;True:C214)
						dbuACT_RepositorioScripts ("CargaDatosExplorador")
						
						CLEAR SET:C117("SetAvisosCobranza")
						QR_DeclareGenericArrays 
					End if 
				Else 
					CD_Dlog (0;"Utilice este script desde la pestaña Avisos de cobranza.")
				End if 
			End if 
			
		: ($vt_accion="STR_BuscaAsignaturasDuplicadas")
			  //dbuACT_RepositorioScripts ("STR_BuscaAsignaturasDuplicadas")
			  //READ ONLY([Alumnos])
			  //READ ONLY([Alumnos_Histórico])
			  //READ ONLY([Alumnos_Calificaciones])
			  //
			  //ARRAY LONGINT(aQR_Longint1;0)
			  //ARRAY LONGINT(aQR_Longint2;0)
			  //ARRAY LONGINT(aQR_Longint3;0)
			  //ARRAY INTEGER(aQR_Integer1;0)
			  //ARRAY TEXT(aQR_Text1;0)
			  //
			  //QUERY([Alumnos];[Alumnos]Nivel_Número=12)
			  //LONGINT ARRAY FROM SELECTION([Alumnos];aQR_Longint1;"")
			  //
			  //vQR_Text1:=SYS_SelectFolder 
			  //If (vQR_Text1#"")
			  //vQR_Text2:=vQR_Text1+"AsignaturasDuplicadas4oMedio.txt"
			  //
			  //EM_ErrorManager ("Install")
			  //EM_ErrorManager ("SetMode";"")
			  //If (SYS_TestPathName (vQR_Text2)=1)
			  //DELETE DOCUMENT(vQR_Text2)
			  //End if 
			  //If (ok=1)
			  //vQR_Time1:=Create document(vQR_Text2;"TEXT")
			  //
			  //For (vQR_Long1;1;Size of array(aQR_Longint1))
			  //vQR_Long4:=aQR_Longint1{vQR_Long1}
			  //GOTO RECORD([Alumnos];vQR_Long4)
			  //vQR_Long6:=[Alumnos]Número
			  //QUERY([Alumnos_Histórico];[Alumnos_Histórico]Alumno_Numero=vQR_Long6)
			  //SELECTION TO ARRAY([Alumnos_Histórico]Año;aQR_Integer1)
			  //For (vQR_Long2;1;Size of array(aQR_Integer1))
			  //`EV2_RegistrosDelAlumno (vQR_Long6;False;aQR_Integer1{vQR_Long2})
			  //SET AUTOMATIC RELATIONS(True;False)
			  //QUERY SELECTION([Alumnos_Calificaciones];[Asignaturas_Histórico]Incluida_En_Actas=True)
			  //SELECTION TO ARRAY([Alumnos_Calificaciones];aQR_Longint3;[Asignaturas_Histórico]Asignatura;aQR_Text1)
			  //SET AUTOMATIC RELATIONS(False;False)
			  //
			  //For (vQR_Long3;1;Size of array(aQR_Text1))
			  //If (aQR_Text1{vQR_Long3}#"")
			  //aQR_Text1{0}:=aQR_Text1{vQR_Long3}
			  //AT_SearchArray (->aQR_Text1;"=")
			  //If (Size of array(DA_Return)>1)
			  //vQR_Text3:="Alumno "+KRL_GetTextFieldData (->[Alumnos]Número;->vQR_Long6;->[Alumnos]Apellidos_y_Nombres)
			  //vQR_Text3:=vQR_Text3+"\t"+"Año: "+String(aQR_Integer1{vQR_Long2})
			  //vQR_Text3:=vQR_Text3+"\t"+"Asignatura: "+aQR_Text1{vQR_Long3}+"\r"
			  //IO_SendPacket (vQR_Time1;vQR_Text3)
			  //End if 
			  //For (vQR_Long5;1;Size of array(DA_Return))
			  //aQR_Text1{DA_Return{vQR_Long5}}:=""
			  //End for 
			  //End if 
			  //End for 
			  //End for 
			  //End for 
			  //CLOSE DOCUMENT(vQR_Time1)
			  //ACTcd_DlogWithShowOnDisk (vQR_Text2;0;"Archivo con resultados en la siguiente ruta: "+vQR_Text2)
			  //Else 
			  //vtACT_document:=""
			  //End if 
			  //EM_ErrorManager ("Clear")
			  //End if 
			
		: ($vt_accion="DeclaraArreglos")
			ARRAY LONGINT:C221(alBWR_recNumsSel1_1;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_2;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_3;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_4;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_5;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_6;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_7;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_8;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_9;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_10;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_11;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_12;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_13;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_14;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_15;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_16;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_17;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_18;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_19;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_20;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_21;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_22;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_23;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_24;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_25;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_26;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_27;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_28;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_29;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_30;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_31;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_32;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_33;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_34;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_35;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_36;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_37;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_38;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_39;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_40;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_41;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_42;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_43;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_44;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_45;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_46;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_47;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_48;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_49;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_50;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_51;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_52;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_53;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_54;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_55;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_56;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_57;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_58;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_59;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_60;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_61;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_62;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_63;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_64;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_65;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_66;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_67;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_68;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_69;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_70;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_71;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_72;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_73;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_74;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_75;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_76;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_77;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_78;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_79;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_80;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_81;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_82;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_83;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_84;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_85;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_86;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_87;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_88;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_89;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_90;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_91;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_92;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_93;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_94;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_95;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_96;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_97;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_98;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_99;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_100;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_101;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_102;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_103;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_104;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_105;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_106;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_107;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_108;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_109;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_110;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_111;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_112;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_113;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_114;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_115;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_116;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_117;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_118;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_119;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_120;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_121;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_122;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_123;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_124;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_125;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_126;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_127;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_128;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_129;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_130;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_131;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_132;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_133;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_134;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_135;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_136;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_137;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_138;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_139;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_140;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_141;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_142;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_143;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_144;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_145;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_146;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_147;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_148;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_149;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_150;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_151;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_152;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_153;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_154;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_155;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_156;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_157;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_158;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_159;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_160;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_161;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_162;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_163;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_164;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_165;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_166;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_167;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_168;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_169;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_170;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_171;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_172;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_173;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_174;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_175;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_176;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_177;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_178;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_179;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_180;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_181;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_182;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_183;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_184;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_185;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_186;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_187;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_188;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_189;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_190;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_191;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_192;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_193;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_194;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_195;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_196;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_197;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_198;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_199;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_200;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_201;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_202;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_203;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_204;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_205;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_206;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_207;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_208;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_209;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_210;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_211;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_212;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_213;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_214;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_215;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_216;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_217;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_218;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_219;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_220;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_221;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_222;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_223;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_224;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_225;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_226;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_227;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_228;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_229;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_230;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_231;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_232;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_233;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_234;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_235;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_236;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_237;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_238;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_239;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_240;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_241;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_242;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_243;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_244;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_245;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_246;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_247;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_248;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_249;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_250;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_251;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_252;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_253;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_254;0)
			ARRAY LONGINT:C221(alBWR_recNumsSel1_255;0)
			
		: ($vt_accion="GuardaSel")
			$ptr:=Get pointer:C304("alBWR_recNumsSel1_"+String:C10(Table:C252(yBWR_currentTable)))
			COPY ARRAY:C226(alBWR_recordNumber;$ptr->)
			
		: ($vt_accion="CargaSel")
			$ptr:=Get pointer:C304("alBWR_recNumsSel1_"+String:C10(Table:C252(yBWR_currentTable)))
			CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;$ptr->;"")
			dbuACT_RepositorioScripts ("CargaDatosExplorador")
			
		: ($vt_accion="VerificaSaldoCargos")
			  //dbuACT_RepositorioScripts ("VerificaSaldoCargos")
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
						
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=!2009-01-01!)
						
						C_LONGINT:C283($i)
						ARRAY LONGINT:C221($aQR_Longint1;0)
						ARRAY LONGINT:C221($aQR_Longint2;0)
						ARRAY REAL:C219($aQR_Real1;0)
						ARRAY REAL:C219($aQR_Real2;0)
						ARRAY REAL:C219($aQR_Real3;0)
						
						SELECTION TO ARRAY:C260([ACT_Cargos:173];$aQR_Longint1;[ACT_Cargos:173]Monto_Neto:5;$aQR_Real1;[ACT_Cargos:173]MontosPagados:8;$aQR_Real2;[ACT_Cargos:173]Saldo:23;$aQR_Real3)
						
						For ($i;1;Size of array:C274($aQR_Longint1))
							Case of 
								: (($aQR_Real2{$i}-$aQR_Real1{$i})#$aQR_Real3{$i})
									APPEND TO ARRAY:C911($aQR_Longint2;$aQR_Longint1{$i})
									
								: (Abs:C99($aQR_Real1{$i})<Abs:C99($aQR_Real3{$i}))
									APPEND TO ARRAY:C911($aQR_Longint2;$aQR_Longint1{$i})
									
							End case 
						End for 
						
						CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$aQR_Longint2;"")
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
						dbuACT_RepositorioScripts ("CargaDatosExplorador")
						
						ARRAY LONGINT:C221($aQR_Longint1;0)
						ARRAY LONGINT:C221($aQR_Longint2;0)
						ARRAY REAL:C219($aQR_Real1;0)
						ARRAY REAL:C219($aQR_Real2;0)
						ARRAY REAL:C219($aQR_Real3;0)
					End if 
				End if 
			End if 
			
		: ($vt_accion="CodigoParaBuscarCamposConProblemas")
			  //Yo abro el archivo 1 en excel, hago un filtro avanzado solo con registros unicos y luego comparo con el archivo 2.
			  //$path1:=xfGetDirName 
			  //If (ok=1)
			  //$table:=Table(Table($1))
			  //READ ONLY($table->)
			  //ALL RECORDS($table->)
			  //SELECTION TO ARRAY($1->;$ax_campo)
			  //$path:=$path1+"archivo1.txt"
			  //$docRef:=Create document($path)
			  //SORT ARRAY($ax_campo;>)
			  //$type:=Type($ax_campo)
			  //For ($i;1;Size of array($ax_campo))
			  //$vt_valor:=""
			  //Case of 
			  //: (($type=LongInt array ) | ($type=Integer array ) | ($type=Real array ))
			  //$vt_valor:=String($ax_campo{$i})
			  //: ($type=Date array )
			  //$vt_valor:=:=String($ax_campo{$i})
			  //: (($Type=String array ) | ($type=Text array ))
			  //$vt_valor:=:=$ax_campo{$i}
			  //: ($type=Boolean array )
			  //$vt_valor:=:=String((Num($ax_campo{$i})=1))
			  //End case 
			  //IO_SendPacket ($docRef;$vt_valor+"\r")
			  //End for 
			  //CLOSE DOCUMENT($docRef)
			  //ARRAY LONGINT($al_veces;0)
			  //AT_DistinctsArrayValues (->$ax_campo)
			  //For ($i;1;Size of array($ax_campo))
			  //QUERY($table->;$1->=$ax_campo{$i})
			  //APPEND TO ARRAY($al_veces;Records in selection($table->))
			  //End for 
			  //$path:=$path1+"archivo2.txt"
			  //$docRef:=Create document($path)
			  //SORT ARRAY($ax_campo;$al_veces;>)
			  //For ($i;1;Size of array($ax_campo))
			  //$vt_valor:=""
			  //Case of 
			  //: (($type=LongInt array ) | ($type=Integer array ) | ($type=Real array ))
			  //$vt_valor:=String($ax_campo{$i})
			  //: ($type=Date array )
			  //$vt_valor:=:=String($ax_campo{$i})
			  //: (($Type=String array ) | ($type=Text array ))
			  //$vt_valor:=:=$ax_campo{$i}
			  //: ($type=Boolean array )
			  //$vt_valor:=:=String((Num($ax_campo{$i})=1))
			  //End case 
			  //IO_SendPacket ($docRef;$vt_valor+"\t"+String($al_veces{$i})+"\r")
			  //End for 
			  //CLOSE DOCUMENT($docRef)
			  //End if 
			
		: ($vt_accion="ReparaTransaccionesYMontosPagadosMPagoEnCargos")
			  //dbuACT_RepositorioScripts ("ReparaTransaccionesYMontosPagadosMPagoEnCargos")
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Pagos:172])
			
			$vd_fecha1:=!2009-01-01!
			$vd_fecha2:=!2010-12-31!
			  //
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fecha2)
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			
			ARRAY REAL:C219($ar_montos;0)
			ARRAY LONGINT:C221($al_recNums1;0)
			ARRAY LONGINT:C221($al_recNums2;0)
			ARRAY TEXT:C222($at_montos;0)
			ARRAY LONGINT:C221($al_idItem;0)
			
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]MontoMonedaPago:14;$ar_montos;[ACT_Transacciones:178];$al_recNums1)
			For ($i;1;Size of array:C274($ar_montos))
				APPEND TO ARRAY:C911($at_montos;String:C10($ar_montos{$i}))
				If (Position:C15(<>tXS_RS_DecimalSeparator;$at_montos{Size of array:C274($at_montos)})>0)
					APPEND TO ARRAY:C911($al_recNums2;$al_recNums1{$i})
				End if 
			End for 
			
			  //KRL_RelateSelection (->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Transacciones]No_Comprobante;"")
			  //KRL_RelateSelection (->[ACT_Pagos]ID;->[ACT_Transacciones]ID_Pago;"")
			
			$vQR_Text1:=ST_GetWord (ACT_DivisaPais ;1;";")
			$vQR_Long2:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vQR_Text1))
			READ WRITE:C146([ACT_Transacciones:178])
			CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNums2;"")
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]ValorMoneda:13;$al_valorMoneda;[ACT_Transacciones:178]MontoMonedaPago:14;$ar_montoM;[ACT_Transacciones:178]ID_Item:3;$al_idItem)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94(([ACT_Transacciones:178]Debito:6*[ACT_Transacciones:178]ValorMoneda:13);$vQR_Long2))
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			
			ARRAY LONGINT:C221($al_idItem;0)
			  //READ ONLY([ACT_Cargos])
			  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=1233)
			  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=507)
			  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=655)
			  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Apoderado=942)
			CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_recNums2;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idItem)
			dbuACT_RepositorioScripts ("ReparaCargos";->$al_idItem)
			
		: ($vt_accion="ReparaCargos")
			ARRAY LONGINT:C221($al_idItem;0)
			COPY ARRAY:C226($ptr1->;$al_idItem)
			
			ARRAY REAL:C219($ar_monto1;0)
			ARRAY REAL:C219($ar_monto2;0)
			For ($i;1;Size of array:C274($al_idItem))
				READ WRITE:C146([ACT_Cargos:173])
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=$al_idItem{$i})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
				ARRAY LONGINT:C221($al_recNum;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
				If ([ACT_Cargos:173]MontosPagados:8=0)
					[ACT_Cargos:173]MontosPagados:8:=Sum:C1([ACT_Transacciones:178]Debito:6)
				End if 
				APPEND TO ARRAY:C911($ar_monto1;[ACT_Cargos:173]MontosPagadosMPago:52)
				[ACT_Cargos:173]MontosPagadosMPago:52:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6)
				APPEND TO ARRAY:C911($ar_monto2;[ACT_Cargos:173]MontosPagadosMPago:52)
				If ([ACT_Cargos:173]MontosPagadosMPago:52=0)
					[ACT_Cargos:173]MontosPagados:8:=0
				End if 
				SAVE RECORD:C53([ACT_Cargos:173])
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
			End for 
			  //CANCEL TRANSACTION
			SET TEXT TO PASTEBOARD:C523(AT_array2text (->$ar_monto1;"\r"))
			TRACE:C157
			SET TEXT TO PASTEBOARD:C523(AT_array2text (->$ar_monto2;"\r"))
			TRACE:C157
			
		: ($vt_accion="LimpiaCampoNoBoletaEnTransacciones")
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Boletas:181])
			C_LONGINT:C283($proc)
			
			$proc:=IT_UThermometer (1;0;"Reparando número de boleta en transacciones...")
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			CREATE SET:C116([ACT_Transacciones:178];"Transacciones1")
			KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
			CREATE SET:C116([ACT_Transacciones:178];"Transacciones2")
			DIFFERENCE:C122("Transacciones1";"Transacciones2";"Transacciones1")
			
			READ WRITE:C146([ACT_Transacciones:178])
			USE SET:C118("Transacciones1")
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			SET_ClearSets ("Transacciones1";"Transacciones2")
			IT_UThermometer (-2;$proc)
			
			REDUCE SELECTION:C351([ACT_Transacciones:178];0)
			REDUCE SELECTION:C351([ACT_Boletas:181];0)
			
		: ($vt_accion="CodigoBuscaRegistrosDañadosBD")
			  //SOPORTE_DB2clipboard 
			  //KRL_CheckAndFix_Database 
			
			READ ONLY:C145([Alumnos_Calificaciones:208])
			READ ONLY:C145([Alumnos:2])
			
			ALL RECORDS:C47([Alumnos_Calificaciones:208])
			ARRAY LONGINT:C221(aQR_Longint1;0)
			DISTINCT VALUES:C339([Alumnos_Calificaciones:208]ID_Alumno:6;aQR_Longint1)
			
			ALL RECORDS:C47([Alumnos:2])
			ARRAY LONGINT:C221(aQR_Longint2;0)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aQR_Longint2)
			
			ARRAY LONGINT:C221(aQR_Longint3;0)
			AT_Difference (->aQR_Longint1;->aQR_Longint2;->aQR_Longint3)
			C_LONGINT:C283($i)
			For ($i;1;Size of array:C274(aQR_Longint3))
				ALERT:C41("Difference 1: "+String:C10(aQR_Longint3{$i})+"  "+String:C10($i)+" de "+String:C10(Size of array:C274(aQR_Longint3)))
				If (Shift down:C543)
					$i:=Size of array:C274(aQR_Longint3)
				End if 
			End for 
			
			  //READ ONLY([Alumnos])
			  //QUERY([Alumnos];[Alumnos]Número=491)
			  //QUERY WITH ARRAY([Alumnos]Número;aQR_Longint3)
			
			  //IO_ExportRecordsFromOneTable (->[Alumnos])
			  //IO_ImportRecords2OneTable (->[Alumnos])
			
		: ($vt_accion="VerificaIntegridadPagos_Cargos_DocCartera")
			  //dbuACT_RepositorioScripts ("VerificaIntegridadPagos_Cargos_DocCartera")
			If (Not:C34(In transaction:C397))
				C_TEXT:C284($vt_document;$vt_text)
				C_TIME:C306($ref)
				$vt_document:=xfGetDirName 
				If ($vt_document#"")
					START TRANSACTION:C239
					C_LONGINT:C283($i;$j;$tomadosTransacciones;$vl_recordsLocked;$vl_Proc)
					C_BOOLEAN:C305($lockedCargos;$vb_abort)
					
					$vl_Proc:=IT_UThermometer (1;0;"Ejecutando script...")
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
					CREATE SET:C116([ACT_Transacciones:178];"setT1")
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1)
					CREATE SET:C116([ACT_Transacciones:178];"setT2")
					DIFFERENCE:C122("setT1";"setT2";"setT1")
					READ WRITE:C146([ACT_Transacciones:178])
					
					  //elimino relacion con cargos
					USE SET:C118("setT1")
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Pago:4;aQR_Longint1)
					For ($i;1;Size of array:C274(aQR_Longint1))
						USE SET:C118("setT1")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=aQR_Longint1{$i})
						ARRAY LONGINT:C221(aQR_Longint3;0)
						ARRAY LONGINT:C221(aQR_Longint4;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint3;"")
						$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->aQR_Longint3;->aQR_Longint4)
						$tomadosTransacciones:=ACTpgs_DesasignaIdTransaccion (->aQR_Longint3)
						For ($j;1;Size of array:C274(aQR_Longint4))
							If (Find in array:C230(aQR_Longint2;aQR_Longint4{$j})=-1)
								APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint4{$j})
							End if 
						End for 
						If (($lockedCargos) | ($tomadosTransacciones>0))
							$i:=Size of array:C274(aQR_Longint1)
							$vb_abort:=True:C214
						End if 
					End for 
					If (Not:C34($vb_abort))
						For ($i;1;Size of array:C274(aQR_Longint2))
							ACTac_Recalcular (aQR_Longint2{$i})
						End for 
						ACTcar_ValidaMontos ("ValidaDesdeArrayRecNumAvisos";->aQR_Longint2)
						SET_ClearSets ("setT1";"setT2")
						
						READ ONLY:C145([Personas:7])
						READ ONLY:C145([ACT_Pagos:172])
						READ ONLY:C145([ACT_Documentos_en_Cartera:182])
						ALL RECORDS:C47([ACT_Documentos_en_Cartera:182])
						CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera1")
						KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
						KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						CREATE SET:C116([ACT_Documentos_en_Cartera:182];"setDocCartera2")
						DIFFERENCE:C122("setDocCartera1";"setDocCartera2";"setDocCartera1")
						READ WRITE:C146([ACT_Documentos_en_Cartera:182])
						USE SET:C118("setDocCartera1")
						
						ARRAY LONGINT:C221(aQR_Longint1;0)  //id_apdo
						ARRAY TEXT:C222(aQR_Text1;0)  //apoderado
						ARRAY DATE:C224(aQR_Date1;0)  //fecha
						ARRAY TEXT:C222(aQR_Text2;0)  //serie
						ARRAY REAL:C219(aQR_Real1;0)  //monto
						ARRAY TEXT:C222(aQR_Text3;0)  //estado
						SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]ID_Apoderado:2;aQR_Longint1;[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;aQR_Date1)
						SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Numero_Doc:6;aQR_Text2;[ACT_Documentos_en_Cartera:182]Monto_Doc:7;aQR_Real1)
						SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Estado:9;aQR_Text3)
						For ($i;1;Size of array:C274(aQR_Longint1))
							QUERY:C277([Personas:7];[Personas:7]No:1=aQR_Longint1{$i})
							APPEND TO ARRAY:C911(aQR_Text1;[Personas:7]Apellidos_y_nombres:30)
						End for 
						DELETE SELECTION:C66([ACT_Documentos_en_Cartera:182])
						$vl_recordsLocked:=Records in set:C195("LockedSet")
						If ($vl_recordsLocked>0)
							$vb_abort:=True:C214
						End if 
					End if 
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
					IT_UThermometer (-2;$vl_Proc)
					If ($vb_abort)
						CD_Dlog (0;"Existían registros en uso. El script no pudo ser ejecutado correctamente.")
						CANCEL TRANSACTION:C241
					Else 
						CD_Dlog (0;"Script ejecutado con éxito.")
						VALIDATE TRANSACTION:C240
						
						AT_DistinctsArrayValues (->aQR_Longint1)
						For ($i;1;Size of array:C274(aQR_Longint1))
							dbuACT_VerificaPagosXCargo (aQR_Longint1{$i})
							QUERY:C277([Personas:7];[Personas:7]No:1=aQR_Longint1{$i})
							ACTpp_RecalculaSaldoApdo (Record number:C243([Personas:7]))
						End for 
						
						If (Size of array:C274(aQR_Text1)>0)
							$vt_document:=$vt_document+"ResultadoScript.TXT"
							$ref:=Create document:C266($vt_document;"TXT")
							If (ok=1)
								$vt_text:="Apoderado"+"\t"+"Fecha documento"+"\t"+"Número de serie"+"\t"+"Monto"+"\t"+"Estado"+"\r"
								IO_SendPacket ($ref;$vt_text)
								For ($i;1;Size of array:C274(aQR_Text1))
									$vt_text:=aQR_Text1{$i}+"\t"+String:C10(aQR_Date1{$i})+"\t"+aQR_Text2{$i}+"\t"+String:C10(aQR_Real1{$i})+"\t"+aQR_Text3{$i}+"\r"
									IO_SendPacket ($ref;$vt_text)
								End for 
								CLOSE DOCUMENT:C267($ref)
								ACTcd_DlogWithShowOnDisk ($vt_document;0;"Fueron eliminados "+String:C10(Size of array:C274(aQR_Text1))+" registro(s) de Documentos en Cartera que no tenían pago asociado."+"\r\r"+"Fueron exportado"+"s algunos datos de los documentos eliminados en la siguiente ruta "+ST_Qte ($vt_document)+"\r\r"+"Para encontrar el documento presione Ubicar.")
							End if 
						End if 
						
					End if 
				Else 
					CD_Dlog (0;"Script no ejecutado.")
				End if 
			End if 
			
		: ($vt_accion="VerificaIntegridadPagosIngresados")
			C_LONGINT:C283($i;$vl_proc)
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			
			$vl_proc:=IT_UThermometer (1;0;"Ejecutando script...")
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con@";*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10#0)
			DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;aQR_Longint1)
			DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Apoderado:11;aQR_Longint2)
			ACTcar_ValidaMontos ("ValidaDesdeIdsAvisos";->aQR_Longint1)
			For ($i;1;Size of array:C274(aQR_Longint2))
				READ ONLY:C145([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]No:1=aQR_Longint2{$i})
				ACTpp_RecalculaSaldoApdo (Record number:C243([Personas:7]))
			End for 
			IT_UThermometer (-2;$vl_proc)
			
		: ($vt_accion="VerificaIntegridadPagosEnCargos")
			  //dbuACT_RepositorioScripts ("VerificaIntegridadPagosEnCargos")
			  //verifica que los montos pagados en cargos tengan pago asociado...
			dbuACT_VerificaCargosPagados 
			
		: ($vt_accion="VerificaIntegridadDescuentos")
			  //dbuACT_RepositorioScripts ("VerificaIntegridadDescuentos")
			
			$vb_carcarDatos:=True:C214
			$vb_continuar:=False:C215
			If (Not:C34(Is nil pointer:C315($ptr1)))
				$vb_carcarDatos:=$ptr1->
			End if 
			
			If ($vb_carcarDatos)
				If (Application type:C494#4D Server:K5:6)
					If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
						If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
							$vb_continuar:=True:C214
						Else 
							CD_Dlog (0;__ ("Ejecutar desde Avisos de Cobranza"))
						End if 
					End if 
				End if 
			Else 
				$vb_continuar:=True:C214
			End if 
			
			If ($vb_continuar)
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_Cargos:173])
				ARRAY LONGINT:C221(aQR_Longint1;0)
				ARRAY LONGINT:C221(aQR_Longint2;0)
				
				ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
				  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=24436)
				
				LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando registros...")
				For ($i;1;Size of array:C274(aQR_Longint1))
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$i})
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					  //SELECTION TO ARRAY([ACT_Cargos]ID;$AL_ID;[ACT_Cargos]Saldo;$AR1)
					$vr_suma:=Sum:C1([ACT_Cargos:173]Saldo:23)
					If ($vr_suma>0)
						APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$i})
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];aQR_Longint2;"")
				If ($vb_carcarDatos)
					dbuACT_RepositorioScripts ("CargaDatosExplorador")
				End if 
			End if 
		: ($vt_accion="ReingresaPagosDescuentosMalUtilizados")
			  //dbuACT_RepositorioScripts("ReingresaPagosDescuentosMalUtilizados")
			C_LONGINT:C283(vQR_Long1;$vl_idDocumento)
			C_REAL:C285($vr_montoAPagar)
			C_LONGINT:C283($vl_cargosOtrasMonedas)
			C_TEXT:C284($vt_monedaPais)
			C_BOOLEAN:C305($vb_transaccionesOK)
			C_LONGINT:C283($vl_lockedSet;$r;$vl_lockedSet2;$vl_proc)
			ARRAY LONGINT:C221(aQR_Longint5;0)  //ids cta
			ARRAY LONGINT:C221(aQR_Longint6;0)  //ids apdo
			
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			$vt_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
			
			CREATE EMPTY SET:C140([ACT_Cargos:173];"LockedSet")
			
			START TRANSACTION:C239
			$vb_transaccionesOK:=True:C214
			
			  //SET QUERY LIMIT(1)
			$vb_carcarDatos:=False:C215
			dbuACT_RepositorioScripts ("VerificaIntegridadDescuentos";->$vb_carcarDatos)
			
			TRACE:C157
			  //se debe probar...
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;aQR_Longint6;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;aQR_Longint5)
			
			  //APPEND TO ARRAY(aQR_Longint5;1073)
			  //APPEND TO ARRAY(aQR_Longint5;0)
			  //APPEND TO ARRAY(aQR_Longint5;0)
			  //APPEND TO ARRAY(aQR_Longint5;1589)
			  //APPEND TO ARRAY(aQR_Longint5;0)
			  //
			  //APPEND TO ARRAY(aQR_Longint6;0)
			  //APPEND TO ARRAY(aQR_Longint6;8079)
			  //APPEND TO ARRAY(aQR_Longint6;7925)
			  //APPEND TO ARRAY(aQR_Longint6;0)
			  //APPEND TO ARRAY(aQR_Longint6;8049)
			
			If (Size of array:C274(aQR_Longint6)>0)
				
				ARRAY LONGINT:C221(aQR_Longint7;0)  // ids apdos para prepago
				
				$vl_proc:=IT_UThermometer (1;0;"Verificando utilización de descuentos en avisos")
				
				For (vQR_Long3;1;Size of array:C274(aQR_Longint5))
					IT_UThermometer (0;$vl_proc;"Verificando utilización de descuentos en avisos. Apoderados "+String:C10(vQR_Long3)+" de "+String:C10(Size of array:C274(aQR_Longint5)))
					
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)  //ids pagos
					ARRAY LONGINT:C221(aQR_Longint4;0)  //ids dc
					
					If (aQR_Longint5{vQR_Long3}#0)
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=aQR_Longint5{vQR_Long3})
					Else 
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint6{vQR_Long3})
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0)
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
					End if 
					  //SET QUERY LIMIT(0)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;>)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
					
					  //ACTcc_OpcionesCalculoCtaCte ("InitArrays")
					
					For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
						GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{vQR_Long1})
						
						If ((Find in array:C230(aQR_Longint7;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)=-1) & ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0))
							APPEND TO ARRAY:C911(aQR_Longint7;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
						End if 
						
						  //ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Avisos_de_Cobranza]ID_Apoderado)
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
						CREATE SET:C116([ACT_Transacciones:178];"setTransacciones")
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						CREATE SET:C116([ACT_Cargos:173];"setCargos")
						
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_cargosOtrasMonedas)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#$vt_monedaPais)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						If ($vl_cargosOtrasMonedas=0)
							
							  //guardo los montos de los pagos como disponibles y almaceno los ids de los pagos en un arreglo...
							USE SET:C118("setTransacciones")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];aQR_Longint2;"")
							For (vQR_Long2;1;Size of array:C274(aQR_Longint2))
								GOTO RECORD:C242([ACT_Transacciones:178];aQR_Longint2{vQR_Long2})
								If (([ACT_Transacciones:178]Glosa:8#"Pago con Descuento") & ([ACT_Transacciones:178]Glosa:8#"Balanceo Descuento"))
									KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;True:C214)
									If (ok=1)
										If (Find in array:C230(aQR_Longint3;[ACT_Pagos:172]ID:1)=-1)
											APPEND TO ARRAY:C911(aQR_Longint3;[ACT_Pagos:172]ID:1)
										End if 
										[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+[ACT_Transacciones:178]Debito:6
										SAVE RECORD:C53([ACT_Pagos:172])
									Else 
										$vb_transaccionesOK:=False:C215
										vQR_Long2:=Size of array:C274(aQR_Longint2)
										vQR_Long1:=Size of array:C274(aQR_Longint1)
									End if 
									KRL_UnloadReadOnly (->[ACT_Pagos:172])
								End if 
							End for 
							
							  //elimino transacciones de pagos
							READ WRITE:C146([ACT_Transacciones:178])
							USE SET:C118("setTransacciones")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
							DELETE SELECTION:C66([ACT_Transacciones:178])
							If (Records in set:C195("LockedSet")=0)
								
								  //limpio montos pagados de cargos
								READ WRITE:C146([ACT_Cargos:173])
								USE SET:C118("setCargos")
								APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]MontosPagadosMPago:52:=0)
								$vl_lockedSet2:=Records in set:C195("LockedSet")
								$vl_lockedSet:=$vl_lockedSet+$vl_lockedSet2
								APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8:=0)
								$vl_lockedSet2:=Records in set:C195("LockedSet")
								$vl_lockedSet:=$vl_lockedSet+$vl_lockedSet2
								APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23:=([ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5))
								$vl_lockedSet2:=Records in set:C195("LockedSet")
								$vl_lockedSet:=$vl_lockedSet+$vl_lockedSet2
								KRL_UnloadReadOnly (->[ACT_Cargos:173])
								
								If ($vl_lockedSet=0)
									  //listo para prepagar...
								Else 
									$vb_transaccionesOK:=False:C215
									vQR_Long1:=Size of array:C274(aQR_Longint1)
								End if 
							Else 
								$vb_transaccionesOK:=False:C215
								vQR_Long1:=Size of array:C274(aQR_Longint1)
							End if 
						Else 
							$vb_transaccionesOK:=False:C215
							vQR_Long1:=Size of array:C274(aQR_Longint1)
							TRACE:C157
							  //no esta preparado para esto... hay que hacerlo cuando se necesite...
						End if 
						
						  //limpieza
						SET_ClearSets ("setTransacciones";"setCargos")
						
					End for 
					
					If ($vb_transaccionesOK)
						  //recalculo aviso y dc
						ARRAY LONGINT:C221(aQR_Longint4;0)  // 
						For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
							ACTac_Recalcular (aQR_Longint1{vQR_Long1})
							GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{vQR_Long1})
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							While (Not:C34(End selection:C36([ACT_Documentos_de_Cargo:174])))
								If (Find in array:C230(aQR_Longint4;[ACT_Documentos_de_Cargo:174]ID_Documento:1)=-1)
									APPEND TO ARRAY:C911(aQR_Longint4;[ACT_Documentos_de_Cargo:174]ID_Documento:1)
								End if 
								NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
							End while 
						End for 
						For (vQR_Long1;1;Size of array:C274(aQR_Longint4))
							$vl_idDocumento:=aQR_Longint4{vQR_Long1}
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$vl_idDocumento)
							ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
						End for 
						
						  //prepago
						For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
							GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{vQR_Long1})
							QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
							$vr_montoAPagar:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							If ($vr_montoAPagar>0)
								While ($vr_montoAPagar>0)
									READ WRITE:C146([ACT_Pagos:172])
									QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;aQR_Longint3)
									QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Saldo:15>0)
									ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]ID:1;>)
									FIRST RECORD:C50([ACT_Pagos:172])
									If (Records in selection:C76([ACT_Pagos:172])>0)
										If ([ACT_Pagos:172]Saldo:15>$vr_montoAPagar)
											$vr_montoAPagar:=0
										Else 
											$vr_montoAPagar:=$vr_montoAPagar-[ACT_Pagos:172]Saldo:15
										End if 
										ACTac_Prepagar (aQR_Longint1{vQR_Long1};False:C215;False:C215;[ACT_Pagos:172]ID:1)
									Else 
										$vr_montoAPagar:=0
									End if 
								End while 
							End if 
						End for 
						
					End if 
					If (Not:C34($vb_transaccionesOK))
						vQR_Long3:=Size of array:C274(aQR_Longint5)
					End if 
				End for 
				
				IT_UThermometer (0;$vl_proc;"Prepagando...")
				If ($vb_transaccionesOK)
					
					For (vQR_Long1;1;Size of array:C274(aQR_Longint7))
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						READ ONLY:C145([ACT_Pagos:172])
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint7{vQR_Long1};*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
						If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=aQR_Longint7{vQR_Long1};*)
							QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
							If (Records in selection:C76([ACT_Pagos:172])>0)
								For (vQR_Long2;1;Size of array:C274(aQR_Longint1))
									ACTac_Prepagar (aQR_Longint1{vQR_Long2})
								End for 
							End if 
						End if 
					End for 
					
					  //$vb_mostrarTermo:=True
					  //ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
					
					IT_UThermometer (-2;$vl_proc)
					VALIDATE TRANSACTION:C240
					CD_Dlog (0;"Script ejecutado OK...")
					
					$vb_carcarDatos:=False:C215
					dbuACT_RepositorioScripts ("VerificaIntegridadDescuentos";->$vb_carcarDatos)
					
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
						CD_Dlog (0;"Quedaron descuentos mal utilizados.")
					Else 
						CD_Dlog (0;"Descuentos OK.")
					End if 
					
				Else 
					  //ACTcc_OpcionesCalculoCtaCte ("InitArrays")
					  //vbACTcc_AgregarElementos:=False
					
					IT_UThermometer (-2;$vl_proc)
					CANCEL TRANSACTION:C241
					CD_Dlog (0;"Script ejecutado NO OK...")
				End if 
			Else 
				CD_Dlog (0;"No fueron encontrados descuentos con problemas.")
			End if 
			
		: ($vt_accion="DesemniteDTElectronicos")  //20170310 RCH
			  //Este codigo se puede usar de base para cuando se necesite re emitir un DTE rechazado por el SII
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			
			C_LONGINT:C283($l_recs)
			
			APPEND TO ARRAY:C911(aQR_Longint1;19748)
			APPEND TO ARRAY:C911(aQR_Longint1;19754)
			APPEND TO ARRAY:C911(aQR_Longint1;19757)
			APPEND TO ARRAY:C911(aQR_Longint1;19789)
			APPEND TO ARRAY:C911(aQR_Longint1;19809)
			APPEND TO ARRAY:C911(aQR_Longint1;19811)
			
			READ WRITE:C146([ACT_Boletas:181])
			QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;aQR_Longint1)
			
			If (USR_GetUserID <0)
				START TRANSACTION:C239
				APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Numero:11:=0)
				$l_recs:=$l_recs+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?- 2)
				$l_recs:=$l_recs+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?- 3)
				$l_recs:=$l_recs+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_CAF:43:=0)  //20170608 RCH
				$l_recs:=$l_recs+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[ACT_Boletas:181])
				
				If ($l_recs=0)
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ("Cambio en folios de DT por cambio de certificado. Ids de DT modificados: "+AT_array2text (->aQR_Longint1;", ";"#########")+".")
					CD_Dlog (0;"Script ejecutado correctamente.")
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;"Registros en uso. El script no pudo ser ejecutado.")
				End if 
			End if 
			ARRAY LONGINT:C221(aQR_Longint1;0)
			
		: ($vt_accion="ReparaDescuentosEnBoletas")  //20150303 RCH
			
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Boletas:181])
			READ ONLY:C145([ACT_Transacciones:178])
			C_LONGINT:C283($l_records;$l_idBoleta;$l_indice)
			C_BOOLEAN:C305($b_boletaValida)
			C_BOOLEAN:C305($b_procesado)
			
			  //$l_records:=BWR_SearchRecords 
			  //If ($l_records#-1)
			
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=!2014-12-01!;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]FechaEmision:3<=!2014-12-31!;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			If (Records in selection:C76([ACT_Boletas:181])>0)
				
				ARRAY LONGINT:C221(aQR_Longint1;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Boletas:181];aQR_Longint1;"")
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando detalle de documentos...")
				For ($l_indice;1;Size of array:C274(aQR_Longint1))
					GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$l_indice})
					
					$l_idBoleta:=[ACT_Boletas:181]ID:1
					$b_boletaValida:=ACTbol_ValidaEmisionDT ($l_idBoleta)
					If (Not:C34($b_boletaValida))
						READ WRITE:C146([ACT_Transacciones:178])
						
						GOTO RECORD:C242([ACT_Boletas:181];aQR_Longint1{$l_indice})
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
						KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Transacciones:178]No_Comprobante:10;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con Descuento";*)
						QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
						
						If (Records in selection:C76([ACT_Transacciones:178])>0)
							START TRANSACTION:C239
							APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=$l_idBoleta)
							$b_boletaValida:=ACTbol_ValidaEmisionDT ($l_idBoleta)
							If ($b_boletaValida)
								VALIDATE TRANSACTION:C240
							Else 
								CANCEL TRANSACTION:C241
							End if 
						Else 
							
						End if 
						
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274(aQR_Longint1))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			Else 
				  //CD_Dlog (0;"Seleccione registros en el explorador.")
			End if 
			
		: ($vt_accion="CambiaFechaDeVencimientoDeAvisosDeCobranza")  //20150702 RCH
			  //dbuACT_RepositorioScripts
			  //_0000_testsCraighouse
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						ARRAY LONGINT:C221(aQR_Longint1;0)
						ARRAY LONGINT:C221(aQR_Longint2;0)
						ARRAY LONGINT:C221(aQR_Longint3;0)
						C_BOOLEAN:C305($b_calcular)
						C_LONGINT:C283($vl_records;$i;$l_indice;$l_locked;$l_resp)
						$vl_records:=BWR_SearchRecords (->[ACT_Avisos_de_Cobranza:124])
						
						If ($vl_records#-1)
							
							CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAC1")
							KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
							KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8#0)
							KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
							KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
							
							CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAC2")
							
							DIFFERENCE:C122("setAC1";"setAC2";"setAC1")
							USE SET:C118("setAC1")
							SET_ClearSets ("setAC1";"setAC2")
							
							If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
								
								$l_resp:=CD_Dlog (0;"Se cambiará la fecha de emisión y vencimiento de "+String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))+" Aviso(s) de Cobranza seleccionado(s) en el explorador, que NO tengan pagos asociados."+"\r\r"+"A continuación deberá seleccionar la fecha de Emisión y luego la fecha de Vencimiento que será aplicada a TODOS los Avisos de Cobranza seleccionados que no tengan pagos asociados."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
								If ($l_resp=1)
									C_DATE:C307($d_fechaEmision;$d_fechaVencimiento)
									SRACT_SelFecha (1)
									If (ok=1)
										$d_fechaEmision:=vd_fecha1
										SRACT_SelFecha (1)
										If (ok=1)
											$d_fechaVencimiento:=vd_fecha1
											
											If ($d_fechaEmision<=$d_fechaVencimiento)
												
												START TRANSACTION:C239
												LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint1;"")
												
												$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Cambiando fecha de Vencimiento en Avisos de Cobranza...")
												For ($l_indice;1;Size of array:C274(aQR_Longint1))
													READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
													GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
													
													If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
														[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4:=$d_fechaEmision
														[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5:=$d_fechaVencimiento
														SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
														
														GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
														READ WRITE:C146([ACT_Transacciones:178])
														QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
														APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5:=$d_fechaVencimiento)
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														KRL_UnloadReadOnly (->[ACT_Transacciones:178])
														
														GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
														READ WRITE:C146([ACT_Documentos_de_Cargo:174])
														QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
														APPLY TO SELECTION:C70([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]FechaEmision:21:=$d_fechaEmision)
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														APPLY TO SELECTION:C70([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=$d_fechaVencimiento)
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
														
														  //se borran posibles intereses ya que el aviso no deberia tener ningun pago asociado
														READ WRITE:C146([ACT_Cargos:173])
														GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
														QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
														KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
														QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100)
														If (Records in selection:C76([ACT_Cargos:173])>0)
															$b_calcular:=True:C214
															APPEND TO ARRAY:C911(aQR_Longint2;aQR_Longint1{$l_indice})
															If (KRL_DeleteSelection (->[ACT_Cargos:173])=0)
																$l_locked:=$l_locked+1
															End if 
														Else 
															$b_calcular:=False:C215
														End if 
														KRL_UnloadReadOnly (->[ACT_Cargos:173])
														
														READ WRITE:C146([ACT_Cargos:173])
														READ ONLY:C145([ACT_Documentos_de_Cargo:174])
														GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
														QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
														KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
														APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22:=$d_fechaEmision)
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$d_fechaVencimiento)
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7))
														$l_locked:=$l_locked+Records in set:C195("LockedSet")
														KRL_UnloadReadOnly (->[ACT_Cargos:173])
														
														GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint1{$l_indice})
														APPEND TO ARRAY:C911(aQR_Longint3;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
														If ($b_calcular)
															ACTac_Recalcular (aQR_Longint1{$l_indice})
														End if 
													Else 
														$l_locked:=$l_locked+1
													End if 
													
													KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
													
													If ($l_locked>0)
														$l_indice:=Size of array:C274(aQR_Longint1)
													End if 
													$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274(aQR_Longint1))
												End for 
												$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
												
												C_LONGINT:C283($l_proc)
												
												If ($l_locked=0)
													VALIDATE TRANSACTION:C240
													If (Size of array:C274(aQR_Longint2)>0)
														$l_proc:=IT_UThermometer (1;0;"Recalculando Avisos...")
														  //recalcular avisos para los cuales se les borró interes
														ACTmnu_RecalcularSaldosAvisos (->aQR_Longint2)
														IT_UThermometer (-2;$l_proc)
													End if 
													LOG_RegisterEvt ("Cambio de fecha de emisión y vencimiento de avisos de cobranza. Ids cambiados: "+AT_array2text (->aQR_Longint3;", ";"#########")+".")
													CD_Dlog (0;"Cambio de fecha de vencimiento ejecutado con éxito.")
												Else 
													CANCEL TRANSACTION:C241
													CD_Dlog (0;"El cambio de fecha de vencimiento no pudo ser ejecutado debido a que fueron encontrados registros en uso.")
												End if 
											Else 
												CD_Dlog (0;"La fecha de emisión no puede ser superior a la fecha de vencimiento.")
											End if 
										End if 
									End if 
								End if 
							Else 
								CD_Dlog (0;"No hay Avisos de Cobranza sin pago asociado en la selección.")
							End if 
							ARRAY LONGINT:C221(aQR_Longint1;0)
						Else 
							CD_Dlog (0;"Seleccione en el explorador los Avisos de Cobranza a los que desea aplicar una nueva fecha de vencimiento.")
						End if 
					Else 
						CD_Dlog (0;"Ejecute el script desde la pestaña Avisos de Cobranza.")
					End if 
				End if 
			End if 
			
		: ($t_accion="AsignaFolioDeDocumentoADocumentoQueSePerdio")
			  //Pasó en la scuola. Ticket 184256
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
						
						ARRAY LONGINT:C221(aQR_Longint1;0)
						
						C_LONGINT:C283($l_recs;$l_resp;$l_folio;$l_idDctoAsoc)
						C_REAL:C285($r_monto)
						C_TEXT:C284($t_tipo)
						
						$r_monto:=6160000
						$l_folio:=46
						$t_tipo:="61"
						$l_idDctoAsoc:=9896
						
						$l_recs:=BWR_SearchRecords 
						If ($l_recs=1)
							READ WRITE:C146([ACT_Boletas:181])
							READ ONLY:C145([ACT_FoliosDT:293])
							
							QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0;*)
							QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_SII:33=$t_tipo;*)
							QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214;*)
							QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Monto_Total:6=$r_monto)
							
							If (Records in selection:C76([ACT_Boletas:181])=1)
								If (Not:C34(Locked:C147([ACT_Boletas:181])))
									APPEND TO ARRAY:C911(aQR_Longint1;[ACT_Boletas:181]ID:1)
									
									QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]tipo_dteSII:7=Num:C11($t_tipo);*)
									QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1)
									
									[ACT_Boletas:181]Numero:11:=$l_folio
									[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
									[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 2
									[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 3
									[ACT_Boletas:181]FechaEmision:3:=DT_GetDateFromDayMonthYear (23;6;2017)
									[ACT_Boletas:181]FechaVencimiento:54:=[ACT_Boletas:181]FechaEmision:3
									[ACT_Boletas:181]ID_CAF:43:=[ACT_FoliosDT:293]id:1
									SAVE RECORD:C53([ACT_Boletas:181])
									KRL_UnloadReadOnly (->[ACT_Boletas:181])
									
									LOG_RegisterEvt ("Cambio en folio de DT. Ids de DT modificados: "+AT_array2text (->aQR_Longint1;", ";"#########")+".")
									CD_Dlog (0;"Script ejecutado correctamente.")
									
								Else 
									CD_Dlog (0;"El documento está en uso. Intente nuevamente más tarde.")
								End if 
							Else 
								CD_Dlog (0;"Seleccione un documento con folio 0 y electrónico, por el monto correcto.")
							End if 
							
							KRL_UnloadReadOnly (->[ACT_Boletas:181])
						Else 
							CD_Dlog (0;"Seleccione solo un documento.")
						End if 
						ARRAY LONGINT:C221(aQR_Longint1;0)
					Else 
						CD_Dlog (0;"Ejecute el script desde la pestaña Documentos Tributarios.")
					End if 
				End if 
			End if 
			
		: ($t_accion="CorrigeNumeroDTEnTransaccionesCuandoHayNC")
			  //Quita valor -1 y lo deja en 0,
			C_LONGINT:C283($l_recBloqueados;$l_indice;$l_proc)
			
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
						$l_proc:=IT_UThermometer (1;0;"Verificando ids de DT en Transacciones...")
						ARRAY LONGINT:C221(aQR_Longint1;0)
						ARRAY LONGINT:C221(aQR_Longint2;0)
						
						START TRANSACTION:C239
						READ WRITE:C146([ACT_Transacciones:178])
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=-1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6#0;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4>0)
						
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];aQR_Longint1)
						
						For ($l_indice;1;Size of array:C274(aQR_Longint1))
							GOTO RECORD:C242([ACT_Transacciones:178];aQR_Longint1{$l_indice})
							If (Not:C34(Locked:C147([ACT_Transacciones:178])))
								APPEND TO ARRAY:C911(aQR_Longint2;[ACT_Transacciones:178]ID_Pago:4)
								[ACT_Transacciones:178]No_Boleta:9:=0
								LOG_RegisterEvt ("Cambio en id de Documento Tributario en transacción id: "+String:C10([ACT_Transacciones:178]ID_Transaccion:1)+", asociada a Aviso de Cobranza id: "+String:C10([ACT_Transacciones:178]No_Comprobante:10)+". ID cambió de "+String:C10(Old:C35([ACT_Transacciones:178]No_Boleta:9))+" a "+String:C10([ACT_Transacciones:178]No_Boleta:9)+".")
								SAVE RECORD:C53([ACT_Transacciones:178])
							Else 
								$l_recBloqueados:=$l_recBloqueados+1
							End if 
						End for 
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
						
						IT_UThermometer (-2;$l_proc)
						
						If ($l_recBloqueados=0)
							VALIDATE TRANSACTION:C240
							
							READ ONLY:C145([ACT_Pagos:172])
							QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;aQR_Longint2)
							dbuACT_RepositorioScripts ("CargaDatosExplorador")
							
							CD_Dlog (0;"Script ejecutado con éxito. Los pagos con transacciones modificadas serán cargados en el explorador.")
						Else 
							CANCEL TRANSACTION:C241
							CD_Dlog (0;"Registro en uso. El script no pudo ser ejecutado.")
						End if 
						
					Else 
						CD_Dlog (0;"Ejecute el script desde la pestaña pagos.")
					End if 
				End if 
			End if 
			
		: ($t_accion="DesemiteBoletaElectronica")
			  //Se puede usar cuando un DTE sea rechazado por el SII
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			C_LONGINT:C283($l_recs;$l_idcaf;$l_resp;$l_indice;$l_recs2)
			
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
						READ WRITE:C146([ACT_Boletas:181])
						
						$l_recs2:=BWR_SearchRecords 
						
						If ($l_recs2>0)
							$l_resp:=CD_Dlog (0;"Se quitará el folio de los Documentos Tributarios selecciondos en el explorador ("+String:C10(Records in selection:C76([ACT_Boletas:181]))+"). Esta operación no se puede deshacer. ¿Desea continuar?";"";"Si";"No")
							If ($l_resp=1)
								SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;aQR_Longint1)
								START TRANSACTION:C239
								For ($l_indice;1;Size of array:C274(aQR_Longint1))
									KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->aQR_Longint1{$l_indice};True:C214)
									If (ok=1)
										[ACT_Boletas:181]Numero:11:=0
										[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?- 2
										[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?- 3
										$l_idcaf:=[ACT_Boletas:181]ID_CAF:43
										[ACT_Boletas:181]ID_CAF:43:=0  //20170608 RCH
										SAVE RECORD:C53([ACT_Boletas:181])
										
										KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;->$l_idcaf;True:C214)
										If (ok=1)
											[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]folio_disponible:6-1
											SAVE RECORD:C53([ACT_FoliosDT:293])
										Else 
											$l_recs:=$l_recs+1
											$l_indice:=Size of array:C274(aQR_Longint1)
										End if 
										KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
									Else 
										$l_recs:=$l_recs+1
										$l_indice:=Size of array:C274(aQR_Longint1)
									End if 
									KRL_UnloadReadOnly (->[ACT_Boletas:181])
								End for 
								
								If ($l_recs=0)
									VALIDATE TRANSACTION:C240
									LOG_RegisterEvt ("Reemisión de DT debido a problema con folio muy antiguo. Ids de DT modificados: "+AT_array2text (->aQR_Longint1;", ";"#########")+". Folio asignado 0.")
									CD_Dlog (0;"Script ejecutado correctamente.")
								Else 
									CANCEL TRANSACTION:C241
									CD_Dlog (0;"Registros en uso. El script no pudo ser ejecutado.")
								End if 
								
							End if 
						End if 
					End if 
				End if 
			End if 
			ARRAY LONGINT:C221(aQR_Longint1;0)
			
		: ($t_accion="CambiaPagoAWebpay")
			  //para corregir pagos que no pueden ser ingresados automáticamente
			ACTfdp_CargaFormasDePago   //20180413 RCH
			C_LONGINT:C283($l_resp;$l_idPago)
			C_TEXT:C284($t_ordenCompra)
			
			$t_ordenCompra:="191360"
			$l_idPago:=5902
			
			READ WRITE:C146([ACT_Pagos:172])
			
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_WebpayOC:32=Num:C11($t_ordenCompra))
			If (Records in selection:C76([ACT_Pagos:172])=0)
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$l_idPago)
				If ([ACT_Pagos:172]id_forma_de_pago:30#-18)
					
					$l_resp:=CD_Dlog (0;"Se asignará la orden de compra: "+$t_ordenCompra+" al pago número: "+String:C10($l_idPago)+". ¿Desea continuar?";"";"Si";"No";"Cancelar")
					
					If ($l_resp=1)
						KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;True:C214)
						If (Not:C34(Locked:C147([ACT_Pagos:172])))
							If (Not:C34(Locked:C147([ACT_Documentos_de_Pago:176])))
								
								[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-18
								[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
								[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
								SAVE RECORD:C53([ACT_Documentos_de_Pago:176])
								
								QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
								[ACT_Pagos:172]id_forma_de_pago:30:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
								[ACT_Pagos:172]FormaDePago:7:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
								[ACT_Pagos:172]forma_de_pago_new:31:=[ACT_Documentos_de_Pago:176]forma_de_pago_new:52
								
								[ACT_Pagos:172]Datos_pago:36:=""
								[ACT_Pagos:172]ID_WebpayOC:32:=Num:C11($t_ordenCompra)
								[ACT_Pagos:172]Datos_pago:36:=""
								
								LOG_RegisterEvt ("Cambio de forma de pago en pago id "+String:C10($l_idPago)+". Forma de pago cambió de "+String:C10(Old:C35([ACT_Pagos:172]id_forma_de_pago:30))+" a "+String:C10([ACT_Pagos:172]id_forma_de_pago:30)+".")
								
								SAVE RECORD:C53([ACT_Pagos:172])
								ACTpgs_AsignaCuentasContables (->[ACT_Pagos:172]ID:1)
								
								POST KEY:C465(-96)
								
							Else 
								CD_Dlog (0;"El registro del Documento de Pago está en uso. El script no puede ser ejecutado")
							End if 
						Else 
							CD_Dlog (0;"El registro del Pago está en uso. El script no puede ser ejecutado")
						End if 
						KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
					End if 
				Else 
					CD_Dlog (0;"Script ya ejecutado")
				End if 
			Else 
				CD_Dlog (0;"La orden de compra ya existe en la base de datos")
			End if 
			
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
			
		: ($t_accion="EmiteDTEConNotaDePedido")
			  //Para permitir la emisión de DTEs cn Notas de pedido.
			<>vb_MsgON:=True:C214
			C_LONGINT:C283($l_recs;$l_indice;$l_emitido;$l_resp)
			C_TEXT:C284($t_param)
			C_DATE:C307($vd_fecha)
			C_TEXT:C284($t_orden)
			
			If (Application type:C494#4D Server:K5:6)
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
						
						$t_orden:=CD_Request ("Ingrese la nota de pedido";"Aceptar";"Cancelar";"";"")
						If (ok=1)
							$l_recs:=BWR_SearchRecords 
							If ($l_recs#-1)
								READ ONLY:C145([ACT_Boletas:181])
								
								QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0)
								QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];[ACT_Boletas:181]DTE_estado_id:24 ?? 1)
								
								If (Records in selection:C76([ACT_Boletas:181])>0)
									$l_resp:=CD_Dlog (0;"Se asignará la Nota de Pedido "+ST_Qte ($t_orden)+" (código 802) a "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" Documentos Tributarios seleccionados.\n\n¿Desea continuar?";"";"Si";"No")
									If ($l_resp=1)
										ACTcfg_LoadConfigData (8)
										
										ARRAY LONGINT:C221(aQR_Longint1;0)
										ARRAY REAL:C219(aQR_Real1;0)
										ARRAY DATE:C224(aQR_Date1;0)
										
										SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;aQR_Longint1;[ACT_Boletas:181]Monto_Total:6;aQR_Real1;[ACT_Boletas:181]FechaEmision:3;aQR_Date1)
										
										For ($l_indice;1;Size of array:C274(aQR_Longint1))
											$t_param:=ACTdte_GeneraArchivo ("GeneraDctoTexto";->aQR_Longint1{$l_indice})
											
											C_TEXT:C284($vt_separador;$vt_text;$vt_ndldr1;$vt_tddr2;$vt_igdr3;$vt_fdr4;$vt_roc5;$vt_fdr6;$vt_cr7;$vt_rdr8)
											$vt_separador:=";"
											
											$vt_ndldr1:="1"
											$vt_tddr2:="802"
											$vt_igdr3:=""
											$vt_fdr4:=$t_orden
											$vt_roc5:=""
											$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->aQR_Date1{$l_indice})
											$vt_cr7:=""
											$vt_rdr8:=""
											
											$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
											$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador
											
											$t_param:=$t_param+$vt_text+Char:C90(9+4)
											$l_emitido:=ACTdte_EmiteDocumento (aQR_Longint1{$l_indice};$t_param)
											If ($l_emitido=0)
												$l_indice:=Size of array:C274(aQR_Longint1)
												CD_Dlog (0;"Los documentos no pudieron ser emitidos.")
											Else 
												READ ONLY:C145([ACT_Boletas:181])
												QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=aQR_Longint1{$l_indice})
												LOG_RegisterEvt ("DTE folio "+String:C10([ACT_Boletas:181]Numero:11)+" emitido con nota de pedido (registro id: "+String:C10([ACT_Boletas:181]ID:1)+").")
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
						End if 
					Else 
						CD_Dlog (0;"Ejecute el script desde la pestaÒa Documentos Tributarios, con los documentos con folio 0 seleccionados.")
					End if 
				End if 
			End if 
			
		: ($t_accion="LimpiaDireccionDeFacturacion")
			
			C_LONGINT:C283($l_ProgressProcID;$t;$l_bloqueados;$l_resp)
			ARRAY LONGINT:C221($aPersonas;0)
			
			$l_resp:=CD_Dlog (0;"El presente script limpiará la dirección de envío de correspondencia para todos los apoderados.\n\n¿Desea continuar?";"";"Si";"No")
			If ($l_resp=1)
				READ WRITE:C146([Personas:7])
				
				QUERY:C277([Personas:7];[Personas:7]ACT_DireccionEC:67#"";*)
				QUERY:C277([Personas:7]; | ;[Personas:7]ACT_ComunaEC:68#"";*)
				QUERY:C277([Personas:7]; | ;[Personas:7]ACT_CodPostalEC:70#"";*)
				QUERY:C277([Personas:7]; | [Personas:7]ACT_CiudadEC:69#"")
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
				LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas;"")
				For ($t;1;Size of array:C274($aPersonas))
					GOTO RECORD:C242([Personas:7];$aPersonas{$t})
					If (Not:C34(Locked:C147([Personas:7])))
						[Personas:7]ACT_DireccionEC:67:=""
						[Personas:7]ACT_ComunaEC:68:=""
						[Personas:7]ACT_CodPostalEC:70:=""
						[Personas:7]ACT_CiudadEC:69:=""
						SAVE RECORD:C53([Personas:7])
					Else 
						$l_bloqueados:=$l_bloqueados+1
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$t/Size of array:C274($aPersonas);__ ("Asignando dirección de envío de correspondencia a apoderados de cuenta..."))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
				KRL_UnloadReadOnly (->[Personas:7])
				
				LOG_RegisterEvt ("Limpieza de dirección de envío de correspondencia ejecutada.")
				
				If ($l_bloqueados=0)
					CD_Dlog (0;"Script ejecutado correctamente")
				Else 
					CD_Dlog (0;"Registros en uso. Intente nuevamente.")
				End if 
				
			End if 
			
			
		: ($vt_accion="AsignaFolioDocumentoTributario")
			
			  // utilizar cuando un id de ACT está relacionado a 2 registros en DTENET
			  // se debe emitir un nuevo documento de las mismas caracteristicas del que no existe y luego usar el script Ticket Nº 215581
			
			If (vsBWR_CurrentModule="AccountTrack")
				If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
					If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
						
						C_LONGINT:C283($bolSeleccionadas)
						
						READ WRITE:C146([ACT_Boletas:181])
						$bolSeleccionadas:=BWR_SearchRecords 
						
						If ($bolSeleccionadas=1)
							
							C_LONGINT:C283($l_resp;$l_folio)
							C_TEXT:C284($t_mensaje)
							$l_folio:=89
							
							$t_mensaje:="Este script le permitirá asignar el número de folio "+String:C10($l_folio)+", al documento tributario seleccionado en el explorador."
							$t_mensaje:=$t_mensaje+"\r\r¿Desea continuar?"
							$l_resp:=CD_Dlog (0;$t_mensaje;"";"Continuar";"Cancelar")
							
							If ($l_resp=1)
								
								C_REAL:C285($r_montoAfecto;$r_montoIva;$r_montoTotal)
								C_LONGINT:C283($l_idRazonS)
								C_TEXT:C284($t_tipoDocumento)
								C_DATE:C307($d_fechaEmision)
								
								  //obtenidos desde el id 91
								$l_idRazonS:=1
								$r_montoAfecto:=541176
								$r_montoIva:=102824
								$r_montoTotal:=644000
								$t_tipoDocumento:="Factura Afecta Digital"
								$d_fechaEmision:=!2018-08-23!
								
								If (Not:C34(Locked:C147([ACT_Boletas:181])))
									If ([ACT_Boletas:181]TipoDocumento:7=$t_tipoDocumento)
										If ([ACT_Boletas:181]Monto_Total:6=$r_montoTotal)
											If ([ACT_Boletas:181]Monto_IVA:5=$r_montoIva)
												If ([ACT_Boletas:181]Monto_Afecto:4=$r_montoAfecto)
													If ([ACT_Boletas:181]ID_RazonSocial:25=$l_idRazonS)
														If ([ACT_Boletas:181]FechaEmision:3=$d_fechaEmision)
															If ([ACT_Boletas:181]Numero:11=0)
																[ACT_Boletas:181]Numero:11:=$l_folio
																
																[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
																[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 2
																[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 3
																
																SAVE RECORD:C53([ACT_Boletas:181])
																
																$t_mensaje:="Asignación de folio "+String:C10($l_folio)+", para el documento tributario ID "+String:C10([ACT_Boletas:181]ID:1)+"."
																LOG_RegisterEvt ($t_mensaje)
																CD_Dlog (0;$t_mensaje+"\r\rScript finalizado correctamente.")
																
																KRL_UnloadReadOnly (->[ACT_Boletas:181])
															Else 
																CD_Dlog (0;"El folio para el documento seleccionado en el explorador no es 0.\r\rNo se puede sobre-escribir el folio ya asignado.\r\rNo se efectuaron cambios.")
															End if 
														Else 
															CD_Dlog (0;"La Fecha de Emisión para el documento tributarios seleccionado en el explorador no es "+String:C10($d_fechaEmision)+"\r\r.No se efectuaron cambios.")
														End if 
													Else 
														CD_Dlog (0;"La Razón Social para el documento tributario seleccionado en el explorador no es "+String:C10($l_idRazonS)+"\r\r.No se efectuaron cambios.")
													End if 
												Else 
													CD_Dlog (0;"El Monto Exento para el documento tributario seleccionado en el explorador es erróneo. Debería ser :"+String:C10($r_montoAfecto)+"\r\r.No se efectuaron cambios.")
												End if 
											Else 
												CD_Dlog (0;"El Monto IVA para el documento tributario seleccionado en el explorador es erróneo. Debería ser :"+String:C10($r_montoIva)+"\r\r.No se efectuaron cambios.")
											End if 
										Else 
											CD_Dlog (0;"El Monto Total para el documento tributario seleccionado en el explorador es erróneo. Debería ser :"+String:C10($r_montoTotal)+"\r\r.No se efectuaron cambios.")
										End if 
									Else 
										CD_Dlog (0;"El Tipo de Documento tributario seleccionado en el explorador es erróneo. Debería ser :"+$t_tipoDocumento+"\r\r.No se efectuaron cambios.")
									End if 
								Else 
									CD_Dlog (0;"Documento tributario bloqueado o en uso por otro proceso. Inténtelo nuevamente más tarde.")
								End if 
							End if 
						Else 
							If ($bolSeleccionadas=0)
								CD_Dlog (0;"No existe selección de registros en el explorador de documentos tributarios. Corrija la selección y vuelva a intentarlo.")
							Else 
								CD_Dlog (0;"Existe más de un documento tributario seleccionado en el explorador. Corrija la selección y vuelva a intentarlo.")
							End if 
						End if 
					Else 
						CD_Dlog (0;"Ejecute el script de desde la pestaña documentos tributarios.")
					End if 
				Else 
					CD_Dlog (0;"Puntero Nulo.")
				End if 
			Else 
				CD_Dlog (0;"Por favor utilice el script desde el módulo AccountTrack.")
			End if 
	End case 
End if 



