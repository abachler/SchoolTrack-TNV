//%attributes = {}
  //ACTcc_DesEmitirCargos

  //REGISTRO DE CAMBIOS
  //20080407 RCH ` PROBLEMA: cuando un aviso estaba emitido para el apoderado de cuenta anterior y se eliminaba, al intentar emitir para el mismo mes se podía no emitir el aviso por problemas con el id del apoderado de los cargos, transacciones o documentos de cargo.
  //SOLUCIÓN IMPLEMENTADA. Buscar la cuenta a partir de las transacciones, luego buscar el apoderado de cuenta y luego actualizar los ids del apoderado de las transacciones, documentos de cargo y cargos por el id del apoderado encontrado.

  //20101027 se agrega un parametro opcional para no recalcular las cuentas ya que cuando se llama desde la eliminacion de aviso, se recalcula siempre...

C_BOOLEAN:C305($vl_recalCtas;$1)
$vl_recalCtas:=True:C214

If (Count parameters:C259>=1)
	$vl_recalCtas:=$1
End if 

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ WRITE:C146([ACT_Transacciones:178])
READ WRITE:C146([ACT_Documentos_de_Cargo:174])
READ WRITE:C146([ACT_Cargos:173])
KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
ARRAY LONGINT:C221($aIDsCtas;0)
ARRAY LONGINT:C221($aTransacciones;0)

$lockedTrans:=0
$lockedDocs:=0
$lockedCargos:=0
$vl_idPersona:=0

QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Transacciones:178]ID_CuentaCorriente:2)
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
$vl_idPersona:=[Personas:7]No:1

DISTINCT VALUES:C339([ACT_Cargos:173]ID_CuentaCorriente:2;$aIDsCtas)
LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aTransacciones;"")
READ WRITE:C146([ACT_Transacciones:178])
For ($w;1;Size of array:C274($aTransacciones))
	GOTO RECORD:C242([ACT_Transacciones:178];$aTransacciones{$w})
	If (Locked:C147([ACT_Transacciones:178]))
		$lockedTrans:=1
		$w:=Size of array:C274($aTransacciones)+1
	Else 
		[ACT_Transacciones:178]No_Comprobante:10:=0
		[ACT_Transacciones:178]ID_Apoderado:11:=$vl_idPersona
		SAVE RECORD:C53([ACT_Transacciones:178])
	End if 
End for 
ARRAY LONGINT:C221($aDocsCargos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aDocsCargos;"")
READ WRITE:C146([ACT_Documentos_de_Cargo:174])
For ($w;1;Size of array:C274($aDocsCargos))
	GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aDocsCargos{$w})
	If (Locked:C147([ACT_Documentos_de_Cargo:174]))
		$lockedDocs:=1
		$w:=Size of array:C274($aDocsCargos)+1
	Else 
		[ACT_Documentos_de_Cargo:174]FechaEmision:21:=!00-00-00!
		[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=!00-00-00!
		[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=0
		[ACT_Documentos_de_Cargo:174]ID_Apoderado:12:=$vl_idPersona
		SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	End if 
End for 
ARRAY LONGINT:C221($aCargos;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aCargos;"")
READ WRITE:C146([ACT_Cargos:173])
For ($w;1;Size of array:C274($aCargos))
	GOTO RECORD:C242([ACT_Cargos:173];$aCargos{$w})
	If (Locked:C147([ACT_Cargos:173]))
		$lockedCargos:=1
		$w:=Size of array:C274($aCargos)+1
	Else 
		[ACT_Cargos:173]FechaEmision:22:=!00-00-00!
		[ACT_Cargos:173]Fecha_de_Vencimiento:7:=!00-00-00!
		[ACT_Cargos:173]LastInterestsUpdate:42:=!00-00-00!
		[ACT_Cargos:173]Intereses:29:=0
		  //[ACT_Cargos]Saldo:=[ACT_Cargos]MontosPagados-[ACT_Cargos]Monto_Neto
		[ACT_Cargos:173]Saldo:23:=0  //20151118 RCH Los cargos proyectados tienen saldo 0 al ser proyectados. Acá se deja igual.
		
		  //20161028 RCH Para manejar los AC pagados completamente con descuentos. Hasta ahora se valida que no hayan pagos para permitir la eliminación
		[ACT_Cargos:173]MontosPagados:8:=0
		[ACT_Cargos:173]MontosPagadosMPago:52:=0
		
		[ACT_Cargos:173]ID_Apoderado:18:=$vl_idPersona
		SAVE RECORD:C53([ACT_Cargos:173])
		If (([ACT_Cargos:173]PctDescto_XItem:34#0) | ([ACT_Cargos:173]Descuentos_XItem:35#0))
			CREATE RECORD:C68([xxACT_DesctosXItem:103])
			[xxACT_DesctosXItem:103]ID:1:=SQ_SeqNumber (->[xxACT_DesctosXItem:103]ID:1)
			[xxACT_DesctosXItem:103]Ref_Item:2:=[ACT_Cargos:173]Ref_Item:16
			[xxACT_DesctosXItem:103]ID_CtaCte:5:=[ACT_Cargos:173]ID_CuentaCorriente:2
			[xxACT_DesctosXItem:103]ID_Cargo:8:=[ACT_Cargos:173]ID:1
			If (Position:C15(" (des";[ACT_Cargos:173]Glosa:12)#0)
				[xxACT_DesctosXItem:103]GlosaExtra:6:=Substring:C12([ACT_Cargos:173]Glosa:12;1;Position:C15(" (de";[ACT_Cargos:173]Glosa:12)-1)
			Else 
				[xxACT_DesctosXItem:103]GlosaExtra:6:=[ACT_Cargos:173]Glosa:12
			End if 
			If ([ACT_Cargos:173]PctDescto_XItem:34>0)
				[xxACT_DesctosXItem:103]Pct_DesctoXItem:3:=[ACT_Cargos:173]PctDescto_XItem:34
				[xxACT_DesctosXItem:103]Descto_XItem:4:=0
			Else 
				[xxACT_DesctosXItem:103]Pct_DesctoXItem:3:=0
				[xxACT_DesctosXItem:103]Descto_XItem:4:=[ACT_Cargos:173]Descuentos_XItem:35
			End if 
			[xxACT_DesctosXItem:103]Fecha_Generacion:7:=[ACT_Cargos:173]Fecha_de_generacion:4
			SAVE RECORD:C53([xxACT_DesctosXItem:103])
		End if 
	End if 
End for 
If ($vl_recalCtas)
	If (($lockedTrans+$lockedDocs+$lockedCargos)>0)
		For ($t;1;Size of array:C274($aIDsCtas))
			ACTcc_CalculaMontos ($aIDsCtas{$t})
		End for 
	End if 
End if 
$0:=(($lockedTrans+$lockedDocs+$lockedCargos)>0)