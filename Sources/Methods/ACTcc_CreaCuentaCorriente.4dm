//%attributes = {}
  //ACTcc_CreaCuentaCorriente
C_REAL:C285(cbCtasAfectasInteres)

$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	If (Count parameters:C259=1)
		$initProc:=$1
	Else 
		$initProc:=False:C215
	End if 
	  //ACTcfg_LoadConfigData (1)
	ACTinit_CreateDefAfectasInteres ("LeeBlob")
	If ($initProc)
		cbNCtasAfectas:=cbCtasAfectasInteres
	End if 
	If ([Alumnos:2]Apellido_paterno:3#"")
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		If (Record number:C243([Alumnos:2])#New record:K29:1)
			  //vb_GuardeCuentaCorriente:=True
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
			If (([Alumnos:2]nivel_numero:29>=Nivel_AdmissionTrack) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados) & ([Alumnos:2]numero:1#0))
				If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
					CREATE RECORD:C68([ACT_CuentasCorrientes:175])
					[ACT_CuentasCorrientes:175]ID_Alumno:3:=[Alumnos:2]numero:1
					[ACT_CuentasCorrientes:175]Estado:4:=True:C214
					[ACT_CuentasCorrientes:175]AfectoIntereses:28:=(cbNCtasAfectas=1)
				End if 
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			End if 
			If (Records in selection:C76([ACT_CuentasCorrientes:175])#0)
				[ACT_CuentasCorrientes:175]ID_Familia:2:=[Alumnos:2]Familia_Número:24
				[ACT_CuentasCorrientes:175]ID_Apoderado:9:=[Alumnos:2]Apoderado_Cuentas_Número:28
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			End if 
			UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
		Else 
			If (([Alumnos:2]nivel_numero:29>=Nivel_AdmissionTrack) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados) & ([Alumnos:2]numero:1#0))
				CREATE RECORD:C68([ACT_CuentasCorrientes:175])
				[ACT_CuentasCorrientes:175]ID_Alumno:3:=[Alumnos:2]numero:1
				[ACT_CuentasCorrientes:175]ID_Familia:2:=[Alumnos:2]Familia_Número:24
				[ACT_CuentasCorrientes:175]ID_Apoderado:9:=[Alumnos:2]Apoderado_Cuentas_Número:28
				[ACT_CuentasCorrientes:175]Estado:4:=True:C214
				[ACT_CuentasCorrientes:175]Numero_Hijo:10:=0
				[ACT_CuentasCorrientes:175]AfectoIntereses:28:=(cbNCtasAfectas=1)
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
			End if 
		End if 
		READ ONLY:C145([ACT_CuentasCorrientes:175])
	End if 
End if 