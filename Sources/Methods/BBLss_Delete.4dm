//%attributes = {}
  //BBLss_Delete

C_LONGINT:C283($0)
If (USR_checkRights ("D";->[BBL_Subscripciones:117]))
	$r:=CD_Dlog (0;__ ("Para guardar un registro de publicación periódica se requiere ingresar al menos su número de registro y el número de la publicación.\r\rPor favor ingrese las informaciones antes de continuar.");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		DELETE RECORD:C58([BBL_Subscripciones:117])
		$0:=1
	End if 
End if 
