//%attributes = {}
  //ACTcae_DoSettings

If (cb_InactivaEgresados=1)
	READ ONLY:C145([Alumnos:2])
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	QUERY:C277([Alumnos:2];[Alumnos:2]Nivel_Nombre:34="Egresados")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inactivando cuentas de alumnos egresados..."))
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
		[ACT_CuentasCorrientes:175]Estado:4:=False:C215
		[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		ACTcc_EliminaCargosLoop 
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_CuentasCorrientes:175])/Records in selection:C76([ACT_CuentasCorrientes:175]))
	End while 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cuentas de Egresados inactivadas.")
End if 
If (cb_InactivaRetirados=1)
	READ ONLY:C145([Alumnos:2])
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_Retirados)
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inactivando cuentas de alumnos retirados..."))
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
		[ACT_CuentasCorrientes:175]Estado:4:=False:C215
		[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		ACTcc_EliminaCargosLoop 
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_CuentasCorrientes:175])/Records in selection:C76([ACT_CuentasCorrientes:175]))
	End while 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cuentas de Retirados inactivadas.")
End if 
If (cb_LimpiaMatrices=1)
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	ALL RECORDS:C47([ACT_CuentasCorrientes:175])
	FIRST RECORD:C50([ACT_CuentasCorrientes:175])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Desasignando matrices..."))
	While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
		[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
		SAVE RECORD:C53([ACT_CuentasCorrientes:175])
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
		ACTcc_EliminaCargosLoop 
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ACT_CuentasCorrientes:175])/Records in selection:C76([ACT_CuentasCorrientes:175]))
	End while 
	KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Matrices desasignadas.")
End if 
If (cb_LimpiaDesctoXCta=1)
	ACTcc_LimpiaDescuentoXCuenta (True:C214)
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Descuentos por cuenta limpios.")
End if 

  //20120629 RCH Se agrega nueva opcion...
If (cb_eliminaDocCarNulos=1)
	C_DATE:C307($vd_date)
	C_LONGINT:C283($i)
	
	ARRAY LONGINT:C221($alACT_recNumDocCar;0)
	$vd_date:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
	READ ONLY:C145([ACT_Documentos_en_Cartera:182])
	READ ONLY:C145([ACT_Documentos_de_Pago:176])
	READ ONLY:C145([ACT_Pagos:172])
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Fecha_Doc:5<=$vd_date;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="@Nulo@")
	LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_en_Cartera:182];$alACT_recNumDocCar;"")
	CREATE EMPTY SET:C140([ACT_Documentos_en_Cartera:182];"setDoc2Del")
	CREATE EMPTY SET:C140([ACT_Documentos_de_Pago:176];"setDocPago2Del")
	For ($i;1;Size of array:C274($alACT_recNumDocCar))
		GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$alACT_recNumDocCar{$i})
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
		If (Records in selection:C76([ACT_Documentos_de_Pago:176])=1)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
			If (Records in selection:C76([ACT_Pagos:172])=1)
				If ([ACT_Pagos:172]Nulo:14=True:C214)
					ADD TO SET:C119([ACT_Documentos_en_Cartera:182];"setDoc2Del")
					ADD TO SET:C119([ACT_Documentos_de_Pago:176];"setDocPago2Del")
				End if 
			Else 
				ADD TO SET:C119([ACT_Documentos_en_Cartera:182];"setDoc2Del")
				ADD TO SET:C119([ACT_Documentos_de_Pago:176];"setDocPago2Del")
			End if 
		Else 
			ADD TO SET:C119([ACT_Documentos_en_Cartera:182];"setDoc2Del")
		End if 
	End for 
	
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	USE SET:C118("setDoc2Del")
	DELETE SELECTION:C66([ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	
	READ WRITE:C146([ACT_Documentos_de_Pago:176])
	USE SET:C118("setDocPago2Del")
	DELETE SELECTION:C66([ACT_Documentos_de_Pago:176])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
	
	SET_ClearSets ("setDoc2Del";"setDocPago2Del")
	
	ACTcae_RegisterEvent (vl_Año;vl_Mes;"Eliminación de Documentos en Cartera nulos realizada.")
End if 