IT_clairvoyanceOnFields2 (Self:C308;->[Profesores:4]Apellidos_y_nombres:28)

If (Form event:C388=On Losing Focus:K2:8)
	If (Records in selection:C76([Profesores:4])=1)
		If ([Profesores:4]Inactivo:62)
			$ignore:=CD_Dlog (0;__ ("El funcionario seleccionado está inactivo.\rSeleccione un funcionario activo o active el funcionario seleccionado."))
			varMonitor:=""
			[BU_Rutas:26]Numero_Monitor:10:=0
			GOTO OBJECT:C206(varMonitor)
		Else 
			varMonitor:=[Profesores:4]Apellidos_y_nombres:28
			[BU_Rutas:26]Numero_Monitor:10:=[Profesores:4]Numero:1
		End if 
	Else 
		varMonitor:=""
		[BU_Rutas:26]Numero_Monitor:10:=0
		GOTO OBJECT:C206(varMonitor)
	End if 
End if 


vbSpell_StopChecking:=True:C214