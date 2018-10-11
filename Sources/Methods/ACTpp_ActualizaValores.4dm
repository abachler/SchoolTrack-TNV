//%attributes = {}
  //ACTpp_ActualizaValores

C_REAL:C285($saldo)
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$rnApdo)
C_BLOB:C604($xBlob)
$rnApdo:=$1
If (Count parameters:C259>=2)
	$xBlob:=$2
	If (BLOB size:C605($xBlob)>0)
		ARRAY REAL:C219(arACT_MontoProyectado;0)
		ARRAY REAL:C219(arACT_MontoEmitido;0)
		ARRAY REAL:C219(arACT_MontoPagado;0)
		ARRAY REAL:C219(arACT_MontoVencido;0)
		BLOB_Blob2Vars (->$xBlob;0;->arACT_MontoProyectado;->arACT_MontoEmitido;->arACT_MontoPagado;->arACT_MontoVencido)
	End if 
End if 
$0:=True:C214
If ($rnApdo#-1)
	READ WRITE:C146([Personas:7])
	GOTO RECORD:C242([Personas:7];$1)
	If (Not:C34(Locked:C147([Personas:7])))
		CREATE EMPTY SET:C140([ACT_Cargos:173];"TC")
		ARRAY LONGINT:C221($alACT_recNumCargo;0)
		ARRAY LONGINT:C221($al_idCC;0)
		
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Cargos:173])
		
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
		QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0)
		$saldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		
		  // AS. 20110725 se comenta por la modificacion en el cambio de apoderado de cuentas
		  //SELECTION TO ARRAY([ACT_CuentasCorrientes]ID;$al_idCC)
		  //[Personas]MontosEmitidos_Ejercicio:=Sum([ACT_CuentasCorrientes]MontosEmitidos_Ejercicio)-AT_GetSumArray (->arACT_MontoEmitido)
		  //[Personas]MontosPagados_Ejercicio:=Sum([ACT_CuentasCorrientes]MontosPagados_Ejercicio)+$saldo-AT_GetSumArray (->arACT_MontoPagado)
		  //[Personas]MontosProyectados_Ejercicio:=Sum([ACT_CuentasCorrientes]MontosProyectados_Ejercicio)-AT_GetSumArray (->arACT_MontoProyectado)
		  //[Personas]DeudaVencida_Ejercicio:=Sum([ACT_CuentasCorrientes]DeudaVencida_Ejercicio)-AT_GetSumArray (->arACT_MontoVencido)
		
		[Personas:7]MontosEmitidos_Ejercicio:82:=0
		[Personas:7]MontosPagados_Ejercicio:84:=0
		[Personas:7]MontosProyectados_Ejercicio:81:=0
		[Personas:7]DeudaVencida_Ejercicio:83:=0
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$alACT_recNumCargo;[ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idCtaCte)
		
		  // AS. 20110725 se comenta por la modificacion en el cambio de apoderado de cuentas
		  //For ($i;Size of array($alACT_recNumCargo);1;-1)
		  //If (Find in array($al_idCC;$alACT_idCtaCte{$i})#-1)
		  //AT_Delete ($i;1;->$alACT_recNumCargo;->$alACT_idCtaCte)
		  //End if 
		  //End for 
		
		For ($i;1;Size of array:C274($alACT_recNumCargo))
			  //20130904 RCH
			  //GOTO RECORD([ACT_Cargos];$alACT_recNumCargo{$i})
			  //ACTcc_CalculaMontosCtasCtes 
			  //GOTO RECORD([ACT_Cargos];$alACT_recNumCargo{$i})
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumCargo{$i})
			ACTcc_CalculaMontosCtasCtes 
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumCargo{$i})
			
			If ([ACT_Cargos:173]FechaEmision:22=!00-00-00!)
				[Personas:7]MontosProyectados_Ejercicio:81:=[Personas:7]MontosProyectados_Ejercicio:81+vrACT_Neto
			Else 
				[Personas:7]MontosEmitidos_Ejercicio:82:=[Personas:7]MontosEmitidos_Ejercicio:82+vrACT_Neto
				If ((Current date:C33(*)>[ACT_Cargos:173]Fecha_de_Vencimiento:7))
					[Personas:7]DeudaVencida_Ejercicio:83:=[Personas:7]DeudaVencida_Ejercicio:83+(vrACT_Neto-vrACT_Pagado)
				End if 
			End if 
			[Personas:7]MontosPagados_Ejercicio:84:=[Personas:7]MontosPagados_Ejercicio:84+vrACT_Pagado
		End for 
		  //20120910 RCH No calculaba bien el monto que estaba en disponible...
		[Personas:7]MontosPagados_Ejercicio:84:=[Personas:7]MontosPagados_Ejercicio:84+$saldo
		[Personas:7]Saldo_Ejercicio:85:=[Personas:7]MontosPagados_Ejercicio:84-[Personas:7]MontosEmitidos_Ejercicio:82
		SAVE RECORD:C53([Personas:7])
		KRL_UnloadReadOnly (->[Personas:7])
	Else 
		BLOB_Variables2Blob (->$xBlob;0;->arACT_MontoProyectado;->arACT_MontoEmitido;->arACT_MontoPagado;->arACT_MontoVencido)
		BM_CreateRequest ("ACTpp_ActualizaValores";String:C10($rnApdo);String:C10($rnApdo);$xBlob)
	End if 
	AT_Initialize (->arACT_MontoProyectado;->arACT_MontoEmitido;->arACT_MontoPagado;->arACT_MontoVencido)
End if 
SET BLOB SIZE:C606($xBlob;0)