//%attributes = {}
  //ACTdc_ConstruyeDatosProrroga

C_TEXT:C284($vt_datosProrrogaT;$vt_datosProrroga2;$0;$vt_dts;$vt_usuario;$vt_dtsFechaProrroga)
ARRAY TEXT:C222($at_datos;0)

$vt_datosProrroga:=$1

AT_Text2Array (->$at_datos;$vt_datosProrroga;"\r")
For ($i;1;Size of array:C274($at_datos))
	$vt_dts:=ST_GetWord ($at_datos{$i};1;"-")
	$vt_usuario:=ST_GetWord ($at_datos{$i};2;"-")
	$vt_dtsFechaProrroga:=ST_GetWord ($at_datos{$i};3;"-")
	$vt_datosProrrogaT:=$vt_datosProrrogaT+String:C10($i)+".- Prorrogado el día "+String:C10(DTS_GetDate ($vt_dts))+", por: "+$vt_usuario+". Fecha prórroga: "+String:C10(DTS_GetDate ($vt_dtsFechaProrroga))+"."+"\r"
End for 
$0:=$vt_datosProrrogaT