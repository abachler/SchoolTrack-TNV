//%attributes = {}
  // SYS_ReiniciarServidor(mostrarDialogo:B; mensaje:T; segundos:L)
  // si la aplicación es cliente y mostrarDialogo=True solicita confimación en el cliente para reiniciar el servidor
  // mensaje: mensaje enviado a los clientes conectados
  // segundos: tiempo de espera para el reinicio
  //
  // creado por: Alberto Bachler Klein: 16-03-16, 12:48:32
  // -----------------------------------------------------------
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_mostrarDialogo)
C_LONGINT:C283($l_Proceso;$l_ref;$l_segundos)
C_TEXT:C284($t_mensaje)


If (False:C215)
	C_BOOLEAN:C305(SYS_ReiniciarServidor ;$1)
	C_TEXT:C284(SYS_ReiniciarServidor ;$2)
	C_LONGINT:C283(SYS_ReiniciarServidor ;$3)
End if 

C_LONGINT:C283(vl_Minutos)

Case of 
	: (Count parameters:C259=3)
		$b_mostrarDialogo:=$1
		$t_mensaje:=$2
		$l_segundos:=$3
	: (Count parameters:C259=2)
		$b_mostrarDialogo:=$1
		$t_mensaje:=$2
	: (Count parameters:C259=1)
		$b_mostrarDialogo:=$1
End case 


If (Application type:C494=4D Remote mode:K5:5)
	If ($b_mostrarDialogo)
		vl_minutos:=Choose:C955($l_segundos>0;$l_segundos/60;10)
		vt_Mensaje:=Choose:C955($t_mensaje#"";$t_mensaje;__ ("El servidor se reiniciará en ^0 minutos.\\Por favor guarde su trabajo y salga SchoolTrack cuanto antes."))
		$l_ref:=Open form window:C675("CIM_ReinicioServidor";Movable form dialog box:K39:8;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("CIM_ReinicioServidor")
		CLOSE WINDOW:C154
	Else 
		$l_Proceso:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684;False:C215;$t_mensaje;$l_segundos)
	End if 
Else 
	$l_segundos:=Choose:C955($l_segundos>0;$l_segundos;30)
	RESTART 4D:C1292($l_segundos;$t_mensaje)
End if 


