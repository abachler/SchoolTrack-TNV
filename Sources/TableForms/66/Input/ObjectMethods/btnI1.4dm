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

SRtbl_ShowChoiceList (0;__ ("Lugar");2;->btnI1;False:C215;-><>aPLace)

If (Choiceidx>0)
	[BBL_Registros:66]Lugar:13:=<>aPLaceCode{Choiceidx}
	BBLmarc_UpdateMARCField (->[BBL_Registros:66]Lugar:13)
End if 