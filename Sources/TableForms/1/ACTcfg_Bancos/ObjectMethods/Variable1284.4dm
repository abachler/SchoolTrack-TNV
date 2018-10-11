$line:=AL_GetLine (xALP_Bancos)
If ($line>0)
	$recNum:=alACT_BankRecNum{$line}
	If ((abACT_BankEstandar{$line}) & (<>lUSR_CurrentUserID>=0))
		CD_Dlog (0;__ ("Este banco es estándar del sistema y no puede ser eliminado."))
	Else 
		If ((atACT_BankID{$line}="") & (atACT_BankName{$line}=""))
			AL_UpdateArrays (xALP_Bancos;0)
			AT_Delete ($line;1;->atACT_BankID;->atACT_BankName;->abACT_BankEstandar;->alACT_BankRecNum;->abACT_BankModified;->atACT_BankNumConvenio)
			AL_UpdateArrays (xALP_Bancos;-2)
			AL_SetLine (xALP_Bancos;0)
			For ($i;1;Size of array:C274(abACT_BankModified))
				ARRAY LONGINT:C221($LongArray;2;0)
				If (abACT_BankEstandar{$i})
					$enterable:=Num:C11(<>lUSR_CurrentUserID<0)
					AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;$enterable)
					AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;2;"")
				End if 
			End for 
			_O_DISABLE BUTTON:C193(bClearBank)
			_O_DISABLE BUTTON:C193(bEstandar)
			If ($recNum#-1)
				READ WRITE:C146([xxACT_Bancos:129])
				GOTO RECORD:C242([xxACT_Bancos:129];$recNum)
				DELETE RECORD:C58([xxACT_Bancos:129])
				READ ONLY:C145([xxACT_Bancos:129])
			End if 
		Else 
			$r:=CD_Dlog (0;__ ("¿Esta seguro que desea eliminar este banco?");__ ("");__ ("No");__ ("Si"))
			If ($r=2)
				SET QUERY LIMIT:C395(1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$apdos)
				QUERY:C277([Personas:7];[Personas:7]ACT_ID_Banco_Cta:48=atACT_BankID{$line})
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY LIMIT:C395(0)
				If ($apdos=1)
					CD_Dlog (0;__ ("Este banco está asignado a por lo menos un apoderado. No es posible eliminarlo."))
				Else 
					If (alACT_BankRecNum{$line}#-1)
						READ WRITE:C146([xxACT_Bancos:129])
						GOTO RECORD:C242([xxACT_Bancos:129];alACT_BankRecNum{$line})
						DELETE RECORD:C58([xxACT_Bancos:129])
						KRL_UnloadReadOnly (->[xxACT_Bancos:129])
					End if 
					AL_UpdateArrays (xALP_Bancos;0)
					AT_Delete ($line;1;->atACT_BankID;->atACT_BankName;->abACT_BankEstandar;->alACT_BankRecNum;->abACT_BankModified;->atACT_BankNumConvenio)
					AL_UpdateArrays (xALP_Bancos;-2)
					AL_SetLine (xALP_Bancos;0)
					For ($i;1;Size of array:C274(abACT_BankModified))
						ARRAY LONGINT:C221($LongArray;2;0)
						If (abACT_BankEstandar{$i})
							$enterable:=Num:C11(<>lUSR_CurrentUserID<0)
							AL_SetCellEnter (xALP_Bancos;1;$i;2;$i;$LongArray;$enterable)
							AL_SetCellStyle (xALP_Bancos;1;$i;2;$i;$LongArray;2;"")
						End if 
					End for 
					_O_DISABLE BUTTON:C193(bClearBank)
					_O_DISABLE BUTTON:C193(bEstandar)
					  //If ($recNum#-1) arriba se elimina el registro...
					  //READ WRITE([xxACT_Bancos])
					  //GOTO RECORD([xxACT_Bancos];$recNum)
					  //DELETE RECORD([xxACT_Bancos])
					  //READ ONLY([xxACT_Bancos])
					  //End if 
				End if 
			End if 
		End if 
	End if 
End if 