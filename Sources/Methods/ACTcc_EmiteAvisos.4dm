//%attributes = {}
  //ACTcc_EmiteAvisos

C_BOOLEAN:C305(vbACT_TerminoEmitir;vbACT_TerminardeEmitir)
C_LONGINT:C283($table)
C_LONGINT:C283(cb_NoPrepagarAuto)
C_BLOB:C604(xBlob)
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221(alACT_CuentasTomadas;0)
C_TEXT:C284(vtACT_CurrentUser)
vbACT_TerminoEmitir:=False:C215
vbACT_TerminardeEmitir:=False:C215
ACTinit_LoadPrefs 
ACTcfg_ItemsMatricula ("InicializaYLee")

bc_SetProgTask:=0
vHrs:=0
vMinutes:=0
vdDate:=!00-00-00!
vtACT_CurrentUser:=""
xBlob:=$1
If (Count parameters:C259>1)
	vpXS_IconModule:=$2
	vsBWR_CurrentModule:=$3
	RegisteredName:=$4
End if 
If (Count parameters:C259>4)
	bc_SetProgTask:=$5
	vdDate:=$6
	vHrs:=$7
	vMinutes:=$8
End if 
If (Count parameters:C259>8)
	vtACT_CurrentUser:=$9
End if 
ARRAY TEXT:C222(atACT_ModelosAviso;0)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
cbVctoSegunConf:=1
  //BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->vdACT_DiaVctoAviso;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm)

ACTcar_OpcionesGenerales ("CargaVarsParaEmision";->xBlob)
Case of 
	: (b1=1)
		ACTcc_EmisionAvisos (1;Generar)
		$modelo:=atACT_ModelosAviso{atACT_ModelosAviso}
		SET BLOB SIZE:C606(yBlob;0)
		BLOB_Variables2Blob (->yBlob;0;->alACT_AvisosImprimir)
		If (Application type:C494=4D Server:K5:6)
			EXECUTE ON CLIENT:C651(RegisteredName;"ACTcc_ImprimeAvisos";1;yBlob;$modelo;bHidePrintSettings)
		Else 
			ACTcc_ImprimeAvisos (1;yBlob;$modelo;bHidePrintSettings)
		End if 
		SET BLOB SIZE:C606(yBlob;0)
	: (b2=1)
		If (bc_SetProgTask=0)
			ACTcc_EmisionAvisos (2;Generar)
		Else 
			vMinutes:=vMinutes+1
			$datetime:=String:C10(vdDate;7)+"_"+String:C10(vHrs;"00")+":"+String:C10(vMinutes;"00")
			BM_CreateRequest ("Emitir Avisos de Cobranza";$datetime;"";xBlob)
		End if 
	: (b3=1)
		ACTcc_ImprimeAvisos (2)
End case 
SET BLOB SIZE:C606(xBlob;0)
vbACT_TerminoEmitir:=True:C214
While (Not:C34(vbACT_TerminardeEmitir))
	IDLE:C311
	DELAY PROCESS:C323(Current process:C322;5)
End while 