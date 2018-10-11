//%attributes = {}
  //BM_EmitirAvisos

  //DECLARATIONS
C_LONGINT:C283($batchID;$1;$id;$status)
C_TEXT:C284($error)
TRACE:C157
  //INITIALIZATION
$batchID:=$1
  //MAIN CODE

MESSAGES OFF:C175
READ WRITE:C146([xShell_BatchRequests:48])
GOTO RECORD:C242([xShell_BatchRequests:48];$batchID)

SET BLOB SIZE:C606(xBlob;0)

$datetime:=[xShell_BatchRequests:48]Msg:2
xBlob:=[xShell_BatchRequests:48]Parameters:8
vdDate:=Date:C102(Substring:C12($datetime;1;Position:C15("_";$datetime)-1))
vHrsStr:=Substring:C12($datetime;Position:C15("_";$datetime)+1;2)
vMinutesStr:=Substring:C12($datetime;Position:C15(":";$datetime)+1)

$ExecTime:=Time:C179(vHrsStr+":"+vMinutesStr+":00")

ARRAY DATE:C224(adACT_fechasEm;0)

If (vdDate<=Current date:C33(*))
	If (Current time:C178(*)>=$ExecTime)
		  //BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->vdACT_DiaVctoAviso;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm)
		ACTcar_OpcionesGenerales ("CargaVarsParaEmision";->xBlob)
		ACTcc_EmisionAvisos (2;Generar)
		$succes:=True:C214
		SET BLOB SIZE:C606(xBlob;0)
		AT_Initialize (->aLong1)
		
		If (Size of array:C274(alACT_CuentasTomadas)>0)
			ACTcc_OpcionesEmision ("LlenaArreglosAMostrar";->alACT_CuentasTomadas)
			$vt_2Log:="Las siguientes cuentas presentaron problemas al momento de realizar la emisión au"+"tomática."+"\r"
			$vt_2Log:=$vt_2Log+AT_Arrays2Text (";";"";->aMotivo;->aDeletedNames)
			LOG_RegisterEvt ($vt_2Log)
			AT_Initialize (->aDeletedNames;->aMotivo;->alACT_CuentasTomadas)
		End if 
		
	Else 
		$succes:=False:C215
	End if 
Else 
	$succes:=False:C215
End if 
$0:=$succes