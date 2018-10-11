//%attributes = {}
  //BBL_SearchDocs

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_SearchDocs
	  //Autor: Alberto Bachler
	  //Creada el 14/6/96 a 5:11 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
ARRAY TEXT:C222(aAbvXRefsType;0)
ARRAY TEXT:C222(aXRefsKeyWord;0)
ARRAY TEXT:C222(aAbvXrefTypeList;0)
ARRAY TEXT:C222(aKw;0)
ARRAY LONGINT:C221(aKwNumber;0)
ARRAY TEXT:C222(aItemCall;0)
ARRAY TEXT:C222(aItemTitle;0)
ARRAY TEXT:C222(aItemAutor;0)
ARRAY LONGINT:C221(aItemNumber;0)
READ ONLY:C145([BBL_Items:61])
REDUCE SELECTION:C351([BBL_Items:61];0)
REDUCE SELECTION:C351([BBL_Thesaurus:68];0)
WDW_OpenDialogInDrawer (->[BBL_Items:61];"Search";__ ("Búsqueda de documentos"))

ARRAY TEXT:C222(aAbvXRefsType;0)
ARRAY TEXT:C222(aXRefsKeyWord;0)
ARRAY TEXT:C222(aAbvXrefTypeList;0)
ARRAY TEXT:C222(aKw;0)
ARRAY LONGINT:C221(aKwNumber;0)
ARRAY TEXT:C222(aItemCall;0)
ARRAY TEXT:C222(aItemTitle;0)
ARRAY TEXT:C222(aItemautor;0)
ARRAY LONGINT:C221(aItemNumber;0)