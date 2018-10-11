//%attributes = {}
  //ACT_LeeMoneda 20160509 RCH
  //En primer lugar se lee la moneda de la base
  //En segundo lugar se lee la moneda de la tabla colegio
  //finalmente se lee la moneda del pais

READ ONLY:C145([xxACT_Monedas:146])
QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Moneda_X_Defecto_Base:11=True:C214)
If (Records in selection:C76([xxACT_Monedas:146])=1)
	<>vsACT_MonedaColegio:=[xxACT_Monedas:146]Nombre_Moneda:2
	<>vsACT_simbMonColegio:=[xxACT_Monedas:146]Simbolo:4
Else 
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	If ([Colegio:31]Moneda:49#"")
		<>vsACT_MonedaColegio:=ST_GetWord ([Colegio:31]Moneda:49;1;";")
		<>vsACT_simbMonColegio:=ST_GetWord ([Colegio:31]Moneda:49;2;";")
	Else 
		<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
		<>vsACT_simbMonColegio:=ST_GetWord (ACT_DivisaPais ;2;";")
	End if 
End if 

