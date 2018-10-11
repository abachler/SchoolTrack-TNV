//%attributes = {}
  //ACTpgs_EliminaCargosNoSel

C_POINTER:C301(ptrArrayOrig;ptrArrayComparacion;ptrArrayBool)
C_TEXT:C284($vt_accion;$1;$vt_valor)
C_TEXT:C284($vt_retorno;$0)

$vt_accion:=$1

Case of 
	: ($vt_accion="LlenaArreglos")
		If (vrACT_MontoAdeudado>0)
			Case of 
				: (vbACT_CargosDesdeAviso)
					ptrArrayOrig:=->alACT_AIDAviso
					ptrArrayComparacion:=->alACT_CIdsAvisos
					ptrArrayBool:=->abACT_ASelectedAvisos
					
				: (vbACT_CargosDesdeItems)
					ptrArrayOrig:=->alACT_RefItem
					ptrArrayComparacion:=->alACT_CRefs
					ptrArrayBool:=->abACT_ASelectedItem
					
				: (vbACT_CargosDesdeAlumnos)
					ptrArrayOrig:=->alACT_AIdsCtas
					ptrArrayComparacion:=->alACT_CIDCtaCte
					ptrArrayBool:=->abACT_ASelectedAlumno
					
				: (vbACT_CargosDesdeAgrupado)
					ptrArrayOrig:=->atACT_YearMonthAgrupado
					ptrArrayComparacion:=->adACT_CFechaEmision
					ptrArrayBool:=->abACT_ASelectedAgrupado
					
			End case 
			ACTpgs_OrdenaCargosAviso (1;True:C214)
		Else 
			ptrArrayOrig:=->alACT_AIDAviso
			ptrArrayComparacion:=->alACT_CIdsAvisos
			ptrArrayBool:=->abACT_ASelectedAvisos
		End if 
		
	: ($vt_accion="EliminaCargos")
		ptrArrayBool->{0}:=False:C215
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (ptrArrayBool;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			For ($i;Size of array:C274($DA_Return);1;-1)
				ARRAY LONGINT:C221($al_positions2Del;0)
				If (vbACT_CargosDesdeAgrupado)
					$vt_valor:=ptrArrayOrig->{$DA_Return{$i}}
					ACTat_SearchArrayByRange ("DesdeAAAAMM";->$vt_valor;->adACT_CFechaEmision;->$al_positions2Del)
				Else 
					ptrArrayComparacion->{0}:=ptrArrayOrig->{$DA_Return{$i}}
					AT_SearchArray (ptrArrayComparacion;"=";->$al_positions2Del)
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
		
	: ($vt_accion="ValidaSeleccionCargos")
		C_BOOLEAN:C305($vb_continuar)
		$vb_continuar:=True:C214
		ARRAY LONGINT:C221($DA_Return;0)
		Case of 
			: (vbACT_CargosDesdeAviso)
				abACT_ASelectedAvisos{0}:=True:C214
				AT_SearchArray (->abACT_ASelectedAvisos;"=";->$DA_Return)
			: (vbACT_CargosDesdeItems)
				abACT_ASelectedItem{0}:=True:C214
				AT_SearchArray (->abACT_ASelectedItem;"=";->$DA_Return)
			: (vbACT_CargosDesdeAlumnos)
				abACT_ASelectedAlumno{0}:=True:C214
				AT_SearchArray (->abACT_ASelectedAlumno;"=";->$DA_Return)
			: (vbACT_CargosDesdeAgrupado)
				abACT_ASelectedAgrupado{0}:=True:C214
				AT_SearchArray (->abACT_ASelectedAgrupado;"=";->$DA_Return)
		End case 
		If (Size of array:C274($DA_Return)=0)
			$vb_continuar:=(CD_Dlog (0;__ ("No hay deuda seleccionada para pagar.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))=1)
		End if 
		$vt_retorno:=String:C10(Num:C11($vb_continuar))
		
End case 
$0:=$vt_retorno