//%attributes = {}
  // MNU_ReiniciarServidor()
  //
  //
  // creado por: Alberto Bachler Klein: 17-03-16, 11:02:47
  // -----------------------------------------------------------
C_TEXT:C284($t_desconexion;$t_mensaje)

$t_mensaje:=__ ("El servidor se reiniciará.\rPor favor guarde su trabajo y salga de Schooltrack.")
$t_desconexion:=String:C10(Count users:C342-1)+__ (" usuario(s) serán desconectados ")
$t_desconexion:=IT_SetTextColor_Name (->$t_desconexion;"red")+__ (" (incluido usted).")
$t_mensaje:=$t_mensaje+"\r\r"+$t_desconexion

SYS_ReiniciarServidor (True:C214;$t_mensaje;10*60)