//%attributes = {}
  //ST_LoadModuleFormatExceptions

C_TEXT:C284(vsBWR_CurrentModule)
C_BLOB:C604($vx_Blob)
If (Count parameters:C259=1)
	$module:=$1
Else 
	$module:=vsBWR_CurrentModule
End if 
ARRAY TEXT:C222(at_ExcepcionesFormato;0)
LIST TO ARRAY:C288("STR_ExcepcionesFormatoNombres";at_ExcepcionesFormato)
BLOB_Variables2Blob (->$vx_Blob;0;->at_ExcepcionesFormato)
$vx_Blob:=PREF_fGetBlob (0;"Excepciones formateo "+$module;$vx_Blob)
BLOB_Blob2Vars (->$vx_Blob;0;->at_ExcepcionesFormato)
