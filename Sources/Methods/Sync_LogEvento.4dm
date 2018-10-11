//%attributes = {"executedOnServer":true}
  // Sync_LogEvento()
  // Por: Alberto Bachler K.: 15-04-15, 11:52:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)
C_LONGINT:C283($6)
C_TEXT:C284($7)

C_TEXT:C284($t_campo;$t_dtsCondor;$t_dtsST;$t_evento;$t_fecha;$t_hora;$t_valor;$t_versionCondor;$t_versionST)
C_BLOB:C604($xBlob)

If (False:C215)
	C_TEXT:C284(Sync_LogEvento ;$1)
	C_TEXT:C284(Sync_LogEvento ;$2)
	C_TEXT:C284(Sync_LogEvento ;$3)
	C_LONGINT:C283(Sync_LogEvento ;$4)
	C_TEXT:C284(Sync_LogEvento ;$5)
	C_LONGINT:C283(Sync_LogEvento ;$6)
	C_TEXT:C284(Sync_LogEvento ;$7)
End if 

If (<>b_UsarLogSync)
	$t_fecha:=String:C10(Current date:C33;Internal date short special:K1:4)
	$t_hora:=String:C10(Current time:C178;HH MM SS:K7:1)
	$t_evento:=$1
	$t_campo:=$2
	$t_valor:=$3
	$t_versionCondor:=String:C10($4)
	$t_dtsCondor:=$5
	$t_versionST:=String:C10($6)
	$t_dtsST:=$7
	  //MONO TICKET 189641
	BLOB_Variables2Blob (->$xBlob;0;->$t_fecha;->$t_hora;->$t_evento;->$t_campo;->$t_valor;->$t_versionCondor;->$t_dtsCondor;->$t_versionST;->$t_dtsST)
	BM_CreateRequest ("Sync_LogEventoTask";"";"";$xBlob)
	
End if 