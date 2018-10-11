  // [Profesores].Input.Botón 3D()
  // Por: Alberto Bachler K.: 26-03-14, 21:31:21
  //  ---------------------------------------------
  //
  //  ---------------------------------------------


OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$x1;$y1;$x2;$y2)
If ([Profesores:4]Fecha_Deceso:71#!00-00-00!)
	$d_fechaDeceso:=DatePicker Display Dialog ($x1;$y1;[Profesores:4]Fecha_Deceso:71)
Else 
	$d_fechaDeceso:=DatePicker Display Dialog ($x1;$y1;Current date:C33(*))
End if 
If ($d_fechaDeceso>Current date:C33(*))
	CD_Dlog (0;__ ("El deceso no puede producirse en una fecha posterior a hoy."))
Else 
	If ($d_fechaDeceso#!00-00-00!)
		[Profesores:4]Fecha_Deceso:71:=$d_fechaDeceso
	End if 
End if 




