C_BOOLEAN:C305(vb_HistoricoEditable)

If (Contextual click:C713)
	$r:=Pop up menu:C542("Establecer permisos...")
	If ($r=1)
		RESOLVE POINTER:C394(Self:C308;$buttonName;$Table;$field)
		USR_SetSpecialPermissions ($buttonName;"EditarHistórico";"Edición de registros históricos")
	End if 
Else 
	$recNumSintesis:=Record number:C243([Alumnos_SintesisAnual:210])
	  //$recNumHistorico:=Record number([Alumnos_Histórico])
	If ((USR_IsGroupMember_by_GrpID (-15001)) | (USR_GetMethodAcces ("EditarHistórico";0)))
		AL_EditHistorico_OM 
		AL_CiclosEscolares_Historico ([Alumnos:2]numero:1)
		If ($recNumSintesis<0)
			$recNumSintesis:=Record number:C243([Alumnos_SintesisAnual:210])
			$recNumHistorico:=Record number:C243([Alumnos_Historico:25])
		End if 
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;vb_HistoricoEditable)
		If (Count list items:C380(hl_CiclosEscolares_Historico)=0)
			_O_DISABLE BUTTON:C193(hl_CiclosEscolares_Historico)
		Else 
			_O_ENABLE BUTTON:C192(hl_CiclosEscolares_Historico)
		End if 
	Else 
		CD_Dlog (0;__ ("Usted no dispone de los permisos necesarios para editar los registros históricos."))
	End if 
End if 