//%attributes = {}
  // KRL_ReloadAsReadOnly()
  // Por: Alberto Bachler K.: 13-10-14, 16:54:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301(${1})

C_LONGINT:C283($i;$l_recNum)
C_POINTER:C301($y_tabla)


If (False:C215)
	C_POINTER:C301(KRL_ReloadAsReadOnly ;${1})
End if 

For ($i;1;Count parameters:C259)
	$y_tabla:=${$i}
	If (Record number:C243($y_tabla->)>=0)
		$l_recNum:=Selected record number:C246($y_tabla->)
		UNLOAD RECORD:C212($y_tabla->)
		READ ONLY:C145($y_tabla->)
		GOTO SELECTED RECORD:C245($y_tabla->;$l_recNum)
	Else 
		READ ONLY:C145($y_tabla->)
	End if 
End for 

