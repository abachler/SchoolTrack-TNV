//%attributes = {}
  //BBL_Thesaurus

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : mnThesaurus
	  //Autor: Alberto Bachler
	  //Creada el 25/5/96 a 16:02
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
If (USR_GetMethodAcces (Current method name:C684))
	$id:=PCS_RunProcess ("PCSrun_BBL_Thesaurus";32000;"Diccionario de materias";False:C215;False:C215;False:C215)
End if 
