IT_Clairvoyance (Self:C308;->aMotAnot;"Motivos para anotaciones")
If (Form event:C388=On Losing Focus:K2:8)
	If (Self:C308->#"")
		$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;Self:C308->)
		If ($el>0)
			$el2:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$el})
			If ($el2>0)
				  //MONO Ticket 180570
				(OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion"))->:=<>atSTR_Anotaciones_categorias{$el}
				
				Case of 
					: (ai_TipoAnotacion{$el2}>0)
						(OBJECT Get pointer:C1124(Object named:K67:5;"tipo.anotacion"))->:="+"
						$puntaje:=<>aiSTR_Anotaciones_motivo_puntaj{$el}
					: (ai_TipoAnotacion{$el2}=0)
						(OBJECT Get pointer:C1124(Object named:K67:5;"tipo.anotacion"))->:="="
						$puntaje:=0
					: (ai_TipoAnotacion{$el2}<0)
						(OBJECT Get pointer:C1124(Object named:K67:5;"tipo.anotacion"))->:="-"
						$puntaje:=Abs:C99(<>aiSTR_Anotaciones_motivo_puntaj{$el})*-1
				End case 
				
				(OBJECT Get pointer:C1124(Object named:K67:5;"puntos.anotacion"))->:=$puntaje
				
			End if 
		Else 
			(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
			(OBJECT Get pointer:C1124(Object named:K67:5;"puntos.anotacion"))->:=0
			(OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion"))->:=""
			(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
		End if 
	Else 
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"puntos.anotacion"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
	End if 
End if 

If ((OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->="")
	  //GOTO OBJECT(*;"anotacion.motivo")
End if 