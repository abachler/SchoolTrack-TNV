C_LONGINT:C283($page)
$page:=Selected list items:C379(Self:C308->)
$vb_bool:=True:C214

ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
AL_UpdateArrays (ALP_CargosXPagar;0)
ACTpgs_MarkNotMark ("InitArrays";->$page;->$vb_bool)
$line:=0
  //20120225 RCH Se agrega if para no seleccionar la linea 1 si no hay datos.
Case of 
	: (vbACT_CargosDesdeAviso)
		If (Size of array:C274(apACT_ASelectedAvisos)>0)
			AL_SetLine (ALP_AvisosXPagar;1)
			$line:=AL_GetLine (ALP_AvisosXPagar)
		End if 
		
	: (vbACT_CargosDesdeItems)
		If (Size of array:C274(apACT_ASelectedItem)>0)
			AL_SetLine (ALP_ItemsXPagar;1)
			$line:=AL_GetLine (ALP_ItemsXPagar)
		End if 
		
	: (vbACT_CargosDesdeAlumnos)
		If (Size of array:C274(apACT_ASelectedAlumnos)>0)
			AL_SetLine (ALP_AlumnosXPagar;1)
			$line:=AL_GetLine (ALP_AlumnosXPagar)
		End if 
		
	: (vbACT_CargosDesdeAgrupado)
		If (Size of array:C274(apACT_ASelectedAgrupado)>0)
			AL_SetLine (ALP_AvisosAgrupadosXPagar;1)
			$line:=AL_GetLine (ALP_AvisosAgrupadosXPagar)
		End if 
		
End case 

AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
ACTpgs_RetornaArreglosCargos 
AT_Initialize (->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp)
AT_Initialize (->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
ACTpgs_CopiaArreglosCargos 
AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)

ACTpgs_SeleccionaCargosAviso ($line)
ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
AL_UpdateArrays (ALP_CargosXPagar;-2)
ACTpgs_SetObjectsCargosDocument 
ACTpgs_LimpiaVarsInterfaz ("SeteaTodasFlechas")