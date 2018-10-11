If (vsPST_aPaterno#"")
	Case of 
		: (vsPST_Parent="Mother")
			CREATE RECORD:C68([Personas:7])
			[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
			[Personas:7]Sexo:8:="F"
			[Personas:7]Apellido_paterno:3:=vsPST_apaterno
			[Personas:7]Apellido_materno:4:=vsPST_aMaterno
			[Personas:7]Nombres:2:=vsPST_Nombres
			[Personas:7]Fecha_de_nacimiento:5:=vdPST_fNac
			[Personas:7]Profesion:13:=vsPST_Profesion
			[Personas:7]Telefono_domicilio:19:=vsPST_TelPers
			[Personas:7]Telefono_profesional:29:=vsPST_TelPro
			[Personas:7]Es_ExAlumno:12:=(viPST_ex=1)
			[Personas:7]RUT:6:=vsPST_RUT
			SAVE RECORD:C53([Personas:7])
			KRL_ReloadAsReadOnly (->[Personas:7])
			viPST_MotherRecNum:=Record number:C243([Personas:7])
		: (vsPST_Parent="Father")
			CREATE RECORD:C68([Personas:7])
			[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
			[Personas:7]Sexo:8:="M"
			[Personas:7]Apellido_paterno:3:=vsPST_apaterno
			[Personas:7]Apellido_materno:4:=vsPST_aMaterno
			[Personas:7]Nombres:2:=vsPST_Nombres
			[Personas:7]Fecha_de_nacimiento:5:=vdPST_fNac
			[Personas:7]Profesion:13:=vsPST_Profesion
			[Personas:7]Telefono_domicilio:19:=vsPST_TelPers
			[Personas:7]Telefono_profesional:29:=vsPST_TelPro
			[Personas:7]Es_ExAlumno:12:=(viPST_ex=1)
			[Personas:7]RUT:6:=vsPST_RUT
			SAVE RECORD:C53([Personas:7])
			KRL_ReloadAsReadOnly (->[Personas:7])
			viPST_FatherRecNum:=Record number:C243([Personas:7])
	End case 
	ACCEPT:C269
Else 
	BEEP:C151
End if 