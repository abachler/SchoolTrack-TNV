$choice:=AL_MuestraListaAnotaciones 
If ($choice>0)
	$motivo:=vtHL_SelectedElementText
	$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;$motivo)
	If ($el>0)
		$categoria:=<>atSTR_Anotaciones_categorias{$el}
		$matriz:=<>aiID_Matriz{$el}
		$el2:=Find in array:C230(aiSTR_IDCategoria;$matriz)
		If ($el2>0)
			Case of 
				: (ai_TipoAnotacion{$el2}>0)
					vtSTRal_TipoAnotacion:="+"
					$puntaje:=<>aiSTR_Anotaciones_motivo_puntaj{$el}
				: (ai_TipoAnotacion{$el2}=0)
					vtSTRal_TipoAnotacion:="="
					$puntaje:=0
				: (ai_TipoAnotacion{$el2}<0)
					vtSTRal_TipoAnotacion:="-"
					$puntaje:=<>aiSTR_Anotaciones_motivo_puntaj{$el}*-1
			End case 
			sMotivo:=$motivo
			vtSTRal_CategoriaAnotacion:=$categoria
			vlSTRal_PuntosAnotación:=$puntaje
		End if 
	End if 
End if 