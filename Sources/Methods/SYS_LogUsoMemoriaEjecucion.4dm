//%attributes = {}
  // SYS_LogUsoMemoriaEjecucion()
  //
  //
  // creado por: Alberto Bachler Klein: 29-12-15, 17:36:49
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_logMemoryUsage)
C_LONGINT:C283($i;$l_procesosUsuario;$l_tareas;$l_usuariosConectados)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_encabezado;$t_evento;$t_linea;$t_nombreComando;$t_opcion;$t_rutaLog)

ARRAY REAL:C219($ar_InfoValor;0)
ARRAY REAL:C219($ar_numeroObjeto;0)
ARRAY TEXT:C222($at_nombresValor;0)



If (False:C215)
	C_TEXT:C284(SYS_LogUsoMemoriaEjecucion ;$1)
	C_TEXT:C284(SYS_LogUsoMemoriaEjecucion ;$2)
End if 

Case of 
	: (Count parameters:C259=2)
		$t_evento:=$2
		$t_nombreComando:=$1
		$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"UsoDeMemoria_Exec_"+$t_nombreComando+".txt"
	: (Count parameters:C259=1)
		$t_nombreComando:=$1
		$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"UsoDeMemoria_Exec_"+$t_nombreComando+".txt"
	Else 
		$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"UsoDeMemoria.txt"
End case 


$b_logMemoryUsage:=True:C214
GET MEMORY STATISTICS:C1118(3;$at_nombresValor;$ar_InfoValor;$ar_numeroObjeto)
If (Test path name:C476($t_rutaLog)#Is a document:K24:1)
	$h_refDocumento:=Create document:C266($t_rutaLog;".txt")
	$t_encabezado:=Choose:C955($t_evento#"";"Evento\tFecha\tHora\tClientes\tProcesos usuario\tTotal procesos\t";\
		"Fecha\tHora\tClientes\tProcesos usuario\tTotal procesos\t")
	
	For ($i;1;Size of array:C274($at_nombresValor))
		$t_encabezado:=$t_encabezado+$at_nombresValor{$i}+"\t"
	End for 
	$t_encabezado:=Substring:C12($t_encabezado;1;Length:C16($t_encabezado)-1)+"\r"
	SEND PACKET:C103($h_refDocumento;$t_encabezado)
	CLOSE DOCUMENT:C267($h_refDocumento)
End if 

GET MEMORY STATISTICS:C1118(3;$at_nombresValor;$ar_InfoValor;$ar_numeroObjeto)
$l_usuariosConectados:=Count users:C342
$l_procesosUsuario:=Count user processes:C343
$l_tareas:=Count tasks:C335
$t_linea:=Choose:C955($t_evento#"";$t_evento+"\t"+String:C10(Current date:C33;Internal date short special:K1:4)+"\t"+String:C10(Current time:C178;HH MM SS:K7:1)+"\t"+String:C10($l_usuariosConectados)+"\t"+String:C10($l_procesosUsuario)+"\t"+String:C10($l_tareas)+"\t";\
String:C10(Current date:C33;Internal date short special:K1:4)+"\t"+String:C10(Current time:C178;HH MM SS:K7:1)+"\t"+String:C10($l_usuariosConectados)+"\t"+String:C10($l_procesosUsuario)+"\t"+String:C10($l_tareas)+"\t")

For ($i;1;Size of array:C274($at_nombresValor))
	If ($at_nombresValor{$i}#"nb@")
		$t_linea:=$t_linea+String:C10(Round:C94($ar_InfoValor{$i}/1024/1024;2);"### ##0,00")+"\t"
	Else 
		$t_linea:=$t_linea+String:C10($ar_InfoValor{$i})+"\t"
	End if 
End for 
$t_linea:=Substring:C12($t_linea;1;Length:C16($t_linea)-1)+"\r"
$h_refDocumento:=Append document:C265($t_rutaLog;".txt")
SEND PACKET:C103($h_refDocumento;$t_linea)
CLOSE DOCUMENT:C267($h_refDocumento)

