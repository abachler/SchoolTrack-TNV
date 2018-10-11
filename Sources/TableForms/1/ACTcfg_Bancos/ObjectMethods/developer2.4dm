C_BLOB:C604(xBlob)
C_TEXT:C284($file;$record)
C_LONGINT:C283($size;$r)
C_TIME:C306($ref)

abACT_BankModified{0}:=True:C214
If (AT_SearchArray (->abACT_BankModified;"=")>0)
	ACTcfg_SaveConfig (4)
End if 

If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373("IN_ACT_SaveTablaBancos";Pila_256K;"Guarda tabla de bancos")
Else 
	IN_ACT_SaveTablaBancos 
End if 