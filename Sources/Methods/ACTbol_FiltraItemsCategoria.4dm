//%attributes = {}
  //ACTbol_FiltraItemsCategoria 

C_TEXT:C284($t_accion;$t_set)
C_LONGINT:C283($l_idCtaCte;$vl_idRazonSocial;$l_idPago;$l_records)

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

If (cbEmitirXCategorias=1)
	Case of 
		: ($t_accion="avisos")
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			
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
			
			  // Modificado por: Saúl Ponce (19-06-2018) Ticket Nº 204836, permitir la generación de boletas para terceros aunque utilicen categorías en la emisión de documento.
			CREATE SET:C116([ACT_Cargos:173];"setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54>0)
			CREATE SET:C116([ACT_Cargos:173];"$temp")
			USE SET:C118("setCargos")
			  //20161117 RCH No se estaban filtrando adecuadamente los cargos asociados a terceros.
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CargoRelacionado=0)
			$l_records:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Not:C34($l_records>0))
				USE SET:C118("setCargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			End if 
			  //CREATE SET([ACT_Cargos];"setCargos")
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CargoRelacionado=0)
			CREATE SET:C116([ACT_Cargos:173];"set1")
			USE SET:C118("setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18#0;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Tercero:54#0)
			CREATE SET:C116([ACT_Cargos:173];"set2")
			UNION:C120("set1";"set2";"set1")
			USE SET:C118("set1")
			SET_ClearSets ("setCargos";"set1";"set2")
			
			KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
			DISTINCT VALUES:C339([xxACT_Items:179]ID_Categoria:8;alACT_idsCategorias)
			
		: ($t_accion="cargosBoleta")
			ARRAY LONGINT:C221($al_idsCargosFiltrados;0)
			CREATE SET:C116([ACT_Cargos:173];"setCargosSinFiltrar")
			  //SET AUTOMATIC RELATIONS(True;False)
			  //QUERY SELECTION([ACT_Cargos];[xxACT_Items]ID_Categoria=alACT_idsCategorias{0};*)
			  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]ID_CargoRelacionado=0)  //20171228 RCH No se filtraban bien los cargos
			  //SET AUTOMATIC RELATIONS(False;False)
			  // Modificado por: Saúl Ponce (19-06-2018) Ticket Nº 204836, permitir la generación de boletas para terceros aunque utilicen categorías en la emisión de documento.
			$l_records:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Not:C34($l_records>0))
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([ACT_Cargos:173];[xxACT_Items:179]ID_Categoria:8=alACT_idsCategorias{0};*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
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
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			
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
			  // QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CargoRelacionado=0)
			  // Modificado por: Saúl Ponce (19-06-2018) Ticket Nº 204836, permitir la generación de boletas para terceros aunque utilicen categorías en la emisión de documento.
			$l_records:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Not:C34($l_records>0))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			End if 
			KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
			DISTINCT VALUES:C339([xxACT_Items:179]ID_Categoria:8;alACT_idsCategorias)
			
			  //: ($t_accion="pagosboleta")
			  //ACTbol_FiltraItemsCategoria ("cargosBoleta")
			
		: ($t_accion="ingresoPagos")
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			
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
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CargoRelacionado=0)
			  // Modificado por: Saúl Ponce (19-06-2018) Ticket Nº 204836, permitir la generación de boletas para terceros aunque utilicen categorías en la emisión de documento.
			$l_records:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54>0)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (Not:C34($l_records>0))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			End if 
			KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
			DISTINCT VALUES:C339([xxACT_Items:179]ID_Categoria:8;alACT_idsCategorias)
			
	End case 
Else 
	Case of 
		: ($t_accion="avisos")
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			APPEND TO ARRAY:C911(alACT_idsCategorias;MAXLONG:K35:2)  // para que entre al for
			
		: ($t_accion="pagos")
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			APPEND TO ARRAY:C911(alACT_idsCategorias;MAXLONG:K35:2)  // para que entre al for
			
		: ($t_accion="ingresoPagos")
			ARRAY LONGINT:C221(alACT_idsCategorias;0)
			APPEND TO ARRAY:C911(alACT_idsCategorias;MAXLONG:K35:2)  // para que entre al for
			
	End case 
End if 
