C_LONGINT:C283($pageRef)
C_TEXT:C284($pageTitle)
$pageNumber:=Selected list items:C379(hl_PaginasOpciones)
GET LIST ITEM:C378(Self:C308->;*;$pageRef;$pageTitle)
  //GOTO PAGE($pageRef)

Case of 
	: ($pageNumber=1)
		$pageRef:=-1
		MPA_OpcionesCalculos_Finales 
		If ([MPA_AsignaturasMatrices:189]BaseCalculoResultado:23>0)
			GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			$l_abajo:=$l_arriba+530
			SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			FORM GOTO PAGE:C247(1)
		Else 
			GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			$l_abajo:=$l_arriba+171
			SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			FORM GOTO PAGE:C247(4)
		End if 
		
	: ($pageNumber=2)
		$pageRef:=1
		MPA_OpcionesCalculos_Ejes 
		
	: ($pageNumber=3)
		$pageRef:=2
		MPA_OpcionesCalculo_Dimensiones 
		
End case 
GET LIST ITEM:C378(Self:C308->;*;$pageRef;$pageTitle)
vl_SelectedTab:=$pageRef