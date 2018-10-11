//%attributes = {}
  //ACTac_DeleteSelection

_O_C_INTEGER:C282($lockedCargos;$lockedDocs)
C_BOOLEAN:C305($Abort;$vb_hayPagare)
$0:=0
$Abort:=False:C215
If (USR_checkRights ("D";->[ACT_Avisos_de_Cobranza:124]))
	CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"Deleteable")
	FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando avisos eliminables..."))
	$selectedAvisos:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	$vb_hayPagare:=False:C215
	For ($i;1;$selectedAvisos)
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		ARRAY REAL:C219(arACT_MontoPagado;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado)
		$montoPagado:=(AT_GetSumArray (->arACT_MontoPagado))*-1
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$trans)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;*)
		QUERY:C277([ACT_Transacciones:178]; & [ACT_Transacciones:178]No_Boleta:9#0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SET QUERY LIMIT:C395(0)
		
		  // 20111025 RCH Cuando no habia pagare asociado no se podian eliminar los avisos.
		  //$vl_idEstadoPagare:=KRL_GetNumericFieldData (->[ACT_Pagares]ID;->[ACT_Avisos_de_Cobranza]ID_Pagare;->[ACT_Pagares]ID_Estado)
		If ([ACT_Pagares:184]ID_Estado:6#0)
			$vl_idEstadoPagare:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;->[ACT_Pagares:184]ID_Estado:6)
		Else 
			$vl_idEstadoPagare:=-2
		End if 
		If (($montoPagado=0) & ($trans=0) & ($vl_idEstadoPagare=-2))
			ADD TO SET:C119([ACT_Avisos_de_Cobranza:124];"Deleteable")
		Else 
			If ($vl_idEstadoPagare>0)
				$vb_hayPagare:=True:C214
			End if 
		End if 
		NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$selectedAvisos;__ ("Verificando avisos eliminables..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	USE SET:C118("Deleteable")
	CLEAR SET:C117("Deleteable")
	AT_Initialize (->arACT_MontoPagado)
	$deletableAvisos:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	If ($deletableAvisos>0)
		If ($deletableAvisos=$selectedAvisos)
			If ($deletableAvisos=1)
				$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el registro seleccionado?");__ ("");__ ("No");__ ("Si"))
			Else 
				$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar los ")+String:C10($selectedAvisos)+__ (" registros seleccionados?");__ ("");__ ("No");__ ("Si"))
			End if 
		Else 
			$r:=CD_Dlog (0;__ ("De ")+String:C10($selectedAvisos)+__ (" registros seleccionados ")+String:C10($deletableAvisos)+__ (" pueden ser eliminados.\rLos restantes están total o parcialmente pagados y/o están incluidos en Documentos Tributarios, por lo que no pueden ser eliminados a menos que elimine primero los pagos y/o anule los Documentos Tributarios asociados.\r\r¿Est"+"á")+__ (" seguro de querer eliminar los ")+String:C10($deletableAvisos)+__ (" registros eliminables?");__ ("");__ ("No");__ ("Si"))
			  //$msg:="De "+String($selectedAvisos)+" registros seleccionados "+String($deletableAvisos)+" pueden ser eliminados."+<>cr+"Los restantes están total o parcialmente pagados y/o están incluidos en Documento"+"s Tributarios"+ST_Boolean2Str ($vb_hayPagare;" y/o están asociados a algún pagaré vigente";"")+", por lo que no pueden ser elimina"+"dos a menos que elimine primero los pagos y/o anule los Documentos Tributarios as"+"ociados"+ST_Boolean2Str ($vb_hayPagare;" y/o anule el pagaré asociado";"")+"."+<>cr+<>cr
		End if 
		  //$r:=CD_Dlog (0;$msg;"";"No";"Si")
		If ($r=2)
			vb_CondonaAvisos:=True:C214
			$continue:=ACTcfg_OpcionesCondonacion ("SolicitaMotivo")
			If ($continue)
				ACTcc_OpcionesCalculoCtaCte ("InitArrays")
				ACTac_RecalculaAvisos ("DeclaraInitVars")
				ARRAY LONGINT:C221($aRecNumAvisos;0)
				SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos)
				START TRANSACTION:C239
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Eliminando Avisos de Cobranza..."))
				$iterations:=Size of array:C274($aRecNumAvisos)
				For ($i;1;Size of array:C274($aRecNumAvisos))
					READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
					READ WRITE:C146([ACT_Cargos:173])
					GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aRecNumAvisos{$i})
					ACTcfg_OpcionesCondonacion ("GuardaMotivo")
					
					ACTac_RecalculaAvisos ("AgregarElemento";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
					$abort:=ACTac_Delete ($aRecNumAvisos{$i})
					If ($abort)
						$i:=Size of array:C274($aRecNumAvisos)+1
					End if 
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$iterations)
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				If (Not:C34($Abort))
					VALIDATE TRANSACTION:C240
					$0:=1
					ACTac_RecalculaAvisos ("RecalculaAviso")
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("En este momento existen registros en uso. La selección no puede ser eliminada."))
				End if 
				$vb_mostrarTermo:=True:C214
				ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)
			Else 
				$vt_dlog:=""
				ACTcfg_OpcionesCondonacion ("RetornaDlogNoContinuar";->$vt_dlog)
				CD_Dlog (0;$vt_dlog)
			End if 
			ACTcfg_OpcionesCondonacion ("InitVars")
			KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
		End if 
	Else 
		CD_Dlog (0;__ ("Ningún registro puede ser eliminado debido a que todos están total o parcialmente pagados y/o están asociados a Documentos Tributarios. Para eliminarlos debe primero eliminar los pagos correspondientes y/o anular los Documentos Tributarios asociado"+"s."))
		  //CD_Dlog (0;"Ningún registro puede ser eliminado debido a que todos están total o parcialmente"+" pagados y/o están asociados a Documentos Tributarios"+ST_Boolean2Str ($vb_hayPagare;" y/o están asociados a Pagarés";"")+". Para eliminarlos debe prim"+"ro eliminar los pagos correspondientes y/o anular los Documentos Tributarios aso"+"ciados"+ST_Boolean2Str ($vb_hayPagare;" y/o anular los pagarés asociados";"")+".")
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 