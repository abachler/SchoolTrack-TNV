//%attributes = {}
  // Método: TGR_BBL_Transacciones
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 10:14:32
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal

If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				READ WRITE:C146([BBL_Lectores:72])
				RELATE ONE:C42([BBL_Transacciones:59]ID_User:4)
				If ([BBL_Transacciones:59]is_Paiement:5)
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27+[BBL_Transacciones:59]Monto:2
				Else 
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27-[BBL_Transacciones:59]Monto:2
				End if 
				SAVE RECORD:C53([BBL_Lectores:72])
				KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				READ WRITE:C146([BBL_Lectores:72])
				RELATE ONE:C42([BBL_Transacciones:59]ID_User:4)
				If ([BBL_Transacciones:59]is_Paiement:5)
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27+[BBL_Transacciones:59]Monto:2-Old:C35([BBL_Transacciones:59]Monto:2)
				Else 
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27-[BBL_Transacciones:59]Monto:2+Old:C35([BBL_Transacciones:59]Monto:2)
				End if 
				SAVE RECORD:C53([BBL_Lectores:72])
				KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				READ WRITE:C146([BBL_Lectores:72])
				RELATE ONE:C42([BBL_Transacciones:59]ID_User:4)
				If ([BBL_Transacciones:59]is_Paiement:5)
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27-Old:C35([BBL_Transacciones:59]Monto:2)
				Else 
					[BBL_Lectores:72]Saldo:27:=[BBL_Lectores:72]Saldo:27+Old:C35([BBL_Transacciones:59]Monto:2)
				End if 
				SAVE RECORD:C53([BBL_Lectores:72])
				KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
		End case 
	End if 
End if 



