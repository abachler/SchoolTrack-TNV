//%attributes = {}
  // EXE_EjecutaScriptRemoto()
  // Por: Alberto Bachler: 02/05/13, 12:08:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_activo)
C_LONGINT:C283($err;$l_IdScript)
C_TEXT:C284($t_TextScript)

If (False:C215)
	C_LONGINT:C283(EXE_EjecutaScriptRemoto ;$1)
	C_TEXT:C284(EXE_EjecutaScriptRemoto ;$2)
End if 
$l_IdScript:=$1
$t_TextScript:=$2

ON ERR CALL:C155("ERR_GenericOnError")
EXE_Execute ($t_TextScript)
ON ERR CALL:C155("")
If (error=0)
	$b_activo:=False:C215
	WSexe_ActivacionScript_out ($l_IdScript;$b_activo)
End if 
error:=0

