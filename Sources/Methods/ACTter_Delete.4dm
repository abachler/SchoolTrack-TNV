//%attributes = {}
  //ACTter_Delete

C_LONGINT:C283($vl_pagos;$vl_avisos;$0;$resp;$l_boletas)
C_BOOLEAN:C305($vb_mostrarAlertas)
C_TEXT:C284($vt_nombreTercero)

$0:=0
$vb_mostrarAlertas:=True:C214
$resp:=1
If (Count parameters:C259=1)
	$vb_mostrarAlertas:=False:C215
End if 
If (USR_checkRights ("D";->[ACT_Terceros:138]))
	SET QUERY LIMIT:C395(1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_pagos)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=[ACT_Terceros:138]Id:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_avisos)
	  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Tercero=[ACT_Terceros]Id)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=[ACT_Terceros:138]Id:1)  //20150408 RCH Se revisan los cargos porque podria tener proyectado
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_boletas)
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Tercero:21=[ACT_Terceros:138]Id:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	SET QUERY LIMIT:C395(0)
	
	If (($vl_pagos=0) & ($vl_avisos=0) & ($l_boletas=0))
		If ($vb_mostrarAlertas)
			$resp:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar este registro?");__ ("");__ ("Si");__ ("No"))
		End if 
		If ($resp=1)
			$vb_validar:=True:C214
			  //READ WRITE([ACT_Terceros]) //20150408 RCH Si no se comenta linea, el metodo KRL_ReloadInReadWriteMode no recarga el registro.
			READ WRITE:C146([ACT_Terceros_Pactado:139])
			KRL_ReloadInReadWriteMode (->[ACT_Terceros:138])
			QUERY:C277([ACT_Terceros_Pactado:139];[ACT_Terceros_Pactado:139]Id_Tercero:2=[ACT_Terceros:138]Id:1)
			$vt_nombreTercero:=[ACT_Terceros:138]Nombre_Completo:9
			START TRANSACTION:C239
			DELETE SELECTION:C66([ACT_Terceros_Pactado:139])
			If (Records in set:C195("LockedSet")=0)
				If (Not:C34(Locked:C147([ACT_Terceros:138])))
					DELETE RECORD:C58([ACT_Terceros:138])
				Else 
					$vb_validar:=False:C215
				End if 
			Else 
				$vb_validar:=False:C215
			End if 
			If ($vb_validar)
				VALIDATE TRANSACTION:C240
				LOG_RegisterEvt ("Eliminación del tercero "+$vt_nombreTercero+" efectuada.")
				$0:=1
			Else 
				CANCEL TRANSACTION:C241
				If ($vb_mostrarAlertas)
					CD_Dlog (0;__ ("Existen registros en uso. La eliminación no puede ser efectuada."))
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Terceros:138])
			KRL_UnloadReadOnly (->[ACT_Terceros_Pactado:139])
		End if 
	Else 
		$0:=2
		If ($vb_mostrarAlertas)
			CD_Dlog (0;__ ("El registro está asociado a Pagos y/o Cargos y/o Documentos Tributarios. El registro no puede ser eliminado."))
		End if 
	End if 
Else 
	If ($vb_mostrarAlertas)
		USR_ALERT_UserHasNoRights (3)
	End if 
End if 