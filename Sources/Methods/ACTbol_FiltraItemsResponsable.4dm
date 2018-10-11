//%attributes = {}
  //ACTbol_FiltraItemsResponsable

C_TEXT:C284($t_accion;$t_set)
C_LONGINT:C283($l_idCtaCte;$vl_idRazonSocial;$l_idPago)
C_LONGINT:C283($l_idCategoria)
C_LONGINT:C283(cb_SepararDTsXPct)

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

If (cb_SepararDTsXPct=1)
	Case of 
		: ($t_accion="avisos")
			ARRAY LONGINT:C221(alACT_Responsables;0)
			ARRAY LONGINT:C221(alACT_Apoderados;0)
			ARRAY LONGINT:C221(alACT_Terceros;0)
			
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
			
			ACTbol_FiltraItemsMoneda ("cargosBoleta")
			
			ACTbol_FiltraItemsResponsable ("llenaArreglo")
			
		: ($t_accion="llenaArreglo")
			C_LONGINT:C283($l_cargosMonedaPais1)  //busco si hay cargos en la moneda del pais
			ARRAY OBJECT:C1221($ao_objetos;0)
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=0)
			CREATE SET:C116([ACT_Cargos:173];"$cargos")
			QUERY SELECTION BY ATTRIBUTE:C1424([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_responsable";>;0)
			CREATE SET:C116([ACT_Cargos:173];"$cargosSeparadosEnAC")
			ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeCargo";->alACT_Responsables)
			
			DIFFERENCE:C122("$cargos";"$cargosSeparadosEnAC";"$cargos")
			USE SET:C118("$cargos")
			If (Records in selection:C76([ACT_Cargos:173])>0)
				ARRAY LONGINT:C221($alACT_idsApdos;0)
				ARRAY LONGINT:C221($alACT_idsTerceros;0)
				While (Not:C34(End selection:C36([ACT_Cargos:173])))
					If ([ACT_Cargos:173]ID_Tercero:54>0)
						If ((Find in array:C230($alACT_idsTerceros;[ACT_Cargos:173]ID_Tercero:54)=-1) & ([ACT_Cargos:173]ID_Tercero:54>0))
							APPEND TO ARRAY:C911($alACT_idsTerceros;[ACT_Cargos:173]ID_Tercero:54)
						End if 
					Else 
						If ((Find in array:C230($alACT_idsApdos;[ACT_Cargos:173]ID_Apoderado:18)=-1) & ([ACT_Cargos:173]ID_Apoderado:18>0))
							APPEND TO ARRAY:C911($alACT_idsApdos;[ACT_Cargos:173]ID_Apoderado:18)
						End if 
					End if 
					NEXT RECORD:C51([ACT_Cargos:173])
				End while 
				
				AT_DistinctsArrayValues (->alACT_Responsables)
				AT_RedimArrays (Size of array:C274(alACT_Responsables);->alACT_Apoderados;->alACT_Terceros)
				
				AT_Inc (0)
				For ($l_indice;1;Size of array:C274($alACT_idsApdos))
					APPEND TO ARRAY:C911(alACT_Responsables;(AT_Inc *-1))  //apoderado para dar num unico
					APPEND TO ARRAY:C911(alACT_Apoderados;$alACT_idsApdos{$l_indice})
					APPEND TO ARRAY:C911(alACT_Terceros;0)
				End for 
				
				For ($l_indice;1;Size of array:C274($alACT_idsTerceros))
					APPEND TO ARRAY:C911(alACT_Responsables;(AT_Inc *-1))  //Terceros para dar num unico
					APPEND TO ARRAY:C911(alACT_Apoderados;0)
					APPEND TO ARRAY:C911(alACT_Terceros;$alACT_idsTerceros{$l_indice})
				End for 
				
			End if 
			
			SET_ClearSets ("$cargos";"$cargosSeparadosEnAC")
			
		: ($t_accion="cargosBoleta")
			
			If (alACT_Responsables{0}#0)  //Si se configura, se deja la selección tal como está.
				
				ARRAY LONGINT:C221($al_idsCargosFiltrados;0)
				
				  //ARRAY OBJECT($ao1;0)
				  //SELECTION TO ARRAY([ACT_Cargos]OB_Responsable;$ao1)  //para depurar
				
				CREATE SET:C116([ACT_Cargos:173];"setCargosSinFiltrar")
				
				  //QUERY SELECTION BY ATTRIBUTE([ACT_Cargos];[ACT_Cargos]OB_Responsable;"id_responsable";=;alACT_Responsables{0})
				$l_pos:=Find in array:C230(alACT_Responsables;alACT_Responsables{0})
				Case of 
					: (alACT_Responsables{0}>0)
						QUERY SELECTION BY ATTRIBUTE:C1424([ACT_Cargos:173];[ACT_Cargos:173]OB_Responsable:70;"id_responsable";=;alACT_Responsables{0})
					: ((alACT_Responsables{0}<0) & (alACT_Apoderados{$l_pos}>0))
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=alACT_Apoderados{$l_pos})
					: (alACT_Responsables{0}<0)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=alACT_Terceros{$l_pos})
					Else 
						REDUCE SELECTION:C351([ACT_Cargos:173];0)  //por precaucion
				End case 
				
				CREATE SET:C116([ACT_Cargos:173];"setCargosFiltrados")
				DIFFERENCE:C122("setCargosSinFiltrar";"setCargosFiltrados";"setCargosSinFiltrar")
				  //USE SET("setCargosSinFiltrar")
				  //QUERY SELECTION BY ATTRIBUTE([ACT_Cargos];[ACT_Cargos]OB_Responsable;"id_responsable";=;0)
				  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_Apoderado=alACT_Responsables{0})
				  //CREATE SET([ACT_Cargos];"cargosNoSeparados")
				
				  //UNION("cargosIdResp";"cargosNoSeparados";"setCargosFiltrados")
				  //USE SET("setCargosFiltrados")
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargosFiltrados)
				USE SET:C118("setCargosSinFiltrar")
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargosFiltrados)
				CREATE SET:C116([ACT_Cargos:173];"setCargosRelacionados")
				UNION:C120("setCargosFiltrados";"setCargosRelacionados";"setCargosFiltrados")
				USE SET:C118("setCargosFiltrados")
				
				SET_ClearSets ("setCargosFiltrados";"setCargosSinFiltrar";"setCargosRelacionados";"cargosNoSeparados")
			End if 
			
		: ($t_accion="pagos")
			ARRAY LONGINT:C221(alACT_Responsables;0)
			ARRAY LONGINT:C221(alACT_Apoderados;0)
			ARRAY LONGINT:C221(alACT_Terceros;0)
			
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
			
			ACTbol_FiltraItemsMoneda ("cargosBoleta")
			
			ACTbol_FiltraItemsResponsable ("llenaArreglo")
			
			
		: ($t_accion="ingresoPagos")
			ARRAY LONGINT:C221(alACT_Responsables;0)
			ARRAY LONGINT:C221(alACT_Apoderados;0)
			ARRAY LONGINT:C221(alACT_Terceros;0)
			
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
			
			ACTbol_FiltraItemsMoneda ("cargosBoleta")
			
			ACTbol_FiltraItemsResponsable ("llenaArreglo")
			
	End case 
Else 
	If (($t_accion="avisos") | ($t_accion="pagos") | ($t_accion="ingresoPagos"))
		ARRAY LONGINT:C221(alACT_Responsables;0)
		ARRAY LONGINT:C221(alACT_Apoderados;0)
		ARRAY LONGINT:C221(alACT_Terceros;0)
		
		APPEND TO ARRAY:C911(alACT_Responsables;0)  // para que entre al for
	End if 
End if 
