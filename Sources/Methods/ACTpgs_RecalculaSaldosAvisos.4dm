//%attributes = {}
  //ACTpgs_RecalculaSaldosAvisos

If (False:C215)
	C_LONGINT:C283($Vencidos)
	
	If (Count parameters:C259=2)
		$Display:=$2
	Else 
		$Display:=True:C214
	End if 
	
	CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$1->)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"todos")
	CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"Vencidos")
	SET QUERY DESTINATION:C396(Into set:K19:2;"Vencidos")
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*))
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	DIFFERENCE:C122("todos";"Vencidos";"todos")
	USE SET:C118("todos")
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
	SET_ClearSets ("todos";"Vencidos")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
		
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$RecNumAC)
		
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RecNumAC{1})
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		$PorPagar:=Abs:C99(Sum:C1([ACT_Cargos:173]Saldo:23))
		[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=$PorPagar
		$SaldoAnterior:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14
		SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
		
		If (Size of array:C274($RecNumAC)>1)
			If ($Display)
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando saldos..."))
			End if 
			$iterations:=Size of array:C274($RecNumAC)
			$currentiteration:=0
			For ($i;2;Size of array:C274($RecNumAC))
				$currentiteration:=$i
				READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
				GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$RecNumAC{$i})
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				$PorPagar:=Abs:C99(Sum:C1([ACT_Cargos:173]Saldo:23))
				If (Macintosh option down:C545 | Windows Alt down:C563)
					[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
					[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=$PorPagar
				Else 
					[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=$SaldoAnterior
					[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=$PorPagar+$SaldoAnterior
				End if 
				$SaldoAnterior:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14
				SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
				If ($Display)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recalculando saldos..."))
				End if 
			End for 
			If ($Display)
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
	End if 
	UNLOAD RECORD:C212([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
End if 