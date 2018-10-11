//%attributes = {}
  // KRL_ResetPreviousRWMode()
  // Por: Alberto Bachler K.: 22-04-14, 16:56:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_registroEnLectura)
C_POINTER:C301($y_tabla)

If (False:C215)
	C_POINTER:C301(KRL_ResetPreviousRWMode ;$1)
	C_BOOLEAN:C305(KRL_ResetPreviousRWMode ;$2)
End if 


$y_tabla:=$1
$b_registroEnLectura:=$2
If ($b_registroEnLectura)
	KRL_ReloadAsReadOnly ($y_tabla)
Else 
	KRL_ReloadInReadWriteMode ($y_tabla)
End if 