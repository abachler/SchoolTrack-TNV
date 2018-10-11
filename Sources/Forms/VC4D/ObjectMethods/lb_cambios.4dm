  // VC4D.lb_cambios()
  //
  //
  // creado por: Alberto Bachler Klein: 03-02-16, 18:24:25
  // -----------------------------------------------------------
C_DATE:C307($d_fecha)
C_TIME:C306($h_hora)
C_POINTER:C301($y_autorCambio;$y_codigoCambio;$y_dts;$y_fechaCambio;$y_Ruta;$y_tipoObjeto;$y_uuidCambio;$y_uuidCodigo)
C_TEXT:C284($t_code;$t_codigoHTML;$t_fecha;$t_infoMetodo;$t_rutaVC4D;$t_uuid)

$y_fechaCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaCambio")
$y_autorCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"autorCambio")
$y_codigoCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoCambio")
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")

If ($y_fechaCambio->>0)
	$y_codigo->:=$y_codigoCambio->{$y_codigoCambio->}
End if 

