ARRAY TEXT:C222(ACTepr_RutApoderado;0)
Case of 
	: (vLabelLink="ID")
		Case of 
			: (vRUTTable=Table:C252(->[Personas:7]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=Num:C11(aRUTRechazo{$i}))
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
			: (vRUTTable=Table:C252(->[Alumnos:2]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=Num:C11(aRUTRechazo{$i}))
					QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
			: (vRUTTable=Table:C252(->[ACT_CuentasCorrientes:175]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=Num:C11(aRUTRechazo{$i}))
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
			: (vRUTTable=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=Num:C11(aRUTRechazo{$i}))
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18;"")
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
		End case 
	Else 
		Case of 
			: (vRUTTable=Table:C252(->[Personas:7]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=aRUTRechazo{$i})
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
			: (vRUTTable=Table:C252(->[Alumnos:2]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=aRUTRechazo{$i})
					QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
			: (vRUTTable=Table:C252(->[ACT_CuentasCorrientes:175]))
				For ($i;1;Size of array:C274(aRUTRechazo))
					QUERY:C277(vLinkingTable->;vLinkingField->=aRUTRechazo{$i})
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					Case of 
						: ([Personas:7]RUT:6#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]RUT:6)
						: ([Personas:7]IDNacional_2:37#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_2:37)
						: ([Personas:7]IDNacional_3:38#"")
							APPEND TO ARRAY:C911(ACTepr_RutApoderado;[Personas:7]IDNacional_3:38)
					End case 
				End for 
		End case 
		
End case 

If (Size of array:C274(ACTepr_RutApoderado)>0)
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_EnvioMailPagosRechazados";-1;4;__ ("Enviar Pagos Rechazados"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_EnvioMailPagosRechazados")
	CLOSE WINDOW:C154
	If (ok=1)
		C_TEXT:C284(vt_parametros)
		ACTepr_OpcionesGenerales ("GuardaBlob")
		  //20141029 RCH Cambio a uso de blob
		  //vt_IdApoderados:=AT_array2text (->alACTepr_ApoderadoID2Enviar;"__/__")
		  //vt_MontosRechazados:=AT_array2text (->arACTepr_ApoMontoRechaEnviar;"__/__")
		  //vt_eMail:=AT_array2text (->atACTepr_EmailApoderadoEnviar;"__/__")
		  //$process:=Execute on server("ACTepr_EnviaMailPR";256000;"Envio de Mail Pagos Rechazados";vt_IdApoderados;vt_MontosRechazados;vt_eMail)
		C_BLOB:C604($xBlob)
		BLOB_Variables2Blob (->$xBlob;0;->alACTepr_ApoderadoID2Enviar;->arACTepr_ApoMontoRechaEnviar;->atACTepr_EmailApoderadoEnviar)
		
		  // Modificado por: Saul Ponce (26/02/2018) Ticket 136131 pasar como parámetro al método un objeto con los datos del proceso
		  //$process:=Execute on server("ACTepr_EnviaMailPR";256000;"Envio de Mail Pagos Rechazados";$xBlob)
		C_OBJECT:C1216($ob_data)
		OB SET:C1220($ob_data;"tipoArchivo";vTipo)
		OB SET:C1220($ob_data;"usuario";<>tUSR_CurrentUser)
		OB SET:C1220($ob_data;"modoPago";vlACT_id_modo_pago)
		OB SET:C1220($ob_data;"nombreArchivo";vtACT_fileName)
		OB SET:C1220($ob_data;"fechaReal";String:C10(vdACT_ImpRealDate))
		$process:=Execute on server:C373("ACTepr_EnviaMailPR";256000;"Envio de Mail Pagos Rechazados";$xBlob;$ob_data)
	End if 
End if 
