//%attributes = {}
  //ACTpgs_OrdenaCargosAviso

C_BOOLEAN:C305($vb_orderFromAvisos)
Case of 
	: (Count parameters:C259=2)
		$vb_orderFromAvisos:=True:C214
End case 
$line:=$1

If ($vb_orderFromAvisos)
	If ($line=0)
		
		Case of 
			: (vbACT_CargosDesdeAviso)
				$ptrAvisoComparacion1:=->alACT_CIdsAvisosTemp
				$ptrAvisoOrden:=->alACT_AIDAviso
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
			: (vbACT_CargosDesdeItems)
				$ptrAvisoComparacion1:=->alACT_CRefsTemp
				$ptrAvisoOrden:=->alACT_RefItem
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->alACT_CIdsAvisosTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
			: (vbACT_CargosDesdeAlumnos)
				$ptrAvisoComparacion1:=->alACT_CIDCtaCteTemp
				$ptrAvisoOrden:=->alACT_AIdsCtas
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->alACT_CIdsAvisosTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
			: (vbACT_CargosDesdeAgrupado)
				ARRAY DATE:C224($ad_arrayOrden;0)
				ARRAY LONGINT:C221($alACT_AIDAviso;0)
				ARRAY LONGINT:C221(DA_Return;0)
				For ($i;1;Size of array:C274(atACT_YearMonthAgrupado))
					$vt_valorABuscar:=atACT_YearMonthAgrupado{$i}
					ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmision;->DA_Return)
					For ($j;1;Size of array:C274(DA_Return))
						APPEND TO ARRAY:C911($ad_arrayOrden;adACT_CFechaEmision{DA_Return{$j}})
						APPEND TO ARRAY:C911($alACT_AIDAviso;alACT_CIdsAvisos{DA_Return{$j}})
					End for 
				End for 
				$ptrAvisoComparacion1:=->alACT_CIdsAvisosTemp
				$ptrAvisoOrden:=->$alACT_AIDAviso
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
		End case 
	Else 
		Case of 
			: (vbACT_CargosDesdeAviso)
				$ptrAvisoComparacion1:=->alACT_CIdsAvisos
				$ptrAvisoOrden:=->alACT_AIDAviso
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
			: (vbACT_CargosDesdeItems)
				$ptrAvisoComparacion1:=->alACT_CRefs
				$ptrAvisoOrden:=->alACT_RefItem
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->alACT_CIdsAvisos;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
			: (vbACT_CargosDesdeAlumnos)
				$ptrAvisoComparacion1:=->alACT_CIDCtaCte
				$ptrAvisoOrden:=->alACT_AIdsCtas
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->alACT_CIdsAvisos;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
			: (vbACT_CargosDesdeAgrupado)
				ARRAY DATE:C224($ad_arrayOrden;0)
				ARRAY LONGINT:C221($alACT_AIDAviso;0)
				ARRAY LONGINT:C221(DA_Return;0)
				For ($i;1;Size of array:C274(atACT_YearMonthAgrupado))
					$vt_valorABuscar:=atACT_YearMonthAgrupado{$i}
					ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmision;->DA_Return)
					For ($j;1;Size of array:C274(DA_Return))
						APPEND TO ARRAY:C911($ad_arrayOrden;adACT_CFechaEmision{DA_Return{$j}})
						APPEND TO ARRAY:C911($alACT_AIDAviso;alACT_CIdsAvisos{DA_Return{$j}})
					End for 
				End for 
				$ptrAvisoComparacion1:=->alACT_CIdsAvisos
				$ptrAvisoOrden:=->$alACT_AIDAviso
				AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		End case 
		
	End if 
