//%attributes = {}
  //ACT_relacionaCtasyApdos

$rel:=$1
If (Count parameters:C259=2)
	$sel:=$2
Else 
	$sel:="selection"
End if 
Case of 
	: ($rel=1)
		If ($sel="selection")
			KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;"")
		Else 
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
		End if 
		CREATE SET:C116([Personas:7];"actuales")
		If ($sel="selection")
			KRL_RelateSelection (->[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2;->[ACT_CuentasCorrientes:175]ID:1;"")
		Else 
			QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1)
		End if 
		KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;"")
		CREATE SET:C116([Personas:7];"Ex")
		UNION:C120("actuales";"ex";"apdos")
		USE SET:C118("apdos")
		SET_ClearSets ("actuales";"ex";"apdos")
	: ($rel=2)
		If ($sel="selection")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
		Else 
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		End if 
		CREATE SET:C116([ACT_CuentasCorrientes:175];"actuales")
		If ($sel="selection")
			KRL_RelateSelection (->[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;->[Personas:7]No:1;"")
		Else 
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2)
		End if 
		KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2;"")
		CREATE SET:C116([ACT_CuentasCorrientes:175];"ex")
		UNION:C120("actuales";"ex";"ctas")
		USE SET:C118("ctas")
		SET_ClearSets ("actuales";"ex";"ctas")
End case 