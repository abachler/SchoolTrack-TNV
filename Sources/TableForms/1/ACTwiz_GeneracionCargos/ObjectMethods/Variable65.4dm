  //20161220 RCH
C_TEXT:C284($t_log)
$t_log:="Inicio asistente de generación de cargos. "
$t_log:=$t_log+"Opción: "+Choose:C955(b1=1;"Matriz";Choose:C955(b2=1;"2";"3"))+". "
$t_log:=$t_log+"Cargo emitido: "+Choose:C955((b2=1) | (b3=1);String:C10(vlACT_selectedItemId);" matriz")+". "
If (b3=1)
	$t_log:=$t_log+"Opción "+ST_Qte ("Afecto a IVA")+": "+String:C10(cbACT_Afecto_IVA)+". "
	$t_log:=$t_log+"Opción "+ST_Qte ("No incluir en documentos tributarios")+": "+String:C10(cbACT_NoDocTrib)+". "
End if 
$t_log:=$t_log+"Fechas de cargos: "+vs1+" de "+String:C10(vdACT_AñoAviso)+", hasta: "+vs2+" de "+String:C10(vdACT_AñoAviso2)+". "
$t_log:=$t_log+"Opción fijar montos: "+String:C10(cbMontosEnMonedaPago)+". "
$t_log:=$t_log+"Generación de cargos para alumnos: "+Choose:C955(f1=1;"seleccionados";Choose:C955(f2=1;"listados";"todos los activos"))+". "
$t_log:=$t_log+Choose:C955(r1=1;"Cualquiera sea la matriz de cargo";"Solo para las cuentas con la matriz "+vsACT_AsignedMatrix2)+". "
SET_UseSet ("Selection")
ARRAY LONGINT:C221($alACT_idsCtas;0)
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$alACT_idsCtas)
$t_log:=$t_log+"Ids ctas ctes: "+AT_array2text (->$alACT_idsCtas;", ";"#########")+"."
LOG_RegisterEvt ($t_log)