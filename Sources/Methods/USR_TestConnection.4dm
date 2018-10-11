//%attributes = {}
  //USR_TestConnection

If (Count parameters:C259=1)
	$registerName:=$1
Else 
	If (<>RegisteredName="")
		$registerName:=Substring:C12(String:C10(<>lUSR_CurrentUserID)+" "+<>tUSR_CurrentUser;1;31)
	Else 
		$registerName:=<>RegisteredName
	End if 
End if 
If (((Macintosh option down:C545) | (Windows Alt down:C563)) & (Shift down:C543))
	$0:=0
Else 
	ARRAY TEXT:C222(clients;0)
	ARRAY LONGINT:C221($methods;0)
	ARRAY TEXT:C222(at_Repeated;0)
	GET REGISTERED CLIENTS:C650(clients;$methods)
	For ($j;1;Size of array:C274(clients))
		$pos:=Position:C15($registerName;clients{$j})
		If ($pos>0)
			INSERT IN ARRAY:C227(at_Repeated;Size of array:C274(at_Repeated)+1;1)
			at_Repeated{Size of array:C274(at_Repeated)}:=clients{$j}
		End if 
	End for 
	ARRAY LONGINT:C221(Conections;Size of array:C274(clients))
	For ($i;1;Size of array:C274(at_Repeated))
		$NoConexion:=ST_GetWord (at_Repeated{$i};1)
		$IdUser:=ST_GetWord (at_Repeated{$i};2)
		$UserName:=ST_GetWord (at_Repeated{$i};3)
		Conections{$i}:=Num:C11($NoConexion)
	End for 
	If (Size of array:C274(Conections)>0)
		$0:=AT_Maximum (->Conections;0)  //
	Else 
		$0:=0
	End if 
	AT_Initialize (->clients;->Conections)
End if 
