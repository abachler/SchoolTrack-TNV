//%attributes = {}
  //ACTpgs_LoadCargosIntoArrays
C_BOOLEAN:C305(vbACTpgs_OrdCarXRecNumArr)


$vb_soloSaldos:=True:C214
If (Count parameters:C259=1)
	$vb_soloSaldos:=$1
End if 

ACTpgs_DeclareArraysCargos 
If ($vb_soloSaldos)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
End if 

If (vbACTpgs_OrdCarXRecNumArr)
	ARRAY LONGINT:C221($alACT_recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNums;"")
	AT_OrderArraysByArray (MAXLONG:K35:2;->al_RecNumsCargos;->$alACT_recNums)
	CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_recNums;"")
End if 

SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumsCargos;[ACT_Cargos:173]Ref_Item:16;alACT_CRefs;[ACT_Cargos:173]FechaEmision:22;adACT_CFechaEmision;[ACT_Cargos:173]Fecha_de_Vencimiento:7;adACT_CFechaVencimiento)
SELECTION TO ARRAY:C260([ACT_Cargos:173]Glosa:12;atACT_CGlosa;[ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado;[ACT_Cargos:173]Monto_Moneda:9;arACT_MontoMoneda;[ACT_Cargos:173]Monto_Neto:5;arACT_CMontoNeto)
SELECTION TO ARRAY:C260([ACT_Cargos:173]Saldo:23;arACT_CSaldo;[ACT_Cargos:173]Intereses:29;arACT_CIntereses;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]Monto_IVA:20;arACT_MontoIVA)
SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACT_CIdsCargos;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_CIDCtaCte;[ACT_Cargos:173]ID_Documento_de_Cargo:3;alACT_CIdDctoCargo;[ACT_Cargos:173]Monto_Afecto:27;arACT_CMontoAfecto)
SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CargoRelacionado:47;alACT_CidCargoGenInt)

ARRAY TEXT:C222(atACT_CAlumno;Size of array:C274(alACT_RecNumsCargos))
ARRAY LONGINT:C221(alACT_CIdsAvisos;Size of array:C274(alACT_RecNumsCargos))
ARRAY DATE:C224(adACT_CfechaInteres;Size of array:C274(alACT_RecNumsCargos))  //se llena en el método que calcula el interés
ARRAY TEXT:C222(atACT_MonedaSimbolo;Size of array:C274(alACT_RecNumsCargos))
_O_ARRAY STRING:C218(2;asACT_Marcas;Size of array:C274(alACT_RecNumsCargos))

AT_RedimArrays (Size of array:C274(alACT_RecNumsCargos);->apACT_ASelectedCargo;->abACT_ASelectedCargo)
For ($m;1;Size of array:C274(alACT_RecNumsCargos))
	abACT_ASelectedCargo{$m}:=False:C215
	GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{$m})
End for 

For ($i;1;Size of array:C274(alACT_RecNumsCargos))
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_CIDCtaCte{$i})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	atACT_CAlumno{$i}:=[Alumnos:2]apellidos_y_nombres:40
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=alACT_CIdDctoCargo{$i})
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
	alACT_CIdsAvisos{$i}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
End for 

ARRAY POINTER:C280(ap_arrays2Pay;24)
ap_arrays2Pay{1}:=->alACT_CIdsAvisos
ap_arrays2Pay{2}:=->alACT_CRefs
ap_arrays2Pay{3}:=->adACT_CFechaEmision
ap_arrays2Pay{4}:=->adACT_CFechaVencimiento
ap_arrays2Pay{5}:=->atACT_CAlumno
ap_arrays2Pay{6}:=->atACT_CGlosa
ap_arrays2Pay{7}:=->arACT_MontoMoneda
ap_arrays2Pay{8}:=->arACT_CMontoNeto
ap_arrays2Pay{9}:=->arACT_CSaldo
ap_arrays2Pay{10}:=->arACT_CIntereses
ap_arrays2Pay{11}:=->alACT_RecNumsCargos
ap_arrays2Pay{12}:=->atACT_MonedaCargo
ap_arrays2Pay{13}:=->atACT_MonedaSimbolo
ap_arrays2Pay{14}:=->alACT_CIDCtaCte
ap_arrays2Pay{15}:=->arACT_MontoPagado
ap_arrays2Pay{16}:=->alACT_CIdsCargos
ap_arrays2Pay{17}:=->alACT_CIdDctoCargo
ap_arrays2Pay{18}:=->arACT_MontoIVA
ap_arrays2Pay{19}:=->arACT_CMontoAfecto
ap_arrays2Pay{20}:=->adACT_CfechaInteres
ap_arrays2Pay{21}:=->alACT_CidCargoGenInt
ap_arrays2Pay{22}:=->asACT_Marcas
ap_arrays2Pay{23}:=->apACT_ASelectedCargo
ap_arrays2Pay{24}:=->abACT_ASelectedCargo

