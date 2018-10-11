If (Self:C308->>0)
	$locked:=False:C215
	$matrixID:=<>alACT_MatrixID{Self:C308->}
	$PrevMatrixID:=[ACT_CuentasCorrientes:175]ID_Matriz:7
	$PrevMatrixName:=vsACT_AsignedMatrix
	If ($matrixID#$PrevMatrixID)
		START TRANSACTION:C239
		$vtMsg:=ACTcc_DesagrupaCargosCta (True:C214)
		$dlog:=CD_Dlog (0;__ ("¿Esta usted seguro que desea cambiar la matriz de cargo asignada?\rEsta operación no se puede deshacer cancelando el registro.\r\r")+$vtMsg;__ ("");__ ("No");__ ("Sí"))
		If ($dlog=2)
			$locked:=False:C215
			$IDCta:=[ACT_CuentasCorrientes:175]ID:1
			UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)
			LOAD RECORD:C52([ACT_CuentasCorrientes:175])
			[ACT_CuentasCorrientes:175]ID_Matriz:7:=$matrixID
			vsACT_AsignedMatrix:=Self:C308->{Self:C308->}
			SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			READ WRITE:C146([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)  //Buscamos cargos asociados con la cuenta
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)  //que no hayan sido avisados
			CREATE SET:C116([ACT_Cargos:173];"CargosCta")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")  //y los documentos de cargo correspondientes
			USE SET:C118("CargosCta")
			DELETE SELECTION:C66([ACT_Cargos:173])  //los eliminamos
			READ ONLY:C145([ACT_Cargos:173])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
			UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
			If (Records in set:C195("LockedSet")>0)  //Si encontramos cuentas bloqueadas
				$locked:=True:C214
				CANCEL TRANSACTION:C241  //Cancelamos la transaccion y avisamos al usuario
				CD_Dlog (0;__ ("Algunas cuentas se encuentran ocupadas y no pueden ser eliminadas en \reste momento.\rIntente repetir el cambio de matriz mas tarde.");__ ("");__ ("Aceptar"))
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)
			Else   //Si no habia cargos bloqueados
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				DELETE SELECTION:C66([ACT_Documentos_de_Cargo:174])  //Eliminamos los documentos de cargo asociados a los cargos
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				If (Records in set:C195("LockedSet")>0)  //Si encontramos documentos tomados...
					$locked:=True:C214
					CANCEL TRANSACTION:C241  //Cancelamos la transaccion y avisamos al usuario
					CD_Dlog (0;__ ("Algunos documentos de cargo se encuentran ocupados y no pueden ser eliminados en \reste momento.\rIntente repetir la eliminación de la matriz mas tarde.");__ ("");__ ("Aceptar"))
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)
				End if 
			End if 
			
			  //A continuacion preparamos un blob, xBlob, para pasarlo a ACTcc_GeneraCargos, metodo que regenerara cargos y documentos
			  //de cargo para las ctas ctes afectadas por la eliminacion de la matriz, siempre y cuando no hayamos tenido ningun registro bloqueado
			
			If (Not:C34($Locked))
				b1:=1
				b2:=0
				b3:=0
				vlACT_SelectedMatrixID:=0
				vlACT_SelectedItemID:=0
				vsACT_Glosa:=""
				vsACT_Moneda:=""
				vrACT_Monto:=0
				cbACT_EsDescuento:=0  //era cbACT_EsDescuento:=False (ABK_Integracion_AT)
				cbACT_Afecto_Iva:=1  // era cbACT_Afecto_Iva:=False (ABK_Integracion_AT)
				bc_ReplaceSameDescription:=0
				ACTcc_DeterminaFechasGeneracion 
				viACT_DiaGeneracion:=viACT_DiaDeuda  //Viene de las preferencias
				viACT_DiaVencimiento2:=viACT_DiaDeuda+viACT_DiaVencimiento  //Viene de las preferencias
				If (Application type:C494#4D Remote mode:K5:5)
					bc_ExecuteOnServer:=0
				Else 
					bc_ExecuteOnServer:=1
				End if 
				vbACT_CargoEspecial:=False:C215
				vbACT_ImputacionUNica:=False:C215
				BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->viACT_DiaVencimiento2;->bc_ExecuteOnServer;->vbACT_ImputacionUNica)
				  //ACTcc_GeneraCargos (xBlob)
				
				$processID:=New process:C317("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob)
				DELAY PROCESS:C323(Current process:C322;60)  //permitir que el proceso se inicie
				$generando:=False:C215
				While (Not:C34($generando))
					IDLE:C311
					GET PROCESS VARIABLE:C371($processID;vbACT_Generando;$generando)
				End while 
				SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeGenerar;$generando)
				
				VALIDATE TRANSACTION:C240  //y validamos la transaccion
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$IDCta)
				LOAD RECORD:C52([ACT_CuentasCorrientes:175])
				Self:C308->:=Find in array:C230(Self:C308->;vsACT_AsignedMatrix)
			Else 
				$el:=Find in array:C230(<>alACT_MatrixID;[ACT_CuentasCorrientes:175]ID_Matriz:7)
				If ($el>0)
					Self:C308->:=$el
					vsACT_AsignedMatrix:=Self:C308->{$el}
				Else 
					vsACT_AsignedMatrix:="Seleccionar..."
					Self:C308->:=0
				End if 
			End if 
		Else 
			If ($PrevMatrixID=0)
				[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
				vsACT_AsignedMatrix:="Seleccionar..."
				Self:C308->:=0
			Else 
				vsACT_AsignedMatrix:=$PrevMatrixName
				Self:C308->:=Find in array:C230(Self:C308->;vsACT_AsignedMatrix)
			End if 
			CANCEL TRANSACTION:C241
		End if 
	End if 
End if 