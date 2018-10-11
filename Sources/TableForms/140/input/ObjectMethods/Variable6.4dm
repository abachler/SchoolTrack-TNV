If (KRL_RegistroFueModificado (->[Familia_RegistroEventos:140]))
	[Familia_RegistroEventos:140]ModuloRef:6:=vlBWR_CurrentModuleRef
End if 

If ([Familia_RegistroEventos:140]Privada:8)
	[Familia_RegistroEventos:140]ID_Owner:7:=<>lUSR_RelatedTableUserID
Else 
	[Familia_RegistroEventos:140]ID_Owner:7:=0
End if 