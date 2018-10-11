//%attributes = {}
  //xALP_CB_ACT_Bancos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Bancos;$col;$line)
	Case of 
		: ($col=1)
			$IDNum:=Num:C11(atACT_BankID{$line})
			atACT_BankID{$line}:=String:C10($IDNum;"000")
			$existe:=Find in array:C230(atACT_BankID;atACT_BankID{$line};2)
			If (($existe#$line) & ($existe#-1))
				CD_Dlog (0;__ ("Ya existe en banco con ese código."))
				atACT_BankID{$line}:=atACT_BankID{0}
				AL_GotoCell (xALP_Bancos;$col;$line)
			Else 
				If ((atACT_BankID{$line}#atACT_BankID{0}) & (atACT_BankID{0}#""))
					If (atACT_BankID{$line}#"")
						abACT_BankModified{$line}:=True:C214
						$procid:=IT_UThermometer (1;0;__ ("Actualizando registros de Apoderados..."))
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]ACT_ID_Banco_Cta:48=atACT_BankID{0})
						  //0xDev_AvoidTriggerExecution (True)
						APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_ID_Banco_Cta:48:=atACT_BankID{$line})
						  //0xDev_AvoidTriggerExecution (False)
						KRL_UnloadReadOnly (->[Personas:7])
						IT_UThermometer (-2;$procid)
					Else 
						BEEP:C151
						atACT_BankID{$line}:=atACT_BankID{0}
					End if 
				End if 
				
			End if 
		: ($col=2)
			$existe:=Find in array:C230(atACT_BankName;atACT_BankName{$line};2)
			If (($existe#$line) & ($existe#-1))
				CD_Dlog (0;__ ("Ya existe en banco con ese nombre."))
				atACT_BankName{$line}:=atACT_BankName{0}
				AL_GotoCell (xALP_Bancos;$col;$line)
			Else 
				If ((atACT_BankName{$line}#atACT_BankName{0}) & (atACT_BankName{0}#""))
					If (atACT_BankName{$line}#"")
						abACT_BankModified{$line}:=True:C214
						$procid:=IT_UThermometer (1;0;__ ("Actualizando registros de Apoderados..."))
						READ WRITE:C146([Personas:7])
						QUERY:C277([Personas:7];[Personas:7]ACT_Banco_Cta:47=atACT_BankName{0})
						  //0xDev_AvoidTriggerExecution (True)
						APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_Banco_Cta:47:=atACT_BankName{$line})
						  //0xDev_AvoidTriggerExecution (False)
						KRL_UnloadReadOnly (->[Personas:7])
						IT_UThermometer (-2;$procid)
					Else 
						BEEP:C151
						atACT_BankName{$line}:=atACT_BankName{0}
					End if 
				End if 
			End if 
		: ($col=3)
			If (atACT_BankID{$line}#"") & (atACT_BankName{$line}#"")
				abACT_BankModified{$line}:=True:C214
			End if 
	End case 
End if 