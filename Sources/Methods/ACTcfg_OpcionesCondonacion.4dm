//%attributes = {}
  //ACTcfg_OpcionesCondonacion

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1)
C_BOOLEAN:C305($vb_continuar)
$vt_accion:=$1
$0:=True:C214

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 
If (Count parameters:C259>=7)
	$ptr6:=$7
End if 
If (Count parameters:C259>=8)
	$ptr7:=$8
End if 

Case of 
	: ($vt_accion="DeclaraVars")
		C_LONGINT:C283(cbSolicitaMotivoCondonacion;cbCondonacionDescuento;cbCondonacionCargo;cbCondonacionAviso;cb_condonaDesdeMenu)
		C_TEXT:C284(vtACT_ObsDocs;vt_MotivoCondonaDescuento)
		C_BOOLEAN:C305(vb_CondonaDescuento;vb_CondonaCargo;vb_CondonaAviso;vb_CondonaAvisos;vb_CondonaDesdeMenu)
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesCondonacion ("DeclaraVars")
		cbSolicitaMotivoCondonacion:=0
		cbCondonacionDescuento:=0
		cbCondonacionCargo:=0
		cbCondonacionAviso:=0
		cb_condonaDesdeMenu:=0
		vtACT_ObsDocs:=""
		vt_MotivoCondonaDescuento:=""
		vb_CondonaDescuento:=False:C215
		vb_CondonaCargo:=False:C215
		vb_CondonaAviso:=False:C215
		vb_CondonaAvisos:=False:C215
		vb_CondonaDesdeMenu:=False:C215
		vb_validaObsVacia:=False:C215  //se utiliza en el form de las observaciones
		
	: ($vt_accion="LeeBlob")
		C_BOOLEAN:C305($vb_CondonaDescuento;$vb_CondonaCargo;$vb_CondonaAviso;$vb_CondonaAvisos;$vb_CondonaDesdeMenu)
		C_TEXT:C284($vt_MotivoCondonaDescuento)
		ACTcfg_OpcionesCondonacion ("DeclaraVars")
		Case of 
			: (vb_CondonaDescuento)
				$vb_CondonaDescuento:=True:C214
			: (vb_CondonaCargo)
				$vb_CondonaCargo:=True:C214
			: (vb_CondonaAviso)
				$vb_CondonaAviso:=True:C214
			: (vb_CondonaAvisos)
				$vb_CondonaAvisos:=True:C214
			: (vb_CondonaDesdeMenu)
				$vb_CondonaDesdeMenu:=True:C214
		End case 
		If (vt_MotivoCondonaDescuento#"")
			$vt_MotivoCondonaDescuento:=vt_MotivoCondonaDescuento
		End if 
		ACTcfg_LeeBlob ("ACTcfg_Condonaciones")
		Case of 
			: ($vb_CondonaDescuento)
				vb_CondonaDescuento:=True:C214
			: ($vb_CondonaCargo)
				vb_CondonaCargo:=True:C214
			: ($vb_CondonaAviso)
				vb_CondonaAviso:=True:C214
			: ($vb_CondonaAvisos)
				vb_CondonaAvisos:=True:C214
			: ($vb_CondonaDesdeMenu)
				vb_CondonaDesdeMenu:=True:C214
		End case 
		If ($vt_MotivoCondonaDescuento#"")
			vt_MotivoCondonaDescuento:=$vt_MotivoCondonaDescuento
		End if 
	: ($vt_accion="GuardaBlob")
		ACTcfg_GuardaBlob ("ACTcfg_Condonaciones")
		
	: ($vt_accion="SolicitaMotivo")
		ACTcfg_OpcionesCondonacion ("LeeBlob")
		If (cbSolicitaMotivoCondonacion=1)
			$vb_continuar:=ACTcfg_OpcionesCondonacion ("ValidaContinuacion")
			If ($vb_continuar)
				If (vt_MotivoCondonaDescuento#"")
					vtACT_ObsDocs:=vt_MotivoCondonaDescuento
					vb_CondonaDescuento:=True:C214
				End if 
				vb_validaObsVacia:=True:C214
				vt_Dlog:=__ ("Estimado usuario, el motivo de la condonación no puede ser vacío.")
				WDW_OpenFormWindow (->[xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar";0;Movable form dialog box:K39:8;__ ("Ingrese motivo de condonación"))
				DIALOG:C40([xxACT_DesctosXItem:103];"ACTpgs_ObsDocumentar")
				CLOSE WINDOW:C154
				If (ok=1)
					If (vb_CondonaDescuento)
						vt_MotivoCondonaDescuento:=vtACT_ObsDocs
					End if 
				Else 
					$0:=False:C215
				End if 
			End if 
		End if 
	: ($vt_accion="GuardaMotivo")
		If (cbSolicitaMotivoCondonacion=1)
			If (vb_CondonaAvisos)
				vb_CondonaAviso:=True:C214
			End if 
			$vb_continuar:=ACTcfg_OpcionesCondonacion ("ValidaContinuacion")
			  //End if 
			If ($vb_continuar)
				If (vtACT_ObsDocs="")
					LOG_RegisterEvt ("El usuario "+<>tUSR_CurrentUser+" no ingresó un motivo de condonación")
				End if 
				Case of 
					: (vb_CondonaDescuento)
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_Cargos:173])
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-1;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-10)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY LONGINT:C221($ids_cuentasCtes;0)
							ARRAY LONGINT:C221($ids_cuentasCtes2;0)
							ARRAY REAL:C219($ar_montos;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;$ar_montos;[ACT_Cargos:173]ID_CuentaCorriente:2;$ids_cuentasCtes2)
							COPY ARRAY:C226($ids_cuentasCtes2;$ids_cuentasCtes)
							AT_DistinctsArrayValues (->$ids_cuentasCtes)
							For ($i;1;Size of array:C274($ids_cuentasCtes))
								$vl_idCuenta:=$ids_cuentasCtes{$i}
								$vl_idAviso:=0
								$vl_idPago:=[ACT_Pagos:172]ID:1
								$vt_periodo:=""
								$vr_monto:=Abs:C99(AT_GetSumArrayByArrayPos (->$vl_idCuenta;"=";->$ids_cuentasCtes2;->$ar_montos))
								$vt_itemCondonado:="Condonación al pago a través de descuento en caja."
								ACTcfg_OpcionesCondonacion ("CreaRegistro";->$vl_idCuenta;->$vl_idAviso;->$vl_idPago;->$vt_periodo;->$vr_monto;->vt_MotivoCondonaDescuento;->$vt_itemCondonado)
							End for 
						End if 
						REDUCE SELECTION:C351([ACT_Cargos:173];0)
						vt_MotivoCondonaDescuento:=""
					: (vb_CondonaCargo)
						$vl_idCuenta:=[ACT_Cargos:173]ID_CuentaCorriente:2
						$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
						$vl_idPago:=0
						$vt_periodo:=String:C10([ACT_Cargos:173]Año:14;"0000")+String:C10([ACT_Cargos:173]Mes:13;"00")
						$vr_monto:=[ACT_Cargos:173]Monto_Neto:5
						$vt_itemCondonado:="Condonación del cargo: "+[ACT_Cargos:173]Glosa:12
						ACTcfg_OpcionesCondonacion ("CreaRegistro";->$vl_idCuenta;->$vl_idAviso;->$vl_idPago;->$vt_periodo;->$vr_monto;->vtACT_ObsDocs;->$vt_itemCondonado)
					: (vb_CondonaAviso)
						ARRAY LONGINT:C221($al_recNumsCargos;0)
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Documentos_de_Cargo:174])
						QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
						KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
						ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2;>)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos)
						For ($i;1;Size of array:C274($al_recNumsCargos))
							KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumsCargos{$i})
							If ([ACT_Cargos:173]Monto_Neto:5>0)
								$vl_idCuenta:=[ACT_Cargos:173]ID_CuentaCorriente:2
								$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								$vl_idPago:=0
								$vt_periodo:=String:C10([ACT_Cargos:173]Año:14;"0000")+String:C10([ACT_Cargos:173]Mes:13;"00")
								$vr_monto:=[ACT_Cargos:173]Monto_Neto:5
								$vt_itemCondonado:="Condonación del cargo: "+[ACT_Cargos:173]Glosa:12
								ACTcfg_OpcionesCondonacion ("CreaRegistro";->$vl_idCuenta;->$vl_idAviso;->$vl_idPago;->$vt_periodo;->$vr_monto;->vtACT_ObsDocs;->$vt_itemCondonado)
							End if 
						End for 
					: (vb_CondonaDesdeMenu)
						For ($i;1;Size of array:C274(alACT_AvisosRecNumCargo))
							READ ONLY:C145([ACT_Cargos:173])
							GOTO RECORD:C242([ACT_Cargos:173];alACT_AvisosRecNumCargo{$i})
							$vl_idCuenta:=[ACT_Cargos:173]ID_CuentaCorriente:2
							$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							$vl_idPago:=0
							$vt_periodo:=String:C10([ACT_Cargos:173]Año:14;"0000")+String:C10([ACT_Cargos:173]Mes:13;"00")
							$vr_monto:=alACT_AvisosMontoCondonacion{$i}
							$vt_itemCondonado:="Condonación del cargo: "+[ACT_Cargos:173]Glosa:12
							ACTcfg_OpcionesCondonacion ("CreaRegistro";->$vl_idCuenta;->$vl_idAviso;->$vl_idPago;->$vt_periodo;->$vr_monto;->vtACT_ObsDocs;->$vt_itemCondonado)
						End for 
				End case 
			End if 
		End if 
	: ($vt_accion="CreaRegistro")
		  //ACTcfg_OpcionesCondonacion ("LeeBlob")
		If (cbSolicitaMotivoCondonacion=1)
			READ WRITE:C146([xxACT_ObservacionesCondonacion:137])
			CREATE RECORD:C68([xxACT_ObservacionesCondonacion:137])
			[xxACT_ObservacionesCondonacion:137]id_Observacion:1:=SQ_SeqNumber (->[xxACT_ObservacionesCondonacion:137]id_Observacion:1)
			[xxACT_ObservacionesCondonacion:137]id_CuentaCorriente:2:=$ptr1->
			[xxACT_ObservacionesCondonacion:137]id_Aviso:3:=$ptr2->
			[xxACT_ObservacionesCondonacion:137]id_Pago:4:=$ptr3->
			[xxACT_ObservacionesCondonacion:137]id_Usuario:5:=USR_GetUserID 
			[xxACT_ObservacionesCondonacion:137]PeriodoCondonado:6:=$ptr4->
			[xxACT_ObservacionesCondonacion:137]MontoCondonado:7:=$ptr5->
			[xxACT_ObservacionesCondonacion:137]MotivoCondonacion:9:=$ptr6->
			[xxACT_ObservacionesCondonacion:137]FechaCondonacion:8:=Current date:C33(*)
			[xxACT_ObservacionesCondonacion:137]GlosaCondonacion:10:=$ptr7->
			SAVE RECORD:C53([xxACT_ObservacionesCondonacion:137])
			KRL_UnloadReadOnly (->[xxACT_ObservacionesCondonacion:137])
		End if 
		
	: ($vt_accion="Interfaz")
		ACTcfg_OpcionesCondonacion ("LeeBlob")
		If (cbSolicitaMotivoCondonacion=1)
			$continue:=ACTcfg_OpcionesCondonacion ("SolicitaMotivo")
			If ($continue)
				ACTcfg_OpcionesCondonacion ("GuardaMotivo")
			End if 
			$0:=$continue
		End if 
		
	: ($vt_accion="ValidaContinuacion")
		$vb_continuar:=False:C215
		Case of 
			: (vb_CondonaDescuento)
				If (cbCondonacionDescuento=1)
					$vb_continuar:=True:C214
				End if 
			: (vb_CondonaCargo)
				If (cbCondonacionCargo=1)
					If ([ACT_Cargos:173]Monto_Neto:5>0)
						$vb_continuar:=True:C214
					End if 
				End if 
			: (vb_CondonaAviso)
				If (cbCondonacionAviso=1)
					C_LONGINT:C283($vl_cargos)
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					READ ONLY:C145([ACT_Cargos:173])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_cargos)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)
					REDUCE SELECTION:C351([ACT_Cargos:173];0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($vl_cargos>0)
						$vb_continuar:=True:C214
					End if 
				End if 
			: (vb_CondonaAvisos)
				If (cbCondonacionAviso=1)
					ARRAY LONGINT:C221($al_recNumsAvisos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos)
					vb_CondonaAviso:=True:C214
					For ($i;1;Size of array:C274($al_recNumsAvisos))
						KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos{$i})
						$vb_continuar:=ACTcfg_OpcionesCondonacion ("ValidaContinuacion")
						If ($vb_continuar)
							$i:=Size of array:C274($al_recNumsAvisos)
						End if 
					End for 
					vb_CondonaAviso:=False:C215
					CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$al_recNumsAvisos)
				End if 
				
			: (vb_CondonaDesdeMenu)
				If (cb_condonaDesdeMenu=1)
					C_LONGINT:C283($vl_cargos)
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					READ ONLY:C145([ACT_Cargos:173])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_cargos)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)
					REDUCE SELECTION:C351([ACT_Cargos:173];0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($vl_cargos>0)
						$vb_continuar:=True:C214
					End if 
				End if 
		End case 
		$0:=$vb_continuar
		
	: ($vt_accion="RetornaDlogNoContinuar")
		Case of 
			: (vb_CondonaDescuento)
				$ptr1->:=__ ("No es posible realizar el decuento ya que no se ingresó texto en la ventana de motivo de condonación. El descuento no fue realizado.")
			: (vb_CondonaCargo)
				$ptr1->:=__ ("No es posible continuar con la eliminación del cargo ya que no se ingresó texto en la ventana de motivo de condonación. El cargo no fue eliminado.")
			: (vb_CondonaAviso)
				$ptr1->:=__ ("No es posible continuar con la eliminación del aviso ya que no se ingresó texto en la ventana de motivo de condonación. El aviso no fue eliminado.")
			: (vb_CondonaAvisos)
				$ptr1->:=__ ("No es posible continuar con la eliminación de los avisos ya que no se ingresó texto en la ventana de motivo de condonación. Los avisos no fueron eliminados.")
			: (vb_CondonaDesdeMenu)
				$ptr1->:=__ ("No es posible continuar con la condonación de los cargos ya que no se ingresó texto en la ventana de motivo de condonación. Los cargos no fueron condonados.")
			Else 
				$ptr1->:=__ ("El proceso no pudo ser completado.")
		End case 
		
	: ($vt_accion="ValidacionesForm")
		IT_SetButtonState (cbSolicitaMotivoCondonacion=1;->cbCondonacionDescuento;->cbCondonacionCargo;->cbCondonacionAviso;->cb_condonaDesdeMenu)
		If (cbSolicitaMotivoCondonacion=0)
			ACTcfg_OpcionesCondonacion ("InitVars")
		End if 
End case 