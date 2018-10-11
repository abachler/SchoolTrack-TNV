//%attributes = {}
  //ACTpgs_ReconstruyeArreglosCargo

ACTcfg_LoadCargosEspeciales (2)
C_BOOLEAN:C305($vb_HayRecargoAdelantado)
$vb_HayRecargoAdelantado:=False:C215

ARRAY DATE:C224(adACT_CFechaEmision;0)
ARRAY DATE:C224(adACT_CFechaVencimiento;0)
ARRAY TEXT:C222(atACT_CAlumno;0)
ARRAY TEXT:C222(atACT_CGlosa;0)
ARRAY REAL:C219(arACT_CMontoNeto;0)
ARRAY REAL:C219(arACT_CIntereses;0)
ARRAY REAL:C219(arACT_CSaldo;0)
ARRAY LONGINT:C221(alACT_RecNumsCargos;0)
ARRAY LONGINT:C221(alACT_CRefs;0)
ARRAY LONGINT:C221(alACT_CIDCtaCte;0)
_O_ARRAY STRING:C218(2;asACT_Marcas;0)
ARRAY REAL:C219(arACT_MontoMoneda;0)
ARRAY TEXT:C222(atACT_MonedaCargo;0)
ARRAY TEXT:C222(atACT_MonedaSimbolo;0)

