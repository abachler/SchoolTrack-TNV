//%attributes = {}
C_TEXT:C284($t_mensaje)
C_LONGINT:C283($1;$cant_regs)
$cant_regs:=$1
$t_mensaje:=__ ("Estimado(a) ^0, existen ^1 registros con actualización de datos descargados desde SchoolNet, esperando de confirmación para aplicar los cambios";<>tUSR_CurrentUser;String:C10($cant_regs))
CD_Dlog (0;$t_mensaje)
