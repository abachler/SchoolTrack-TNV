  // [BBL_Lectores].Input.popup.lectores.grupo()
  // Por: Alberto Bachler: 22/11/13, 12:12:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_opcionUsuario;$i_indice)

ARRAY LONGINT:C221($al_idGrupos;0)
ARRAY TEXT:C222($at_grupos;0)


COPY ARRAY:C226(<>alBBL_GruposLectores;$al_idGrupos)
COPY ARRAY:C226(<>atBBL_GruposLectores;$at_grupos)

For ($i_indice;Size of array:C274($al_idGrupos);1;-1)
	If (($al_idGrupos{$i_indice}<0) & ($al_idGrupos{$i_indice}#-5))
		AT_Delete ($i_indice;1;->$al_idGrupos;->$at_grupos)
	End if 
End for 

APPEND TO ARRAY:C911($at_grupos;"(-")
APPEND TO ARRAY:C911($al_idGrupos;0)
SORT ARRAY:C229($al_idGrupos;$at_grupos)
$l_opcionUsuario:=IT_DynamicPopupMenu_Array (->$at_grupos)

If ($l_opcionUsuario>0)
	[BBL_Lectores:72]ID_GrupoLectores:37:=$al_idGrupos{$l_opcionUsuario}
	[BBL_Lectores:72]Grupo:2:=$at_grupos{$l_opcionUsuario}
End if 

