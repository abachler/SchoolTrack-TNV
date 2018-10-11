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
If (<>aPlace>0)
	[BBL_Registros:66]Lugar:13:=<>aPLaceCode{<>aPLace}
	BBLmarc_UpdateMARCField (->[BBL_Registros:66]Lugar:13)
End if 