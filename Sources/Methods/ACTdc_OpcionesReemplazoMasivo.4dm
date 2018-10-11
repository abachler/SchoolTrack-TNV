//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): roberto
  // Fecha y hora: 25-07-12, 13:27:08
  // ----------------------------------------------------
  // Método: ACTdc_OpcionesReemplazoMasivo
  // Descripción
  // metodo que reune el nuevo codigo que permitira reemplazar varios documentos a la vez
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$vt_accion;$0;$vt_retorno)
C_LONGINT:C283($vl_indice)
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_page)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="BuscaDocumentos")
		  //C_LONGINT($vl_idApdo;$vl_idTercero)
		  //
		  //$vl_idApdo:=[ACT_Documentos_en_Cartera]ID_Apoderado
		  //$vl_idTercero:=[ACT_Documentos_en_Cartera]ID_Tercero
		  //
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_en_Cartera:182];alACT_RecNumsDocs;"")
		  //If ($vl_idApdo#0)
		  //QUERY SELECTION([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID_Apoderado=$vl_idApdo)
		  //End if 
		  //If ($vl_idTercero#0)
		  //QUERY SELECTION([ACT_Documentos_en_Cartera];[ACT_Documentos_en_Cartera]ID_Tercero=$vl_idTercero)
		  //End if 
		QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Reemplazado:14=False:C215)
		
	: ($vt_accion="CargaArreglos")
		ACTdc_OpcionesReemplazoMasivo ("DeclaraArreglosLB")
		ARRAY LONGINT:C221($alACTlb_idDocCargo;0)
		SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]ID:1;alACTlb_ReempIDDoc;[ACT_Documentos_en_Cartera:182]Tipo_Doc:4;atACTlb_ReempTipoDoc;[ACT_Documentos_en_Cartera:182]Fecha_Doc:5;adACTlb_ReempFechaDoc;[ACT_Documentos_en_Cartera:182]Numero_Doc:6;atACTlb_ReempSerie;[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10;adACTlb_ReempFechaV;[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;alACTlb_ReempTitular;[ACT_Documentos_en_Cartera:182]Monto_Doc:7;arACTlb_ReempMontoPago;[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;$alACTlb_idDocCargo;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;alACTlb_IDFP;[ACT_Documentos_en_Cartera:182]id_estado:21;alACTlb_IDFPE)
		
		AT_RedimArrays (Size of array:C274(alACTlb_ReempIDDoc);->lb_formasPago)
		
		For ($i;1;Size of array:C274(alACTlb_ReempTitular))
			APPEND TO ARRAY:C911(atACTlb_ReempTitular;KRL_GetTextFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$alACTlb_idDocCargo{$i};->[ACT_Documentos_de_Pago:176]Titular:9))
			  //si los documentos a reemplazar son para el mismo apoderado, se seleccionan todos. Sino, se selecciona solo el primero
			If (($i=1) | (Count in array:C907(alACTlb_ReempTitular;alACTlb_ReempTitular{1})=Size of array:C274(alACTlb_ReempTitular)))
				APPEND TO ARRAY:C911(abACTlb_Reemp;True:C214)
			Else 
				APPEND TO ARRAY:C911(abACTlb_Reemp;False:C215)
			End if 
			
			  //estados por defecto para los documentos a reemplazar
			ACTdc_OpcionesGenerales ("CargaArregloEstadosXFdP";->alACTlb_IDFP{$i};->alACTlb_IDFPE{$i})
			APPEND TO ARRAY:C911(atACTlb_Estado2Asignar;atACT_estadosReemp{atACT_estadosReemp})
			APPEND TO ARRAY:C911(alACTlb_EstadoID2Asignar;alACT_estadosIDReemp{atACT_estadosReemp})
		End for 
		
	: ($vt_accion="DeclaraArreglosLB")
		ARRAY TEXT:C222(atACTlb_ReempTipoDoc;0)
		ARRAY DATE:C224(adACTlb_ReempFechaDoc;0)
		ARRAY TEXT:C222(atACTlb_ReempSerie;0)
		ARRAY DATE:C224(adACTlb_ReempFechaV;0)
		ARRAY TEXT:C222(atACTlb_ReempTitular;0)
		ARRAY REAL:C219(arACTlb_ReempMontoPago;0)
		ARRAY TEXT:C222(atACTlb_Estado2Asignar;0)
		ARRAY BOOLEAN:C223(abACTlb_Reemp;0)
		ARRAY LONGINT:C221(alACTlb_ReempIDDoc;0)
		ARRAY LONGINT:C221(alACTlb_ReempTitular;0)
		
		ARRAY LONGINT:C221(alACTlb_EstadoID2Asignar;0)
		ARRAY LONGINT:C221(alACTlb_IDFP;0)
		ARRAY LONGINT:C221(alACTlb_IDFPE;0)
		
		C_REAL:C285(vrACT_MontoAReemplazar;vrACT_SaldoAReemplazar)
		vrACT_MontoAReemplazar:=0
		vrACT_SaldoAReemplazar:=0
		
		  //20120912 RCH Error en compilado
		ARRAY BOOLEAN:C223(lb_formasPago;0)
		
	: ($vt_accion="CargaLB")
		ACTdc_OpcionesReemplazoMasivo ("CargaArreglos")
		
	: ($vt_accion="CargaListBox")
		ACTdc_OpcionesReemplazoMasivo ("BuscaDocumentos")
		ACTdc_OpcionesReemplazoMasivo ("CargaLB")
		ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetallePagos")
		
	: ($vt_accion="OnLoadList")
		C_LONGINT:C283(rb_UnDocumento;rb_VariosDocumentos)
		C_TEXT:C284(vsACT_DocsReemp2)
		C_LONGINT:C283(vlACT_ReempPor2)
		C_LONGINT:C283(vlACTreemp_Modo)  //modo 1 antiguo; modo 2 nuevo
		C_REAL:C285(vrACT_MontoAReemplazarXFP;vrACT_MontoAReemplazos;vrACT_SaldoAReemplazar)
		vlACTreemp_Modo:=1
		vlACTreemp_Modo:=Num:C11(PREF_fGet (USR_GetUserID ;"ACT_PaginaReemplazo";String:C10(vlACTreemp_Modo)))
		rb_UnDocumento:=Num:C11(vlACTreemp_Modo=1)
		rb_VariosDocumentos:=Num:C11(vlACTreemp_Modo=2)
		vsACT_DocsReemp2:=vsACT_DocsReemp
		vlACT_ReempPor2:=alACT_IDFormasdePago{Find in array:C230(aACT_DocsReemp;vsACT_DocsReemp2)}
		
	: ($vt_accion="OnCloseBox")
		ACTdc_OpcionesReemplazoMasivo ("DeclaraArreglosLB")
		
	: ($vt_accion="SetObjectVisible")
		vlACTreemp_Modo:=Choose:C955((rb_UnDocumento=1);1;2)
		PREF_Set (USR_GetUserID ;"ACT_PaginaReemplazo";String:C10(vlACTreemp_Modo))
		
		  //20120912 RCH Daba error en compilado...
		ACTdc_OpcionesReemplazoMasivo ("DeclaraArreglosLB")
		Case of 
			: (vlACTreemp_Modo=1)
				ACTdc_CargaDatosDCartera 
				FORM GOTO PAGE:C247(1)
			: (vlACTreemp_Modo=2)
				ACTdc_OpcionesReemplazoMasivo ("CargaListBox")
				FORM GOTO PAGE:C247(8)
		End case 
		
		OBJECT SET VISIBLE:C603(*;"pagina1_@";(vlACTreemp_Modo=1))
		OBJECT SET VISIBLE:C603(lb_doc2Reemp;(vlACTreemp_Modo=2))
		OBJECT SET VISIBLE:C603(*;"comoReemp@";(vlACTreemp_Modo=1))
		OBJECT SET ENABLED:C1123(*;"comoReemp@";(vlACTreemp_Modo=1))
		
		ACTdc_OpcionesReemplazoMasivo ("CalculaMonto2Reemplazar")
		ACTdc_OpcionesReemplazoMasivo ("SetNextIngresar")
		ACTdc_OpcionesReemplazoMasivo ("ObjetosPagina8")
		
	: ($vt_accion="ObjetosPagina8")
		OBJECT SET VISIBLE:C603(*;"pago_cheque@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pago_tc@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pago_letra@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pago_redcompra@";False:C215)
		OBJECT SET VISIBLE:C603(*;"pago_efectivo";False:C215)
		
		$choice:=Find in array:C230(aACT_DocsReemp;vsACT_DocsReemp2)
		If ($choice>0)
			Case of 
				: ($choice=(vl_indiceFormasDePago))  //Efectivo
					OBJECT SET VISIBLE:C603(*;"pago_efectivo";True:C214)
					
				: ($choice=1)  //Mismo cheque
					OBJECT SET VISIBLE:C603(*;"pago_cheque@";True:C214)
					
				: ($choice=(vl_indiceFormasDePago+1))  //Otro cheque
					OBJECT SET VISIBLE:C603(*;"pago_cheque@";True:C214)
					
				: ($choice=(vl_indiceFormasDePago+2))  //Tarjeta de Credito
					OBJECT SET VISIBLE:C603(*;"pago_tc@";True:C214)
					
				: ($choice=(vl_indiceFormasDePago+4))  //Letra
					C_BOOLEAN:C305($msg)
					ACTcfg_LoadConfigData (8)
					ACTcfg_LoadConfigData (6)
					  //$catID:=Find in array(atACT_Categorias;"letra@")
					$catID:=Find in array:C230(alACT_IDsCats;-2)
					If (($catID>0) & (Size of array:C274(alACT_AñoTasaImpuesto)>0))
						alACT_IDCat{0}:=alACT_IDsCats{$catID}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->alACT_IDCat;"=";->$DA_Return)
						If (Size of array:C274($DA_Return)=1)
							vtACT_LDocumento:=String:C10(alACT_Proxima{$DA_Return{1}})
							vl_indexLC:=$DA_Return{1}
							If (Num:C11(vtACT_LDocumento)<=0)
								$msg:=True:C214
							End if 
						Else 
							$msg:=True:C214
						End if 
					Else 
						$msg:=True:C214
					End if 
					If ($msg)
						OBJECT SET VISIBLE:C603(vtACT_PagoMsg;True:C214)
					Else 
						OBJECT SET VISIBLE:C603(*;"pago_letra@";True:C214)
					End if 
					
				: ($choice=(vl_indiceFormasDePago+3))  //Redcompr
					OBJECT SET VISIBLE:C603(*;"pago_redcompra@";True:C214)
					
				: ($choice=2)  //Varios cheques
					  //no se puede desde aca.. hay que ingresarlos de a uno
				Else 
					OBJECT SET VISIBLE:C603(*;"pago_efectivo";True:C214)
					
			End case 
		End if 
		
		OBJECT SET ENABLED:C1123(bIngresarReemplazar;((vrACT_MontoAReemplazos=vrACT_MontoAReemplazar) | (vlACTreemp_Modo=1)))
		
	: ($vt_accion="CalculaMonto2Reemplazar")
		$vrACT_MontoAReemplazar:=vrACT_MontoAReemplazar
		vrACT_MontoAReemplazar:=0
		If (vlACTreemp_Modo=2)
			For ($vl_i;1;Size of array:C274(arACTlb_ReempMontoPago))
				If (abACTlb_Reemp{$vl_i})
					vrACT_MontoAReemplazar:=vrACT_MontoAReemplazar+arACTlb_ReempMontoPago{$vl_i}
				End if 
			End for 
			  //para validar que no hayan cambios despues de ingresar documentos asociados a un monto...
			If ($vrACT_MontoAReemplazar#0)
				If ($vrACT_MontoAReemplazar#vrACT_MontoAReemplazar)
					If (Size of array:C274(arACTreemp_ResTotal)#0)
						ACTdc_OpcionesReemplazoVariosD ("DeclaraArreglosDetallePagos")
					End if 
				End if 
			End if 
			
		Else 
			vrACT_MontoAReemplazar:=[ACT_Documentos_de_Pago:176]MontoPago:6
		End if 
		vrACT_SaldoAReemplazar:=vrACT_MontoAReemplazar-vrACT_MontoAReemplazos
		
	: ($vt_accion="SetNextIngresar")
		vlACTreemp_Modo:=Choose:C955((rb_UnDocumento=1);1;2)
		PREF_Set (USR_GetUserID ;"ACT_PaginaReemplazo";String:C10(vlACTreemp_Modo))
		Case of 
			: (vlACTreemp_Modo=1)
				Case of 
					: (i_Doc=Size of array:C274(alACT_RecNumsDocs))
						OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
						OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
						
					: (Size of array:C274(alACT_RecNumsDocs)>1)
						OBJECT SET VISIBLE:C603(*;"@next@";True:C214)
						OBJECT SET VISIBLE:C603(*;"@Ingresar@";False:C215)
						
					: (Size of array:C274(alACT_RecNumsDocs)=1)
						OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
						OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
						
					: (Size of array:C274(alACT_RecNumsDocs)=0)
						
				End case 
				
			: (vlACTreemp_Modo=2)
				OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
				OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
				
				OBJECT SET ENABLED:C1123(bIngresarReemplazar;(vrACT_MontoAReemplazos=vrACT_MontoAReemplazar))
		End case 
		
	: ($vt_accion="ValidaSeleccionados")
		C_LONGINT:C283($vl_apoderadoAsignado;$vl_apoderado;$i)
		$vl_apoderadoAsignado:=$vy_pointer1->
		$vd_fecha:=$vy_pointer2->
		For ($i;1;Size of array:C274(alACTlb_ReempTitular))
			$vl_apoderado:=alACTlb_ReempTitular{$i}
			If ($vl_apoderadoAsignado#$vl_apoderado)
				abACTlb_Reemp{$i}:=False:C215
			Else 
				$vl_idDocPago:=KRL_GetNumericFieldData (->[ACT_Documentos_en_Cartera:182]ID:1;->alACTlb_ReempIDDoc{$i};->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
				$vd_fecha2:=KRL_GetDateFieldData (->[ACT_Documentos_de_Pago:176]ID:1;->$vl_idDocPago;->[ACT_Documentos_de_Pago:176]FechaPago:4)
				If ($vd_fecha#$vd_fecha2)
					abACTlb_Reemp{$i}:=False:C215
				End if 
			End if 
		End for 
		
	: ($vt_accion="ReemplazaDocumentos")
		If (vrACT_MontoAReemplazos>0)
			If (vrACT_MontoAReemplazos=vrACT_MontoAReemplazar)
				
				
				ARRAY LONGINT:C221($DA_Return;0)
				ARRAY LONGINT:C221(alACTReemp_IdsDocs2Reemp;0)  //ids docs cartera
				ARRAY LONGINT:C221(alACTReemp_IdsEstados;0)  //ids docs cartera
				
				  //cargo dosc en cartera a reemplazar
				abACTlb_Reemp{0}:=True:C214
				AT_SearchArray (->abACTlb_Reemp;"=";->$DA_Return)
				For ($i;1;Size of array:C274($DA_Return))
					APPEND TO ARRAY:C911(alACTReemp_IdsDocs2Reemp;alACTlb_ReempIDDoc{$DA_Return{$i}})
					APPEND TO ARRAY:C911(alACTReemp_IdsEstados;alACTlb_EstadoID2Asignar{$DA_Return{$i}})
				End for 
				
				$vl_resp:=CD_Dlog (0;__ ("Usted reemplazará ")+String:C10(Size of array:C274(alACTReemp_IdsDocs2Reemp))+__ (" pago(s) por ")+String:C10(Size of array:C274(alACTreemp_ResForma))+__ (" nuevo(s) pago(s).")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
				
				If ($vl_resp=1)
					
					C_BLOB:C604($vy_docsCartera;$vy_resumen;$vy_cheque;$vy_tarjetaC;$vy_letra;$vy_redcompra;$vy_otros;$vy_parametros)
					  //documentos a reemplazar
					BLOB_Variables2Blob (->$vy_docsCartera;0;->alACTReemp_IdsDocs2Reemp;->alACTReemp_IdsEstados)
					  //resumen
					BLOB_Variables2Blob (->$vy_resumen;0;->atACTreemp_ResForma;->alACTreemp_ResForma;->arACTreemp_ResTotal;->atACTreemp_ResDetalle;->alACTreemp_ResRef)
					  //cheque
					BLOB_Variables2Blob (->$vy_cheque;0;->adACTreemp_CH_Fecha;->atACTreemp_CH_NoCta;->atACTreemp_CH_Titular;->atACTreemp_CH_Banco;->atACTreemp_CH_Serie;->arACTreemp_CH_Monto;->atACTreemp_CH_BancoC)
					  //tc
					BLOB_Variables2Blob (->$vy_tarjetaC;0;->atACTreemp_TC_Op;->atACTreemp_TC_TipoT;->atACTreemp_TC_BE;->atACTreemp_TC_BEC;->atACTreemp_TC_NumT;->atACTreemp_TC_VencM;->atACTreemp_TC_VencA;->atACTreemp_TC_Tit;->atACTreemp_TC_RutT;->arACTreemp_TC_Monto)
					  //letra
					BLOB_Variables2Blob (->$vy_letra;0;->atACTreemp_L_Num;->afACTreemp_L_FE;->afACTreemp_L_FV;->atACTreemp_L_Tit;->atACTreemp_L_RutTit;->arACTreemp_L_Monto)
					  //redcompra
					  //BLOB_Variables2Blob (->$vy_redcompra;0;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto)
					  //20131128 ASM Ticket 127351
					BLOB_Variables2Blob (->$vy_redcompra;0;->atACTreemp_RC_NumO;->arACTreemp_RC_Monto;->atACTreemp_RC_TipoT;->atACTreemp_RC_BE;->atACTreemp_RC_BEC;->atACTreemp_RC_NumT;->atACTreemp_RC_VencM;->atACTreemp_RC_VencA;->atACTreemp_RC_Tit;->atACTreemp_RC_RutT)
					  //otros
					BLOB_Variables2Blob (->$vy_otros;0;->atACTreemp_OT_Forma;->alACTreemp_OT_Forma;->arACTreemp_OT_Monto)
					
					BLOB_Variables2Blob (->$vy_parametros;0;->$vy_docsCartera;->$vy_resumen;->$vy_cheque;->$vy_tarjetaC;->$vy_letra;->$vy_redcompra;->$vy_otros)
					$vb_done:=ACTdc_ReemplazaVariosDocumentos ($vy_parametros)
					
					If ($vb_done)
						$vt_retorno:="1"
					Else 
						$vt_retorno:="0"
					End if 
					
				Else 
					$vt_retorno:="1"  //para que no muestre el otro mensaje...
				End if 
				  //If (Not($vb_done))
				  //$vt_key:=AT_array2text (->alACTReemp_IdsDocs2Reemp;" - ";"#########")
				  //BM_CreateRequest ("ACT_reemplazarVarios";"";$vt_key;$vy_parametros)
				  //End if 
				
			Else 
				CD_Dlog (0;__ ("El monto a reemplazar debe ser igual al monto en reemplazos"))
			End if 
		Else 
			BEEP:C151
		End if 
		
End case 

$0:=$vt_retorno
