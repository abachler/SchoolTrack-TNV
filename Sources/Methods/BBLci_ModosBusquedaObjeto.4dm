//%attributes = {}
  // BBLci_ModosBusquedaObjeto()
  // Por: Alberto Bachler: 30/09/13, 18:13:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

_O_C_INTEGER:C282($i_modos)
C_TEXT:C284($t_tipos)

ARRAY LONGINT:C221($al_LineasResultado;0)


If (False:C215)
	C_TEXT:C284(BBLci_ModosBusquedaObjeto ;$1)
End if 
C_TEXT:C284(vt_RefMenuModoBusqueda)
ARRAY LONGINT:C221(al_refModoBusquedaObjeto;0)
ARRAY TEXT:C222(at_nombreCampoObjeto;0)

$t_tipos:=$1
  //
  //If ($t_tipos="")  // todos los modos de busqueda son válidos
  //COPY ARRAY(al_RefModoBusqueda_BBLci;al_refModoBusquedaObjeto)
  //COPY ARRAY(at_nombreCampo_BBLci;at_nombreCampoObjeto)
  //Else 

If (Position:C15("L";$t_tipos)>0)
	For ($i_modos;1;Size of array:C274(at_TipoBusqueda_BBLci))
		If (at_TipoBusqueda_BBLci{$i_modos}="l")
			APPEND TO ARRAY:C911(al_refModoBusquedaObjeto;al_RefModoBusqueda_BBLci{$i_modos})
			APPEND TO ARRAY:C911(at_nombreCampoObjeto;at_nombreCampo_BBLci{$i_modos})
		End if 
	End for 
End if 

If (Position:C15("R";$t_tipos)>0)
	If (Size of array:C274(at_nombreCampoObjeto)>0)
		APPEND TO ARRAY:C911(al_refModoBusquedaObjeto;-100)
		APPEND TO ARRAY:C911(at_nombreCampoObjeto;"(-")
	End if 
	For ($i_modos;1;Size of array:C274(at_TipoBusqueda_BBLci))
		If (at_TipoBusqueda_BBLci{$i_modos}="R")
			APPEND TO ARRAY:C911(al_refModoBusquedaObjeto;al_RefModoBusqueda_BBLci{$i_modos})
			APPEND TO ARRAY:C911(at_nombreCampoObjeto;at_nombreCampo_BBLci{$i_modos})
		End if 
	End for 
End if 

If (Position:C15("i";$t_tipos)>0)
	If (Size of array:C274(at_nombreCampoObjeto)>0)
		APPEND TO ARRAY:C911(al_refModoBusquedaObjeto;-100)
		APPEND TO ARRAY:C911(at_nombreCampoObjeto;"(-")
	End if 
	For ($i_modos;1;Size of array:C274(at_TipoBusqueda_BBLci))
		If (at_TipoBusqueda_BBLci{$i_modos}="i")
			APPEND TO ARRAY:C911(al_refModoBusquedaObjeto;al_RefModoBusqueda_BBLci{$i_modos})
			APPEND TO ARRAY:C911(at_nombreCampoObjeto;at_nombreCampo_BBLci{$i_modos})
		End if 
	End for 
End if 


If (vt_RefMenuModoBusqueda#"")
	RELEASE MENU:C978(vt_RefMenuModoBusqueda)
End if 
vt_RefMenuModoBusqueda:=Create menu:C408
For ($i_modos;1;Size of array:C274(al_refModoBusquedaObjeto))
	APPEND MENU ITEM:C411(vt_RefMenuModoBusqueda;at_nombreCampoObjeto{$i_modos})
	SET MENU ITEM PARAMETER:C1004(vt_RefMenuModoBusqueda;-1;String:C10(al_refModoBusquedaObjeto{$i_modos}))
End for 

