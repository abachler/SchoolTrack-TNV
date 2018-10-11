//%attributes = {}
  //ACTbol_LeeListaDocsTribs

C_TEXT:C284($vt_accion)
$vt_accion:=$1

Case of 
	: ($vt_accion="LeeLista")
		ACTbol_LeeListaDocsTribs ("DeclaraArreglos")
		C_LONGINT:C283($hl_listCategorias;$i)
		For ($i;1;Size of array:C274(<>atACT_CategoriasDocsTrib))
			APPEND TO ARRAY:C911(alACT_CategoriasDctos;<>alACT_CategoriasDocsTrib{$i})
			APPEND TO ARRAY:C911(atACT_CategoriasDctos;<>atACT_CategoriasDocsTrib{$i})
		End for 
		
		
		
	: ($vt_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACT_CategoriasDctos;0)
		ARRAY TEXT:C222(atACT_CategoriasDctos;0)
		
End case 

