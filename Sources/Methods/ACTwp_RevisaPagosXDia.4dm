//%attributes = {}
  //ACTwp_RevisaPagosXDia

C_DATE:C307($d_fecha;$1)
C_TEXT:C284($t_json)
C_BOOLEAN:C305($vb_ejecutado;$0;$b_registrarLog;$2)

ARRAY LONGINT:C221($alACT_id;0)
ARRAY TEXT:C222($atACT_avisos;0)
ARRAY LONGINT:C221($alACT_idRelFamiliar;0)
ARRAY REAL:C219($arACT_monto;0)
ARRAY TEXT:C222($atACT_fecha;0)
ARRAY TEXT:C222($atACT_estado;0)
ARRAY LONGINT:C221($alACT_enviado;0)
ARRAY REAL:C219($arACT_orden_compra;0)

ARRAY TEXT:C222($atACT_idNTC;0)
ARRAY TEXT:C222($atACT_avisosNTC;0)
ARRAY TEXT:C222($atACT_idRelFamiliarNTC;0)
ARRAY TEXT:C222($atACT_montoNTC;0)
ARRAY TEXT:C222($atACT_fechaNTC;0)
ARRAY TEXT:C222($atACT_estadoNTC;0)
ARRAY TEXT:C222($atACT_descripcionMensaje;0)
ARRAY LONGINT:C221($al_colores;0)
ARRAY LONGINT:C221($al_estilos;0)

ARRAY TEXT:C222($nodes;0)
ARRAY LONGINT:C221($types;0)
ARRAY TEXT:C222($names;0)

ARRAY TEXT:C222($nodes2;0)
ARRAY LONGINT:C221($types2;0)
ARRAY TEXT:C222($names2;0)

ARRAY TEXT:C222($nodes3;0)
ARRAY LONGINT:C221($types3;0)
ARRAY TEXT:C222($names3;0)

$d_fecha:=$1
$b_registrarLog:=$2

$t_json:=SN3_RetreivePagosWP ($d_fecha)

