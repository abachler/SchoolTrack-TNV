If (Self:C308->=1)
	vtACT_DescOrdenes:="Cuenta corriente, glosa, saldo, fecha de emisión, fecha de vencimiento."
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)