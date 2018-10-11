//%attributes = {}
  //ACTlc_EliminaLetra

C_LONGINT:C283($1;$idDocPago;$found)
C_BOOLEAN:C305($0)

$idDocPago:=$1
$0:=True:C214

$found:=Find in field:C653([ACT_Documentos_de_Pago:176]ID:1;$idDocPago)
If ($found#-1)
	READ WRITE:C146([ACT_Documentos_de_Pago:176])
	GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$found)
	If (Not:C34(Locked:C147([ACT_Documentos_de_Pago:176])))
		If (([ACT_Documentos_de_Pago:176]Nulo:37=True:C214) & ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8))
			DELETE RECORD:C58([ACT_Documentos_de_Pago:176])
		Else 
			$0:=True:C214
		End if 
	Else 
		$0:=False:C215
	End if 
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
End if 