//%attributes = {}
  //ACTpgs_CargaDatosPagoTercero

C_BOOLEAN:C305($1;$display;$vb_desdePrepago)
C_DATE:C307($2;$fecha)
C_REAL:C285($deuda)
C_LONGINT:C283($vl_idAvisoAPagar;$vl_idItemPagar)
C_DATE:C307($vdACT_FechaUF)
Case of 
	: (Count parameters:C259=6)
		$display:=$1
		$fecha:=$2
		$vl_idAvisoAPagar:=$3
		$vl_idItemPagar:=$4
		$vdACT_FechaUF:=$5
		$vb_desdePrepago:=$6
	: (Count parameters:C259=5)
		$display:=$1
		$fecha:=$2
		$vl_idAvisoAPagar:=$3
		$vl_idItemPagar:=$4
		$vdACT_FechaUF:=$5
	: (Count parameters:C259=4)
		$display:=$1
		$fecha:=$2
		$vl_idAvisoAPagar:=$3
		$vl_idItemPagar:=$4
	: (Count parameters:C259=3)
		$display:=$1
		$fecha:=$2
		$vl_idAvisoAPagar:=$3
	: (Count parameters:C259=2)
		$display:=$1
		$fecha:=$2
	: (Count parameters:C259=1)
		$display:=$1
		$fecha:=Current date:C33(*)
	Else 
		$display:=True:C214
		$fecha:=Current date:C33(*)
End case 
If ($vdACT_FechaUF=!00-00-00!)
	$vdACT_FechaUF:=$fecha
End if 
If ($display)
	$procID:=IT_UThermometer (1;0;__ ("Buscando deuda ...");-1)
End if 
ACTpgs_DeclareArraysInterfaz 
ACTpgs_DeclareArraysCargos 
ACTpgs_CargaDatos 

  //ACTpgs_DeclareArraysCargos 
ACTpgs_DeclaraArreglosCargosT 
$deuda:=ACTpgs_BuscaDeuda ([ACT_Terceros:138]Id:1;$vl_idAvisoAPagar;$vdACT_FechaUF;$vl_idItemPagar)
If (($deuda<0) | (($vb_desdePrepago) & (vrACTpgs2_deuda<0)))
	ACTpgs_CargaAvisosDeuda ($vdACT_FechaUF)
	ACTpgs_CalculaDesctoRXA ("CalculaDescto";->$fecha)
	ACTpgs_CalculaInteresesInArrays ($fecha;$display)
	
	  //ACTpgs_RecalculaAvisosInArrays ($vdACT_FechaUF)
	ACTpgs_DescuentosXTramo ("CargaIngresoPagos";->$vdACT_FechaUF)  //20170714 RCH
	ACTpgs_RecalculaAvisosInArrays ($vdACT_FechaUF)
	
	ACTpgs_RecalculaDeuda ("cargaDatos";$vdACT_FechaUF)
	OBJECT SET VISIBLE:C603(cb_OcupaSaldos;False:C215)
	ACTpgs_OpcionesFormPago ("SetColorNombreTercero")
	
	IT_SetEnterable (vb_AuthorizedDesctos;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
Else 
	If ($display)
		$format:="|Despliegue_ACT"
		Case of 
			: (vrACTpgs2_deuda#0)
				CD_Dlog (0;__ ("El Tercero ")+vsACT_NomApellido+__ (" tiene saldo a favor de ")+String:C10($deuda;$format)+__ (" y a la vez tiene cargos con saldo.\r\rBusque los pagos con Disponible y use la opción "+ST_Qte ("Utilizar Disponible")+", que aparece en el popup lateral de la pestaña Pagos."))
			: ($deuda=0)
				CD_Dlog (0;__ ("El Tercero ")+vsACT_NomApellido+__ (" no tiene deuda."))
			Else 
				CD_Dlog (0;__ ("El Tercero ")+vsACT_NomApellido+__ (" tiene un saldo a favor de ")+String:C10($deuda;$format)+__ ("."))
		End case 
	End if 
	_O_DISABLE BUTTON:C193(bAvisos)
	IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
	vrACT_MontoAdeudado:=0
	vrACT_MontoAdeudadoAfecto:=0
	vrACT_MontoAdeudadoExento:=0
	vrACT_SaldoDisp:=0
	vrACT_OtrosSaldosDisp:=0
	OBJECT SET VISIBLE:C603(cb_OcupaSaldos;False:C215)
	vrACT_MontoPago:=vrACT_MontoAdeudado
	vrACT_MontoAPagarAfecto:=vrACT_MontoAdeudadoAfecto
	vrACT_MontoAPagarExento:=vrACT_MontoAdeudadoExento
	vrACT_MontoAPagar:=vrACT_MontoAdeudado
	vrACT_SeleccionadoAfecto:=0
	vrACT_SeleccionadoExento:=0
	vrACT_SeleccionadoAPagar:=0
End if 
BRING TO FRONT:C326(Current process:C322)
IT_SetButtonState (True:C214;->bIngresarPago)
IT_SetEnterable (True:C214;0;->vtACT_BancoNombre;->vtACT_BancoCuenta;->vtACT_BancoTitular;->vtACT_BancoRUTTitular;->vtACT_NoSerie;->vdACT_FechaDocumento;->vrACT_MontoPrimero)
vsACT_RutApoderado:=""
vsACT_NomApellido:=""
vsACT_RutCta:=""
vsACT_NomApellidoCta:=""
btn_apdo:=0
btn_tercero:=1
vbACT_PagoXApdo:=False:C215
vbACT_PagoXCuenta:=False:C215
vbACTpgs_PagoXTercero:=True:C214
vt_MsgApdo:=""
modcargos:=False:C215
If ($display)
	IT_UThermometer (-2;$procID)
End if 