//%attributes = {}
  //SRACTcc_GetAfectayBoleta

$cargo:=Find in field:C653([ACT_Cargos:173]ID:1;[ACT_Transacciones:178]ID_Item:3)
If ($cargo#-1)
	READ ONLY:C145([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];$cargo)
	vAfecta:=ST_Boolean2Str (([ACT_Cargos:173]TasaIVA:21#0);"SI";"NO")
	If ([ACT_Transacciones:178]ID_Pago:4#0)
		vTipo:="P"
	Else 
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([xxACT_ItemsMatriz:180])
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
		$noMatriz2:=([ACT_Documentos_de_Cargo:174]ID_Matriz:2=-2)
		QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)
		QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
		$NoEnMatriz:=(Records in selection:C76([xxACT_ItemsMatriz:180])=0)
		$descto:=([ACT_Cargos:173]Monto_Neto:5<0)
		$emitido:=([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
		vTipo:=ST_Boolean2Str (($descto);"D";"C")+"."+ST_Boolean2Str ((($noMatriz2) | ($NoEnMatriz));"NM";"M")+"."+ST_Boolean2Str (($emitido);"E";"P")
	End if 
End if 
$boleta:=Find in field:C653([ACT_Boletas:181]ID:1;[ACT_Transacciones:178]No_Boleta:9)
If ($boleta#-1)
	READ ONLY:C145([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];$boleta)
	vBoleta:=[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11)
Else 
	vBoleta:="Ninguno"
End if 