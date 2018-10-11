$line:=AL_GetLine (xALP_Transactions)
If ($line>0)
	READ WRITE:C146([BBL_Transacciones:59])
	GOTO RECORD:C242([BBL_Transacciones:59];aLong1{$line})
	If (Not:C34(Locked:C147([BBL_Transacciones:59])))
		TRACE:C157
		If ([BBL_Transacciones:59]is_Paiement:5)
			OK:=CD_Dlog (0;__ ("¿Desea realmente eliminar este pago?");__ ("");__ ("No");__ ("Sí"))
		Else 
			OK:=CD_Dlog (0;__ ("¿Desea realmente eliminar este cargo?");__ ("");__ ("No");__ ("Sí"))
		End if 
		If (OK=2)
			TRACE:C157
			$patronRec:=Record number:C243([BBL_Lectores:72])
			DELETE RECORD:C58([BBL_Transacciones:59])
			GOTO RECORD:C242([BBL_Lectores:72];$patronRec)
			AL_UpdateArrays (xALP_Transactions;0)
			AT_Delete ($line;1;->aLong1;->aText1;->aDate1;->aReal1;->aReal2)
			AL_UpdateArrays (xALP_Transactions;-2)
			If ([BBL_Lectores:72]Saldo:27<0)
				AL_SetFooters (xALP_Transactions;3;1;"")
				AL_SetForeColor (xALP_Transactions;3;"Black";0;"Black";0;"Red";0)
				AL_SetFooters (xALP_Transactions;4;1;String:C10([BBL_Lectores:72]Saldo:27;"### ### ##0"))
				AL_SetForeColor (xALP_Transactions;4;"Black";0;"Black";0;"Red";0)
			Else 
				AL_SetFooters (xALP_Transactions;4;1;"")
				AL_SetForeColor (xALP_Transactions;4;"Black";0;"Black";0;"Red";0)
				AL_SetFooters (xALP_Transactions;3;1;String:C10([BBL_Lectores:72]Saldo:27;"### ### ##0"))
				AL_SetForeColor (xALP_Transactions;3;"Black";0;"Black";0;"Blue";0)
			End if 
		End if 
	End if 
Else 
	BEEP:C151
End if 