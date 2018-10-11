//%attributes = {"executedOnServer":true}
  // Sync_ErrorCallBack()
  // Por: Alberto Bachler K.: 14-04-15, 18:05:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_REAL:C285($2)
C_TEXT:C284($3)

C_LONGINT:C283($l_conexion)


If (False:C215)
	C_LONGINT:C283(Sync_ErrorCallBack ;$1)
	C_REAL:C285(Sync_ErrorCallBack ;$2)
	C_TEXT:C284(Sync_ErrorCallBack ;$3)
End if 

$l_conexion:=$1
vl_pgSQL_ErrorCode:=$2
vt_pgSQLmensajeError:=$3


Case of 
	: (vl_pgSQL_ErrorCode=1)
		
	: (vl_pgSQL_ErrorCode#0)
		
End case 