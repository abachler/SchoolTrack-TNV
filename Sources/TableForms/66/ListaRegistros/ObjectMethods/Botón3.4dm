If (Records in set:C195("Userset")>0)
	USE SET:C118("Userset")
	CLEAR SET:C117("Userset")
	ORDER BY:C49([BBL_Registros:66];[BBL_Items:61]Primer_título:4;>;[BBL_Registros:66]Número_de_copia:2;>)
	COPY NAMED SELECTION:C331([BBL_Registros:66];"◊Editions")
	vtBBL_LastTitle:=""
	vtBBL_Title:=""
End if 