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
	[Profesores:4]Nacionalidad:7:=Self:C308->{Self:C308->}
End if 

PF_SetIdentificadorPrincipal 