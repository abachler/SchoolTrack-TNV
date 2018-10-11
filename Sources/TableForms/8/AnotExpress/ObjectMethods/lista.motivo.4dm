  // [Alumnos_Conducta].AnotExpress.lista.motivo()
  // Por: Alberto Bachler K.: 08-05-14, 19:15:14
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_fecha:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_listaMotivo:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_listaTipoAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.tipoAnotacion")
$y_listaCategoriaAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.categoriaAnotacion")
$y_listaPuntajeAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"lista.puntajeAnotacion")


$l_fila:=$y_listaMotivo->

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
	Else 
		$t_motivo:=$y_listaMotivo->{$l_fila}
		IT_Clairvoyance (->$t_motivo;->aMotAnot;"Motivos para anotaciones")
		If (Form event:C388=On Losing Focus:K2:8)
			If ($t_motivo#"")
				$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;$t_motivo)
				If ($el>0)
					$el2:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$el})
					If ($el2>0)
						$y_listaPuntajeAnotacion->{$l_fila}:=<>aiSTR_Anotaciones_motivo_puntaj{$el}
						$y_listaCategoriaAnotacion->{$l_fila}:=<>atSTR_Anotaciones_categorias{$el}
						Case of 
							: (ai_TipoAnotacion{$el2}>0)
								$y_listaTipoAnotacion->{$l_fila}:="+"
							: (ai_TipoAnotacion{$el2}=0)
								$y_listaTipoAnotacion->{$l_fila}:="="
								$puntaje:=0
							: (ai_TipoAnotacion{$el2}<0)
								$y_listaTipoAnotacion->{$l_fila}:="-"
						End case 
					End if 
				Else 
					$y_listaMotivo->{$l_fila}:=""
					$y_listaPuntajeAnotacion->{$l_fila}:=0
					$y_listaCategoriaAnotacion->{$l_fila}:=""
					$y_listaTipoAnotacion->{$l_fila}:=0
				End if 
			Else 
				$y_listaMotivo->{$l_fila}:=""
				$y_listaPuntajeAnotacion->{$l_fila}:=0
				$y_listaCategoriaAnotacion->{$l_fila}:=""
				$y_listaTipoAnotacion->{$l_fila}:=0
			End if 
		End if 
		
		  //If ($y_listaMotivo->{$l_fila}="")
		  //EDIT ITEM(*;"lista.motivo";$l_fila)
		  //End if 
		
End case 



