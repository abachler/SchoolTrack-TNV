//%attributes = {}
  // IO_ExportRecordsFromOneTable()
  // Por: Alberto Bachler K.: 23-07-14, 13:19:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($i;$l_idProgreso;$l_registros)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_mensaje;$t_nombreTabla;$t_RutaDocumento)

If (False:C215)
	C_POINTER:C301(IO_ExportRecordsFromOneTable ;$1)
	C_TEXT:C284(IO_ExportRecordsFromOneTable ;$2)
	C_TEXT:C284(IO_ExportRecordsFromOneTable ;$3)
End if 


$y_tabla:=$1
$t_nombreTabla:=Table name:C256($y_tabla)
If (Count parameters:C259>=2)
	$t_RutaDocumento:=$2
End if 
If (Count parameters:C259=3)
	$t_mensaje:=$3
Else 
	$t_mensaje:="Exportando registros del archivo "+$t_nombreTabla
End if 


$t_metodoOnErrorActual:=Method called on error:C704

error:=0
ON ERR CALL:C155("ERR_GenericOnError")

SET CHANNEL:C77(12;$t_RutaDocumento)
If (ok=1)
	$l_registros:=Records in selection:C76($y_tabla->)
	SEND VARIABLE:C80($t_nombreTabla)
	SEND VARIABLE:C80($l_registros)
	$l_idProgreso:=Progress New 
	Progress SET TITLE ($l_idProgreso;$t_nombreTabla)
	FIRST RECORD:C50($y_tabla->)
	For ($i;1;$l_registros)
		SEND RECORD:C78($y_tabla->)
		NEXT RECORD:C51($y_tabla->)
		If (Dec:C9($i/1000)=0)
			Progress SET PROGRESS ($l_idProgreso;$i/$l_registros;String:C10($i)+" / "+String:C10($l_registros))
		End if 
	End for 
	Progress QUIT ($l_idProgreso)
	SET CHANNEL:C77(11)
End if 

$0:=error

error:=0
ON ERR CALL:C155($t_metodoOnErrorActual)

