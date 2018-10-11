//%attributes = {}
  //ACTpgs_OrdenaCargos
C_BOOLEAN:C305($b_DTECLG)

If (Count parameters:C259=1)
	$b_DTECLG:=$1
End if 

  //20150915 RCH Si es dte no se ordena...
If (Not:C34($b_DTECLG))
	
	ACTcfg_LoadConfigData (1)
	ACTcfg_LoadCargosEspeciales (2)
	C_BOOLEAN:C305($vb_HayRecargoAdelantado)
	$vb_HayRecargoAdelantado:=False:C215
	
	ARRAY POINTER:C280($apACT_SortPointers;0)
	ARRAY LONGINT:C221($alACT_SortOrder;0)
	
	ARRAY LONGINT:C221(al_idRefItemRA;0)
	COPY ARRAY:C226(alACT_CRefs;al_idRefItemRA)
	al_idRefItemRA{0}:=vl_idIE  //variable vl_idIE ,de recargo por adelantado, cargada en ACTpgs_LoadCargosEspeciales(2)
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->al_idRefItemRA;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		ARRAY TEXT:C222(atACT_CAlumnoIE;0)
		ARRAY TEXT:C222(atACT_CGlosaImpresionIE;0)
		ARRAY TEXT:C222(atACT_CGlosaIE;0)
		ARRAY REAL:C219(arACT_CSaldoIE;0)
		ARRAY DATE:C224(adACT_CFechaEmisionIE;0)
		ARRAY DATE:C224(adACT_CFechaVencimientoIE;0)
		ARRAY REAL:C219(arACT_CMontoNetoIE;0)
		ARRAY TEXT:C222(atACT_CAlumnoCursoIE;0)
		ARRAY TEXT:C222(atACT_CAlumnoNivelNombreIE;0)
		ARRAY TEXT:C222(atACT_CAlumnoPCursoIE;0)
		ARRAY TEXT:C222(atACT_CAlumnoPNivelNombreIE;0)
		ARRAY REAL:C219(arACT_CInteresesIE;0)
		ARRAY LONGINT:C221(alACT_RecNumsCargosIE;0)
		ARRAY LONGINT:C221(alACT_CRefsIE;0)
		ARRAY LONGINT:C221(alACT_CIDCtaCteIE;0)
		ARRAY TEXT:C222(asACT_MarcasIE;0)
		ARRAY REAL:C219(arACT_MontoMonedaIE;0)
		ARRAY TEXT:C222(atACT_MonedaCargoIE;0)
		ARRAY TEXT:C222(atACT_MonedaSimboloIE;0)
		ARRAY TEXT:C222(asACT_AfectoIE;0)
		ARRAY REAL:C219(arACT_CTotalDesctosIE;0)
		
		  //20150915 RCH
		ARRAY REAL:C219(arACT_TasaIVAIE;0)
		
		For ($i;1;Size of array:C274($DA_Return))
			  //AT_Insert (0;1;->atACT_CAlumnoIE;->atACT_CGlosaImpresionIE;->atACT_CGlosaIE;->arACT_CSaldoIE;->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->arACT_CMontoNetoIE;->atACT_CAlumnoCursoIE;->atACT_CAlumnoNivelNombreIE;->atACT_CAlumnoPCursoIE;->atACT_CAlumnoPNivelNombreIE;->arACT_CInteresesIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE;->asACT_AfectoIE;->arACT_CTotalDesctosIE)
			AT_Insert (0;1;->atACT_CAlumnoIE;->atACT_CGlosaImpresionIE;->atACT_CGlosaIE;->arACT_CSaldoIE;->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->arACT_CMontoNetoIE;->atACT_CAlumnoCursoIE;->atACT_CAlumnoNivelNombreIE;->atACT_CAlumnoPCursoIE;->atACT_CAlumnoPNivelNombreIE;->arACT_CInteresesIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE;->asACT_AfectoIE;->arACT_CTotalDesctosIE;->arACT_TasaIVAIE)
			atACT_CAlumnoIE{$i}:=atACT_CAlumno{$DA_Return{$i}}
			atACT_CGlosaImpresionIE{$i}:=atACT_CGlosaImpresion{$DA_Return{$i}}
			atACT_CGlosaIE{$i}:=atACT_CGlosa{$DA_Return{$i}}
			arACT_CSaldoIE{$i}:=arACT_CSaldo{$DA_Return{$i}}
			adACT_CFechaEmisionIE{$i}:=adACT_CFechaEmision{$DA_Return{$i}}
			adACT_CFechaVencimientoIE{$i}:=adACT_CFechaVencimiento{$DA_Return{$i}}
			arACT_CMontoNetoIE{$i}:=arACT_CMontoNeto{$DA_Return{$i}}
			atACT_CAlumnoCursoIE{$i}:=atACT_CAlumnoCurso{$DA_Return{$i}}
			atACT_CAlumnoNivelNombreIE{$i}:=atACT_CAlumnoNivelNombre{$DA_Return{$i}}
			atACT_CAlumnoPCursoIE{$i}:=atACT_CAlumnoPCurso{$DA_Return{$i}}
			atACT_CAlumnoPNivelNombreIE{$i}:=atACT_CAlumnoPNivelNombre{$DA_Return{$i}}
			arACT_CInteresesIE{$i}:=arACT_CIntereses{$DA_Return{$i}}
			alACT_RecNumsCargosIE{$i}:=alACT_RecNumsCargos{$DA_Return{$i}}
			alACT_CRefsIE{$i}:=alACT_CRefs{$DA_Return{$i}}
			alACT_CIDCtaCteIE{$i}:=alACT_CIDCtaCte{$DA_Return{$i}}
			asACT_MarcasIE{$i}:=asACT_Marcas{$DA_Return{$i}}
			arACT_MontoMonedaIE{$i}:=arACT_MontoMoneda{$DA_Return{$i}}
			atACT_MonedaCargoIE{$i}:=atACT_MonedaCargo{$DA_Return{$i}}
			atACT_MonedaSimboloIE{$i}:=atACT_MonedaSimbolo{$DA_Return{$i}}
			asACT_AfectoIE{$i}:=asACT_Afecto{$DA_Return{$i}}
			arACT_CTotalDesctosIE{$i}:=arACT_CTotalDesctos{$DA_Return{$i}}
			
			  //20150915 RCH
			arACT_TasaIVAIE{$i}:=arACT_TasaIVA{$DA_Return{$i}}
			
		End for 
		For ($i;Size of array:C274($DA_Return);1;-1)
			AT_Delete ($DA_Return{$i};1;->atACT_CAlumno;->atACT_CGlosaImpresion;->atACT_CGlosa;->arACT_CSaldo;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->arACT_CMontoNeto;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->arACT_CIntereses;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->asACT_Afecto;->arACT_CTotalDesctos)
		End for 
		$vb_HayRecargoAdelantado:=True:C214
	End if 
	
	If (mCtaGlosa=1)
		ARRAY POINTER:C280($apACT_SortPointers;27)
		ARRAY LONGINT:C221($alACT_SortOrder;27)
		AT_Inc (0)
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumno
		$apACT_SortPointers{AT_Inc }:=->atACT_CGlosaImpresion
		$apACT_SortPointers{AT_Inc }:=->atACT_CGlosa
		$apACT_SortPointers{AT_Inc }:=->arACT_CSaldo
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaEmision
		$apACT_SortPointers{AT_Inc }:=->adACT_CFechaVencimiento
		$apACT_SortPointers{AT_Inc }:=->arACT_CMontoNeto
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumnoCurso
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumnoNivelNombre
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumnoPCurso
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumnoPNivelNombre
		$apACT_SortPointers{AT_Inc }:=->arACT_CIntereses
		$apACT_SortPointers{AT_Inc }:=->alACT_RecNumsCargos
		$apACT_SortPointers{AT_Inc }:=->alACT_CRefs
		$apACT_SortPointers{AT_Inc }:=->alACT_CIDCtaCte
		$apACT_SortPointers{AT_Inc }:=->asACT_Marcas
		$apACT_SortPointers{AT_Inc }:=->arACT_MontoMoneda
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaCargo
		$apACT_SortPointers{AT_Inc }:=->atACT_MonedaSimbolo
		$apACT_SortPointers{AT_Inc }:=->asACT_Afecto
		$apACT_SortPointers{AT_Inc }:=->arACT_CTotalDesctos
		$apACT_SortPointers{AT_Inc }:=->alACT_MesCargo
		$apACT_SortPointers{AT_Inc }:=->alACT_AñoCargo
		$apACT_SortPointers{AT_Inc }:=->atACT_MesCargo
		$apACT_SortPointers{AT_Inc }:=->atACT_CAlumnoNoMatricula
		$apACT_SortPointers{AT_Inc }:=->atACT_AñoCargo
		$apACT_SortPointers{AT_Inc }:=->arACT_TasaIVA
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
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		$alACT_SortOrder{AT_Inc }:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
	Else 
		ARRAY LONGINT:C221(alACT_PosinArraysVenc;0)  //Aqui van a estar los vencidos
		ARRAY LONGINT:C221(alACT_PosinArraysResto1;0)
		ARRAY LONGINT:C221(alACT_PosinArraysNegRef;0)  //Aqui van a estar los cargos extraordinarios
		ARRAY LONGINT:C221(alACT_PosinArraysResto2;0)
		ARRAY LONGINT:C221(alACT_PosinArraysItemNoMatriz;0)  //Aqui van a estar los cargos que son un item pero no pertenecen a la matriz de la cuenta
		ARRAY LONGINT:C221(alACT_PosinArraysResto3;0)
		ARRAY LONGINT:C221(alACT_PosinArraysResto4;0)  //Aqui van a estar los normales
		
		For ($i;1;Size of array:C274(adACT_CFechaVencimiento))
			If (adACT_CFechaVencimiento{$i}<Current date:C33(*))
				INSERT IN ARRAY:C227(alACT_PosinArraysVenc;Size of array:C274(alACT_PosinArraysVenc)+1;1)
				alACT_PosinArraysVenc{Size of array:C274(alACT_PosinArraysVenc)}:=$i
				asACT_Marcas{$i}:="V"
			Else 
				INSERT IN ARRAY:C227(alACT_PosinArraysResto1;Size of array:C274(alACT_PosinArraysResto1)+1;1)
				alACT_PosinArraysResto1{Size of array:C274(alACT_PosinArraysResto1)}:=$i
			End if 
		End for 
		
		For ($i;1;Size of array:C274(alACT_PosinArraysResto1))
			If (alACT_CRefs{$i}<0)
				INSERT IN ARRAY:C227(alACT_PosinArraysNegRef;Size of array:C274(alACT_PosinArraysNegRef)+1;1)
				alACT_PosinArraysNegRef{Size of array:C274(alACT_PosinArraysNegRef)}:=alACT_PosinArraysResto1{$i}
				asACT_Marcas{alACT_PosinArraysResto1{$i}}:="NR"
			Else 
				INSERT IN ARRAY:C227(alACT_PosinArraysResto2;Size of array:C274(alACT_PosinArraysResto2)+1;1)
				alACT_PosinArraysResto2{Size of array:C274(alACT_PosinArraysResto2)}:=alACT_PosinArraysResto1{$i}
			End if 
		End for 
		
		For ($i;1;Size of array:C274(alACT_PosinArraysResto2))
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_CIDCtaCte{alACT_PosinArraysResto2{$i}})
			$IDMatrixCta:=[ACT_CuentasCorrientes:175]ID_Matriz:7
			QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$IDMatrixCta)
			QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Item:2=alACT_CRefs{alACT_PosinArraysResto2{$i}})
			If (Records in selection:C76([xxACT_ItemsMatriz:180])=0)
				INSERT IN ARRAY:C227(alACT_PosinArraysItemNoMatriz;Size of array:C274(alACT_PosinArraysItemNoMatriz)+1;1)
				alACT_PosinArraysItemNoMatriz{Size of array:C274(alACT_PosinArraysItemNoMatriz)}:=alACT_PosinArraysResto2{$i}
				asACT_Marcas{alACT_PosinArraysResto2{$i}}:="NM"
			Else 
				INSERT IN ARRAY:C227(alACT_PosinArraysResto3;Size of array:C274(alACT_PosinArraysResto3)+1;1)
				alACT_PosinArraysResto3{Size of array:C274(alACT_PosinArraysResto3)}:=alACT_PosinArraysResto2{$i}
			End if 
		End for 
		
		For ($i;1;Size of array:C274(adACT_CFechaVencimiento))
			$EnVenc:=Find in array:C230(alACT_PosinArraysVenc;$i)
			$EnNegRef:=Find in array:C230(alACT_PosinArraysNegRef;$i)
			$EnNoMatriz:=Find in array:C230(alACT_PosinArraysItemNoMatriz;$i)
			If (($EnVenc=-1) & ($EnNegRef=-1) & ($EnNoMatriz=-1))
				INSERT IN ARRAY:C227(alACT_PosinArraysResto4;Size of array:C274(alACT_PosinArraysResto4)+1;1)
				alACT_PosinArraysResto4{Size of array:C274(alACT_PosinArraysResto4)}:=$i
				asACT_Marcas{$i}:="N"
			End if 
		End for 
		
		ARRAY REAL:C219(arACT_TempSaldos;Size of array:C274(alACT_PosinArraysNegRef))
		ARRAY DATE:C224(adACT_TempEmision;Size of array:C274(alACT_PosinArraysNegRef))
		
		For ($i;1;Size of array:C274(alACT_PosinArraysNegRef))
			arACT_TempSaldos{$i}:=arACT_CSaldo{alACT_PosinArraysNegRef{$i}}
			adACT_TempEmision{$i}:=adACT_CFechaEmision{alACT_PosinArraysNegRef{$i}}
		End for 
		
		ARRAY POINTER:C280($apACT_SortPointers;3)
		ARRAY LONGINT:C221($alACT_SortOrder;3)
		$apACT_SortPointers{1}:=->adACT_TempEmision
		$apACT_SortPointers{2}:=->arACT_TempSaldos
		$apACT_SortPointers{3}:=->alACT_PosinArraysNegRef
		$alACT_SortOrder{1}:=1
		$alACT_SortOrder{2}:=1
		$alACT_SortOrder{3}:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
		
		ARRAY REAL:C219(arACT_TempSaldos;Size of array:C274(alACT_PosinArraysVenc))
		ARRAY DATE:C224(adACT_TempEmision;Size of array:C274(alACT_PosinArraysVenc))
		
		For ($i;1;Size of array:C274(alACT_PosinArraysVenc))
			arACT_TempSaldos{$i}:=arACT_CSaldo{alACT_PosinArraysVenc{$i}}
			adACT_TempEmision{$i}:=adACT_CFechaEmision{alACT_PosinArraysVenc{$i}}
		End for 
		
		ARRAY POINTER:C280($apACT_SortPointers;3)
		ARRAY LONGINT:C221($alACT_SortOrder;3)
		$apACT_SortPointers{1}:=->adACT_TempEmision
		$apACT_SortPointers{2}:=->arACT_TempSaldos
		$apACT_SortPointers{3}:=->alACT_PosinArraysVenc
		$alACT_SortOrder{1}:=1
		$alACT_SortOrder{2}:=1
		$alACT_SortOrder{3}:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
		
		ARRAY REAL:C219(arACT_TempSaldos;Size of array:C274(alACT_PosinArraysItemNoMatriz))
		ARRAY DATE:C224(adACT_TempEmision;Size of array:C274(alACT_PosinArraysItemNoMatriz))
		
		For ($i;1;Size of array:C274(alACT_PosinArraysItemNoMatriz))
			arACT_TempSaldos{$i}:=arACT_CSaldo{alACT_PosinArraysItemNoMatriz{$i}}
			adACT_TempEmision{$i}:=adACT_CFechaEmision{alACT_PosinArraysItemNoMatriz{$i}}
		End for 
		
		ARRAY POINTER:C280($apACT_SortPointers;3)
		ARRAY LONGINT:C221($alACT_SortOrder;3)
		$apACT_SortPointers{1}:=->adACT_TempEmision
		$apACT_SortPointers{2}:=->arACT_TempSaldos
		$apACT_SortPointers{3}:=->alACT_PosinArraysItemNoMatriz
		$alACT_SortOrder{1}:=1
		$alACT_SortOrder{2}:=1
		$alACT_SortOrder{3}:=0
		MULTI SORT ARRAY:C718($apACT_SortPointers;$alACT_SortOrder)
		
		$CuantosCargos:=Size of array:C274(alACT_PosinArraysVenc)+Size of array:C274(alACT_PosinArraysNegRef)+Size of array:C274(alACT_PosinArraysItemNoMatriz)+Size of array:C274(alACT_PosinArraysResto4)
		$count:=0
		
		ARRAY LONGINT:C221($alACT_NuevasPos;$CuantosCargos)
		ARRAY LONGINT:C221(alACT_RecNumsVenc;Size of array:C274(alACT_PosinArraysVenc))
		
		For ($i;1;Size of array:C274(alACT_PosinArraysVenc))
			$alACT_NuevasPos{$i}:=alACT_PosinArraysVenc{$i}
			alACT_RecNumsVenc{$i}:=alACT_RecNumsCargos{alACT_PosinArraysVenc{$i}}
		End for 
		$count:=$i-1
		ARRAY LONGINT:C221(alACT_RecNumsNormales;Size of array:C274(alACT_PosinArraysResto4))
		
		ACTpgs_SortByMatrix (->alACT_PosinArraysResto4)
		
		For ($j;1;Size of array:C274(alACT_PosinArraysResto4))
			$alACT_NuevasPos{$count+$j}:=alACT_PosinArraysResto4{$j}
			alACT_RecNumsNormales{$j}:=alACT_RecNumsCargos{alACT_PosinArraysResto4{$j}}
		End for 
		
		$count:=$count+$j-1
		ARRAY LONGINT:C221(alACT_RecNumsNoMatriz;Size of array:C274(alACT_PosinArraysItemNoMatriz))
		
		For ($k;1;Size of array:C274(alACT_PosinArraysItemNoMatriz))
			$alACT_NuevasPos{$count+$k}:=alACT_PosinArraysItemNoMatriz{$k}
			alACT_RecNumsNoMatriz{$k}:=alACT_RecNumsCargos{alACT_PosinArraysItemNoMatriz{$k}}
		End for 
		
		$count:=$count+$k-1
		ARRAY LONGINT:C221(alACT_RecNumsNegRef;Size of array:C274(alACT_PosinArraysNegRef))
		
		For ($l;1;Size of array:C274(alACT_PosinArraysNegRef))
			$alACT_NuevasPos{$count+$l}:=alACT_PosinArraysNegRef{$l}
			alACT_RecNumsNegRef{$l}:=alACT_RecNumsCargos{alACT_PosinArraysNegRef{$l}}
		End for 
		
		ARRAY DATE:C224($adACT_CFechaEmisionTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY DATE:C224($adACT_CFechaVencimientoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoCursoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoNivelNombreTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoPCursoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoPNivelNombreTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CGlosaTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CGlosaImpresionTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY REAL:C219($arACT_CMontoNetoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY REAL:C219($arACT_CInteresesTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY REAL:C219($arACT_CSaldoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY LONGINT:C221($alACT_RecNumsCargosTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY LONGINT:C221($alACT_CRefsTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY LONGINT:C221($alACT_CIDCtaCteTemp;Size of array:C274(adACT_CFechaEmision))
		_O_ARRAY STRING:C218(2;$asACT_MarcasTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY REAL:C219($arACT_MontoMonedaTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_MonedaCargoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_MonedaSimboloTemp;Size of array:C274(adACT_CFechaEmision))
		_O_ARRAY STRING:C218(2;$asACT_AfectoTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY REAL:C219($arACT_TotalDesctosTemp;Size of array:C274(adACT_CFechaEmision))
		ARRAY LONGINT:C221($alACT_MesCargo;Size of array:C274(adACT_CFechaEmision))
		ARRAY LONGINT:C221($alACT_AñoCargo;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_MesCargo;Size of array:C274(adACT_CFechaEmision))
		ARRAY TEXT:C222($atACT_CAlumnoNoMatricula;Size of array:C274(adACT_CFechaEmision))
		
		ARRAY TEXT:C222($atACT_AñoCargo;Size of array:C274(adACT_CFechaEmision))
		
		  //20150915 RCH
		ARRAY REAL:C219($arACT_TasaIVA;Size of array:C274(arACT_TasaIVA))
		
		For ($i;1;Size of array:C274($alACT_NuevasPos))
			$adACT_CFechaEmisionTemp{$i}:=adACT_CFechaEmision{$alACT_NuevasPos{$i}}
			$adACT_CFechaVencimientoTemp{$i}:=adACT_CFechaVencimiento{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoTemp{$i}:=atACT_CAlumno{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoCursoTemp{$i}:=atACT_CAlumnoCurso{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoNivelNombreTemp{$i}:=atACT_CAlumnoNivelNombre{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoPCursoTemp{$i}:=atACT_CAlumnoPCurso{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoPNivelNombreTemp{$i}:=atACT_CAlumnoPNivelNombre{$alACT_NuevasPos{$i}}
			$atACT_CGlosaTemp{$i}:=atACT_CGlosa{$alACT_NuevasPos{$i}}
			$atACT_CGlosaImpresionTemp{$i}:=atACT_CGlosaImpresion{$alACT_NuevasPos{$i}}
			$arACT_CMontoNetoTemp{$i}:=arACT_CMontoNeto{$alACT_NuevasPos{$i}}
			$arACT_CInteresesTemp{$i}:=arACT_CIntereses{$alACT_NuevasPos{$i}}
			$arACT_CSaldoTemp{$i}:=arACT_CSaldo{$alACT_NuevasPos{$i}}
			$alACT_RecNumsCargosTemp{$i}:=alACT_RecNumsCargos{$alACT_NuevasPos{$i}}
			$alACT_CRefsTemp{$i}:=alACT_CRefs{$alACT_NuevasPos{$i}}
			$alACT_CIDCtaCteTemp{$i}:=alACT_CIDCtaCte{$alACT_NuevasPos{$i}}
			$asACT_MarcasTemp{$i}:=asACT_Marcas{$alACT_NuevasPos{$i}}
			$arACT_MontoMonedaTemp{$i}:=arACT_MontoMoneda{$alACT_NuevasPos{$i}}
			$atACT_MonedaCargoTemp{$i}:=atACT_MonedaCargo{$alACT_NuevasPos{$i}}
			$atACT_MonedaSimboloTemp{$i}:=atACT_MonedaSimbolo{$alACT_NuevasPos{$i}}
			$asACT_AfectoTemp{$i}:=asACT_Afecto{$alACT_NuevasPos{$i}}
			$arACT_TotalDesctosTemp{$i}:=arACT_CTotalDesctos{$alACT_NuevasPos{$i}}
			$alACT_MesCargo{$i}:=alACT_MesCargo{$alACT_NuevasPos{$i}}
			$alACT_AñoCargo{$i}:=alACT_AñoCargo{$alACT_NuevasPos{$i}}
			$atACT_MesCargo{$i}:=atACT_MesCargo{$alACT_NuevasPos{$i}}
			$atACT_CAlumnoNoMatricula{$i}:=atACT_CAlumnoNoMatricula{$alACT_NuevasPos{$i}}
			
			$atACT_AñoCargo{$i}:=atACT_AñoCargo{$alACT_NuevasPos{$i}}
			
			  //20150915 RCH
			$arACT_TasaIVA{$i}:=arACT_TasaIVA{$alACT_NuevasPos{$i}}
			
		End for 
		
		  //For ($i;1;Size of array($alACT_NuevasPos))
		  //adACT_CFechaEmision{$i}:=adACT_CFechaEmisionTemp{$i}
		  //adACT_CFechaVencimiento{$i}:=adACT_CFechaVencimientoTemp{$i}
		  //atACT_CAlumno{$i}:=atACT_CAlumnoTemp{$i}
		  //atACT_CAlumnoCurso{$i}:=atACT_CAlumnoCursoTemp{$i}
		  //atACT_CAlumnoNivelNombre{$i}:=atACT_CAlumnoNivelNombreTemp{$i}
		  //atACT_CAlumnoPCurso{$i}:=atACT_CAlumnoPCursoTemp{$i}
		  //atACT_CAlumnoPNivelNombre{$i}:=atACT_CAlumnoPNivelNombreTemp{$i}
		  //atACT_CGlosa{$i}:=atACT_CGlosaTemp{$i}
		  //atACT_CGlosaImpresion{$i}:=atACT_CGlosaImpresionTemp{$i}
		  //arACT_CMontoNeto{$i}:=arACT_CMontoNetoTemp{$i}
		  //arACT_CIntereses{$i}:=arACT_CInteresesTemp{$i}
		  //arACT_CSaldo{$i}:=arACT_CSaldoTemp{$i}
		  //alACT_RecNumsCargos{$i}:=alACT_RecNumsCargosTemp{$i}
		  //alACT_CRefs{$i}:=alACT_CRefsTemp{$i}
		  //alACT_CIDCtaCte{$i}:=alACT_CIDCtaCteTemp{$i}
		  //asACT_Marcas{$i}:=asACT_MarcasTemp{$i}
		  //arACT_MontoMoneda{$i}:=arACT_MontoMonedaTemp{$i}
		  //atACT_MonedaCargo{$i}:=atACT_MonedaCargoTemp{$i}
		  //atACT_MonedaSimbolo{$i}:=atACT_MonedaSimboloTemp{$i}
		  //asACT_Afecto{$i}:=asACT_AfectoTemp{$i}
		  //arACT_CTotalDesctos{$i}:=arACT_TotalDesctosTemp{$i}
		  //End for 
		
		COPY ARRAY:C226($adACT_CFechaEmisionTemp;adACT_CFechaEmision)
		COPY ARRAY:C226($adACT_CFechaVencimientoTemp;adACT_CFechaVencimiento)
		COPY ARRAY:C226($atACT_CAlumnoTemp;atACT_CAlumno)
		COPY ARRAY:C226($atACT_CAlumnoCursoTemp;atACT_CAlumnoCurso)
		COPY ARRAY:C226($atACT_CAlumnoNivelNombreTemp;atACT_CAlumnoNivelNombre)
		COPY ARRAY:C226($atACT_CAlumnoPCursoTemp;atACT_CAlumnoPCurso)
		COPY ARRAY:C226($atACT_CAlumnoPNivelNombreTemp;atACT_CAlumnoPNivelNombre)
		COPY ARRAY:C226($atACT_CGlosaTemp;atACT_CGlosa)
		COPY ARRAY:C226($atACT_CGlosaImpresionTemp;atACT_CGlosaImpresion)
		COPY ARRAY:C226($arACT_CMontoNetoTemp;arACT_CMontoNeto)
		COPY ARRAY:C226($arACT_CInteresesTemp;arACT_CIntereses)
		COPY ARRAY:C226($arACT_CSaldoTemp;arACT_CSaldo)
		COPY ARRAY:C226($alACT_RecNumsCargosTemp;alACT_RecNumsCargos)
		COPY ARRAY:C226($alACT_CRefsTemp;alACT_CRefs)
		COPY ARRAY:C226($alACT_CIDCtaCteTemp;alACT_CIDCtaCte)
		COPY ARRAY:C226($asACT_MarcasTemp;asACT_Marcas)
		COPY ARRAY:C226($arACT_MontoMonedaTemp;arACT_MontoMoneda)
		COPY ARRAY:C226($atACT_MonedaCargoTemp;atACT_MonedaCargo)
		COPY ARRAY:C226($atACT_MonedaSimboloTemp;atACT_MonedaSimbolo)
		COPY ARRAY:C226($asACT_AfectoTemp;asACT_Afecto)
		COPY ARRAY:C226($arACT_TotalDesctosTemp;arACT_CTotalDesctos)
		COPY ARRAY:C226($alACT_MesCargo;alACT_MesCargo)
		COPY ARRAY:C226($alACT_AñoCargo;alACT_AñoCargo)
		COPY ARRAY:C226($atACT_MesCargo;atACT_MesCargo)
		COPY ARRAY:C226($atACT_CAlumnoNoMatricula;atACT_CAlumnoNoMatricula)
		
		COPY ARRAY:C226($atACT_AñoCargo;atACT_AñoCargo)
		
		  //20150915 RCH
		COPY ARRAY:C226($arACT_TasaIVA;arACT_TasaIVA)
		
	End if 
	
	If ($vb_HayRecargoAdelantado)
		For ($i;1;Size of array:C274(atACT_CAlumnoIE))
			AT_Insert (0;1;->atACT_CAlumno;->atACT_CGlosaImpresion;->atACT_CGlosa;->arACT_CSaldo;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->arACT_CMontoNeto;->atACT_CAlumnoCurso;->atACT_CAlumnoNivelNombre;->atACT_CAlumnoPCurso;->atACT_CAlumnoPNivelNombre;->arACT_CIntereses;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->asACT_Afecto;->arACT_CTotalDesctos)
			atACT_CAlumno{Size of array:C274(atACT_CAlumno)}:=atACT_CAlumnoIE{$i}
			atACT_CGlosaImpresion{Size of array:C274(atACT_CGlosaImpresion)}:=atACT_CGlosaImpresionIE{$i}
			atACT_CGlosa{Size of array:C274(atACT_CGlosa)}:=atACT_CGlosaIE{$i}
			arACT_CSaldo{Size of array:C274(arACT_CSaldo)}:=arACT_CSaldoIE{$i}
			adACT_CFechaEmision{Size of array:C274(adACT_CFechaEmision)}:=adACT_CFechaEmisionIE{$i}
			adACT_CFechaVencimiento{Size of array:C274(adACT_CFechaVencimiento)}:=adACT_CFechaVencimientoIE{$i}
			arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}:=arACT_CMontoNetoIE{$i}
			atACT_CAlumnoCurso{Size of array:C274(atACT_CAlumnoCurso)}:=atACT_CAlumnoCursoIE{$i}
			atACT_CAlumnoNivelNombre{Size of array:C274(atACT_CAlumnoNivelNombre)}:=atACT_CAlumnoNivelNombreIE{$i}
			atACT_CAlumnoPCurso{Size of array:C274(atACT_CAlumnoPCurso)}:=atACT_CAlumnoPCursoIE{$i}
			atACT_CAlumnoPNivelNombre{Size of array:C274(atACT_CAlumnoPNivelNombre)}:=atACT_CAlumnoPNivelNombreIE{$i}
			arACT_CIntereses{Size of array:C274(arACT_CIntereses)}:=arACT_CInteresesIE{$i}
			alACT_RecNumsCargos{Size of array:C274(alACT_RecNumsCargos)}:=alACT_RecNumsCargosIE{$i}
			alACT_CRefs{Size of array:C274(alACT_CRefs)}:=alACT_CRefsIE{$i}
			alACT_CIDCtaCte{Size of array:C274(alACT_CIDCtaCte)}:=alACT_CIDCtaCteIE{$i}
			asACT_Marcas{Size of array:C274(asACT_Marcas)}:=asACT_MarcasIE{$i}
			arACT_MontoMoneda{Size of array:C274(arACT_MontoMoneda)}:=arACT_MontoMonedaIE{$i}
			atACT_MonedaCargo{Size of array:C274(atACT_MonedaCargo)}:=atACT_MonedaCargoIE{$i}
			atACT_MonedaSimbolo{Size of array:C274(atACT_MonedaSimbolo)}:=atACT_MonedaSimboloIE{$i}
			asACT_Afecto{Size of array:C274(asACT_Afecto)}:=asACT_AfectoIE{$i}
			arACT_CTotalDesctos{Size of array:C274(arACT_CTotalDesctos)}:=arACT_CTotalDesctosIE{$i}
			
			  //20150915 RCH
			COPY ARRAY:C226($arACT_TasaIVA;arACT_TasaIVA)
			arACT_TasaIVA{Size of array:C274(arACT_TasaIVA)}:=arACT_TasaIVAIE{$i}
			
		End for 
		  //AT_Initialize (->atACT_CAlumnoIE;->atACT_CGlosaImpresionIE;->atACT_CGlosaIE;->arACT_CSaldoIE;->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->arACT_CMontoNetoIE;->atACT_CAlumnoCursoIE;->atACT_CAlumnoNivelNombreIE;->atACT_CAlumnoPCursoIE;->atACT_CAlumnoPNivelNombreIE;->arACT_CInteresesIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE;->asACT_AfectoIE;->arACT_CTotalDesctosIE)
		AT_Initialize (->atACT_CAlumnoIE;->atACT_CGlosaImpresionIE;->atACT_CGlosaIE;->arACT_CSaldoIE;->adACT_CFechaEmisionIE;->adACT_CFechaVencimientoIE;->arACT_CMontoNetoIE;->atACT_CAlumnoCursoIE;->atACT_CAlumnoNivelNombreIE;->atACT_CAlumnoPCursoIE;->atACT_CAlumnoPNivelNombreIE;->arACT_CInteresesIE;->alACT_RecNumsCargosIE;->alACT_CRefsIE;->alACT_CIDCtaCteIE;->asACT_MarcasIE;->arACT_MontoMonedaIE;->atACT_MonedaCargoIE;->atACT_MonedaSimboloIE;->asACT_AfectoIE;->arACT_CTotalDesctosIE;->arACT_TasaIVAIE)
		
	End if 
	AT_Initialize (->al_idRefItemRA)
	UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
	
End if 