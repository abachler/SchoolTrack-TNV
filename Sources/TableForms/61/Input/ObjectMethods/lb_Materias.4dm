  // [BBL_Items].Input.lb_Materias()
  // Por: Alberto Bachler K.: 11-02-15, 15:24:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_filasSeleccionadas;$l_itemSeleccionado)
C_POINTER:C301($y_Materias)
C_TEXT:C284($t_popupItems)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
Case of 
	: (Form event:C388=On Row Moved:K2:32)
		BBLitm_GuardaMaterias 
		BBLitm_ActualizaFichasCatalogo 
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			$l_filasSeleccionadas:=LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"lb_Materias");->$al_filasSeleccionadas)
			Case of 
				: (Size of array:C274($al_filasSeleccionadas)=0)
					$t_popupItems:="(Eliminar"
					
				: (Size of array:C274($al_filasSeleccionadas)=1)
					$t_popupItems:="Eliminar la materia seleccionada"
					
				: (Size of array:C274($al_filasSeleccionadas)>1)
					$t_popupItems:="Eliminar las "+String:C10(Size of array:C274($al_filasSeleccionadas))+" materias seleccionadas"
			End case 
			
			$l_itemSeleccionado:=Pop up menu:C542($t_popupItems)
			Case of 
					  //: ($l_itemSeleccionado=1)
					  //OBJECT SET ENTERABLE(*;"materias";True)
					  //APPEND TO ARRAY($y_materias->;"")
					  //EDIT ITEM(*;"materias";Size of array($y_materias->))
					
				: ($l_itemSeleccionado=1)
					SORT ARRAY:C229($al_filasSeleccionadas;>)
					For ($i;Size of array:C274($al_filasSeleccionadas);1;-1)
						DELETE FROM ARRAY:C228($y_Materias->;$al_filasSeleccionadas{$i})
					End for 
					BBLitm_GuardaMaterias 
					BBLitm_ActualizaFichasCatalogo 
					
			End case 
		End if 
		
	: (Form event:C388=On Selection Change:K2:29)
		
End case 