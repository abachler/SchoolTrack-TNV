If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Formule format : Print
	  //Autor: Alberto Bachler
	  //Creada el 22/6/96 a 6:48 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (In header:C112)
	sheader:=DT_SpecialDate2String (Current date:C33)+", Pagina "+String:C10(Printing page:C275)+"\r"+("MediaTrack")
End if 