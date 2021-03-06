//%attributes = {"executedOnServer":true}
  // SYS_GetLastRepairInfo(nombreBD:Y; fechaReparacion:Y; horaReparacion) <- textoError:T
  // Analiza el log de Reparación y retorna información sobre la Reparación
  // <-> nombreBD: puntero sobre variable texto, retorna la ruta de la BD Reparada
  // <-> fechaReparacion: puntero sobre variable fecha, retorna la fecha de Reparación
  // <-> horaReparacion: puntero sobre variable hora, retorna la fecha de Reparación
  // Por: Alberto Bachler: 12/01/13, 12:54:40
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($x_blob)
C_DATE:C307($d_date)
C_LONGINT:C283($l_desdePosicion;$l_elemento)
C_TIME:C306($h_time)
C_POINTER:C301($y_fecha;$y_hora;$y_Ruta)
C_TEXT:C284($t_contenido;$t_date;$t_dts;$t_Error;$t_LogReparacion;$t_logFolder;$t_nombreActualBD;$t_nombreBDReparada;$t_nombreEstructura;$t_rutaBDReparada)
C_TEXT:C284($t_time)

ARRAY TEXT:C222($at_TextoDocumento;0)

If (False:C215)
	C_POINTER:C301(SYS_GetLastCompactInfo;$1)
	C_POINTER:C301(SYS_GetLastCompactInfo;$2)
	C_POINTER:C301(SYS_GetLastCompactInfo;$3)
End if 

$y_Ruta:=$1
$y_fecha:=$2
$y_hora:=$3


$t_logFolder:=Get 4D folder:C485(Logs folder:K5:19)
$t_nombreEstructura:=Replace string:C233(SYS_GetServerProperty (XS_StructureName);".4DB";"")
$t_LogReparacion:=$t_logFolder+$t_nombreEstructura+"_Repair_Log.xml"
If (Test path name:C476($t_LogReparacion)=Is a document:K24:1)
	DOCUMENT TO BLOB:C525($t_LogReparacion;$x_blob)
	
	$l_posicionInicial:=API Find In Blob ($x_blob;"<start_timer time=")
	$l_posicionInicial:=$l_posicionInicial+Length:C16("<start_timer time=")+1
	$l_posicionFinal:=API Find In Blob ($x_blob;"/>";0;$l_posicionInicial)
	$l_numeroCaracteres:=$l_posicionFinal-$l_posicionInicial-1
	$t_dts:=BLOB to text:C555($x_blob;Mac text without length:K22:10;$l_posicionInicial;$l_numeroCaracteres)
	If (($t_dts#"") & (Length:C16($t_dts)=25))
		$t_date:=ST_GetWord ($t_dts;1;"T")
		$t_time:=ST_GetWord ($t_dts;2;"T")
		$h_time:=Time:C179(ST_GetWord ($t_time;1;"-"))
		$d_date:=DT_GetDateFromDayMonthYear (Num:C11(ST_GetWord ($t_date;3;"-"));Num:C11(ST_GetWord ($t_date;2;"-"));Num:C11(ST_GetWord ($t_date;1;"-")))
	End if 
	
	$l_posicionInicial:=API Find In Blob ($x_blob;"<move from=\"")
	$l_posicionInicial:=$l_posicionInicial+Length:C16("<move from=\"")+1
	$l_posicionInicial:=API Find In Blob ($x_blob;"to=\"";0;$l_posicionInicial)
	$l_posicionInicial:=$l_posicionInicial+Length:C16("to=\"")
	$l_posicionFinal:=API Find In Blob ($x_blob;">";0;$l_posicionInicial)
	$l_numeroCaracteres:=$l_posicionFinal-$l_posicionInicial-1
	$t_rutaBDReparada:=BLOB to text:C555($x_blob;Mac text without length:K22:10;$l_posicionInicial;$l_numeroCaracteres)
	
	
End if 

$t_nombreActualBD:=SYS_Path2FileName (Data file:C490)
$t_nombreBDReparada:=SYS_Path2FileName ($t_rutaBDReparada)

Case of 
	: (Test path name:C476($t_LogReparacion)#Is a document:K24:1)
		$t_Error:=__ ("ERROR 1: No se encontró el log de Reparación")
	: ($t_rutaBDReparada="")
		$t_Error:=__ ("ERROR 2: No se encontró ninguna referencia a una Reparación de base de datos en el log")
	: (Test path name:C476($t_rutaBDReparada)#Is a document:K24:1)
		$t_Error:=__ ("ERROR 3: No se encontró el archivo de datos referenciado en el log: \r\r")+$t_rutaBDReparada
	: ($t_nombreActualBD#$t_nombreBDReparada)
		$t_Error:=__ ("ADVERTENCIA: El nombre de la base de datos actual ($t_nombreActualBD) es distinto del nombre de la base de datos reparada ($t_nombreBDReparada)")
		$t_Error:=Replace string:C233($t_Error;"$t_nombreActualBD";$t_nombreActualBD)
		$t_Error:=Replace string:C233($t_Error;"$t_nombreBDReparada";$t_nombreBDReparada)
End case 

$y_Ruta->:=$t_rutaBDReparada
$y_fecha->:=$d_date
$y_hora->:=$h_time

$0:=$t_error

