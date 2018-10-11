//%attributes = {"executedOnServer":true}
  // CIM_VerLogActividades()
  // Por: Alberto Bachler K.: 07-10-15, 14:00:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_fecha:=$1
$y_Hora:=$2
$y_usuario:=$3
$y_evento:=$4
$y_modulo:=$5
$y_tabla:=$6
$y_recNum:=$7


$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"Registro de Actividades.txt"
$t_rutaRespaldos:=Get 4D folder:C485(Logs folder:K5:19)+"Registro de Actividades anteriores"+Folder separator:K24:12
  //If (SYS_IsWindows )
  //USE CHARACTER SET("windows-1252";1)
  //Else 
  //USE CHARACTER SET("MacRoman";1)
  //End if 
DOCUMENT TO BLOB:C525($t_rutaLog;$x_blob)
$t_log:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)

While ($t_log#"")
	$t_registro:=Substring:C12($t_log;1;Position:C15("\r";$t_log)-1)
	$t_log:=Substring:C12($t_log;Position:C15("\r";$t_log)+1)
	APPEND TO ARRAY:C911($y_fecha->;Date:C102(ST_GetWord ($t_registro;1;"\t")))
	APPEND TO ARRAY:C911($y_hora->;Time:C179(ST_GetWord ($t_registro;2;"\t")))
	APPEND TO ARRAY:C911($y_usuario->;ST_GetWord ($t_registro;3;"\t"))
	APPEND TO ARRAY:C911($y_evento->;ST_GetWord ($t_registro;4;"\t"))
	APPEND TO ARRAY:C911($y_modulo->;ST_GetWord ($t_registro;5;"\t"))
	APPEND TO ARRAY:C911($y_tabla->;ST_GetWord ($t_registro;6;"\t"))
	APPEND TO ARRAY:C911($y_recNum->;Num:C11(ST_GetWord ($t_registro;7;"\t")))
End while 
  //$t_lineas:=ST_countlines ($t_log)
  //  //AT_Text2Array (->$at_Contenido;->$t_log)
  //
  //
  //For ($i;1;$t_lineas)
  //$t_linea:=ST_GetLine ($t_log;$i)
  //APPEND TO ARRAY($y_fecha->;Date(ST_GetWord ($t_linea;1;"\t")))
  //APPEND TO ARRAY($y_hora->;Time(ST_GetWord ($t_linea;2;"\t")))
  //APPEND TO ARRAY($y_usuario->;ST_GetWord ($t_linea;3;"\t"))
  //APPEND TO ARRAY($y_evento->;ST_GetWord ($t_linea;4;"\t"))
  //APPEND TO ARRAY($y_modulo->;ST_GetWord ($t_linea;5;"\t"))
  //APPEND TO ARRAY($y_tabla->;ST_GetWord ($t_linea;6;"\t"))
  //APPEND TO ARRAY($y_recNum->;Num(ST_GetWord ($t_linea;7;"\t")))
  //End for 
  //
