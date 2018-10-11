//%attributes = {}
  //ACTpgs_IngresarDocumentos

C_LONGINT:C283($proc)
C_LONGINT:C283(vl_cargosEliminados)
C_BOOLEAN:C305(vb_NoMostrarAlertas)
C_LONGINT:C283($repeticion;$vl_indexLC)
C_LONGINT:C283($unaXDoc;$unaXTotal)
C_TEXT:C284($vsACT_LugardePago)
C_REAL:C285($vrACT_MontoAdeudado)
C_TEXT:C284($vsACT_NomApellido)
C_BOOLEAN:C305(vb_documentando)  //se utiliza al ingresar el pago
ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)

vb_documentando:=False:C215
$unaXDoc:=fUnaBoletaporDocumento
$unaXTotal:=fUnaBoleta
  //$vl_indexLC:=vl_indexLC
$vsACT_LugardePago:=vsACT_LugardePago
$vrACT_MontoAdeudado:=vrACT_MontoAdeudado
$vsACT_NomApellido:=vsACT_NomApellido
vl_cargosEliminados:=0
ACTinit_LoadFdPago 
$cb_filtrarCargos:=True:C214
If (vrACT_MontoAdeudado>0)
	If (vrACT_MontoAdeudado>0)
		Case of 
			: (vbACT_CargosDesdeAviso)
				$ptrArrayOrig:=->alACT_AIDAviso
				$ptrArrayComparacion:=->alACT_CIdsAvisos
				$ptrArrayBool:=->abACT_ASelectedAvisos
			: (vbACT_CargosDesdeItems)
				$ptrArrayOrig:=->alACT_RefItem
				$ptrArrayComparacion:=->alACT_CRefs
				$ptrArrayBool:=->abACT_ASelectedItem
			: (vbACT_CargosDesdeAlumnos)
				$ptrArrayOrig:=->alACT_AIdsCtas
				$ptrArrayComparacion:=->alACT_CIDCtaCte
				$ptrArrayBool:=->abACT_ASelectedAlumno
			: (vbACT_CargosDesdeAgrupado)
				$ptrArrayOrig:=->atACT_YearMonthAgrupado
				$ptrArrayComparacion:=->adACT_CFechaEmision
				$ptrArrayBool:=->abACT_ASelectedAgrupado
				$vl_alp:=ALP_AvisosAgrupadosXPagar
			Else 
				$cb_filtrarCargos:=False:C215
		End case 
		ACTpgs_OrdenaCargosAviso (1;True:C214)
	Else 
		$ptrArrayOrig:=->alACT_AIDAviso
		$ptrArrayComparacion:=->alACT_CIdsAvisos
		$ptrArrayBool:=->abACT_ASelectedAvisos
		$vl_alp:=ALP_AvisosXPagar
	End if 
	
	If ($cb_filtrarCargos)
		$ptrArrayBool->{0}:=False:C215
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray ($ptrArrayBool;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			For ($i;Size of array:C274($DA_Return);1;-1)
				ARRAY LONGINT:C221($al_positions2Del;0)
				If (vbACT_CargosDesdeAgrupado)
					C_TEXT:C284($vt_valor)
					$vt_valor:=$ptrArrayOrig->{$DA_Return{$i}}
					ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valor;->adACT_CFechaEmision;->$al_positions2Del)
				Else 
					$ptrArrayComparacion->{0}:=$ptrArrayOrig->{$DA_Return{$i}}
					AT_SearchArray ($ptrArrayComparacion;"=";->$al_positions2Del)
				End if 
				Case of 
					: (vbACT_CargosDesdeAviso)
						ACTpgs_ArreglosAvisos ("EliminaElementosNoSeleccionados";->$DA_Return{$i})
					: (vbACT_CargosDesdeItems)
						ACTpgs_ArreglosItems ("EliminaElementosNoSeleccionados";->$DA_Return{$i})
					: (vbACT_CargosDesdeAlumnos)
						ACTpgs_ArreglosCuentas ("EliminaElementosNoSeleccionados";->$DA_Return{$i})
					: (vbACT_CargosDesdeAgrupado)
						ACTpgs_ArreglosAgrupado ("EliminaElementosNoSeleccionados";->$DA_Return{$i})
				End case 
				For ($j;Size of array:C274($al_positions2Del);1;-1)
					AT_Delete ($al_positions2Del{$j};1;->alACT_RecNumsCargos;->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
				End for 
			End for 
		End if 
		abACT_ASelectedCargo{0}:=False:C215
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->abACT_ASelectedCargo;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			For ($i;Size of array:C274($DA_Return);1;-1)
				AT_Delete ($DA_Return{$i};1;->alACT_RecNumsCargos;->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo;->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
			End for 
		End if 
		ACTpgs_CalculaInteresCargos (vdACT_FechaPago;False:C215)
		
		ACTpgs_DescuentosXTramo ("CreaDescuentosIngresoPagos")  //20170714 RCH
		
	End if 
End if 

If (rCheques=1)
	vlACT_FormasdePago:=-4
	$repeticion:=Size of array:C274(arACT_MontoCheque)
Else 
	vlACT_FormasdePago:=-8
	$repeticion:=Size of array:C274(arACT_LCFolio)
End if 
  //$formaIdx:=Find in array(atACT_FormasdePago;vsACT_FormasdePago+"@")
vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)

vbACTpgs_NoUtilizarDctos:=True:C214
ACTpgs_CreaCargoDesctoEspecial 
vbACTpgs_NoUtilizarDctos:=False:C215
ACTcfg_OpcionesRecargosCaja ("GeneraMultaXCaja")
ACTcfg_OpcionesRecargosCaja ("InsertaCargoXCaja4Pago")
ACTpgs_CopiaArreglosCargos 
$proc:=IT_UThermometer (1;0;__ ("Ingresando pagos. Un momento por favor..."))

  //20131105 RCH
$vbACTpgs_PagoXTercero:=vbACTpgs_PagoXTercero
$vbACT_PagoXCuenta:=vbACT_PagoXCuenta
$vbACT_PagoXApdo:=vbACT_PagoXApdo

For ($i;1;$repeticion)
	
	  //20131105 RCH
	vbACTpgs_PagoXTercero:=$vbACTpgs_PagoXTercero
	vbACT_PagoXCuenta:=$vbACT_PagoXCuenta
	vbACT_PagoXApdo:=$vbACT_PagoXApdo
	
	ACTcfg_ItemsMatricula ("InicializaYLee")
	vbACT_documentando:=True:C214
	vb_NoMostrarAlertas:=True:C214
	fUnaBoletaporDocumento:=$unaXDoc  //por si se resetean estas variables en el ingreso de pago
	fUnaBoleta:=$unaXTotal
	vsACT_LugardePago:=$vsACT_LugardePago
	vrACT_MontoAdeudado:=$vrACT_MontoAdeudado
	vsACT_NomApellido:=$vsACT_NomApellido
	
	  //20131202 ASM ticket 127579 
	  //If (Records in selection([Personas])=0)
	  //QUERY([Personas];[Personas]No=[ACT_CuentasCorrientes]ID_Apoderado)
	  //ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
	  //End if 
	
	ACTpgs_LimpiaVarsInterfaz ("Recarga")
	ACTpgs_MapVariables ($i)
	If (vrACT_MontoAdeudado>0)
		If (Size of array:C274(alACT_RecNumsCargos)>0)
			ACTpgs_RetornaArreglosCargos 
			  //actualiza saldos de primer cargo porque después de la primera vuelta puede variar.
			If (alACT_RecNumsCargos{1}>0)
				READ ONLY:C145([ACT_Cargos:173])
				GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{1})
				arACT_CSaldo{1}:=[ACT_Cargos:173]Saldo:23
			End if 
			
			$MontoPagado:=vrACT_MontoPago
			For ($j;1;Size of array:C274(alACT_RecNumsCargos))
				$vl_idCargo:=alACT_CIdsCargos{$j}
				KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					$vr_saldo:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
				Else 
					$vr_saldo:=Abs:C99(arACT_CSaldo{$j})
				End if 
				Case of 
					: ($vr_saldo>=$MontoPagado)
						$MontoPagado:=0
					: ($vr_saldo<$MontoPagado)
						$MontoPagado:=$MontoPagado-$vr_saldo
				End case 
				If ($MontoPagado=0)
					$donde:=1
					$cuantos:=$j-1
					$j:=Size of array:C274(alACT_RecNumsCargos)
					AT_Delete ($donde;$cuantos;->alACT_RecNumsCargosTemp;->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp;->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp)
				End if 
			End for 
		End if 
	End if 
	Case of 
		: (fUnaBoleta=1)
			ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215)
		: (fUnaBoletaporDocumento=1)
			ACTpgs_IngresarPagos (vlACT_FormasdePago;True:C214)
		Else 
			ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215)
	End case 
	For ($x;1;Size of array:C274(alACTpgs_Avisos2Recalc))
		If (Find in array:C230($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$x})=-1)
			APPEND TO ARRAY:C911($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$x})
		End if 
	End for 
End for 
For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
	ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
End for 
  //20131210 RCH Cambio arreglo alACT_RecNumsAvisos por $alACTpgs_Avisos2Recalc
For ($tt;1;Size of array:C274($alACTpgs_Avisos2Recalc))
	ACTac_Prepagar ($alACTpgs_Avisos2Recalc{$tt};True:C214)
End for 

IT_UThermometer (-2;$proc)