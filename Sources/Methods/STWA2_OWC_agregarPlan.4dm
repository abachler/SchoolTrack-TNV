//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:52:07
  // ----------------------------------------------------
  // Método: STWA2_OWC_agregarPlan
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
$d:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"d")
$m:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"m")
$a:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"a")
If (KRL_GotoRecord (->[Asignaturas:18];$rn;False:C215))
	If (($d#"") & ($m#"") & ($a#""))
		$fecha:=DT_GetDateFromDayMonthYear (Num:C11($d);Num:C11($m);Num:C11($a))
		$json:=STWA2_AJAX_AgregarPlan ($fecha)
	Else 
		$json:=STWA2_AJAX_AgregarPlan 
	End if 
Else 
	$json:=STWA2_JSON_SendError (-60000)
End if 

$0:=$json