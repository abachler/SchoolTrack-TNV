If (USR_IsGroupMember_by_GrpID (-15001))
	If (Self:C308->#0)
		$modRef:=aModRefs{Self:C308->}
		[xShell_Userfields:76]ModuleName:10:=<>aModules{$modRef}
	End if 
Else 
	CD_Dlog (0;__ ("Sólo los administradores pueden cambiar campos propios de módulo."))
End if 