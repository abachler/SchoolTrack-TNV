//%attributes = {}
  //ACTabc_ExportPACCumbresM
  //Exporta por razon social.

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_noCuotas;vQR_Long1;$vl_total)
$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
vFechaPAC:=String:C10(Current date:C33(*);7)
vtotalPAC:=""
vnumTransPAC:=""

READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])

ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)

KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
CREATE SET:C116([ACT_Cargos:173];"CargosTodos")
ACTcfg_OpcionesRazonesSociales ("LoadConfig")

C_TEXT:C284($vt_numBoleta_1;$vt_codCtaCte_2;$vt_montoNeto_3;$vt_valorIVA_4;$vt_concepto_5;$vt_fechaV_6;$vt_email_7;$vt_clavePago_8;$vt_nombre_9;$vt_ApPaterno_10;$vt_telefono_11;$vt_opcional1_12;$vt_opcional2_13;$vt_opcional3_14;$vt_fechaV2_15;$vt_montoNeto_16;$vt_valorIVA2_17;$vt_concepto_18;$vt_saldoAnterior19)
C_TEXT:C284($vt_separador)
C_REAL:C285($vr_monto)
$vt_separador:="|"
vQR_Date1:=vd_fechaUF

If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
End if 

CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargosProcesados")
For (vQR_Long3;1;Size of array:C274(alACTcfg_Razones))
	
	USE SET:C118("CargosTodos")
	If (alACTcfg_Razones{vQR_Long3}=-1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57<=alACTcfg_Razones{vQR_Long3})
	Else 
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_RazonSocial:57=alACTcfg_Razones{vQR_Long3})
	End if 
	If (Records in selection:C76([ACT_Cargos:173])>0)
		CREATE SET:C116([ACT_Cargos:173];"CargosRazonSocial")
		DIFFERENCE:C122("CargosTodos";"CargosRazonSocial";"CargosTodos")
		
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos")
		
		$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";ST_GetWord (atACTcfg_Razones{vQR_Long3};2;" ")+"_"+$fileName)
		If ($ref#?00:00:00?)
			
			If (vl_otrasMonedas=1)
				C_TEXT:C284($vt_monedaOrg)
				$vt_monedaOrg:=<>vsACT_MonedaColegio
				<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
			End if 
			
			
			$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>)
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
			While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
				USE SET:C118("setAvisos")
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>)
					REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];1)
					REMOVE FROM SET:C561([ACT_Avisos_de_Cobranza:124];"setAvisos")
					
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					CREATE SET:C116([ACT_Cargos:173];"selectionApdo")
					INTERSECTION:C121("CargosRazonSocial";"selectionApdo";"selectionApdo")
					
					CREATE SET:C116([ACT_Cargos:173];"selectionApdo")
					DIFFERENCE:C122("CargosRazonSocial";"selectionApdo";"CargosRazonSocial")
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
					$vt_fechaV_6:=String:C10([ACT_Cargos:173]Fecha_de_Vencimiento:7)
					
					
					ARRAY DATE:C224(aQR_Date1;0)
					ARRAY LONGINT:C221(aQR_Longint4;0)
					ARRAY TEXT:C222(aQR_Text1;0)
					SELECTION TO ARRAY:C260([ACT_Cargos:173]FechaEmision:22;aQR_Date1;[ACT_Cargos:173]Ref_Item:16;aQR_Longint4;[ACT_Cargos:173]Glosa:12;aQR_Text1)
					
					FIRST RECORD:C50([ACT_Cargos:173])
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18)
					
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;<;[ACT_Avisos_de_Cobranza:124]Mes:6;<)
					vQR_Date2:=[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18
					FIRST RECORD:C50([ACT_Boletas:181])
					
					  //******** DESDE ACA
					USE SET:C118("selectionApdo")
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
					AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->aQR_Longint2)
					AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_RazonSocial:57;->aQR_Longint1)
					AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint3)
					
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CuentaCorriente:2;aQR_Longint2)
					QRY_QueryWithArray (->[ACT_Cargos:173]ID_RazonSocial:57;->aQR_Longint1;True:C214)
					QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint3;True:C214)
					
					  //cargos atrasados
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<aQR_Date1{Size of array:C274(aQR_Date1)};*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
					CREATE SET:C116([ACT_Cargos:173];"setCargosRST")
					UNION:C120("setCargosRST";"selectionApdo";"setCargosRS")
					
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
					ARRAY REAL:C219(aQR_Real1;0)
					
					  //***** INTERESES *****
					USE SET:C118("setCargosRS")
					CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargosRST")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_CargoRelacionado:47;->[ACT_Cargos:173]ID:1;"")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						CREATE SET:C116([ACT_Cargos:173];"setCargosRST")
					End if 
					UNION:C120("setCargosRS";"setCargosRST";"setCargosRS")
					  //***** INTERESES *****
					
					DIFFERENCE:C122("setCargosRS";"setCargosProcesados";"setCargosRS")
					UNION:C120("setCargosRS";"setCargosProcesados";"setCargosProcesados")
					
					USE SET:C118("setCargosRS")
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
					$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;vQR_Pointer1;vQR_Date1))
					
					  //******** HASTA ACA
					
					READ ONLY:C145([xxACT_Items:179])
					If (Size of array:C274(aQR_Longint4)>0)
						SORT ARRAY:C229(aQR_Longint4;aQR_Text1;<)
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aQR_Longint4{1})
						If (Records in selection:C76([xxACT_Items:179])=1)
							$vt_concepto_5:=[xxACT_Items:179]Glosa_de_Impresión:20
						Else 
							$vt_concepto_5:=aQR_Text1{1}
						End if 
					End if 
					
					$vt_numBoleta_1:=String:C10([ACT_Boletas:181]Numero:11)
					$vt_codCtaCte_2:=[ACT_CuentasCorrientes:175]Codigo:19
					$vt_montoNeto_3:=String:C10($vr_monto)
					$vt_valorIVA_4:="0"
					$vt_concepto_5:=$vt_concepto_5
					$vt_fechaV_6:=$vt_fechaV_6
					$vt_email_7:=""
					$vt_clavePago_8:=""
					$vt_nombre_9:=[Alumnos:2]apellidos_y_nombres:40
					$vt_ApPaterno_10:=""
					$vt_telefono_11:=""
					$vt_opcional1_12:=[Alumnos:2]curso:20
					$vt_opcional2_13:=String:C10([ACT_Boletas:181]FechaEmision:3)
					$vt_opcional3_14:=atACTcfg_Razones{vQR_Long3}
					$vt_fechaV2_15:=String:C10(vQR_Date2)
					$vt_montoNeto_16:=$vt_montoNeto_3
					$vt_valorIVA2_17:=$vt_valorIVA_4
					$vt_concepto_18:=$vt_concepto_5
					$vt_saldoAnterior19:="0"
					
					
					
					$text:=$vt_numBoleta_1+$vt_Separador+$vt_codCtaCte_2+$vt_Separador+$vt_montoNeto_3+$vt_Separador+$vt_valorIVA_4+$vt_Separador+$vt_concepto_5+$vt_Separador+$vt_fechaV_6+$vt_Separador+$vt_email_7+$vt_Separador+$vt_clavePago_8+$vt_Separador+$vt_nombre_9+$vt_Separador+$vt_ApPaterno_10+$vt_Separador+$vt_telefono_11+$vt_Separador+$vt_opcional1_12+$vt_Separador+$vt_opcional2_13+$vt_Separador+$vt_opcional3_14+$vt_Separador+$vt_fechaV2_15+$vt_Separador+$vt_montoNeto_16+$vt_Separador+$vt_valorIVA2_17+$vt_Separador+$vt_concepto_18+$vt_Separador+$vt_saldoAnterior19+"\r"
					IO_SendPacket ($ref;$text)
					
					vtotalPAC:=String:C10(Num:C11(vtotalPAC)+1)
					vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+$vr_monto)
					
					SET_ClearSets ("setCargosRST";"setCargosRS";"selectionApdo")
				End if 
				
				USE SET:C118("setAvisos")
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("CargosRazonSocial"))/$vl_total;"Exportando datos razón social "+ST_GetWord (atACTcfg_Razones{vQR_Long3};2;" ")+"...")
			End while 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			CLOSE DOCUMENT:C267($ref)
			
			If (vl_otrasMonedas=1)
				<>vsACT_MonedaColegio:=$vt_monedaOrg
			End if 
		Else 
			vb_detenerImp:=True:C214
		End if 
	End if 
End for 
vnumTransPAC:=String:C10(Num:C11(vnumTransPAC);"|Despliegue_ACT")
SET_ClearSets ("CargosTodos")
SET_ClearSets ("setAvisos";"setCargosProcesados";"CargosRazonSocial")
