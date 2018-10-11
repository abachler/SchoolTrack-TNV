  // [Alumnos_Conducta].AnotExpress.Botón invisible1()
  // Por: Alberto Bachler K.: 09-05-14, 12:53:29
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$l_itemSeleccionado:=AL_MuestraListaAnotaciones 
If ($l_itemSeleccionado>0)
	$t_motivo:=vtHL_SelectedElementText
	$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;$t_motivo)
	
	If ($el>0)
		$el2:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$el})
		
		If ($el2>0)
			(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=$t_motivo
			(OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion"))->:=<>atSTR_Anotaciones_categorias{$el}
			  //MONO Ticket 180570
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
End if 

