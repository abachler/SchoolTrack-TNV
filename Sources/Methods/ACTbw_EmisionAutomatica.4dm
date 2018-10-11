//%attributes = {}
  //ACTbw_EmisionAutomatica

ALL RECORDS:C47([ACT_CuentasCorrientes:175])
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
ARRAY LONGINT:C221($alACT_CuentasTomadas;0)
C_TEXT:C284($vt_2Log)
ACTinit_LoadPrefs 

If (cb_GenerarAvisoAuto=1)
	b1:=0
	b2:=1
	b3:=0
	bHidePrintSettings:=0  //era bHidePrintSettings:=False (ABK_Integracion_AT)
	aMeses:=Month of:C24(Current date:C33(*))
	aMeses2:=aMeses
	viACT_DiaGeneracion:=0  //era viACT_DiaGeneracion:=!00/00/00! (ABK_Integracion_AT)
	vdACT_FechaAviso:=Current date:C33(*)
	vdACT_DiaAviso:=Day of:C23(Current date:C33(*))
	bc_ExecuteOnServer:=0
	vs1:=aMeses{aMeses}
	vs2:=aMeses{aMeses}
	vdACT_AñoAviso:=0
	cbIncluirSaldosAnteriores:=1
	Generar:=False:C215
	BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_NombreMoneda;->arACT_ValorMoneda;->atACT_SimboloMoneda;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores)
	$ProcessID:=Execute on server:C373("ACTcc_EmiteAvisos";Pila_256K;"Emisión de Avisos";xblob)
	DELAY PROCESS:C323(Current process:C322;60)
	GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
	SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeEmitir;True:C214)
End if 
If (Size of array:C274($alACT_CuentasTomadas)>0)
	ACTcc_OpcionesEmision ("LlenaArreglosAMostrar";->$alACT_CuentasTomadas)
	$vt_2Log:="Las siguientes cuentas presentaron problemas al momento de realizar la emisión au"+"tomática."+"\r"
	$vt_2Log:=$vt_2Log+AT_Arrays2Text (":";", ";->aMotivo;->aDeletedNames)
	LOG_RegisterEvt ($vt_2Log)
	AT_Initialize (->aDeletedNames;->aMotivo)
End if 