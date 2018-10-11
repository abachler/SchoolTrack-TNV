If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script ◊aDocType
	  //Autor: Alberto Bachler
	  //Creada el 15/5/96 a 15:41
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción: Asigna el tipo de documento seleccionado en el popup
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (Self:C308->>0)
	[BBL_Subscripciones:117]Periodicidad:3:=Self:C308->{Self:C308->}
End if 