If ($t_json#"")
	  //obtiene info desde json
	
	  //$root:=JSON Parse text ($t_json)
	  //JSON GET CHILD NODES ($root;$nodes;$types;$names)
	  //If (Size of array($nodes)>0)  //20151210 RCH
	  //JSON GET CHILD NODES ($nodes{1};$nodes2;$types2;$names2)
	  //For ($i;1;Size of array($nodes2))
	  //JSON GET CHILD NODES ($nodes2{$i};$nodes3;$types3;$names3)
	  //For ($j;1;Size of array($nodes3))
	  //$node:=$nodes3{$j}
	  //$name:=$names3{$j}
	  //Case of 
	  //: ($name="id")
	  //APPEND TO ARRAY($alACT_id;JSON Get long ($node))
	  //: ($name="avisos")
	  //APPEND TO ARRAY($atACT_avisos;JSON Get text ($node))
	  //: ($name="idrelfamiliar")
	  //APPEND TO ARRAY($alACT_idRelFamiliar;JSON Get long ($node))
	  //: ($name="montototal")
	  //APPEND TO ARRAY($arACT_monto;JSON Get real ($node))
	  //: ($name="fecha")
	  //APPEND TO ARRAY($atACT_fecha;JSON Get text ($node))
	  //: ($name="estado")
	  //APPEND TO ARRAY($atACT_estado;JSON Get text ($node))
	  //: ($name="enviadoST")
	  //APPEND TO ARRAY($alACT_enviado;JSON Get long ($node))
	  //: ($name="clg_orden_compra")
	  //APPEND TO ARRAY($arACT_orden_compra;JSON Get real ($node))
	  //End case 
	  //End for 
	  //End for 
	  //JSON CLOSE ($root)
	  //obtiene info desde json
	
	
	ARRAY TEXT:C222($at_propiedadJson;0)
	ARRAY LONGINT:C221($al_propiedadJsonref;0)
	ARRAY TEXT:C222($at_propiedadJsonTemp;0)
	ARRAY LONGINT:C221($al_propiedadJsonrefTemp;0)
	ARRAY TEXT:C222($at_Json;0)
	
	  //ticket 163675 JVP
	  //array objetos
	ARRAY OBJECT:C1221($ao_Registros;0)
	
	
	C_POINTER:C301($y_pointer)
	C_TEXT:C284($t_valor)
	C_OBJECT:C1216($ob_valor)  //20170704 RCH
	
	  //$y_pointer:=Get pointer("t_arreglo")
	
	$ob_raiz:=OB_JsonToObject ($t_json)
	  //OB GET PROPERTY NAMES($ob_raiz;$at_propiedadJson;$al_propiedadJsonref)
	  //$y_pointer->:=OB Get($ob_raiz;$at_propiedadJson{1};OB Get type($ob_raiz;$at_propiedadJson{1}))
	  //cambio ticket 163675 JVP
	OB_GET ($ob_raiz;->$ao_Registros;"registros")
	$y_pointer:=->$ao_Registros
	If (Size of array:C274($y_pointer->)>0)
		  //For ($j;1;Size of array($y_pointer->))
		  //C_OBJECT($ob_objeto)
		  //OB GET PROPERTY NAMES($y_pointer->{$j};$at_propiedadJsonTemp;$al_propiedadJsonrefTemp)
		  //For ($i;1;Size of array($at_propiedadJson))
		  //$t_valor:=OB Get($y_pointer->{$j};$at_propiedadJsonTemp{$i};OB Get type($ob_objeto;$at_propiedadJsonTemp{$i}))
		  //Case of 
		  //: ($at_propiedadJsonTemp{$i}="id")
		  //APPEND TO ARRAY($alACT_id;Num($t_valor))
		  //  //APPEND TO ARRAY($alACT_id;JSON Get long ($node))
		  //: ($at_propiedadJsonTemp{$i}="avisos")
		  //APPEND TO ARRAY($atACT_avisos;$t_valor)
		  //: ($at_propiedadJsonTemp{$i}="idrelfamiliar")
		  //APPEND TO ARRAY($alACT_idRelFamiliar;Num($t_valor))
		  //: ($at_propiedadJsonTemp{$i}="montototal")
		  //APPEND TO ARRAY($arACT_monto;Num($t_valor))
		  //: ($at_propiedadJsonTemp{$i}="fecha")
		  //APPEND TO ARRAY($atACT_fecha;$t_valor)
		  //: ($at_propiedadJsonTemp{$i}="estado")
		  //APPEND TO ARRAY($atACT_estado;$t_valor)
		  //: ($at_propiedadJsonTemp{$i}="enviadoST")
		  //APPEND TO ARRAY($alACT_enviado;Num($t_valor))
		  //: ($at_propiedadJsonTemp{$i}="clg_orden_compra")
		  //APPEND TO ARRAY($arACT_orden_compra;Num($t_valor))
		  //: ($at_propiedadJsonTemp{$i}="json")
		  //APPEND TO ARRAY($at_Json;$t_valor)
		  //End case 
		  //End for 
		  //End for 
		
		  //cambio ticket 163675 JVP
		C_LONGINT:C283($l_valor)
		C_REAL:C285($r_valor)
		For ($j;1;Size of array:C274($y_pointer->))
			OB_GET ($y_pointer->{$j};->$l_valor;"id")
			APPEND TO ARRAY:C911($alACT_id;$l_valor)
			
			OB_GET ($y_pointer->{$j};->$t_valor;"avisos")
			APPEND TO ARRAY:C911($atACT_avisos;$t_valor)
			
			OB_GET ($y_pointer->{$j};->$l_valor;"idrelfamiliar")
			APPEND TO ARRAY:C911($alACT_idRelFamiliar;$l_valor)
			
			OB_GET ($y_pointer->{$j};->$r_valor;"montototal")
			APPEND TO ARRAY:C911($arACT_monto;$r_valor)
			
			OB_GET ($y_pointer->{$j};->$t_valor;"fecha")
			APPEND TO ARRAY:C911($atACT_fecha;$t_valor)
			
			OB_GET ($y_pointer->{$j};->$t_valor;"estado")
			APPEND TO ARRAY:C911($atACT_estado;$t_valor)
			
			OB_GET ($y_pointer->{$j};->$l_valor;"enviadoST")
			APPEND TO ARRAY:C911($alACT_enviado;$l_valor)
			
			OB_GET ($y_pointer->{$j};->$r_valor;"clg_orden_compra")
			APPEND TO ARRAY:C911($arACT_orden_compra;$r_valor)
			  //al traer directo queda con valores sucios
			  //OB_GET ($y_pointer->{$j};->$t_valor;"json")
			  //APPEND TO ARRAY($at_Json;$t_valor)
			  // o obtengo un objeto y lo convierto en texto json
			OB_GET ($y_pointer->{$j};->$ob_valor;"json")
			$t_valor:=OB_Object2Json ($ob_valor)
			APPEND TO ARRAY:C911($at_Json;$t_valor)
		End for 
		
		  //fin codigo 163675
		
		  //verifica pagos
		For ($l_idsPagos;1;Size of array:C274($alACT_id))
			READ ONLY:C145([ACT_Pagos:172])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			
			$l_idApdo:=$alACT_idRelFamiliar{$l_idsPagos}
			$t_json:=$at_Json{$l_idsPagos}
			
			If ($atACT_estado{$l_idsPagos}="APROBADO")  //solo se procesan los aprobados
				ARRAY LONGINT:C221($alACT_idsAC;0)
				ARRAY LONGINT:C221($alACT_idsApoderadosAC;0)
				AT_Text2Array (->$alACT_idsAC;$atACT_avisos{$l_idsPagos};",")
				
				QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAC)
				DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$alACT_idsApoderadosAC)
				If (Size of array:C274($alACT_idsApoderadosAC)=1)
					$l_idApdo:=$alACT_idsApoderadosAC{1}
					
					If ($l_idApdo=$alACT_idRelFamiliar{$l_idsPagos})
						If ($l_idApdo>0)
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_WebpayOC:32=$arACT_orden_compra{$l_idsPagos};*)
							QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
							
							If (Records in selection:C76([ACT_Pagos:172])=0)
								$l_dia:=Num:C11(Substring:C12($atACT_fecha{$l_idsPagos};9;2))
								$l_mes:=Num:C11(Substring:C12($atACT_fecha{$l_idsPagos};6;2))
								$l_year:=Num:C11(Substring:C12($atACT_fecha{$l_idsPagos};1;4))
								$d_fecha:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_year)
								
								READ WRITE:C146([ACT_Pagos:172])
								QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=$d_fecha;*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Monto_Pagado:5=$arACT_monto{$l_idsPagos};*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]id_forma_de_pago:30=-18;*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_WebpayOC:32=0;*)  //20140516 RCH. Cuando se pagaba 2 veces, se asignaba mal la orden de compra.
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_Apoderado:3=$l_idApdo;*)
								QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
								
								If (Records in selection:C76([ACT_Pagos:172])>1)
									READ ONLY:C145([ACT_Transacciones:178])
									QUERY WITH ARRAY:C644([ACT_Transacciones:178]No_Comprobante:10;$alACT_idsAC)
									KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
								End if 
								
								
								Case of 
									: (Records in selection:C76([ACT_Pagos:172])=0)  //el pago no existe en la base
										  //$json:=ACTwa_IngresaPago ($arACT_monto{$l_idsPagos};$atACT_avisos{$l_idsPagos};$d_fecha;"";False)
										$json:=ACTwa_IngresaPago ($arACT_monto{$l_idsPagos};$atACT_avisos{$l_idsPagos};$d_fecha;"";False:C215;"";$t_json)
										
										C_REAL:C285($r_procesado)
										C_TEXT:C284($root;$nodeErr;$nodeErrCod)
										C_OBJECT:C1216($ob_json)
										$ob_json:=OB_JsonToObject ($json)
										$nodeErr:=OB Get:C1224($ob_json;"estado";Is text:K8:3)
										$nodeErrCod:=OB Get:C1224($ob_json;"codigo";Is text:K8:3)
										  //$root:=JSON Parse text ($json)
										  //$nodeErr:=JSON Get child by name ($root;"estado")
										  //$nodeErrCod:=JSON Get child by name ($nodeErr;"codigo")
										  //$r_procesado:=JSON Get real ($nodeErrCod)
										  //JSON CLOSE ($root)
										
										If ($r_procesado=0)
											READ WRITE:C146([ACT_Pagos:172])
											
											QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=$d_fecha;*)
											QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Monto_Pagado:5=$arACT_monto{$l_idsPagos};*)
											QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]id_forma_de_pago:30=-18;*)
											QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_WebpayOC:32=0;*)  //20140516 RCH. Cuando se pagaba 2 veces, se asignaba mal la orden de compra.
											QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_Apoderado:3=$l_idApdo;*)
											QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
											
											If (Records in selection:C76([ACT_Pagos:172])>1)
												READ ONLY:C145([ACT_Transacciones:178])
												QUERY WITH ARRAY:C644([ACT_Transacciones:178]No_Comprobante:10;$alACT_idsAC)
												KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
											End if 
											
											If (Records in selection:C76([ACT_Pagos:172])=1)
												[ACT_Pagos:172]ID_WebpayOC:32:=$arACT_orden_compra{$l_idsPagos}
												[ACT_Pagos:172]DTS_WebPaySN:33:=$atACT_fecha{$l_idsPagos}
												SAVE RECORD:C53([ACT_Pagos:172])
											Else 
												  //error porque no fue ingresado el pago
												
												APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
												APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
												APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
												APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
												APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
												APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
												APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El pago existe en SN, fue creado en ACT pero no pudo ser encontrado. Por favor verifique si el pago existe en la base de datos. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
												APPEND TO ARRAY:C911($al_colores;Red:K11:4)
												APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
												
											End if 
										Else 
											  //el pago no pudo ser ingresado
											
											APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
											APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
											APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
											APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
											APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
											APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
											APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El pago existe en SN, no existe en ACT y no pudo ser ingresado al sistema. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
											
											APPEND TO ARRAY:C911($al_colores;Red:K11:4)
											APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
											
										End if 
										
									: (Records in selection:C76([ACT_Pagos:172])=1)  //se asigna el id
										[ACT_Pagos:172]ID_WebpayOC:32:=$arACT_orden_compra{$l_idsPagos}
										[ACT_Pagos:172]DTS_WebPaySN:33:=$atACT_fecha{$l_idsPagos}
										If ([ACT_Pagos:172]Datos_pago:36="")
											ACTwp_ActualizaCampoTipoPago ($t_json;[ACT_Pagos:172]ID:1)
										End if 
										SAVE RECORD:C53([ACT_Pagos:172])
										
										APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
										APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
										APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
										APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El pago fue validado correctamente. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
										
										APPEND TO ARRAY:C911($al_colores;Green:K11:9)
										APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
										
									: (Records in selection:C76([ACT_Pagos:172])>1)  //no se puede identificar el pago
										  //error. Alertar en el centro de notificaciones
										
										
										APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
										APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
										APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
										APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
										APPEND TO ARRAY:C911($atACT_descripcionMensaje;"No fue posible identificar el pago con los datos entregados. Deberá revisar si el pago existe en la base de datos. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
										
										APPEND TO ARRAY:C911($al_colores;Red:K11:4)
										APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
										
								End case 
								  //ACTwp_ActualizaCampoTipoPago ($t_json;[ACT_Pagos]ID)
								KRL_UnloadReadOnly (->[ACT_Pagos:172])
								
								  //Else 
								  //ya procesado
								  //20151104 ASM ticket 150749 para actualizar el tipo de pago
								  //ACTwp_ActualizaCampoTipoPago ($t_json;[ACT_Pagos]ID)
								  //KRL_UnloadReadOnly (->[ACT_Pagos])
							End if 
							
						Else 
							  //no hay apoderado en avisos
							APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
							APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
							APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
							APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
							APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
							APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
							APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El pago existe en SN, no existe en ACT y no pudo ser ingresado al sistema. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
							
							APPEND TO ARRAY:C911($al_colores;Red:K11:4)
							APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
							
						End if 
						
					Else 
						  //no hay apoderado en avisos
						APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
						APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_descripcionMensaje;"El pago existe en SN, no existe en ACT pero no pudo ser ingresado debido a que el identificacor del apoderado asociado a los Avisos de Cobranza pagados no coincide con el id de la relación familiar en WP. Id asociado a los Avisos: "+String:C10($l_idApdo)+", id en WP: "+String:C10($alACT_idRelFamiliar{$l_idsPagos})+". Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
						
						APPEND TO ARRAY:C911($al_colores;Red:K11:4)
						APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
						
					End if 
					
				Else 
					
					If (Size of array:C274($alACT_idsApoderadosAC)>1)
						  //avisos para mas de un apoderado para los ids entregados
						APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
						APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_descripcionMensaje;"Los números de aviso de cobranza entregados corresponden a más de un apoderado. El pago no pudo ser validado. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
						
						APPEND TO ARRAY:C911($al_colores;Red:K11:4)
						APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
						
					Else 
						  //no fueron encontrados avisos
						APPEND TO ARRAY:C911($atACT_idNTC;String:C10($alACT_id{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_avisosNTC;$atACT_avisos{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;String:C10($alACT_idRelFamiliar{$l_idsPagos}))
						APPEND TO ARRAY:C911($atACT_montoNTC;String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT_Pagos"))
						APPEND TO ARRAY:C911($atACT_fechaNTC;$atACT_fecha{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_estadoNTC;$atACT_estado{$l_idsPagos})
						APPEND TO ARRAY:C911($atACT_descripcionMensaje;"No fueron encontrados avisos de cobranza para los números de Avisos de Cobranza entregados. Es posible que los avisos hayan sido eliminados. Orden de compra: "+String:C10($arACT_orden_compra{$l_idsPagos})+".")
						
						APPEND TO ARRAY:C911($al_colores;Red:K11:4)
						APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
						
					End if 
					
				End if 
			Else 
				  //pago no aprobado. Se registra en las observaciones del apoderado
				If ($b_registrarLog)
					READ ONLY:C145([Personas:7])
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
					If (Records in selection:C76([Personas:7])=1)
						ACTpp_CreateObs ([Personas:7]No:1;"El apoderado intentó hacer un pago en Webpay pero este fue rechazado. Intento de pago para avisos: "+$atACT_avisos{$l_idsPagos}+", por un monto de: "+String:C10($arACT_monto{$l_idsPagos};"|Despliegue_ACT")+", con fecha de pago: "+$atACT_fecha{$l_idsPagos}+".";Current date:C33(*))
					End if 
				End if 
			End if 
		End for 
		  //verifica pagos
		
		  //$vb_ejecutado:=True
	End if 
	$vb_ejecutado:=True:C214  //20170603 RCH Cuando no habían pagos, se cortaba la verificación.
Else 
	
	APPEND TO ARRAY:C911($atACT_idNTC;"")
	APPEND TO ARRAY:C911($atACT_avisosNTC;"")
	APPEND TO ARRAY:C911($atACT_idRelFamiliarNTC;"")
	APPEND TO ARRAY:C911($atACT_montoNTC;"")
	APPEND TO ARRAY:C911($atACT_fechaNTC;"")
	APPEND TO ARRAY:C911($atACT_estadoNTC;"")
	APPEND TO ARRAY:C911($atACT_descripcionMensaje;"Verificación de pagos Webpay no realizada para el día "+String:C10($d_fecha)+".")
	
	APPEND TO ARRAY:C911($al_colores;Red:K11:4)
	APPEND TO ARRAY:C911($al_estilos;Plain:K14:1)
	
	$vb_ejecutado:=False:C215
End if 

  //crea mensajes para el centro de notificaciones
If (Size of array:C274($atACT_idNTC)>0)
	If ($b_registrarLog)
		C_TEXT:C284($t_Encabezado;$t_descripcion;$t_uuid)
		ARRAY TEXT:C222($at_TitulosColumnas;0)
		
		$t_Encabezado:="Verificación de Pagos Webpay para el día "+String:C10($d_fecha)+"."
		$t_descripcion:="Verificación diaria de los pagos con forma de pago Webpay ingresados a través de SchoolNet\r\rEl presente listado muestra el detalle de la verificación"
		
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Mensaje")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"id WP")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Ids AC")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"id Apdo")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Monto Pago")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Fecha Pago")
		APPEND TO ARRAY:C911($at_TitulosColumnas;"Estado Pago SN")
		
		$t_uuid:=NTC_CreaMensaje ("AccountTrack";$t_Encabezado;$t_descripcion)
		NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$atACT_descripcionMensaje;->$atACT_idNTC;->$atACT_avisosNTC;->$atACT_idRelFamiliarNTC;->$atACT_montoNTC;->$atACT_fechaNTC;->$atACT_estadoNTC)
		NTC_Mensaje_EstilosColores ($t_uuid;->$al_estilos;->$al_Colores)
	End if 
End if 

$0:=$vb_ejecutado