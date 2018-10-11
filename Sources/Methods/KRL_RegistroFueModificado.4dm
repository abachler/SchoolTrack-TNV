//%attributes = {}
  // KRL_RegistroFueModificado()
  // Por: Alberto Bachler: 06/03/13, 04:11:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)

C_BOOLEAN:C305($b_registroModificado)
C_LONGINT:C283($i;$l_numeroTabla;$l_ultimoCampo)
C_POINTER:C301($y_tabla)

If (False:C215)
	C_BOOLEAN:C305(KRL_RegistroFueModificado ;$0)
	C_POINTER:C301(KRL_RegistroFueModificado ;$1)
End if 
$y_tabla:=$1
$l_ultimoCampo:=Get last field number:C255($y_tabla)
For ($i;1;$l_ultimoCampo)
	$l_numeroTabla:=Table:C252($y_tabla)
	If (Is field number valid:C1000($l_numeroTabla;$i))
		If (KRL_FieldChanges (Field:C253($l_numeroTabla;$i)))
			$b_registroModificado:=True:C214
			$i:=$l_ultimoCampo
		End if 
	End if 
End for 

$0:=$b_registroModificado

