  // [xxSTR_Materias].Input.enunciadosMapa()
  // Por: Alberto Bachler K.: 19-05-14, 11:27:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_elemento;$l_idMatriz;$l_idObjeto;$l_proceso;$l_recNumMatriz;$l_recNumObjeto;$l_refPeriodo;$l_retirar;$l_tipoObjeto)
C_POINTER:C301($y_Origen)
C_TEXT:C284($t_enunciado;$t_nombreMatriz;$t_nombrePeriodo)

$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
$y_numeroNivel_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_recNumMatriz_al:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
$l_refPeriodo:=(OBJECT Get pointer:C1124(Object named:K67:5;"refPeriodo"))->
$l_recNumMatriz:=$y_recNumMatriz_al->{$y_recNumMatriz_al->}


Case of 
	: (Form event:C388=On Drop:K2:12)
		If (($y_numeroNivel_al->>0) & ($y_recNumMatriz_al->>0))
			KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatriz;False:C215)
			$l_idMatriz:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
			
			DRAG AND DROP PROPERTIES:C607($y_Origen;$l_elemento;$l_proceso)
			If ($y_Origen=(OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")))
				$l_elemento:=Selected list items:C379($y_Origen->)
				GET LIST ITEM:C378($y_Origen->;$l_elemento;$l_recNumObjeto;$t_enunciado)
				GET LIST ITEM PARAMETER:C985($y_Origen->;$l_recNumObjeto;"TipoObjeto";$l_tipoObjeto)
				GET LIST ITEM PARAMETER:C985($y_Origen->;$l_recNumObjeto;"IdObjeto";$l_idObjeto)
				
				If (Length:C16($t_enunciado)>80)
					$t_enunciado:=Substring:C12($t_enunciado;1;80)+"..."
				End if 
				
				$t_enunciado:=IT_SetTextStyle_Bold (->$t_enunciado;True:C214)
				Case of 
					: ($l_tipoObjeto=Eje_Aprendizaje)
						$l_retirar:=CD_Dlog (0;Replace string:C233(__ ("¿Desea quitar el Eje de aprendizaje ^0 y todas sus dependencias de la configuracion seleccionada?");__ ("^0");$t_enunciado);__ ("");__ ("Quitar");__ ("Cancelar"))
						If ($l_retirar=1)
							EVLG_RetiraAprendizaje ($l_idMatriz;$l_idObjeto;$l_refPeriodo;Eje_Aprendizaje)
						End if 
						
					: ($l_tipoObjeto=Dimension_Aprendizaje)
						$l_retirar:=CD_Dlog (0;Replace string:C233(__ ("¿Desea quitar la Dimensión de aprendizaje ^0 y todas sus dependencias de la configuracion seleccionada?");__ ("^0");$t_enunciado);__ ("");__ ("Quitar");__ ("Cancelar"))
						If ($l_retirar=1)
							EVLG_RetiraAprendizaje ($l_idMatriz;$l_idObjeto;$l_refPeriodo;Dimension_Aprendizaje)
						End if 
						
					: ($l_tipoObjeto=Logro_Aprendizaje)
						$l_retirar:=CD_Dlog (0;Replace string:C233(__ ("¿Desea quitar la Competencia ^0  de la configuración seleccionada?");__ ("^0");$t_enunciado);__ ("");__ ("Quitar");__ ("Cancelar"))
						If ($l_retirar=1)
							EVLG_RetiraAprendizaje ($l_idMatriz;$l_idObjeto;$l_refPeriodo;Logro_Aprendizaje)
						End if 
				End case 
				
				If ($l_retirar=1)
					MPA_ListaEnunciadosMatriz ($y_recNumMatriz_al->{$y_recNumMatriz_al->};$l_refPeriodo;$y_listaEnunciadosMatriz)
				End if 
			End if 
		End if 
		
End case 