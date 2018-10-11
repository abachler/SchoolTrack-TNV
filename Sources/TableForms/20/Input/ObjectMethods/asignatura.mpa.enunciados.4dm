  // [xxSTR_Materias].Input.asignatura.mpa.enunciados()
  // Por: Alberto Bachler K.: 19-05-14, 11:19:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_AsignarSoloArrastrados)
C_LONGINT:C283($i;$l_elemento;$l_idEnunciado;$l_idMatriz;$l_proceso;$l_recNumMatriz;$l_referenciaItem;$l_refPeriodo;$l_tipoObjeto;$p;$l_nivelNumero)
C_POINTER:C301($y_Origen)
C_TEXT:C284($t_enunciado;$t_nombreMatriz;$t_nombrePeriodo)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
$y_numeroNivel_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_recNumMatriz_al:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
$l_refPeriodo:=(OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo"))->

Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_Origen;$l_elemento;$l_proceso)
		
		If ($y_Origen=(OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")))
			$l_elemento:=Selected list items:C379($y_Origen->;$al_filasSeleccionadas)
			
			If (Size of array:C274($al_filasSeleccionadas)>0)
				READ ONLY:C145([MPA_DefinicionCompetencias:187])
				READ ONLY:C145([MPA_DefinicionDimensiones:188])
				READ ONLY:C145([MPA_DefinicionEjes:185])
				READ ONLY:C145([MPA_DefinicionAreas:186])
				READ ONLY:C145([MPA_AsignaturasMatrices:189])
				
				If (($y_recNumMatriz_al->>0) & ($y_numeroNivel_al->>0))
					$l_recNumMatriz:=$y_recNumMatriz_al->{$y_recNumMatriz_al->}
					$l_nivelNumero:=$y_numeroNivel_al->{$y_numeroNivel_al->}
					KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatriz;False:C215)
					$l_idMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
					$b_AsignarSoloArrastrados:=(Size of array:C274($al_filasSeleccionadas)>1)
					$p:=IT_UThermometer (1;0;__ ("Actualizando matriz de evaluación de aprendizajes..."))
					For ($i;1;Size of array:C274($al_filasSeleccionadas))
						SELECT LIST ITEMS BY POSITION:C381($y_Origen->;$al_filasSeleccionadas{$i})
						GET LIST ITEM:C378($y_Origen->;$al_filasSeleccionadas{$i};$l_referenciaItem;$t_enunciado)
						GET LIST ITEM PARAMETER:C985($y_Origen->;$l_referenciaItem;"IdObjeto";$l_idEnunciado)
						GET LIST ITEM PARAMETER:C985($y_Origen->;$l_referenciaItem;"TipoObjeto";$l_tipoObjeto)
						EVLG_AgregaObjeto_a_Matriz ($l_idMatriz;$l_tipoObjeto;$l_idEnunciado;$l_refPeriodo;$b_AsignarSoloArrastrados)
					End for 
					$p:=IT_UThermometer (-2;$p)
					MPA_ListaEnunciadosMatriz ($y_recNumMatriz_al->{$y_recNumMatriz_al->};$l_refPeriodo;$y_listaEnunciadosMatriz)
				End if 
			End if 
		End if 
End case 