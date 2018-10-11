//%attributes = {}
USR_TaskRefTable 
LISTBOX SORT COLUMNS:C916(*;"lb_TaskTypes";1;>)
$y_Acciones_H:=OBJECT Get pointer:C1124(Object named:K67:5;"acciones_H")
$y_Acciones_H->:=1

$y_UsuarioNombre_H:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosNombre_H")
$y_UsuarioNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosNombre")
$y_UsuarioSesiones:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosSesiones")
$y_usuariosTiempo:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosTiempo")
$y_usuariosRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosRecNum")
$y_usuariosSegundos:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosSegundos")
READ ONLY:C145([xShell_UserConnections:281])
ALL RECORDS:C47([xShell_UserConnections:281])
SELECTION TO ARRAY:C260([xShell_UserConnections:281];$y_usuariosRecNum->;[xShell_UserConnections:281]Login:2;$y_UsuarioNombre->;[xShell_UserConnections:281]Connections_Number:8;$y_UsuarioSesiones->;[xShell_UserConnections:281]Connections_TotalTime:9;$y_usuariosSegundos->)
ARRAY TEXT:C222($y_usuariosTiempo->;Size of array:C274($y_usuariosRecNum->))
For ($i;1;Size of array:C274($y_usuariosRecNum->))
	$y_usuariosTiempo->{$i}:=DT_Duracion_a_Texto ($y_usuariosSegundos->{$i})
End for 
LISTBOX SORT COLUMNS:C916(*;"lb_UsersConex";1)
LISTBOX SELECT ROW:C912(*;"lb_UsersConex";0;lk remove from selection:K53:3)
$y_UsuarioNombre_H->:=1


READ ONLY:C145([xShell_UserEvents:282])
ALL RECORDS:C47([xShell_UserEvents:282])

