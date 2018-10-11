//%attributes = {}
  //ACTcc_Activar

C_LONGINT:C283($proc)
If (USR_GetMethodAcces (Current method name:C684))
	If (vbACT_EstadoCC)
		$r:=CD_Dlog (0;__ ("El alumno asociado a esta cuenta corriente tiene el estado ")+ST_Qte ([Alumnos:2]Status:50)+__ (" en SchoolTrack.\r¿Está usted seguro de querer desactivar esta cuenta?");__ ("");__ ("Si");__ ("No"))
	Else 
		$r:=CD_Dlog (0;__ ("El alumno asociado a esta cuenta corriente tiene el estado ")+ST_Qte ([Alumnos:2]Status:50)+__ (" en SchoolTrack.\r¿Está usted seguro de querer activar esta cuenta?");__ ("");__ ("Si");__ ("No"))
	End if 
	If ($r=2)
		[ACT_CuentasCorrientes:175]Estado:4:=vbACT_EstadoCC
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
	Else 
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		$proc:=IT_UThermometer (1;0;__ ("Desactivando cuenta. Un momento por favor..."))
		vbACT_EstadoCC:=[ACT_CuentasCorrientes:175]Estado:4
		If (Not:C34(vbACT_EstadoCC))
			$PrevMatrixID:=[ACT_CuentasCorrientes:175]ID_Matriz:7
			[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
			SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			vsACT_AsignedMatrix:="Seleccionar..."
			  //vrACT_MontoMatriz:=0
			  //vtACT_SimbMonedaMatriz:=""
			<>atACT_MatrixName:=0
			  //If ($PrevMatrixID#0)
			READ WRITE:C146([ACT_Cargos:173])
			READ WRITE:C146([ACT_Documentos_de_Cargo:174])
			  //QUERY([xxACT_ItemsMatriz];[xxACT_ItemsMatriz]ID_Matriz=$PrevMatrixID)
			  //KRL_RelateSelection (->[ACT_Cargos]Ref_Item;->[xxACT_ItemsMatriz]ID_Item;"")
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			ACTcc_EliminaCargosLoop 
			ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
			LOAD RECORD:C52([ACT_CuentasCorrientes:175])
			UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			  //End if 
		End if 
		IT_UThermometer (-2;$proc)
	End if 
Else 
	[ACT_CuentasCorrientes:175]Estado:4:=vbACT_EstadoCC
End if 