For ($i;1;Size of array:C274(adACT_CFechaVencimiento))
	Case of 
		: (adACT_CFechaVencimiento{$i}<Current date:C33(*))
			asACT_Marcas{$i}:="V"
		: (alACT_CRefs{$i}<0)
			asACT_Marcas{$i}:="NR"
		Else 
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([xxACT_ItemsMatriz:180])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_CIDCtaCte{$i})
			$IDMatrixCta:=[ACT_CuentasCorrientes:175]ID_Matriz:7
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$IDMatrixCta)
			QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=alACT_CRefs{$i})
			If (Records in selection:C76([xxACT_ItemsMatriz:180])=0)
				asACT_Marcas{$i}:="NM"
			Else 
				asACT_Marcas{$i}:="N"
			End if 
	End case 
End for 
ACTpgs_SimboloMoneda 
If (Not:C34(vbACTpgs_OrdCarXRecNumArr))
	ACTcfg_LoadConfigData (1)
	If (mCtaGlosa=1)
		ARRAY POINTER:C280($apACT_SortPointers;24)
		ARRAY LONGINT:C221($alACT_SortOrder;24)
		AT_Inc (0)
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaVencimiento
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumno
		$apACT_SortPointers{AT_Inc }:=->atACT_CGlosa
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdsAvisos
		$apACT_SortPointers{AT_Inc }:=->arACT_CSaldo
		$apACT_SortPointers{AT_Inc }:=->arACT_CMontoNeto
		$apACT_SortPointers{AT_Inc }:=->arACT_CIntereses
		$apACT_SortPointers{AT_Inc }:=->alACT_RecNumsCargos
		$apACT_SortPointers{AT_Inc }:=->alACT_CRefs
		$apACT_SortPointers{AT_Inc }:=->alACT_CIDCtaCte
		$apACT_SortPointers{AT_Inc }:=->asACT_Marcas
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoMoneda
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaCargo
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaSimbolo
		$apACT_SortPointers{AT_Inc }:=->arACT_CMontoAfecto
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoIVA
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoPagado
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdsCargos
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdDctoCargo
		$apACT_SortPointers{AT_Inc }:=->adACT_CfechaInteres
		$apACT_SortPointers{AT_Inc }:=->alACT_CidCargoGenInt
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaEmision
		$apACT_SortPointers{AT_Inc }:=->apACT_ASelectedCargo
		$apACT_SortPointers{AT_Inc }:=->abACT_ASelectedCargo
		AT_Inc (0)
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
	Else 
		ARRAY POINTER:C280($apACT_SortPointers;24)
		ARRAY LONGINT:C221($alACT_SortOrder;24)
		AT_Inc (0)
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaVencimiento
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdsAvisos
		$apACT_SortPointers{AT_Inc }:=->arACT_CSaldo
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaEmision
		$apACT_SortPointers{AT_Inc }:=->atACT_CGlosa
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumno
		$apACT_SortPointers{AT_Inc }:=->arACT_CIntereses
		$apACT_SortPointers{AT_Inc }:=->alACT_RecNumsCargos
		$apACT_SortPointers{AT_Inc }:=->alACT_CRefs
		$apACT_SortPointers{AT_Inc }:=->alACT_CIDCtaCte
		$apACT_SortPointers{AT_Inc }:=->asACT_Marcas
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoMoneda
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaCargo
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaSimbolo
		$apACT_SortPointers{AT_Inc }:=->arACT_CMontoAfecto
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoIVA
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoPagado
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdsCargos
		$apACT_SortPointers{AT_Inc }:=->alACT_CIdDctoCargo
		$apACT_SortPointers{AT_Inc }:=->adACT_CfechaInteres
		$apACT_SortPointers{AT_Inc }:=->alACT_CidCargoGenInt
		$apACT_SortPointers{AT_Inc }:=->arACT_CMontoNeto
		$apACT_SortPointers{AT_Inc }:=->apACT_ASelectedCargo
		$apACT_SortPointers{AT_Inc }:=->abACT_ASelectedCargo
		AT_Inc (0)
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=1
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
	End if 
	  //Recargos por adelantado
	ACTcfg_LoadCargosEspeciales (2)
	ARRAY LONGINT:C221($al_idRefItemRA;0)
	COPY ARRAY:C226(alACT_CRefs;$al_idRefItemRA)
	$al_idRefItemRA{0}:=vl_idIE  //variable vl_idIE ,de recargo por adelantado, cargada en ACTpgs_LoadCargosEspeciales(2)
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$al_idRefItemRA;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		For ($j;1;Size of array:C274($DA_Return))
			AT_Insert (0;1;->alACT_CIdsAvisos;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_MontoMoneda;->arACT_CMontoNeto;->arACT_CSaldo;->arACT_CIntereses;->alACT_RecNumsCargos;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->alACT_CIDCtaCte;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->asACT_Marcas;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
			atACT_CAlumno{Size of array:C274(atACT_CAlumno)}:=atACT_CAlumno{$DA_Return{$j}}
			atACT_CGlosa{Size of array:C274(atACT_CGlosa)}:=atACT_CGlosa{$DA_Return{$j}}
			arACT_CSaldo{Size of array:C274(arACT_CSaldo)}:=arACT_CSaldo{$DA_Return{$j}}
			adACT_CFechaEmision{Size of array:C274(adACT_CFechaEmision)}:=adACT_CFechaEmision{$DA_Return{$j}}
			adACT_CFechaVencimiento{Size of array:C274(adACT_CFechaVencimiento)}:=adACT_CFechaVencimiento{$DA_Return{$j}}
			arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}:=arACT_CMontoNeto{$DA_Return{$j}}
			arACT_CIntereses{Size of array:C274(arACT_CIntereses)}:=arACT_CIntereses{$DA_Return{$j}}
			alACT_RecNumsCargos{Size of array:C274(alACT_RecNumsCargos)}:=alACT_RecNumsCargos{$DA_Return{$j}}
			alACT_CRefs{Size of array:C274(alACT_CRefs)}:=alACT_CRefs{$DA_Return{$j}}
			alACT_CIDCtaCte{Size of array:C274(alACT_CIDCtaCte)}:=alACT_CIDCtaCte{$DA_Return{$j}}
			asACT_Marcas{Size of array:C274(asACT_Marcas)}:=asACT_Marcas{$DA_Return{$j}}
			arACT_MontoMoneda{Size of array:C274(arACT_MontoMoneda)}:=arACT_MontoMoneda{$DA_Return{$j}}
			atACT_MonedaCargo{Size of array:C274(atACT_MonedaCargo)}:=atACT_MonedaCargo{$DA_Return{$j}}
			atACT_MonedaSimbolo{Size of array:C274(atACT_MonedaSimbolo)}:=atACT_MonedaSimbolo{$DA_Return{$j}}
			arACT_CMontoAfecto{Size of array:C274(arACT_CMontoAfecto)}:=arACT_CMontoAfecto{$DA_Return{$j}}
			arACT_MontoIVA{Size of array:C274(arACT_MontoIVA)}:=arACT_MontoIVA{$DA_Return{$j}}
			arACT_MontoPagado{Size of array:C274(arACT_MontoPagado)}:=arACT_MontoPagado{$DA_Return{$j}}
			alACT_CIdsCargos{Size of array:C274(alACT_CIdsCargos)}:=alACT_CIdsCargos{$DA_Return{$j}}
			alACT_CIdDctoCargo{Size of array:C274(alACT_CIdDctoCargo)}:=alACT_CIdDctoCargo{$DA_Return{$j}}
			adACT_CfechaInteres{Size of array:C274(adACT_CfechaInteres)}:=adACT_CfechaInteres{$DA_Return{$j}}
			alACT_CidCargoGenInt{Size of array:C274(alACT_CidCargoGenInt)}:=alACT_CidCargoGenInt{$DA_Return{$j}}
			alACT_CIdsAvisos{Size of array:C274(alACT_CIdsAvisos)}:=alACT_CIdsAvisos{$DA_Return{$j}}
			apACT_ASelectedCargo{Size of array:C274(apACT_ASelectedCargo)}:=apACT_ASelectedCargo{$DA_Return{$j}}
			abACT_ASelectedCargo{Size of array:C274(abACT_ASelectedCargo)}:=abACT_ASelectedCargo{$DA_Return{$j}}
		End for 
		For ($j;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$j};1;->alACT_CIdsAvisos;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_MontoMoneda;->arACT_CMontoNeto;->arACT_CSaldo;->arACT_CIntereses;->alACT_RecNumsCargos;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->alACT_CIDCtaCte;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->asACT_Marcas;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		End for 
	End if 
	  //->alACT_CIdsAvisos;->alACT_CRefs;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_MontoMoneda;->arACT_CMontoNeto;->arACT_CSaldo;->arACT_CIntereses;->alACT_RecNumsCargos;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->alACT_CIDCtaCte;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->asACT_Marcas)
	  //->alACT_CIdsAvisosTemp;->alACT_CRefsTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_MontoMonedaTemp;->arACT_CMontoNetoTemp;->arACT_CSaldoTemp;->arACT_CInteresesTemp;->alACT_RecNumsCargosTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->alACT_CIDCtaCteTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->asACT_MarcasTemp)
End if 
vbACTpgs_OrdCarXRecNumArr:=False:C215
