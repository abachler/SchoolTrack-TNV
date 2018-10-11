ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")

ACTpgs_LoadInteresRecord 
ARRAY LONGINT:C221(alACT_IntAvisoID;0)
ARRAY DATE:C224(adACT_IntFecha;0)
ARRAY DATE:C224(adACT_IntFechaV;0)
ARRAY TEXT:C222(atACT_IntGlosa;0)
ARRAY REAL:C219(arACT_IntMonto;0)
ARRAY REAL:C219(arACT_IntSaldo;0)
ARRAY LONGINT:C221(alACT_IntRecNum;0)
ARRAY LONGINT:C221(alACT_IntCargoID;0)
ARRAY DATE:C224(adACT_IntFechaT;0)
ARRAY DATE:C224(adACT_IntFechaVT;0)
ARRAY TEXT:C222(atACT_IntGlosaT;0)
ARRAY REAL:C219(arACT_IntMontoT;0)
ARRAY REAL:C219(arACT_IntSaldoT;0)
ARRAY LONGINT:C221(alACT_IntCargoIDT;0)
ARRAY LONGINT:C221(alACT_IntRecNumT;0)
ARRAY LONGINT:C221($alACT_IntCargoDocID;0)
$recNumAlumno:=Record number:C243([Alumnos:2])
$recNumCtaCte:=Record number:C243([ACT_CuentasCorrientes:175])
$recNumApdo:=Record number:C243([Personas:7])
$recNumTercero:=Record number:C243([ACT_Terceros:138])
ARRAY LONGINT:C221($at_cargosDelAviso;0)
ARRAY LONGINT:C221($at_cargosIntereses;0)
alACT_CRefsTemp{0}:=[xxACT_Items:179]ID:1
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->alACT_CRefsTemp;"=";->$DA_Return)
AT_Initialize (->adACT_IntFechaT;->atACT_IntGlosaT;->arACT_IntMontoT;->alACT_IntCargoIDT;->alACT_IntRecNumT;->arACT_IntSaldoT)
COPY ARRAY:C226(alACT_RecNumsCargosTemp;alACT_IntRecNumT)
ARRAY LONGINT:C221($alACT_IntCargoDocID;0)
For ($j;1;Size of array:C274($DA_Return))
	AT_Insert (1;1;->alACT_IntAvisoID;->adACT_IntFecha;->atACT_IntGlosa;->arACT_IntMonto;->alACT_IntCargoID;->adACT_IntFechaV;->alACT_IntRecNum;->arACT_IntSaldo)
	alACT_IntAvisoID{1}:=alACT_CIdsAvisosTemp{$DA_Return{$j}}
	adACT_IntFecha{1}:=adACT_CFechaEmisionTemp{$DA_Return{$j}}
	adACT_IntFechaV{1}:=adACT_CFechaVencimientoTemp{$DA_Return{$j}}
	atACT_IntGlosa{1}:=atACT_CGlosaTemp{$DA_Return{$j}}
	arACT_IntMonto{1}:=arACT_CMontoNetoTemp{$DA_Return{$j}}
	alACT_IntCargoID{1}:=alACT_CIdsCargosTemp{$DA_Return{$j}}
	alACT_IntRecNum{1}:=alACT_IntRecNumT{$DA_Return{$j}}
	arACT_IntSaldo{1}:=arACT_CSaldoTemp{$DA_Return{$j}}
End for 
AT_MultiLevelSort (">>>>";->adACT_IntFecha;->alACT_IntAvisoID;->atACT_IntGlosa;->arACT_IntMonto;->alACT_IntCargoID;->adACT_IntFechaV;->alACT_IntRecNum;->arACT_IntSaldo)
AT_Initialize (->adACT_IntFechaT;->atACT_IntGlosaT;->arACT_IntMontoT;->alACT_IntCargoIDT;->adACT_IntFechaVT;->alACT_IntRecNumT;->arACT_IntSaldoT)
If (Size of array:C274(adACT_IntFecha)>0)
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTpgs_PlanillaIntereses";0;4;__ ("Planilla de Intereses"))
	DIALOG:C40([xxSTR_Constants:1];"ACTpgs_PlanillaIntereses")
	CLOSE WINDOW:C154
	If (modCargos)
		ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
		Case of 
			: (vbACT_PagoXApdo)
				GOTO RECORD:C242([Personas:7];$recNumApdo)
				ACTpgs_CargaDatosPagoApdo (True:C214;vdACT_FechaPago)
			: (vbACT_PagoXCuenta)
				GOTO RECORD:C242([Alumnos:2];$recNumAlumno)
				GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCtaCte)
				GOTO RECORD:C242([Personas:7];$recNumApdo)
				ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
			: (vbACTpgs_PagoXTercero)
				GOTO RECORD:C242([ACT_Terceros:138];$recNumTercero)
				ACTpgs_CargaDatosPagoTercero (True:C214;vdACT_FechaPago)
		End case 
		ACTpgs_CopiaArreglosCargos 
		IT_SetButtonState (False:C215;->bSubirAviso;->bBajarAviso)
	End if 
Else 
	$glosaInt:=[xxACT_Items:179]Glosa:2
	CD_Dlog (0;__ ("No hay cargos por concepto de ")+$glosaInt+__ ("."))
End if 
AT_Initialize (->adACT_IntFecha;->atACT_IntGlosa;->arACT_IntMonto;->alACT_IntCargoID;->alACT_IntAvisoID;->adACT_IntFechaV;->alACT_IntRecNum;->arACT_IntSaldo)
AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
AL_SetLine (ALP_AvisosXPagar;0)