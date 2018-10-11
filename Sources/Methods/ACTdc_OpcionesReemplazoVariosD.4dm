//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): roberto
  // Fecha y hora: 28-07-12, 14:00:20
  // ----------------------------------------------------
  // Método: ACTdc_OpcionesReemplazoVariosD
  // Descripción
  // metodo para controlar lo que tiene que ver con el reemplazo de uno o mas documentos por varias formas de pago
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$vt_accion;$0;$vt_retorno)
C_POINTER:C301($vy_pointer1)
C_POINTER:C301(${2})

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArreglosDetallePagos")
		  //cuadro resumen
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosResumen")
		  //cheque
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetalleCheques")
		  //tarjeta credito
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetalleTC")
		  //letra
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetalleLetra")
		  //redcompra
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetalleRedcompra")
		  //otros
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetalleOtros")
		
		ARRAY LONGINT:C221(alACTReemp_IdsDocs2Reemp;0)
		ARRAY LONGINT:C221(alACTReemp_IdsEstados;0)
		
		  //20120912 RCH Para intentar quitar un error en conpilado...
		ARRAY BOOLEAN:C223(lb_formasPago;0)
		
		vrACT_MontoAReemplazarXFP:=0
		vrACT_MontoAReemplazos:=0
		vrACT_SaldoAReemplazar:=0
		
	: ($vt_accion="DeclaraArreglosResumen")
		ARRAY TEXT:C222(atACTreemp_ResForma;0)
		ARRAY LONGINT:C221(alACTreemp_ResForma;0)
		ARRAY REAL:C219(arACTreemp_ResTotal;0)
		ARRAY TEXT:C222(atACTreemp_ResDetalle;0)
		ARRAY LONGINT:C221(alACTreemp_ResRef;0)
		
	: ($vt_accion="DeclaraArreglosDetalleCheques")
		ARRAY DATE:C224(adACTreemp_CH_Fecha;0)
		ARRAY TEXT:C222(atACTreemp_CH_NoCta;0)
		ARRAY TEXT:C222(atACTreemp_CH_Titular;0)
		ARRAY TEXT:C222(atACTreemp_CH_Banco;0)
		ARRAY TEXT:C222(atACTreemp_CH_Serie;0)
		ARRAY REAL:C219(arACTreemp_CH_Monto;0)
		ARRAY TEXT:C222(atACTreemp_CH_BancoC;0)
		
	: ($vt_accion="DeclaraArreglosDetalleTC")
		ARRAY TEXT:C222(atACTreemp_TC_Op;0)
		ARRAY TEXT:C222(atACTreemp_TC_TipoT;0)
		ARRAY TEXT:C222(atACTreemp_TC_BE;0)
		ARRAY TEXT:C222(atACTreemp_TC_BEC;0)
		ARRAY TEXT:C222(atACTreemp_TC_NumT;0)
		ARRAY TEXT:C222(atACTreemp_TC_VencM;0)
		ARRAY TEXT:C222(atACTreemp_TC_VencA;0)
		ARRAY TEXT:C222(atACTreemp_TC_Tit;0)
		ARRAY TEXT:C222(atACTreemp_TC_RutT;0)
		ARRAY REAL:C219(arACTreemp_TC_Monto;0)
		
	: ($vt_accion="DeclaraArreglosDetalleLetra")
		ARRAY TEXT:C222(atACTreemp_L_Num;0)
		ARRAY DATE:C224(afACTreemp_L_FE;0)
		ARRAY DATE:C224(afACTreemp_L_FV;0)
		ARRAY TEXT:C222(atACTreemp_L_Tit;0)
		ARRAY TEXT:C222(atACTreemp_L_RutTit;0)
		ARRAY REAL:C219(arACTreemp_L_Monto;0)
		
	: ($vt_accion="DeclaraArreglosDetalleRedcompra")
		ARRAY TEXT:C222(atACTreemp_RC_NumO;0)
		ARRAY REAL:C219(arACTreemp_RC_Monto;0)
		  //********Ticket 116401
		ARRAY TEXT:C222(atACTreemp_RC_TipoT;0)
		ARRAY TEXT:C222(atACTreemp_RC_BE;0)
		ARRAY TEXT:C222(atACTreemp_RC_BEC;0)
		ARRAY TEXT:C222(atACTreemp_RC_NumT;0)
		ARRAY TEXT:C222(atACTreemp_RC_VencM;0)
		ARRAY TEXT:C222(atACTreemp_RC_VencA;0)
		ARRAY TEXT:C222(atACTreemp_RC_Tit;0)
		ARRAY TEXT:C222(atACTreemp_RC_RutT;0)
		  //**************
	: ($vt_accion="DeclaraArreglosDetalleOtros")
		ARRAY TEXT:C222(atACTreemp_OT_Forma;0)
		ARRAY LONGINT:C221(alACTreemp_OT_Forma;0)
		ARRAY REAL:C219(arACTreemp_OT_Monto;0)
		
	: ($vt_accion="AgregaPagos")
		If (vrACT_MontoAReemplazarXFP>0)
			$vr_montoYaReemp:=AT_GetSumArray (->arACTreemp_ResTotal)
			
			If (($vr_montoYaReemp+vrACT_MontoAReemplazarXFP)<=vrACT_MontoAReemplazar)
				
				$Reemplazar:=ACTdc_ValidaDocReemplazador (Find in array:C230(aACT_DocsReemp;vsACT_DocsReemp2);True:C214)
				If ($Reemplazar)
					$vt_detalle:=""
					$vl_referencia:=0
					Case of 
						: (vlACT_ReempPor2=-4)  // cheque
							ARRAY LONGINT:C221($al_banco;0)
							ARRAY LONGINT:C221($al_cuenta;0)
							ARRAY LONGINT:C221($al_serie;0)
							ARRAY LONGINT:C221($al_resultado;0)
							ARRAY LONGINT:C221($al_resultadoF;0)
							
							atACTreemp_CH_BancoC{0}:=vACT_BancoCodigo
							AT_SearchArray (->atACTreemp_CH_BancoC;"=";->$al_banco)
							atACTreemp_CH_NoCta{0}:=vACT_Cuenta
							AT_SearchArray (->atACTreemp_CH_NoCta;"=";->$al_cuenta)
							atACTreemp_CH_Serie{0}:=vACT_Serie
							AT_SearchArray (->atACTreemp_CH_Serie;"=";->$al_serie)
							
							AT_intersect (->$al_banco;->$al_cuenta;->$al_resultado)
							AT_intersect (->$al_resultado;->$al_serie;->$al_resultadoF)
							
							If (Size of array:C274($al_resultadoF)=0)
								APPEND TO ARRAY:C911(adACTreemp_CH_Fecha;vACT_FechaDoc)
								APPEND TO ARRAY:C911(atACTreemp_CH_NoCta;vACT_Cuenta)
								APPEND TO ARRAY:C911(atACTreemp_CH_Titular;vACT_Titular)
								APPEND TO ARRAY:C911(atACTreemp_CH_Banco;vACT_BancoNombre)
								APPEND TO ARRAY:C911(atACTreemp_CH_Serie;vACT_Serie)
								APPEND TO ARRAY:C911(arACTreemp_CH_Monto;vrACT_MontoAReemplazarXFP)
								APPEND TO ARRAY:C911(atACTreemp_CH_BancoC;vACT_BancoCodigo)
								
								$vt_detalle:=String:C10(vACT_FechaDoc)
								$vl_referencia:=Size of array:C274(adACTreemp_CH_Fecha)
								
								vACT_FechaDoc:=Add to date:C393(vACT_FechaDoc;0;1;0)
								vACT_Serie:=String:C10(Num:C11(vACT_Serie)+1)
								vtACT_FechaDoc:=String:C10(vACT_FechaDoc)
							Else 
								$Reemplazar:=False:C215
								CD_Dlog (0;__ ("Ya existe un documento ingresado para el mismo banco, cuenta y serie."))
							End if 
							
						: (vlACT_ReempPor2=-6)  // TC
							If (Find in array:C230(atACTreemp_TC_Op;vtACT_TCDocumento)=-1)
								APPEND TO ARRAY:C911(atACTreemp_TC_Op;vtACT_TCDocumento)
								APPEND TO ARRAY:C911(atACTreemp_TC_TipoT;vtACT_TCTipo)
								APPEND TO ARRAY:C911(atACTreemp_TC_BE;vtACT_TCBancoEmisor)
								APPEND TO ARRAY:C911(atACTreemp_TC_BEC;vtACT_TCBancoCodigo)
								APPEND TO ARRAY:C911(atACTreemp_TC_NumT;vtACT_TCNumero)
								APPEND TO ARRAY:C911(atACTreemp_TC_VencM;vtACT_TCMesVencimiento)
								APPEND TO ARRAY:C911(atACTreemp_TC_VencA;vtACT_TCAgnoVencimiento)
								APPEND TO ARRAY:C911(atACTreemp_TC_Tit;vtACT_TCTitular)
								APPEND TO ARRAY:C911(atACTreemp_TC_RutT;vtACT_TCRUTTitular)
								APPEND TO ARRAY:C911(arACTreemp_TC_Monto;vrACT_MontoAReemplazarXFP)
								
								$vt_detalle:=vtACT_TCDocumento
								$vl_referencia:=Size of array:C274(atACTreemp_TC_Op)
							Else 
								$Reemplazar:=False:C215
								CD_Dlog (0;__ ("Operación ya ingresada."))
							End if 
							
						: (vlACT_ReempPor2=-8)  // Letra
							
							If (Find in array:C230(atACTreemp_L_Num;vtACT_LDocumento)=-1)
								APPEND TO ARRAY:C911(atACTreemp_L_Num;vtACT_LDocumento)
								APPEND TO ARRAY:C911(afACTreemp_L_FE;vdACT_LFechaEmision)
								APPEND TO ARRAY:C911(afACTreemp_L_FV;vdACT_LFechaVencimiento)
								APPEND TO ARRAY:C911(atACTreemp_L_Tit;vtACT_LTitular)
								APPEND TO ARRAY:C911(atACTreemp_L_RutTit;vtACT_LRUTTitular)
								APPEND TO ARRAY:C911(arACTreemp_L_Monto;vrACT_MontoAReemplazarXFP)
								
								$vt_detalle:=vtACT_LDocumento
								$vl_referencia:=Size of array:C274(atACTreemp_L_Num)
								
								vtACT_LDocumento:=String:C10(Num:C11(vtACT_LDocumento)+1)
							Else 
								$Reemplazar:=False:C215
								CD_Dlog (0;__ ("Documento ya ingresado."))
							End if 
							
						: (vlACT_ReempPor2=-7)
							If (Find in array:C230(atACTreemp_RC_NumO;vtACT_RDocumento)=-1)
								APPEND TO ARRAY:C911(atACTreemp_RC_NumO;vtACT_RDocumento)
								APPEND TO ARRAY:C911(arACTreemp_RC_Monto;vrACT_MontoAReemplazarXFP)
								  //******Ticket 116401
								APPEND TO ARRAY:C911(atACTreemp_RC_TipoT;vtACT_TDTipo)
								APPEND TO ARRAY:C911(atACTreemp_RC_BE;vtACT_TDBancoEmisor)
								APPEND TO ARRAY:C911(atACTreemp_RC_BEC;vtACT_TDBancoCodigo)
								APPEND TO ARRAY:C911(atACTreemp_RC_NumT;vtACT_TDNumero)
								APPEND TO ARRAY:C911(atACTreemp_RC_VencM;vtACT_TDMesVencimiento)
								APPEND TO ARRAY:C911(atACTreemp_RC_VencA;vtACT_TDAgnoVencimiento)
								APPEND TO ARRAY:C911(atACTreemp_RC_Tit;vtACT_TDTitular)
								APPEND TO ARRAY:C911(atACTreemp_RC_RutT;vtACT_TDRUTTitular)
								  // /*********************
								$vt_detalle:=vtACT_RDocumento
								$vl_referencia:=Size of array:C274(atACTreemp_RC_NumO)
							Else 
								$Reemplazar:=False:C215
								CD_Dlog (0;__ ("Operación ya ingresada."))
							End if 
							
						Else 
							
							ARRAY LONGINT:C221($al_forma;0)
							ARRAY LONGINT:C221($al_monto;0)
							ARRAY LONGINT:C221($al_resultadoF;0)
							
							alACTreemp_OT_Forma{0}:=vlACT_ReempPor2
							AT_SearchArray (->alACTreemp_OT_Forma;"=";->$al_forma)
							
							arACTreemp_OT_Monto{0}:=vrACT_MontoAReemplazarXFP
							AT_SearchArray (->arACTreemp_OT_Monto;"=";->$al_monto)
							
							AT_intersect (->$al_forma;->$al_monto;->$al_resultadoF)
							
							Case of 
								: (Size of array:C274($al_resultadoF)>0)
									$vl_resp:=CD_Dlog (0;__ ("Ya existe un pago con la misma forma de pago y el mismo monto.")+"\r\r"+__ ("¿Desea agregar un nuevo pago?");"";__ ("Si");__ ("No"))
								: (Size of array:C274($al_forma)>0)
									$vl_resp:=CD_Dlog (0;__ ("Ya existe un pago con la misma forma de pago.")+"\r\r"+__ ("¿Desea agregar un nuevo pago?");"";__ ("Si");__ ("No"))
								Else 
									$vl_resp:=1
							End case 
							
							If ($vl_resp=1)
								APPEND TO ARRAY:C911(atACTreemp_OT_Forma;vsACT_DocsReemp2)
								APPEND TO ARRAY:C911(alACTreemp_OT_Forma;vlACT_ReempPor2)
								APPEND TO ARRAY:C911(arACTreemp_OT_Monto;vrACT_MontoAReemplazarXFP)
								
								$vl_referencia:=Size of array:C274(atACTreemp_OT_Forma)
							Else 
								$Reemplazar:=False:C215
							End if 
							
					End case 
					
					  //arreglos de resumen
					If ($Reemplazar)
						  //$vl_pos:=Find in array(alACTreemp_ResForma;vlACT_ReempPor2)
						  //If ($vl_pos=-1)
						  //APPEND TO ARRAY(atACTreemp_ResForma;vsACT_DocsReemp2)
						  //APPEND TO ARRAY(alACTreemp_ResForma;vlACT_ReempPor2)
						  //APPEND TO ARRAY(alACTreemp_ResCant;1)
						  //APPEND TO ARRAY(arACTreemp_ResTotal;vrACT_MontoAReemplazarXFP)
						  //GET PICTURE FROM LIBRARY("Ojito";$vp_picure)
						  //APPEND TO ARRAY(apACTreemp_ResVer;$vp_picure)  //AGREGAR OJO
						  //Else 
						  //alACTreemp_ResCant{$vl_pos}:=alACTreemp_ResCant{$vl_pos}+1
						  //arACTreemp_ResTotal{$vl_pos}:=arACTreemp_ResTotal{$vl_pos}+vrACT_MontoAReemplazarXFP
						  //End if 
						
						APPEND TO ARRAY:C911(atACTreemp_ResForma;vsACT_DocsReemp2)
						APPEND TO ARRAY:C911(alACTreemp_ResForma;vlACT_ReempPor2)
						APPEND TO ARRAY:C911(arACTreemp_ResTotal;vrACT_MontoAReemplazarXFP)
						APPEND TO ARRAY:C911(atACTreemp_ResDetalle;$vt_detalle)
						APPEND TO ARRAY:C911(alACTreemp_ResRef;$vl_referencia)
						
						SORT ARRAY:C229(alACTreemp_ResForma;atACTreemp_ResForma;arACTreemp_ResTotal;atACTreemp_ResDetalle;alACTreemp_ResRef;<)
						
						LISTBOX COLLAPSE:C1101(lb_formasPago)
						$vl_row:=Find in array:C230(atACTreemp_ResForma;vsACT_DocsReemp2)
						$vl_col:=1
						LISTBOX SELECT BREAK:C1117(lb_formasPago;$vl_row;$vl_col)
						
						ARRAY LONGINT:C221($al_formas;0)
						ARRAY LONGINT:C221($al_referencias;0)
						ARRAY LONGINT:C221($al_interseccion;0)
						alACTreemp_ResForma{0}:=vlACT_ReempPor2
						AT_SearchArray (->alACTreemp_ResForma;"=";->$al_formas)
						alACTreemp_ResRef{0}:=$vl_referencia
						AT_SearchArray (->alACTreemp_ResRef;"=";->$al_referencias)
						AT_intersect (->$al_formas;->$al_referencias;->$al_interseccion)
						
						
						LISTBOX EXPAND:C1100(lb_formasPago;False:C215;lk break row:K53:18;$vl_row;$vl_col)
						LISTBOX SELECT ROW:C912(lb_formasPago;0;lk remove from selection:K53:3)
					End if 
					
					vrACT_MontoAReemplazarXFP:=0
					vrACT_MontoAReemplazos:=AT_GetSumArray (->arACTreemp_ResTotal)
					vrACT_SaldoAReemplazar:=vrACT_MontoAReemplazar-vrACT_MontoAReemplazos
				End if 
				
			Else 
				CD_Dlog (0;__ ("El monto de los reemplazos no puede ser mayor al monto a reemplazar."))
			End if 
		Else 
			CD_Dlog (0;__ ("Ingrese un monto para el reemplazo con esta forma de pago."))
		End if 
		ACTdc_OpcionesReemplazoVariosD ("SetDeleteIcon")
		
	: ($vt_accion="SetDeleteIcon")
		ARRAY LONGINT:C221($DA_Return;0)
		lb_formasPago{0}:=True:C214
		AT_SearchArray (->lb_formasPago;"=";->$DA_Return)
		OBJECT SET ENABLED:C1123(bDelArrayElement;(Size of array:C274($DA_Return)>0))
		
		ACTdc_OpcionesReemplazoMasivo ("SetNextIngresar")
		
	: ($vt_accion="EliminaPago")
		
		$vl_eliminado:=Find in array:C230(lb_formasPago;True:C214)
		If ($vl_eliminado>0)
			$vl_resp:=CD_Dlog (0;__ ("¿Está seguro de que desea quitar el pago con forma de pago ")+ST_Qte (atACTreemp_ResForma{$vl_eliminado})+__ (", por ")+String:C10(arACTreemp_ResTotal{$vl_eliminado};"|Despliegue_ACT_Pagos")+"?";"";__ ("Si");__ ("No"))
			If ($vl_resp=1)
				$vl_indice:=alACTreemp_ResRef{$vl_eliminado}
				$vlACT_ReempPor:=alACTreemp_ResForma{$vl_eliminado}
				Case of 
					: ($vlACT_ReempPor=-4)  // cheque
						AT_Delete ($vl_indice;1;->adACTreemp_CH_Fecha;->atACTreemp_CH_NoCta;->atACTreemp_CH_Titular;->atACTreemp_CH_Banco;->atACTreemp_CH_Serie;->arACTreemp_CH_Monto;->atACTreemp_CH_BancoC)
						
					: ($vlACT_ReempPor=-6)  // TC
						AT_Delete ($vl_indice;1;->atACTreemp_TC_Op;->atACTreemp_TC_TipoT;->atACTreemp_TC_BE;->atACTreemp_TC_BEC;->atACTreemp_TC_NumT;->atACTreemp_TC_VencM;->atACTreemp_TC_VencA;->atACTreemp_TC_Tit;->atACTreemp_TC_RutT;->arACTreemp_TC_Monto)
						
					: ($vlACT_ReempPor=-8)  // Letra
						AT_Delete ($vl_indice;1;->atACTreemp_L_Num;->afACTreemp_L_FE;->afACTreemp_L_FV;->atACTreemp_L_Tit;->atACTreemp_L_RutTit;->arACTreemp_L_Monto)
						
					: ($vlACT_ReempPor=-7)
						  //AT_Delete ($vl_indice;1;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto)
						  // Ticket 116401
						AT_Delete ($vl_indice;1;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto;->atACTreemp_RC_TipoT;->atACTreemp_RC_BE;->atACTreemp_RC_BEC;->atACTreemp_RC_NumT;->atACTreemp_RC_VencM;->atACTreemp_RC_VencA;->atACTreemp_RC_Tit;->atACTreemp_RC_RutT)
						
					Else 
						AT_Delete ($vl_indice;1;->atACTreemp_OT_Forma;->alACTreemp_OT_Forma;->arACTreemp_OT_Monto)
				End case 
				
				AT_Delete ($vl_eliminado;1;->atACTreemp_ResForma;->alACTreemp_ResForma;->arACTreemp_ResTotal;->atACTreemp_ResDetalle;->alACTreemp_ResRef)
				
				  //***** DECREMENTO VALOR DE REFERENCIAS YA QUE SE ELIMINO UNA
				ARRAY LONGINT:C221($al_forma;0)
				ARRAY LONGINT:C221($al_referenciaMayor;0)
				ARRAY LONGINT:C221($al_result;0)
				alACTreemp_ResForma{0}:=$vlACT_ReempPor
				AT_SearchArray (->alACTreemp_ResForma;"=";->$al_forma)
				alACTreemp_ResRef{0}:=$vl_indice
				AT_SearchArray (->alACTreemp_ResRef;">=";->$al_referenciaMayor)
				AT_intersect (->$al_forma;->$al_referenciaMayor;->$al_result)
				For ($i;1;Size of array:C274($al_result))
					alACTreemp_ResRef{$al_result{$i}}:=alACTreemp_ResRef{$al_result{$i}}-1
				End for 
				  //***** DECREMENTO VALOR DE REFERENCIAS YA QUE SE ELIMINO UNA
				
				vrACT_MontoAReemplazarXFP:=0
				vrACT_MontoAReemplazos:=AT_GetSumArray (->arACTreemp_ResTotal)
				vrACT_SaldoAReemplazar:=vrACT_MontoAReemplazar-vrACT_MontoAReemplazos
				ACTdc_OpcionesReemplazoVariosD ("SetDeleteIcon")
			End if 
		End if 
		
End case 

$0:=$vt_retorno
