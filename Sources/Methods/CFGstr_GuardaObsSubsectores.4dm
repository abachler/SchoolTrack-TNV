//%attributes = {}
  // CFGstr_GuardaObsSubsectores()
  //
  //
  // creado por: Alberto Bachler Klein: 10-12-15, 19:15:33
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_expanded;$b_isFolder)
C_LONGINT:C283($i;$l_idCategoria;$l_idObservacion;$l_index)
C_POINTER:C301($y_listaCategorias;$y_listboxObservaciones;$y_nivelNumero_al;$y_nivelNumero_at;$y_objeto_categorias;$y_objeto_observaciones;$y_observaciones;$y_refNivel_t)
C_TEXT:C284($t_categoria;$t_categoria2;$t_nivel;$t_nivelActual;$t_observacion;$t_ultimaCategoria)
C_OBJECT:C1216($ob_nodoCategoria;$ob_nodoNivel;$ob_observacion;$ob_raiz)

ARRAY OBJECT:C1221($ao_Categorias;0)
ARRAY OBJECT:C1221($ao_observaciones;0)

$y_listboxObservaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_observaciones")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")

$y_nivelNumero_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_refNivel_t:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual")
If (Num:C11($y_refNivel_t->)=0)
	
	
Else 
	
	AT_Initialize (->$ao_Categorias;->$ao_observaciones)
	$l_idCategoria:=0
	$l_idObservacion:=0
	$b_isFolder:=True:C214
	$b_expanded:=True:C214
	$t_ultimaCategoria:=""
	For ($i;1;Size of array:C274($y_objeto_categorias->))
		$t_categoria:=$y_objeto_categorias->{$i}
		If ($t_categoria=__ ("[sin categoría]"))
			$t_categoria2:="none"
		Else 
			$t_categoria2:=$y_objeto_categorias->{$i}
		End if 
		If ($t_categoria#$t_ultimaCategoria)
			$t_ultimaCategoria:=$t_categoria
			$l_idCategoria:=$l_idCategoria-1
			
			CLEAR VARIABLE:C89($ob_nodoCategoria)
			$ob_nodoCategoria:=OB_Create 
			OB_SET ($ob_nodoCategoria;->$t_categoria2;"title")
			OB_SET ($ob_nodoCategoria;->$l_idCategoria;"id")
			  //OB_SET ($ob_nodoCategoria;->$b_isFolder;"is folder")
			OB_SET ($ob_nodoCategoria;->$b_isFolder;"isFolder")  //20180718 ASM Ticket 211873
			OB_SET ($ob_nodoCategoria;->$b_expanded;"expand")
			
			
			AT_Initialize (->$ao_Observaciones)
			$l_index:=$i
			While ($t_categoria=$t_ultimaCategoria)
				$t_observacion:=$y_objeto_observaciones->{$l_index}
				If ($t_observacion#"")
					$l_idObservacion:=$l_idObservacion+1
					CLEAR VARIABLE:C89($ob_observacion)
					$ob_observacion:=OB_Create 
					OB_SET ($ob_observacion;->$t_observacion;"title")
					OB_SET ($ob_observacion;->$l_idObservacion;"id")
					APPEND TO ARRAY:C911($ao_observaciones;$ob_observacion)
				End if 
				If ($l_index<Size of array:C274($y_objeto_categorias->))
					$l_index:=$l_index+1
					$t_categoria:=$y_objeto_categorias->{$l_index}
				Else 
					$t_categoria:=""
				End if 
			End while 
			
			OB_SET ($ob_nodoCategoria;->$ao_observaciones;"children")
			APPEND TO ARRAY:C911($ao_categorias;$ob_nodoCategoria)
			
		End if 
	End for 
	
	$ob_Raiz:=[xxSTR_Materias:20]ob_Observaciones:7
	$ob_nodoNivel:=OB_Create 
	OB_SET ($ob_nodoNivel;->$ao_categorias;"categorias")
	OB_SET ($ob_raiz;->$ob_nodoNivel;$y_refNivel_t->)
	
	[xxSTR_Materias:20]ob_Observaciones:7:=$ob_raiz
	SAVE RECORD:C53([xxSTR_Materias:20])
End if 