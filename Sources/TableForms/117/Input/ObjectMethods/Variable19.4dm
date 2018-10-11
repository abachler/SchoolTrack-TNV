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
If ((Self:C308->>0) & (Self:C308->{Self:C308->}#[BBL_Items:61]Regla:20))
	QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=Self:C308->{Self:C308->})
	[BBL_Subscripciones:117]Regla:24:=[xxBBL_ReglasParaItems:69]Codigo_regla:1
End if 