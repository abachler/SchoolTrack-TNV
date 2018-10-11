//%attributes = {}
  // KRL_UnloadReadOnly()
  // Por: Alberto Bachler: 27/05/13, 11:47:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301(${1})

C_LONGINT:C283($i;$l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_Pointer)
C_TEXT:C284($t_nombreVariable)

If (False:C215)
	C_POINTER:C301(KRL_UnloadReadOnly ;${1})
End if 

For ($i;1;Count parameters:C259)
	$y_Pointer:=${$i}
	If (Type:C295($y_Pointer)=Is pointer:K8:14)
		RESOLVE POINTER:C394($y_Pointer;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
		If ($l_numeroTabla#-1)
			UNLOAD RECORD:C212($y_Pointer->)
			READ ONLY:C145($y_Pointer->)
		Else 
			ALERT:C41("El parametro "+String:C10($i)+" es un puntero sobre tabla inválido.")
		End if 
	Else 
		ALERT:C41("El parametro "+String:C10($i)+" no es un puntero.")
	End if 
End for 