If (Self:C308->>0)
	[ADT_Contactos:95]Nacionalidad:19:=Self:C308->{Self:C308->}
End if 


If ([ADT_Contactos:95]Nacionalidad:19#"Chilen@")
	OBJECT SET VISIBLE:C603(*;"extranjero@";True:C214)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT GET COORDINATES:C663([ADT_Contactos:95]RUT:11;$left;$top;$right;$bottom)
	If ($left=188)
		OBJECT MOVE:C664([ADT_Contactos:95]RUT:11;10;0;-10;0)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*;"extranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"rut@";True:C214)
	OBJECT GET COORDINATES:C663([ADT_Contactos:95]RUT:11;$left;$top;$right;$bottom)
	If ($left=198)
		OBJECT MOVE:C664([ADT_Contactos:95]RUT:11;-10;0;10;0)
	End if 
End if 
