//%attributes = {}
  //ACTbol_FiltraItemsMoneda

C_TEXT:C284($t_accion;$t_set)
C_LONGINT:C283($l_idCtaCte;$vl_idRazonSocial;$l_idPago)
C_LONGINT:C283($l_idCategoria)

$t_accion:=$1
If (Count parameters:C259>=2)
	$t_set:=$2
End if 
If (Count parameters:C259>=3)
	$l_idCtaCte:=$3
End if 
If (Count parameters:C259>=4)
	$vl_idRazonSocial:=$4
End if 
If (Count parameters:C259>=5)
	$l_idPago:=$5
End if 

If (cbEmitirXMonedas=1)
	Case of 
		: ($t_accion="avisos")
			ARRAY TEXT:C222(atACT_Monedas;0)
			
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			
			ARRAY LONGINT:C221($al_RecNumRegistros;0)
			ACTbol_FiltraCargos ($t_set;->$al_RecNumRegistros)
			CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$al_RecNumRegistros;"")
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			If (i1=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			End if 
			If (e2=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCtaCte)
			End if 
			ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRazonSocial)
			
			ACTbol_FiltraItemsCategoria ("cargosBoleta")
			
			ACTbol_FiltraItemsMoneda ("llenaArreglo")
			
		: ($t_accion="llenaArreglo")
			C_LONGINT:C283($l_cargosMonedaPais1)  //busco si hay cargos en la moneda del pais
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_cargosMonedaPais)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=False:C215)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			C_LONGINT:C283($l_cargosMonedaPais2)  //busco si hay cargos en moneda, en la moneda del pais
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_cargosMonedaPais2)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28=<>vtACT_monedaPais)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			  //busco si hay cargos en otras monedas
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#<>vtACT_monedaPais)
			DISTINCT VALUES:C339([ACT_Cargos:173]Moneda:28;atACT_Monedas)  //lleno arreglo con posibles cargos de otras monedas
			
			If (($l_cargosMonedaPais>0) | ($l_cargosMonedaPais2>0))
				APPEND TO ARRAY:C911(atACT_Monedas;<>vtACT_monedaPais)  //Agrego moneda pais
			End if 
			
		: ($t_accion="cargosBoleta")
			ARRAY LONGINT:C221($al_idsCargosFiltrados;0)
			CREATE SET:C116([ACT_Cargos:173];"setCargosSinFiltrar")
			If (atACT_Monedas{0}=<>vtACT_monedaPais)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=<>vtACT_monedaPais;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=False:C215)
			Else 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28=atACT_Monedas{0};*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
			End if 
			CREATE SET:C116([ACT_Cargos:173];"setCargosFiltrados")
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargosFiltrados)
			USE SET:C118("setCargosSinFiltrar")
			QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargosFiltrados)
			CREATE SET:C116([ACT_Cargos:173];"setCargosRelacionados")
			UNION:C120("setCargosFiltrados";"setCargosRelacionados";"setCargosFiltrados")
			USE SET:C118("setCargosFiltrados")
			
			SET_ClearSets ("setCargosFiltrados";"setCargosSinFiltrar";"setCargosRelacionados")
			
		: ($t_accion="pagos")
			ARRAY TEXT:C222(atACT_Monedas;0)
			
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			
			USE SET:C118($t_set)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			If (e2=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCtaCte)
			End if 
			ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRazonSocial)
			
			ACTbol_FiltraItemsCategoria ("cargosBoleta")
			
			ACTbol_FiltraItemsMoneda ("llenaArreglo")
			
		: ($t_accion="ingresoPagos")
			ARRAY TEXT:C222(atACT_Monedas;0)
			
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$l_idPago)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			If (cb_EmiteXCuenta=1)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCtaCte)
			End if 
			If (cs_MultiRazones=1)
				ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRazonSocial)
			End if 
			
			ACTbol_FiltraItemsCategoria ("cargosBoleta")
			
			ACTbol_FiltraItemsMoneda ("llenaArreglo")
			
	End case 
Else 
	If (($t_accion="avisos") | ($t_accion="pagos") | ($t_accion="ingresoPagos"))
		ARRAY TEXT:C222(atACT_Monedas;0)
		APPEND TO ARRAY:C911(atACT_Monedas;<>vtACT_monedaPais)  // para que entre al for
	End if 
End if 
