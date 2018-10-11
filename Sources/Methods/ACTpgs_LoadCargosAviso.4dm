//%attributes = {}
  //ACTpgs_LoadCargosAviso

C_POINTER:C301($ptr1)
If (Count parameters:C259>=1)
	$ptr1:=$1
End if 
C_BOOLEAN:C305(vbACT_CargosDesdeAviso;vbACT_CargosDesdeItems;vbACT_CargosDesdeAlumnos)

Case of 
	: (vbACT_CargosDesdeAviso)
		$vl_alp:=ALP_AvisosXPagar
		$vt_title:="Cargos incluídos en el aviso N° "
		  //$ptr:=->alACT_CIdsAvisos
		$ptr:=->alACT_AIDAviso
	: (vbACT_CargosDesdeItems)
		$vl_alp:=ALP_ItemsXPagar
		$vt_title:="Cargos incluídos para el ítem N° "
		$ptr:=->alACT_RefItem
	: (vbACT_CargosDesdeAlumnos)
		$vl_alp:=ALP_AlumnosXPagar
		$vt_title:="Cargos incluídos para la cuenta N° "
		$ptr:=->alACT_AIdsCtas
	: (vbACT_CargosDesdeAgrupado)
		$vl_alp:=ALP_AvisosAgrupadosXPagar
		$vt_title:="Cargos incluídos para el período "
		$ptr:=->atACT_YearMonthAgrupado
		
		
End case 
$line:=AL_GetLine ($vl_alp)
If ((vbACT_CargosDesdeAgrupado))
	$vt_title:=$vt_title+$ptr->{$line}
Else 
	$vt_title:=$vt_title+String:C10($ptr->{$line})
End if 
aviso:=$line
PROCESS PROPERTIES:C336(Current process:C322;$name;$state;$time)
Case of 
	: ($name="Ingreso de Pagos")
		ACTpgs_CopiaArreglosCargos 
		ACTpgs_SeleccionaCargosAviso ($line)
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_CargosAviso";0;4;$vt_title)
		DIALOG:C40([xxSTR_Constants:1];"ACT_CargosAviso")
		CLOSE WINDOW:C154
		ACTpgs_OrdenaCargosAviso ($line)
		AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
		AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		ACTpgs_RetornaArreglosCargos 
		AT_Initialize (->alACT_CIdsAvisosTemp;->adACT_CFechaEmisionTemp;->adACT_CFechaVencimientoTemp;->atACT_CAlumnoTemp;->atACT_CGlosaTemp;->arACT_CMontoNetoTemp;->arACT_CInteresesTemp;->arACT_CSaldoTemp;->alACT_RecNumsCargosTemp;->alACT_CRefsTemp;->alACT_CIDCtaCteTemp;->asACT_MarcasTemp;->arACT_MontoMonedaTemp;->atACT_MonedaCargoTemp;->atACT_MonedaSimboloTemp)
		AT_Initialize (->arACT_MontoPagadoTemp;->alACT_CIdsCargosTemp;->alACT_CIdDctoCargoTemp;->arACT_MontoIVATemp;->arACT_CMontoAfectoTemp;->adACT_CfechaInteresTemp;->alACT_CidCargoGenIntTemp;->apACT_ASelectedCargoTemp;->abACT_ASelectedCargoTemp)
	: ($name="Documentar Deudas")
		ACTpgs_SeleccionaCargosAviso ($line)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
	Else 
		AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
		AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		ACTpgs_SeleccionaCargosAviso ($line)
		
		AL_UpdateArrays (ALP_CargosXPagar;-2)
End case 
If (Is nil pointer:C315($ptr1))
	ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
Else 
	If (Size of array:C274($ptr1->)>0)
		ACTpgs_RecalculaDeuda ("recalculoSeleccionado";vdACT_FechaPago)
	End if 
End if 