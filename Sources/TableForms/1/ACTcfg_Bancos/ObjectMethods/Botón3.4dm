If (Not:C34(Semaphore:C143("Verificando bancos en apdos.")))
	READ WRITE:C146([Personas:7])
	ALL RECORDS:C47([Personas:7])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando información de bancos en apoderados..."))
	FIRST RECORD:C50([Personas:7])
	While (Not:C34(End selection:C36([Personas:7])))
		$banco:=Find in array:C230(atACT_BankName;[Personas:7]ACT_Banco_Cta:47)
		$idBanco:=Find in array:C230(atACT_BankID;[Personas:7]ACT_ID_Banco_Cta:48)
		Case of 
			: (($banco#-1) & ($idBanco#-1))
				If ($banco#$idBanco)
					[Personas:7]ACT_ID_Banco_Cta:48:=atACT_BankID{$banco}
				End if 
			: (($banco=-1) & ($idBanco#-1))
				[Personas:7]ACT_Banco_Cta:47:=atACT_BankName{$idbanco}
			: (($banco#-1) & ($idBanco=-1))
				[Personas:7]ACT_ID_Banco_Cta:48:=atACT_BankID{$banco}
			: (($banco=-1) & ($idBanco=-1))
				[Personas:7]ACT_Banco_Cta:47:=""
				[Personas:7]ACT_ID_Banco_Cta:48:=""
		End case 
		If (KRL_RegistroFueModificado (->[Personas:7]))
			SAVE RECORD:C53([Personas:7])
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Personas:7])/Records in table:C83([Personas:7]);__ ("Verificando información de bancos en apoderados..."))
		NEXT RECORD:C51([Personas:7])
	End while 
	CLEAR SEMAPHORE:C144("Verificando bancos en apdos.")
	UNLOAD RECORD:C212([Personas:7])
	READ ONLY:C145([Personas:7])
Else 
	CD_Dlog (0;__ ("Otro usuario ya inició el proceso de verificación."))
End if 