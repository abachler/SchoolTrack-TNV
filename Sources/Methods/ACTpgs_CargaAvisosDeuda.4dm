//%attributes = {}
  //ACTpgs_CargaAvisosDeuda

C_BOOLEAN:C305(vbACT_ModOrderAvisos)
Case of 
	: (Count parameters:C259=1)
		$vd_fecha:=$1
	Else 
		$vd_fecha:=Current date:C33(*)
End case 

  //AL AGREGAR ARREGLOS ACÁ SE DEBE AGREGAR TAMBIEN EN ACTPGS_CREATEDOCCARGO4INT Y EN LA VENTANA DE PAGOS (EN LAS FLECHAS)
ACTpgs_DeclareArraysAvisos 
ACTcfg_LoadConfigData (1)

  //20120710 RCH Se pasa codigo a metodo
ACTac_OpcionesGenerales ("CreaArregloDesdeRecNumCargo";->al_RecNumsCargos;->alACT_RecNumsAvisos)

$recNumApdo:=Record number:C243([Personas:7])
$recNumTercero:=Record number:C243([ACT_Terceros:138])

  //***** verifica recargos x tramo
  //20120614 RCH Recargos Mackay
ACTitems_OpcionesRecalculoTramo ("CalculaDesdeIngresoDePagos";->al_RecNumsCargos;->$vd_fecha)
  //***** verifica recargos x tramo

  //  //***** verifica recargos automaticos
  //  //20120614 RCH Recargos Mackay
  //ACTcfg_OpcionesRecargosAut ("RecalculaDesdeIngresoDePagos";->al_RecNumsCargos;->alACT_RecNumsAvisos;->$vd_fecha)
  //  //***** verifica recargos automaticos

  //***** verifica eliminacion de descuentos
  //20121222 RCH 
ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosIngresoDePagos";->$vd_fecha)
  //***** verifica eliminacion de descuentos

  //***** verifica recargos automaticos
  //20131217 RCH Se mueve para que se calculen despues de la eliminacion de dctos
ACTcfg_OpcionesRecargosAut ("RecalculaDesdeIngresoDePagos";->al_RecNumsCargos;->alACT_RecNumsAvisos;->$vd_fecha)
  //***** verifica recargos automaticos

  //***** 20141005 RCH verifica recargos automaticos por tabla
ACTrat_OpcionesCalculos ("RecalculaDesdeIngresoDePagos";->al_RecNumsCargos;->alACT_RecNumsAvisos;->$vd_fecha)
  //***** verifica recargos automaticos

ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos;$vd_fecha)
KRL_GotoRecord (->[Personas:7];$recNumApdo)
KRL_GotoRecord (->[ACT_Terceros:138];$recNumTercero)
CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
If (RNApdo#-1)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
Else 
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
End if 
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_AIDAviso;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;adACT_AFechaEmision;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;adACT_AFechaVencimiento;[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12;arACT_ASaldoAnterior;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;arACT_AMontoaPagar;[ACT_Avisos_de_Cobranza:124]Moneda:17;atACT_AMoneda;[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16;arACT_AMontoMoneda;[ACT_Avisos_de_Cobranza:124]Intereses:13;arACT_AIntereses)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Monto_Afecto_IVA:9;arACT_AMontoAfecto;[ACT_Avisos_de_Cobranza:124]Monto_Bruto:8;arACT_AMontoBruto;[ACT_Avisos_de_Cobranza:124]Monto_IVA:10;arACT_AMontoIVA)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;arACT_AMontoNeto;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;$alACT_AidPagare)
AT_Insert (0;Size of array:C274(alACT_AIDAviso);->abACT_ASelectedAvisos;->apACT_ASelectedAvisos;->arACT_AMontoSeleccionado;->alACT_ANoPagare)
For ($m;1;Size of array:C274(alACT_AIDAviso))
	abACT_ASelectedAvisos{$m}:=False:C215
	GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedAvisos{$m})
	  //20120724 RCH carga numero pagare
	If ($alACT_AidPagare{$m}#0)
		alACT_ANoPagare{$m}:=KRL_GetNumericFieldData (->[ACT_Pagares:184]ID:12;->$alACT_AidPagare{$m};->[ACT_Pagares:184]Numero_Pagare:11)
	End if 
End for 
If (Not:C34(vbACT_ModOrderAvisos))
	COPY ARRAY:C226(alACT_AIDAviso;alACT_AIDAvisoOrder)
Else 
	For ($i;Size of array:C274(alACT_AIDAvisoOrder);1;-1)
		$found:=Find in array:C230(alACT_AIDAviso;alACT_AIDAvisoOrder{$i})
		If ($found=-1)
			AT_Delete ($i;1;->alACT_AIDAvisoOrder)
		End if 
	End for 
	AT_OrderArraysByArray (-1;->alACT_AIDAvisoOrder;->alACT_AIDAviso;->adACT_AFechaEmision;->adACT_AFechaVencimiento;->arACT_ASaldoAnterior;->arACT_AIntereses;->arACT_AMontoaPagar;->atACT_AMoneda;->arACT_AMontoMoneda;->alACT_RecNumsAvisos;->abACT_ASelectedAvisos;->apACT_ASelectedAvisos)
	COPY ARRAY:C226(alACT_AIDAviso;alACT_AIDAvisoOrder)
End if 
CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];al_RecNumsCargos)
ACTpgs_LoadCargosIntoArrays 

ACTpgs_CargaArreglosInterfaz ($vd_fecha)
