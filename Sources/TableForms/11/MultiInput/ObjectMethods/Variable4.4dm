IT_Clairvoyance (Self:C308;->aMotAnot;"Motivos para anotaciones")
If (Self:C308->#"")
	$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;Self:C308->)
	If ($el>0)
		$el2:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$el})
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
			vtSTRal_CategoriaAnotacion:=<>atSTR_Anotaciones_categorias{$el}
			vlSTRal_PuntosAnotación:=$puntaje
		End if 
	Else 
		smotivo:=""
		vtSTRal_CategoriaAnotacion:=""
		vlSTRal_PuntosAnotación:=0
	End if 
Else 
	  //GOTO AREA(Self->)
End if 
