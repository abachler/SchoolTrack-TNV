//%attributes = {}
  //ACT_OpcionesReferenciasMX
C_TEXT:C284($t_accion;$0;$t_retorno)
C_POINTER:C301($vy_parametro1)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If (Count parameters:C259>=2)
	$vy_parametro1:=$2
End if 

Case of 
	: ($t_accion="")
		
		WDW_OpenFormWindow (->[ACT_Avisos_de_Cobranza:124];"ReferenciasMX";-1;4;__ ("Consulta Referencias"))
		DIALOG:C40([ACT_Avisos_de_Cobranza:124];"ReferenciasMX")
		CLOSE WINDOW:C154
		
	: ($t_accion="busca")
		C_TEXT:C284($t_referencia;$t_json;$err)
		C_LONGINT:C283($vl_pID;$l_indice)
		C_TEXT:C284($t_referencia;$t_avisos;$t_montos;$t_montototal;$t_idrelfamiliar;$t_fecha_pago;$t_valor)
		
		$t_referencia:=$vy_parametro1->
		Variable4:=""
		
		vtACT_referenciaBusqueda:=""
		vtACT_referencia:=""
		vtACT_nombreApoderado:=""
		vdACT_fechaPago:=!00-00-00!
		vrACT_total:=0
		vtACT_idACSel:=""
		vtACT_textoAC:=""
		
		ACT_OpcionesReferenciasMX ("declaraArreglos")
		ACT_OpcionesReferenciasMX ("declaraArreglosCargos")
		
		  // Modificado por: Saul Ponce (26/02/2018)
		$t_referencia:=ACT_OpcionesReferenciasMX ("procesaTextoIngresado";->$t_referencia)
		
		  //If ($t_referencia#"")
		If (($t_referencia#".") & (($t_referencia#"")))
			
			C_BOOLEAN:C305($b_convenioVacio)
			C_TEXT:C284($t_webService;$t_ref;$t_servicio)
			
			$b_convenioVacio:=False:C215
			$t_ref:=ST_GetWord ($t_referencia;1;".")
			$t_webService:=ST_GetWord ($t_referencia;2;".")
			
			WEB SERVICE SET PARAMETER:C777("rol";<>gRolBD)
			WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
			  //WEB SERVICE SET PARAMETER("referencia";$t_referencia)
			
			  // Modificado por: Saul Ponce (26/02/2018)
			If ("consulta_referencia_x_id"=$t_webService)
				If (vsACT_ConvenioBanco#"")
					WEB SERVICE SET PARAMETER:C777("id";$t_ref)
					WEB SERVICE SET PARAMETER:C777("convenio";vsACT_ConvenioBanco)
					$b_convenioVacio:=True:C214
				End if 
			Else 
				WEB SERVICE SET PARAMETER:C777("referencia";$t_ref)
			End if 
			
			If ($t_webService#"")
				
				  //WEB SERVICE SET PARAMETER("rol";<>gRolBD)
				  //WEB SERVICE SET PARAMETER("codigopais";<>vtXS_CountryCode)
				  //WEB SERVICE SET PARAMETER("referencia";$t_referencia)
				
				$vl_pID:=IT_UThermometer (1;0;__ ("Interrogando SchoolNet...");-1)
				
				  //$err:=SN3_CallWebService ("sn3ws_PagoOnline_proceso.consulta_referencia")
				$err:=SN3_CallWebService ("sn3ws_PagoOnline_proceso."+$t_webService)
				
				IT_UThermometer (-2;$vl_pID)
				If ($err="")
					WEB SERVICE GET RESULT:C779($t_json;"resultado";*)
					
					If (ok=1)
						  //If ($t_json#"false")
						If (($t_json#"false") & (($t_json#"")))  //20171129 RCH
							
							If ($t_json#"null")
								  //201700220 RCH Se cambia a manejo con objecto
								C_OBJECT:C1216($ob)
								$ob:=JSON Parse:C1218($t_json)
								$t_referencia:=OB Get:C1224($ob;"referencia")
								$t_avisos:=OB Get:C1224($ob;"avisos")
								$t_montos:=OB Get:C1224($ob;"montos")
								  //$t_montos:=Replace string($t_montos;".";<>tXS_RS_DecimalSeparator) // Modificado por: Saul Ponce (20-03-2018) Ticket 201650, los montos fueron enviados con formato a SN
								  //$t_montos:=Replace string($t_montos;",";<>tXS_RS_DecimalSeparator) // intentar determinar el separador decimal a utilizar podría no funcionar en todos los casos
								$t_montototal:=OB Get:C1224($ob;"montototal")
								  //$t_montototal:=Replace string($t_montototal;".";<>tXS_RS_DecimalSeparator) // Modificado por: Saul Ponce (20-03-2018) Ticket 201650, los montos fueron enviados con formato a SN
								  //$t_montototal:=Replace string($t_montototal;",";<>tXS_RS_DecimalSeparator) 
								$t_idrelfamiliar:=OB Get:C1224($ob;"idrelfamiliar")
								$t_fecha_pago:=OB Get:C1224($ob;"fecha_pago")
								$t_fecha_pago:=Substring:C12($t_fecha_pago;1;10)
								
								ARRAY LONGINT:C221($al_idsAC;0)
								AT_Text2Array (->$al_idsAC;$t_avisos)
								
								  // Modificado por: Saul Ponce (13/03/2018) Ticket 193649, cambio el tipo de array porque el Json que recibimos viene con separador de miles y decimales y 4D se equivoca al asignar "|Despliegue_ACT_Pagos"
								  //ARRAY REAL($ar_montos;0)
								  //AT_Text2Array (->$ar_montos;$t_montos)
								
								ARRAY TEXT:C222($at_montos;0)
								AT_Text2Array (->$at_montos;$t_montos)
								
								For ($l_indice;1;Size of array:C274($al_idsAC))
									  //AT_Insert (1;1;->atACT_referencia;->alACT_idAviso;->arACT_monto;->arACT_total;->atACT_apoderado;->atACT_alumno;->adACT_fechaPago)
									  //AT_Insert (1;1;->atACT_referencia;->alACT_idAviso;->arACT_monto;->arACT_total;->atACT_alumno;->adACT_fechaPago)
									AT_Insert (1;1;->atACT_referencia;->alACT_idAviso;->atACT_monto;->arACT_total;->atACT_apoderado;->atACT_alumno;->adACT_fechaPago)
									atACT_referencia{1}:=$t_referencia
									alACT_idAviso{1}:=$al_idsAC{$l_indice}
									  //arACT_monto{1}:=$ar_montos{$l_indice}  
									atACT_monto{1}:=$at_montos{$l_indice}
									arACT_total{1}:=Num:C11($t_montototal)
									
									READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
									READ ONLY:C145([ACT_Documentos_de_Cargo:174])
									READ ONLY:C145([ACT_Cargos:173])
									READ ONLY:C145([ACT_CuentasCorrientes:175])
									
									QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=alACT_idAviso{1})
									If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
										If ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
											atACT_apoderado{1}:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)
										Else 
											atACT_apoderado{1}:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;->[ACT_Terceros:138]Nombre_Completo:9)
										End if 
										If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
											KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
											atACT_alumno{1}:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)
										Else 
											ARRAY TEXT:C222($atACT_nombres;0)
											QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
											KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
											KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
											SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$atACT_nombres)
											atACT_alumno{1}:=AT_array2text (->$atACT_nombres;"-")
										End if 
									Else 
										atACT_apoderado{1}:="Aviso de Cobranza eliminado"
										atACT_alumno{1}:="-"
										  //atACT_alumno{1}:="Aviso de Cobranza no encontrado"
									End if 
									
									adACT_fechaPago{1}:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fecha_pago;9;2));Num:C11(Substring:C12($t_fecha_pago;6;2));Num:C11(Substring:C12($t_fecha_pago;1;4)))
								End for 
								
								$t_retorno:="1"
								
							Else 
								CD_Dlog (0;"Respuesta del servicio  nula.")
							End if 
							
						Else 
							CD_Dlog (0;"Referencia no encontrada.")
						End if 
					End if 
				Else 
					CD_Dlog (0;"Error al conectarse a SchoolNet: "+$err+".")
				End if 
			Else 
				If ($b_convenioVacio)
					$t_msjError:="El texto ingresado fue identificado como un ID, pero no seleccionó el banco requerido."
				Else 
					$t_msjError:="Ocurrió un error al setear los parámetros del Web Service."
				End if 
				CD_Dlog (0;$t_msjError)
			End if 
		End if 
		
		OBJECT SET ENABLED:C1123(*;"bBanco@";True:C214)
		
	: ($t_accion="declaraArreglos")
		ARRAY TEXT:C222(atACT_referencia;0)
		ARRAY LONGINT:C221(alACT_idAviso;0)
		  //ARRAY REAL(arACT_monto;0)
		ARRAY TEXT:C222(atACT_monto;0)
		ARRAY REAL:C219(arACT_total;0)
		ARRAY TEXT:C222(atACT_apoderado;0)
		ARRAY TEXT:C222(atACT_alumno;0)
		ARRAY DATE:C224(adACT_fechaPago;0)
		ACT_OpcionesReferenciasMX ("declaraArreglosCargos")
		
	: ($t_accion="declaraArreglosCargos")
		ARRAY DATE:C224(adACT_cargoVencimiento;0)
		ARRAY TEXT:C222(atACT_cargoAlumno;0)
		ARRAY TEXT:C222(atACT_cargoNombre;0)
		ARRAY TEXT:C222(atACT_cargoMoneda;0)
		ARRAY REAL:C219(arACT_cargoMonto;0)
		ARRAY REAL:C219(arACT_cargoSaldo;0)
		
	: ($t_accion="cargaDetalleCargos")
		ACT_OpcionesReferenciasMX ("declaraArreglosCargos")
		
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		C_LONGINT:C283($col;$line)
		C_POINTER:C301($ptr)
		
		LISTBOX GET CELL POSITION:C971(lb_referencias;$col;$line;$ptr)
		If ($line<=Size of array:C274(atACT_referencia))
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=alACT_idAviso{$line})
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			
			ARRAY LONGINT:C221($alACT_recNumsCargos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumsCargos;"")
			For ($l_indice;1;Size of array:C274($alACT_recNumsCargos))
				GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumsCargos{$l_indice})
				APPEND TO ARRAY:C911(adACT_cargoVencimiento;[ACT_Cargos:173]Fecha_de_Vencimiento:7)
				KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				APPEND TO ARRAY:C911(atACT_cargoAlumno;ST_UppercaseFirstLetter ([Alumnos:2]apellidos_y_nombres:40))
				APPEND TO ARRAY:C911(atACT_cargoNombre;ST_UppercaseFirstLetter ([ACT_Cargos:173]Glosa:12))
				APPEND TO ARRAY:C911(atACT_cargoMoneda;[ACT_Cargos:173]Moneda:28)
				APPEND TO ARRAY:C911(arACT_cargoMonto;[ACT_Cargos:173]Monto_Neto:5)
				APPEND TO ARRAY:C911(arACT_cargoSaldo;[ACT_Cargos:173]Saldo:23)
			End for 
			
			vtACT_idACSel:=String:C10(alACT_idAviso{$line})
			vtACT_textoAC:=__ ("Detalle de cargos del Aviso de Cobranza ")+vtACT_idACSel
			
		End if 
		
		
	: ($t_accion="procesaTextoIngresado")
		
		C_LONGINT:C283($l_numero)
		C_REAL:C285($l_largo)
		C_TEXT:C284($t_textoIngresado;$t_servicio)
		
		$t_retorno:=""
		$t_servicio:=""
		$t_textoIngresado:=$vy_parametro1->
		$l_largo:=Length:C16($t_textoIngresado)
		
		If ($l_largo>=15)
			$t_retorno:=$t_textoIngresado
			$t_servicio:="consulta_referencia"
		Else 
			If ($l_largo=3)
				$l_numero:=Num:C11($vy_parametro1->)
				If (($l_numero>=1) & ($l_numero<=129))
					$t_retorno:=$t_textoIngresado
					$t_servicio:="consulta_referencia_x_id"
				End if 
			End if 
		End if 
		
		$t_retorno:=$t_retorno+"."+$t_servicio
		
End case 

$0:=$t_retorno
