//%attributes = {}
  //SERwa_EjecutaScript

C_TEXT:C284($0;$t_errorScript)
C_POINTER:C301($y_Names;$y_Data;$1;$2)
C_TEXT:C284($t_dts;$t_script;$t_llave)
C_BLOB:C604($xBlob)

$y_Names:=$1
$y_Data:=$2

$t_dts:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dts")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"llave")
$t_script:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"script")

CONVERT FROM TEXT:C1011($t_script;"UTF-8";$xBlob)
$b_ejecutado:=SERwa_Ejecuta ($t_llave;$t_dts;$xBlob;->$t_errorScript)  //vt_json

If ($b_ejecutado)
	If (vt_json="")  //si el script no retorna información en esta variable, se avisa.
		vt_json:="Script no genera respuesta en variable vt_json"
	End if 
	ARRAY TEXT:C222($at_Tags;1)
	ARRAY POINTER:C280($ay_Values;1)
	$at_Tags{1}:="json"
	$ay_Values{1}:=->vt_json
	$0:=SERwa_GeneraRespuesta ("0";$t_errorScript;->$at_Tags;->$ay_Values)
Else 
	$0:=SERwa_GeneraRespuesta ("-100";$t_errorScript)
End if 


