//%attributes = {}
  //dbuACT_VerificaAvisosPagados
  //20110214  En el colegio Yaocalli fueron encontrados 14 avisos de cobranza que tenian monto a pagar 0 y no tenian pago asociado
  // ... el pago habia sido eliminado pero el monto a pagar no se actualizo correctamente. Hay que monitorear esta situacion.

C_LONGINT:C283($i;$vl_records;$vl_proc)

ARRAY LONGINT:C221($alACT_recNumAvisos;0)
ARRAY LONGINT:C221($alACT_idsAvisos;0)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Transacciones:178])

MESSAGES OFF:C175
$vl_proc:=IT_UThermometer (1;0;"Ejecutando verificación...")
If (Not:C34(IT_AltKeyIsDown ))
	  //se verifica para avisos de hace 3 meses atras
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5>=Add to date:C393(Current date:C33(*);0;-3;0))
Else 
	ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
End if 
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_Neto:11>0)
QUERY SELECTION BY FORMULA:C207([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_Neto:11#[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$alACT_recNumAvisos;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando montos de avisos...")
For ($i;1;Size of array:C274($alACT_idsAvisos))
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$alACT_idsAvisos{$i};*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($vl_records=0)
		  //LOG_RegisterEvt ("Aviso de cobranza número: "+String($alACT_idsAvisos{$i})+" recalculado automáticamente.") //20121221 RCH genera muchas entradas en el log
		ACTac_Recalcular ($alACT_recNumAvisos{$i})
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_idsAvisos))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

IT_UThermometer (-2;$vl_proc)