For ($i;1;Size of array:C274(apACT_BlobsAvisos))
	ARRAY DATE:C224(adACT_CFechaEmisionT;0)
	ARRAY DATE:C224(adACT_CFechaVencimientoT;0)
	ARRAY TEXT:C222(atACT_CAlumnoT;0)
	ARRAY TEXT:C222(atACT_CGlosaT;0)
	ARRAY REAL:C219(arACT_CMontoNetoT;0)
	ARRAY REAL:C219(arACT_CInteresesT;0)
	ARRAY REAL:C219(arACT_CSaldoT;0)
	ARRAY LONGINT:C221(alACT_RecNumsCargosT;0)
	ARRAY LONGINT:C221(alACT_CRefsT;0)
	ARRAY LONGINT:C221(alACT_CIDCtaCteT;0)
	_O_ARRAY STRING:C218(2;asACT_MarcasT;0)
	ARRAY REAL:C219(arACT_MontoMonedaT;0)
	ARRAY TEXT:C222(atACT_MonedaCargoT;0)
	ARRAY TEXT:C222(atACT_MonedaSimboloT;0)
	BLOB_Blob2Vars (apACT_BlobsAvisos{$i};0;->adACT_CFechaEmisionT;->adACT_CFechaVencimientoT;->atACT_CAlumnoT;->atACT_CGlosaT;->arACT_CMontoNetoT;->arACT_CInteresesT;->arACT_CSaldoT;->alACT_RecNumsCargosT;->alACT_CRefsT;->alACT_CIDCtaCteT;->asACT_MarcasT;->arACT_MontoMonedaT;->atACT_MonedaCargoT;->atACT_MonedaSimboloT)
	AT_Insert (0;Size of array:C274(adACT_CFechaEmisionT);->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
	
	ARRAY LONGINT:C221(al_idRefItemRA;0)
	COPY ARRAY:C226(alACT_CRefsT;al_idRefItemRA)
	al_idRefItemRA{0}:=vl_idIE  //variable vl_idIE ,de recargo por adelantado, cargada en ACTpgs_LoadCargosEspeciales(2)
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->al_idRefItemRA;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		ARRAY DATE:C224(adACT_CFechaEmisionIE;0)
		ARRAY DATE:C224(adACT_CFechaVencimientoIE;0)
		ARRAY TEXT:C222(atACT_CAlumnoIE;0)
		ARRAY TEXT:C222(atACT_CGlosaIE;0)
		ARRAY REAL:C219(arACT_CMontoNetoIE;0)
		ARRAY REAL:C219(arACT_CInteresesIE;0)
		ARRAY REAL:C219(arACT_CSaldoIE;0)
		ARRAY LONGINT:C221(alACT_RecNumsCargosIE;0)
		ARRAY LONGINT:C221(alACT_CRefsIE;0)
		ARRAY LONGINT:C221(alACT_CIDCtaCteIE;0)
		ARRAY TEXT:C222(asACT_MarcasIE;0)
		ARRAY REAL:C219(arACT_MontoMonedaIE;0)
		ARRAY TEXT:C222(atACT_MonedaCargoIE;0)
		ARRAY TEXT:C222(atACT_MonedaSimboloIE;0)
		For ($j;1;Size of array:C274($DA_Return))
			AT_Insert (0;1;->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->atACT_CAlumnoIE;->atACT_CGlosaIE;->arACT_CMontoNetoIE;->arACT_CInteresesIE;->arACT_CSaldoIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE)
			adACT_CFechaEmisionIE{$j}:=adACT_CFechaEmisionT{$DA_Return{$j}}
			adACT_CFechaVencimientoIE{$j}:=adACT_CFechaVencimientoT{$DA_Return{$j}}
			atACT_CAlumnoIE{$j}:=atACT_CAlumnoT{$DA_Return{$j}}
			atACT_CGlosaIE{$j}:=atACT_CGlosaT{$DA_Return{$j}}
			arACT_CMontoNetoIE{$j}:=arACT_CMontoNetoT{$DA_Return{$j}}
			arACT_CInteresesIE{$j}:=arACT_CInteresesT{$DA_Return{$j}}
			arACT_CSaldoIE{$j}:=arACT_CSaldoT{$DA_Return{$j}}
			alACT_RecNumsCargosIE{$j}:=alACT_RecNumsCargosT{$DA_Return{$j}}
			alACT_CRefsIE{$j}:=alACT_CRefsT{$DA_Return{$j}}
			alACT_CIDCtaCteIE{$j}:=alACT_CIDCtaCteT{$DA_Return{$j}}
			asACT_MarcasIE{$j}:=asACT_MarcasT{$DA_Return{$j}}
			arACT_MontoMonedaIE{$j}:=arACT_MontoMonedaT{$DA_Return{$j}}
			atACT_MonedaCargoIE{$j}:=atACT_MonedaCargoT{$DA_Return{$j}}
			atACT_MonedaSimboloIE{$j}:=atACT_MonedaSimboloT{$DA_Return{$j}}
		End for 
		For ($j;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$j};1;->adACT_CFechaEmisionT;->adACT_CFechaVencimientoT;->atACT_CAlumnoT;->atACT_CGlosaT;->arACT_CMontoNetoT;->arACT_CInteresesT;->arACT_CSaldoT;->alACT_RecNumsCargosT;->alACT_CRefsT;->alACT_CIDCtaCteT;->asACT_MarcasT;->arACT_MontoMonedaT;->atACT_MonedaCargoT;->atACT_MonedaSimboloT)
		End for 
		$vb_HayRecargoAdelantado:=True:C214
	Else 
		$vb_HayRecargoAdelantado:=False:C215
	End if 
	
	$p:=1
	For ($w;Size of array:C274(adACT_CFechaEmision)-Size of array:C274(adACT_CFechaEmisionT)+1;Size of array:C274(adACT_CFechaEmision))
		adACT_CFechaEmision{$w}:=adACT_CFechaEmisionT{$p}
		adACT_CFechaVencimiento{$w}:=adACT_CFechaVencimientoT{$p}
		atACT_CAlumno{$w}:=atACT_CAlumnoT{$p}
		atACT_CGlosa{$w}:=atACT_CGlosaT{$p}
		arACT_CMontoNeto{$w}:=arACT_CMontoNetoT{$p}
		arACT_CIntereses{$w}:=arACT_CInteresesT{$p}
		arACT_CSaldo{$w}:=arACT_CSaldoT{$p}
		alACT_RecNumsCargos{$w}:=alACT_RecNumsCargosT{$p}
		alACT_CRefs{$w}:=alACT_CRefsT{$p}
		alACT_CIDCtaCte{$w}:=alACT_CIDCtaCteT{$p}
		asACT_Marcas{$w}:=asACT_MarcasT{$p}
		arACT_MontoMoneda{$w}:=arACT_MontoMonedaT{$p}
		atACT_MonedaCargo{$w}:=atACT_MonedaCargoT{$p}
		atACT_MonedaSimbolo{$w}:=atACT_MonedaSimboloT{$p}
		$p:=$p+1
	End for 
	
	$p:=1
	If ($vb_HayRecargoAdelantado)
		  //For ($i;1;Size of array(atACT_CAlumnoIE))
		For ($w;Size of array:C274(adACT_CFechaEmision)-Size of array:C274(adACT_CFechaEmisionIE)+1;Size of array:C274(adACT_CFechaEmision))
			  //AT_Insert (0;1;->adACT_CFechaEmision;->adACT_CFechaVencimnto;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
			adACT_CFechaEmision{$w}:=adACT_CFechaEmisionIE{$p}
			adACT_CFechaVencimiento{$w}:=adACT_CFechaVencimientoIE{$p}
			atACT_CAlumno{$w}:=atACT_CAlumnoIE{$p}
			atACT_CGlosa{$w}:=atACT_CGlosaIE{$p}
			arACT_CMontoNeto{$w}:=arACT_CMontoNetoIE{$p}
			arACT_CIntereses{$w}:=arACT_CInteresesIE{$p}
			arACT_CSaldo{$w}:=arACT_CSaldoIE{$p}
			alACT_RecNumsCargos{$w}:=alACT_RecNumsCargosIE{$p}
			alACT_CRefs{$w}:=alACT_CRefsIE{$p}
			alACT_CIDCtaCte{$w}:=alACT_CIDCtaCteIE{$p}
			asACT_Marcas{$w}:=asACT_MarcasIE{$p}
			arACT_MontoMoneda{$w}:=arACT_MontoMonedaIE{$p}
			atACT_MonedaCargo{$w}:=atACT_MonedaCargoIE{$p}
			atACT_MonedaSimbolo{$w}:=atACT_MonedaSimboloIE{$p}
			$p:=$p+1
		End for 
		AT_Initialize (->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->atACT_CAlumnoIE;->atACT_CGlosaIE;->arACT_CMontoNetoIE;->arACT_CInteresesIE;->arACT_CSaldoIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE)
	End if 
End for 
AT_Initialize (->adACT_CFechaEmisionT;->adACT_CFechaVencimientoT;->atACT_CAlumnoT;->atACT_CGlosaT;->arACT_CMontoNetoT;->arACT_CInteresesT;->arACT_CSaldoT;->alACT_RecNumsCargosT;->alACT_CRefsT;->alACT_CIDCtaCteT;->asACT_MarcasT;->arACT_MontoMonedaT;->atACT_MonedaCargoT;->atACT_MonedaSimboloT)
AT_Initialize (->al_idRefItemRA)