//%attributes = {}
  //ACTcfg_pctsXFechaPago

C_REAL:C285(vr_pctXFechaPago1;vr_pctXFechaPago2;vr_pctXFechaPago3;vr_pctXFechaPago4;vr_montoEnPctIE)
C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
C_LONGINT:C283($1;$accion)
$accion:=$1

Case of 
	: ($accion=1)
		BLOB_Variables2Blob (->xBlob;0;->vr_pctXFechaPago1;->vr_pctXFechaPago2;->vr_pctXFechaPago3;->vr_pctXFechaPago4;->vr_montoEnPctIE)
		PREF_SetBlob (0;"ACTcfg_montosXFechaPago";xBlob)
		
	: ($accion=2)
		xBlob:=PREF_fGetBlob (0;"ACTcfg_montosXFechaPago";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->vr_pctXFechaPago1;->vr_pctXFechaPago2;->vr_pctXFechaPago3;->vr_pctXFechaPago4;->vr_montoEnPctIE)
End case 

SET BLOB SIZE:C606(xBlob;0)