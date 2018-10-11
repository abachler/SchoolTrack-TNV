If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script ◊aPrefDoc
	  //Autor: Alberto Bachler
	  //Creada el 15/5/96 a 15:30
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis: Asigna la regla a un documento
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

If (Self:C308->>0)
	[ACT_Terceros:138]Nacionalidad:27:=Self:C308->{Self:C308->}
End if 

If ([ACT_Terceros:138]Nacionalidad:27#"Chilen@")
	OBJECT SET VISIBLE:C603(*;"extranjero@";True:C214)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT GET COORDINATES:C663([ACT_Terceros:138]RUT:4;$left;$top;$right;$bottom)
	If ($left=188)
		OBJECT MOVE:C664([ACT_Terceros:138]RUT:4;10;0;-10;0)
	End if 
Else 
	OBJECT SET VISIBLE:C603(*;"extranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"labelextranjero@";False:C215)
	OBJECT SET VISIBLE:C603(*;"rut@";True:C214)
	OBJECT GET COORDINATES:C663([ACT_Terceros:138]RUT:4;$left;$top;$right;$bottom)
	If ($left=198)
		OBJECT MOVE:C664([ACT_Terceros:138]RUT:4;-10;0;10;0)
	End if 
End if 
