//%attributes = {}
  //LOG_RegisterChangeConf
  //20120516 RCH Se crea metodo para centralizar cambios en la configuracion. Se registra texto de check y valor. Aca se obtiene el nombre de la ventana de la configuracion.
  //se puede agregar este codigo en los check de la configuracion...
  //LOG_RegisterChangeConf (OBJECT Get title(Self->);Self->)

C_LONGINT:C283($vl_valor;$vl_modulo)
C_TEXT:C284($vt_opcion;$vt_winTitle;$vt_log;$0)
C_BOOLEAN:C305($vb_retornaTexto)

$vt_opcion:=$1
$vl_valor:=$2
If (Count parameters:C259>=3)
	$vb_retornaTexto:=$3
End if 
$vt_winTitle:=Get window title:C450  //se espera obtener a que configuracion pertenece el cambio...

  //LOG_RegisterEvt ("Cambio en configuración"+ST_Boolean2Str ($vt_winTitle#"";" "+$vt_winTitle;"")+". Opción: "+ST_Qte ($vt_opcion)+", valor asignado: "+String($vl_valor)+".")
  //20120723 RCH para retornar el log en ventanas que permiten cancelar
$vt_log:="Cambio en configuración"+ST_Boolean2Str ($vt_winTitle#"";" "+$vt_winTitle;"")+". Opción: "+ST_Qte ($vt_opcion)+", valor asignado: "+String:C10($vl_valor)+"."
If ($vb_retornaTexto)
	$0:=$vt_log
Else 
	LOG_RegisterEvt ($vt_log)
End if 