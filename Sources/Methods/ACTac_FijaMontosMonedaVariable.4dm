//%attributes = {}
  //ACTac_FijaMontosMonedaVariable

C_LONGINT:C283($vl_proc;$vl_resp)
C_TEXT:C284($vt_msj;$vt_monedaCargo;$1;$vt_Set)
C_REAL:C285($vrACT_montoNeto;$vr_sumaPagadosC)
C_DATE:C307($vd_fecha)
C_LONGINT:C283($i;$vl_idCargo)
C_REAL:C285($vr_sumaPagadosT)
C_BOOLEAN:C305($0;$vb_procesoEjecutado)
C_REAL:C285($montonetodsctos)

ARRAY TEXT:C222($atACT_monedas;0)
ARRAY REAL:C219($arACT_valorMoneda;0)
ARRAY LONGINT:C221($alACT_recNums;0)
ARRAY LONGINT:C221($alACT_idsDocCargo;0)
ARRAY LONGINT:C221($alACT_recNumsT;0)
ARRAY LONGINT:C221($alACT_idsAvisos;0)
ARRAY LONGINT:C221($alACT_recNumAvisos;0)
ARRAY LONGINT:C221($alACT_idsAvisosNoModif;0)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

$vt_Set:=$1

USE SET:C118($vt_set)
$vl_proc:=IT_UThermometer (1;0;__ ("Buscando cargos en moneda variable..."))
KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]No_Incluir_en_DocTrib:50=False:C215;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";"))
IT_UThermometer (-2;$vl_proc)

If (Records in selection:C76([ACT_Cargos:173])>0)
	SRACT_SelFecha (1)
	$vd_fecha:=vd_Fecha1
	If ($vd_fecha#!00-00-00!)
		DISTINCT VALUES:C339([ACT_Cargos:173]Moneda:28;$atACT_monedas)
		For ($i;1;Size of array:C274($atACT_monedas))
			APPEND TO ARRAY:C911($arACT_valorMoneda;ACTut_fValorDivisa ($atACT_monedas{$i};$vd_fecha))
		End for 
		
		$vt_msj:=__ ("Los montos en moneda variable, asociados a los Avisos de Cobranza seleccionados, serán fijados a la fecha ")+String:C10($vd_fecha)+". "+__ ("La paridad a utilizar será la siguiente: ")+AT_Arrays2Text (";";"=";->$atACT_monedas;->$arACT_valorMoneda)+"."
		$vt_msj:=$vt_msj+"\r\r"+__ ("¿Desea continuar?")
		$vl_resp:=CD_Dlog (0;$vt_msj;"";__ ("Si");__ ("No"))
		
		If ($vl_resp=1)
			$vb_procesoEjecutado:=True:C214
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNums;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Fijando montos en moneda variable..."))
			For ($i;1;Size of array:C274($alACT_recNums))
				READ WRITE:C146([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNums{$i})
				
				$vt_monedaCargo:=ST_GetWord (ACT_DivisaPais ;1;";")
				$vrACT_montoNeto:=ACTut_retornaMontoEnMoneda ([ACT_Cargos:173]Monto_Neto:5;[ACT_Cargos:173]Moneda:28;$vd_fecha;$vt_monedaCargo)
				$vl_idCargo:=[ACT_Cargos:173]ID:1
				
				If ([ACT_Cargos:173]Monto_Neto:5<0)
					[ACT_Cargos:173]Monto_Neto:5:=Abs:C99($vrACT_montoNeto)*-1
				Else 
					[ACT_Cargos:173]Monto_Neto:5:=$vrACT_montoNeto
				End if 
				[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
				[ACT_Cargos:173]FechaMonedaVariable:61:=$vd_fecha
				[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=False:C215
				
				If ([ACT_Cargos:173]TasaIVA:21#0)
					[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94([ACT_Cargos:173]Monto_Bruto:24*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
				Else 
					[ACT_Cargos:173]TasaIVA:21:=0
					[ACT_Cargos:173]Monto_Afecto:27:=0
					[ACT_Cargos:173]Monto_IVA:20:=0
					[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
				End if 
				
				  //modificar el saldo de los cargos
				$vr_sumaPagadosC:=[ACT_Cargos:173]MontosPagadosMPago:52
				[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagadosMPago:52
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				
				If (Abs:C99($vr_sumaPagadosC)<=Abs:C99([ACT_Cargos:173]Monto_Neto:5))
					SAVE RECORD:C53([ACT_Cargos:173])
					
					  // modificar las transacciones
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$vl_idCargo;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4>0)
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6:=[ACT_Transacciones:178]MontoMonedaPago:14)
					ARRAY LONGINT:C221($alACT_recNumsT;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$alACT_recNumsT;"")
					$vr_sumaPagadosT:=ACTtra_CalculaMontos ("calculaFromRecNum";->$alACT_recNumsT;->[ACT_Transacciones:178]Debito:6)
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					
					If (Find in array:C230($alACT_idsDocCargo;[ACT_Cargos:173]ID_Documento_de_Cargo:3)=-1)
						APPEND TO ARRAY:C911($alACT_idsDocCargo;[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					End if 
				Else 
					APPEND TO ARRAY:C911($alACT_idsAvisosNoModif;KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15))
				End if 
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNums))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			$vl_proc:=IT_UThermometer (1;0;"Recalculando avisos...")
			For ($i;1;Size of array:C274($alACT_idsDocCargo))
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$alACT_idsDocCargo{$i})
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
				If (Find in array:C230($alACT_recNumAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
					APPEND TO ARRAY:C911($alACT_idsAvisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					APPEND TO ARRAY:C911($alACT_recNumAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))
				End if 
			End for 
			ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumAvisos)
			IT_UThermometer (-2;$vl_proc)
			
			SORT ARRAY:C229($alACT_idsAvisos;>)
			LOG_RegisterEvt ("Montos variables de Avisos de Cobranza fijados, a la fecha "+String:C10($vd_fecha)+" (Paridad: "+AT_Arrays2Text (";";"=";->$atACT_monedas;->$arACT_valorMoneda)+"), para los Avisos de Cobranza números "+AT_array2text (->$alACT_idsAvisos;"-";"#########")+".")
			
			AT_DistinctsArrayValues (->$alACT_idsAvisosNoModif)
			If (Size of array:C274($alACT_idsAvisosNoModif)>0)
				For ($i;1;Size of array:C274($alACT_idsAvisosNoModif))
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$alACT_idsAvisosNoModif{$i})
					REMOVE FROM SET:C561([ACT_Avisos_de_Cobranza:124];$vt_Set)
				End for 
				CD_Dlog (0;__ ("El monto no pudo ser fijado para cargos de los avisos: ")+AT_array2text (->$alACT_idsAvisosNoModif;"-";"#########")+".")
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No hay cargos en moneda variable, con saldo pendiente, dentro de la selección de Avisos de Cobranza."))
End if 

$0:=$vb_procesoEjecutado