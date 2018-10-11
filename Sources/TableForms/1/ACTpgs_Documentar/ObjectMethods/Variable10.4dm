  //SET QUERY DESTINATION(Into variable ;$Duplicados)
  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]Ch_BancoCodigo=vtACT_BancoCodigo;*)
  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_Cuenta=vtACT_BancoCuenta;*)
  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=Self->;*)
  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Nulo=False)
  //SET QUERY DESTINATION(Into current selection )

C_LONGINT:C283($Duplicados)
$Duplicados:=ACTdc_buscaDuplicados (2;Self:C308->;vtACT_BancoCuenta;vtACT_BancoID)

If ($Duplicados>0)
	CD_Dlog (0;__ ("Para este banco y cuenta ya existe un cheque con este número de serie."))
	Self:C308->:=""
	GOTO OBJECT:C206(Self:C308->)
End if 