  // [xShell_Reports].EnvioRepositorio.mostrarHistorial()
  // Por: Alberto Bachler K.: 13-08-14, 13:11:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

RIN_HistorialCambios ([xShell_Reports:54]UUID:47;<>GUUID)
$y_dts_at:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaHora")
If (Size of array:C274($y_dts_at->)>0)
	For ($i_elementos;1;Size of array:C274($y_dts_at->))
		$y_dts_at->{$i_elementos}:=DTS_GetDateTimeString ($y_dts_at->{$i_elementos})
	End for 
	
	GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha+403;$l_abajo)
	OBJECT SET VISIBLE:C603(*;OBJECT Get name:C1087(Object current:K67:2);False:C215)
	OBJECT SET VISIBLE:C603(*;"ocultarHistorial";True:C214)
Else 
	ModernUI_Notificacion (__ ("Historial de cambios del informe");__ ("Este informe no ha sido modificado desde su creación"))
End if 

