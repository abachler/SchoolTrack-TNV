//%attributes = {}
  //ACTpgs_SeleccionaCargosAviso

$line:=$1

AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)

If ($line>0)
	Case of 
		: (vbACT_CargosDesdeAviso)
			alACT_CIdsAvisosTemp{0}:=alACT_AIDAviso{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_CIdsAvisosTemp;"=";->$DA_Return)
			
		: (vbACT_CargosDesdeItems)
			alACT_CRefsTemp{0}:=alACT_RefItem{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_CRefsTemp;"=";->$DA_Return)
			
		: (vbACT_CargosDesdeAlumnos)
			alACT_CIDCtaCteTemp{0}:=alACT_AIdsCtas{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->alACT_CIDCtaCteTemp;"=";->$DA_Return)
			
		: (vbACT_CargosDesdeAgrupado)
			$vt_valorABuscar:=atACT_YearMonthAgrupado{$line}
			ARRAY LONGINT:C221($DA_Return;0)
			ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valorABuscar;->adACT_CFechaEmisionTemp;->$DA_Return)
			
	End case 
	
	For ($i;1;Size of array:C274($DA_Return))
		AT_Insert ($i;1;->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
		AT_Insert ($i;1;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		
		alACT_CIdsAvisos{$i}:=alACT_CIdsAvisosTemp{$DA_return{$i}}
		adACT_CFechaEmision{$i}:=adACT_CFechaEmisionTemp{$DA_return{$i}}
		adACT_CFechaVencimiento{$i}:=adACT_CFechaVencimientoTemp{$DA_return{$i}}
		atACT_CAlumno{$i}:=atACT_CAlumnoTemp{$DA_return{$i}}
		atACT_CGlosa{$i}:=atACT_CGlosaTemp{$DA_return{$i}}
		arACT_CMontoNeto{$i}:=arACT_CMontoNetoTemp{$DA_return{$i}}
		arACT_CIntereses{$i}:=arACT_CInteresesTemp{$DA_return{$i}}
		arACT_CSaldo{$i}:=arACT_CSaldoTemp{$DA_return{$i}}
		alACT_RecNumsCargos{$i}:=alACT_RecNumsCargosTemp{$DA_return{$i}}
		alACT_CRefs{$i}:=alACT_CRefsTemp{$DA_return{$i}}
		alACT_CIDCtaCte{$i}:=alACT_CIDCtaCteTemp{$DA_return{$i}}
		asACT_Marcas{$i}:=asACT_MarcasTemp{$DA_return{$i}}
		arACT_MontoMoneda{$i}:=arACT_MontoMonedaTemp{$DA_return{$i}}
		atACT_MonedaCargo{$i}:=atACT_MonedaCargoTemp{$DA_return{$i}}
		atACT_MonedaSimbolo{$i}:=atACT_MonedaSimboloTemp{$DA_return{$i}}
		arACT_MontoPagado{$i}:=arACT_MontoPagadoTemp{$DA_return{$i}}
		alACT_CIdsCargos{$i}:=alACT_CIdsCargosTemp{$DA_return{$i}}
		alACT_CIdDctoCargo{$i}:=alACT_CIdDctoCargoTemp{$DA_return{$i}}
		arACT_MontoIVA{$i}:=arACT_MontoIVATemp{$DA_return{$i}}
		arACT_CMontoAfecto{$i}:=arACT_CMontoAfectoTemp{$DA_return{$i}}
		adACT_CfechaInteres{$i}:=adACT_CfechaInteresTemp{$DA_return{$i}}
		alACT_CidCargoGenInt{$i}:=alACT_CidCargoGenIntTemp{$DA_return{$i}}
		apACT_ASelectedCargo{$i}:=apACT_ASelectedCargoTemp{$DA_return{$i}}
		abACT_ASelectedCargo{$i}:=abACT_ASelectedCargoTemp{$DA_return{$i}}
	End for 
End if 