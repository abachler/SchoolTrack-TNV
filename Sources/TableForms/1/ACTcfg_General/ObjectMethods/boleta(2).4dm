If (Self:C308->=1)
	vtACT_DescOrdenes:="Cargos vencidos, cargos no pertenecientes a la matriz, cargos pertenecientes a la"+" matriz en el orden establecido por la matriz."
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)