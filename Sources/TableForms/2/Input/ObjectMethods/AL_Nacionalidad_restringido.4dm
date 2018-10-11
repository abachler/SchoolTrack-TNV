If (Self:C308->>0)
	[Alumnos:2]Nacionalidad:8:=Self:C308->{Self:C308->}
End if 


If ([Alumnos:2]Nacionalidad:8#"Chilen@")
	OBJECT SET VISIBLE:C603(*;"extranjero@";True:C214)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT GET COORDINATES:C663([Alumnos:2]RUT:5;$left;$top;$right;$bottom)
	If ($left=527)
		OBJECT MOVE:C664([Alumnos:2]RUT:5;10;0;-10;0)
	End if 
	  //If ([Alumnos]RUT="")
	  //SET VISIBLE(*;"rut@";False)
	  //End if 
Else 
	OBJECT SET VISIBLE:C603(*;"extranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"rut@";True:C214)
	OBJECT GET COORDINATES:C663([Alumnos:2]RUT:5;$left;$top;$right;$bottom)
	If ($left=537)
		OBJECT MOVE:C664([Alumnos:2]RUT:5;-10;0;10;0)
	End if 
End if 

AL_SetIdentificadorPrincipal 