Else 
	Case of 
		: (vbACT_CargosDesdeAviso)
			$ptrAvisoComparacion1:=->alACT_CIdsAvisosTemp
			$ptrAvisoOrden:=->alACT_AIDAviso
			AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
		: (vbACT_CargosDesdeItems)
			$ptrAvisoComparacion1:=->alACT_CRefsTemp
			$ptrAvisoOrden:=->alACT_RefItem
			AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->alACT_CIdsAvisosTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
		: (vbACT_CargosDesdeAlumnos)
			$ptrAvisoComparacion1:=->alACT_CIDCtaCteTemp
			$ptrAvisoOrden:=->alACT_AIdsCtas
			AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->alACT_CIdsAvisosTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
		: (vbACT_CargosDesdeAgrupado)
			ARRAY DATE:C224($ad_arrayOrden;0)
			ARRAY LONGINT:C221($alACT_AIDAviso;0)
			ARRAY LONGINT:C221(DA_Return;0)
			For ($i;1;Size of array:C274(atACT_YearMonthAgrupado))
				$vt_valorABuscar:=atACT_YearMonthAgrupado{$i}
				ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmision;->DA_Return)
				For ($j;1;Size of array:C274(DA_Return))
					APPEND TO ARRAY:C911($ad_arrayOrden;adACT_CFechaEmision{DA_Return{$j}})
					APPEND TO ARRAY:C911($alACT_AIDAviso;alACT_CIdsAvisos{DA_Return{$j}})
				End for 
			End for 
			$ptrAvisoComparacion1:=->alACT_CIdsAvisosTemp
			$ptrAvisoOrden:=->$alACT_AIDAviso
			AT_OrderArraysByArray (-999;$ptrAvisoOrden;$ptrAvisoComparacion1;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
	End case 
	ARRAY LONGINT:C221(DA_Return;0)
	If (vbACT_CargosDesdeAgrupado)
		$vt_valorABuscar:=atACT_YearMonthAgrupado{$line}
		ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmisionTemp;->DA_Return)
	Else 
		$ptrAvisoComparacion1->{0}:=$ptrAvisoOrden->{$line}
		AT_SearchArray ($ptrAvisoComparacion1;"=";->DA_Return)
	End if 
	
	For ($i;1;Size of array:C274(DA_Return))  //guarda el orden seleccionado
		alACT_CIdsAvisosTemp{DA_Return{$i}}:=alACT_CIdsAvisos{$i}
		adACT_CFechaEmisionTemp{DA_Return{$i}}:=adACT_CFechaEmision{$i}
		adACT_CFechaVencimientoTemp{DA_Return{$i}}:=adACT_CFechaVencimiento{$i}
		atACT_CAlumnoTemp{DA_Return{$i}}:=atACT_CAlumno{$i}
		atACT_CGlosaTemp{DA_Return{$i}}:=atACT_CGlosa{$i}
		arACT_CMontoNetoTemp{DA_Return{$i}}:=arACT_CMontoNeto{$i}
		arACT_CInteresesTemp{DA_Return{$i}}:=arACT_CIntereses{$i}
		arACT_CSaldoTemp{DA_Return{$i}}:=arACT_CSaldo{$i}
		alACT_RecNumsCargosTemp{DA_Return{$i}}:=alACT_RecNumsCargos{$i}
		alACT_CRefsTemp{DA_Return{$i}}:=alACT_CRefs{$i}
		alACT_CIDCtaCteTemp{DA_Return{$i}}:=alACT_CIDCtaCte{$i}
		asACT_MarcasTemp{DA_Return{$i}}:=asACT_Marcas{$i}
		arACT_MontoMonedaTemp{DA_Return{$i}}:=arACT_MontoMoneda{$i}
		atACT_MonedaCargoTemp{DA_Return{$i}}:=atACT_MonedaCargo{$i}
		atACT_MonedaSimboloTemp{DA_Return{$i}}:=atACT_MonedaSimbolo{$i}
		arACT_MontoPagadoTemp{DA_Return{$i}}:=arACT_MontoPagado{$i}
		alACT_CIdsCargosTemp{DA_Return{$i}}:=alACT_CIdsCargos{$i}
		alACT_CIdDctoCargoTemp{DA_Return{$i}}:=alACT_CIdDctoCargo{$i}
		arACT_MontoIVATemp{DA_Return{$i}}:=arACT_MontoIVA{$i}
		arACT_CMontoAfectoTemp{DA_Return{$i}}:=arACT_CMontoAfecto{$i}
		adACT_CfechaInteresTemp{DA_Return{$i}}:=adACT_CfechaInteres{$i}
		alACT_CidCargoGenIntTemp{DA_Return{$i}}:=alACT_CidCargoGenInt{$i}
		apACT_ASelectedCargoTemp{DA_Return{$i}}:=apACT_ASelectedCargo{$i}
		abACT_ASelectedCargoTemp{DA_Return{$i}}:=abACT_ASelectedCargo{$i}
	End for 
End if 