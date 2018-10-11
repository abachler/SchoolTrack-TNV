//%attributes = {"executedOnServer":true}
  // CIM_InfoCompactacion()
  // Por: Alberto Bachler K.: 30-09-14, 11:40:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_LONGINT:C283($0)

C_BOOLEAN:C305($b_canceladoUsuario;$b_exito)
C_LONGINT:C283($l_error)
C_POINTER:C301($y_cancelada;$y_exito;$y_inicio;$y_termino)
C_TEXT:C284($t_datafile;$t_estructura;$t_inicio;$t_logCompactacion;$t_NombreEstructura;$t_operacion;$t_refElemento;$t_refXML;$t_ruta)
C_TEXT:C284($t_termino)

If (False:C215)
	C_LONGINT:C283(CIM_InfoCompactacion ;$0)
	C_POINTER:C301(CIM_InfoCompactacion ;$1)
	C_POINTER:C301(CIM_InfoCompactacion ;$2)
	C_POINTER:C301(CIM_InfoCompactacion ;$3)
	C_POINTER:C301(CIM_InfoCompactacion ;$4)
End if 

$y_inicio:=$1
$y_termino:=$2
$y_exito:=$3
$y_cancelada:=$4

$t_NombreEstructura:=SYS_GetServerProperty (XS_StructureName)
$t_NombreEstructura:=Replace string:C233($t_NombreEstructura;".4DB";"")
$t_NombreEstructura:=Replace string:C233($t_NombreEstructura;".4DC";"")
$t_logCompactacion:=Get 4D folder:C485(Logs folder:K5:19)+$t_NombreEstructura+"_Compact_Log.xml"

If (Test path name:C476($t_logCompactacion)=Is a document:K24:1)
	$t_refXML:=DOM Parse XML source:C719($t_logCompactacion)
	$t_refElemento:=DOM Find XML element:C864($t_refXML;"verifylog")
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"operation";$t_operacion)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"structure";$t_estructura)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"data";$t_datafile)
	
	$t_refElemento:=DOM Find XML element:C864($t_refXML;"verifylog/start_timer")
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"time";$t_inicio)
	
	$t_refElemento:=DOM Find XML element:C864($t_refXML;"verifylog/stop_timer")
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"time";$t_termino)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"success";$b_exito)
	DOM GET XML ATTRIBUTE BY NAME:C728($t_refElemento;"user_canceled";$b_canceladoUsuario)
	
	DOM CLOSE XML:C722($t_refXML)
	
	If (($t_datafile=Data file:C490) & ($t_operacion="Compact"))
		$y_inicio->:=$t_inicio
		$y_termino->:=$t_termino
		$y_exito->:=$b_exito
		$y_cancelada->:=$b_canceladoUsuario
		$l_error:=0
	Else 
		$l_error:=-2  // el log de reparación no corresponde a la base de datos
	End if 
	
Else 
	$l_error:=-1  // no hay log de reparacion
End if 

$0:=$l_error

