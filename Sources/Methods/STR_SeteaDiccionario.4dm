//%attributes = {}
  //STR_SeteaDiccionario

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$l_Langage)
$0:=False:C215
$l_Langage:=$1
If ($l_Langage>0)
	SPELL SET CURRENT DICTIONARY:C904($l_Langage)
	$0:=Choose:C955(OK=1;True:C214;False:C215)
End if 