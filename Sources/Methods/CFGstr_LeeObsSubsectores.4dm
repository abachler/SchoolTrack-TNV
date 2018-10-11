//%attributes = {}
  // CFGstr_LeeObsSubsectores()
  //
  //
  // creado por: Alberto Bachler Klein: 10-12-15, 17:16:07
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_crearSinCategoria;$b_expanded;$b_isFolder;$b_sinCategoriaExiste)
C_LONGINT:C283($i;$i_Categorias;$i_childrens;$l_idCategoria;$l_idCategoriaTemp;$l_posicion)
C_POINTER:C301($y_categorias;$y_listaCategorias;$y_listboxObservaciones;$y_nivelNumero_al;$y_nivelNumero_at;$y_objeto_categorias;$y_objeto_observaciones;$y_observaciones;$y_refNivel_t)
C_TEXT:C284($t_Categoria;$t_llave;$t_nivel;$t_nivelActual;$t_observacion;$t_tempCategoria)
C_OBJECT:C1216($ob_nodoCategoria;$ob_nodoNivel;$ob_raiz)

ARRAY LONGINT:C221($al_filas;0)
ARRAY LONGINT:C221($al_tipo;0)
ARRAY TEXT:C222($at_nombres;0)
ARRAY OBJECT:C1221($ao_Categorias;0)
ARRAY OBJECT:C1221($ao_Childrens;0)
ARRAY OBJECT:C1221($ao_Observaciones;0)

$y_listboxObservaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_observaciones")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")
$y_objeto_categorias:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Categorias")
$y_objeto_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"objeto_Observaciones")

$y_nivelNumero_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_refNivel_t:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual")

CLEAR VARIABLE:C89($ao_Categorias)
CLEAR VARIABLE:C89($ao_Childrens)
AT_Initialize ($y_listaCategorias;$y_categorias;$y_observaciones;$y_objeto_categorias;$y_objeto_observaciones;->$ao_Categorias;->$ao_Childrens)

  // verifico que exista la categoría "none" (sin categoria)
$l_idCategoria:=0
$b_sinCategoriaExiste:=False:C215
$t_llave:=String:C10($y_nivelNumero_al->{$y_nivelNumero_al->})+".categorias"
$ob_raiz:=[xxSTR_Materias:20]ob_Observaciones:7
OB_GET ($ob_raiz;->$ao_Categorias;$t_llave)
For ($i_Categorias;1;Size of array:C274($ao_Categorias))
	$t_Categoria:=""
	  //OB_GET ($ao_Categorias{$i_Categorias};->$t_Categoria;"categorias.title")
	  //OB_GET ($ao_Categorias{$i_Categorias};->$l_idCategoriaTemp;"categorias.id")
	OB_GET ($ao_Categorias{$i_Categorias};->$t_Categoria;"title")
	OB_GET ($ao_Categorias{$i_Categorias};->$l_idCategoriaTemp;"id")
	If ($l_idCategoriaTemp<$l_idCategoria)
		$l_idCategoria:=$l_idCategoria-1
	End if 
	If ($t_Categoria="none")
		$b_sinCategoriaExiste:=True:C214
	End if 
End for 

If (Not:C34($b_sinCategoriaExiste))
	$t_categoria:="none"
	AT_Initialize (->$ao_Observaciones)
	$ob_nodoCategoria:=OB_Create 
	OB_SET ($ob_nodoCategoria;->$t_categoria;"title")
	OB_SET ($ob_nodoCategoria;->$l_idCategoria;"id")
	OB_SET ($ob_nodoCategoria;->$b_isFolder;"is folder")
	OB_SET ($ob_nodoCategoria;->$b_expanded;"expand")
	OB_SET ($ob_nodoCategoria;->$ao_observaciones;"children")
	APPEND TO ARRAY:C911($ao_categorias;$ob_nodoCategoria)
	
	$ob_nodoNivel:=OB_Create 
	OB_SET ($ob_nodoNivel;->$ao_categorias;"categorias")
	OB_SET ($ob_raiz;->$ob_nodoNivel;$y_refNivel_t->)
	[xxSTR_Materias:20]ob_Observaciones:7:=$ob_raiz
	SAVE RECORD:C53([xxSTR_Materias:20])
End if 
  //.


  // leeo las observaciones desde el objeto
For ($i_Categorias;1;Size of array:C274($ao_Categorias))
	$t_Categoria:=""
	AT_Initialize (->$ao_Childrens)
	  //OB_GET ($ao_Categorias{$i_Categorias};->$t_Categoria;"categorias.title")
	  //OB_GET ($ao_Categorias{$i_Categorias};->$ao_Childrens;"categorias.children")
	OB_GET ($ao_Categorias{$i_Categorias};->$t_Categoria;"title")
	OB_GET ($ao_Categorias{$i_Categorias};->$ao_Childrens;"children")
	If (($t_categoria="none") | ($t_categoria=""))
		$t_categoria:=__ ("[sin categoria]")
		$b_crearSinCategoria:=False:C215
	End if 
	If (Size of array:C274($ao_Childrens)>0)
		For ($i_childrens;1;Size of array:C274($ao_Childrens))
			$t_observacion:=""
			OB_GET ($ao_Childrens{$i_childrens};->$t_observacion;"title")
			APPEND TO ARRAY:C911($y_objeto_categorias->;$t_Categoria)
			APPEND TO ARRAY:C911($y_objeto_observaciones->;$t_observacion)
		End for 
	Else 
		APPEND TO ARRAY:C911($y_objeto_categorias->;$t_Categoria)
		APPEND TO ARRAY:C911($y_objeto_observaciones->;"")
	End if 
End for 




COPY ARRAY:C226($y_objeto_categorias->;$y_listaCategorias->)
AT_DistinctsArrayValues ($y_listaCategorias)
If (Size of array:C274($y_listaCategorias->)>0)
	LISTBOX SELECT ROW:C912(*;"lb_categoria";1;0)
	$y_objeto_categorias->{0}:=$y_listaCategorias->{$y_listaCategorias->}
	AT_SearchArray ($y_objeto_categorias;"=";->$al_filas)
	For ($i;1;Size of array:C274($al_filas))
		If ($y_objeto_observaciones->{$al_filas{$i}}#"")
			APPEND TO ARRAY:C911($y_observaciones->;$y_objeto_observaciones->{$al_filas{$i}})
		End if 
	End for 
End if 


$l_posicion:=Find in array:C230($y_listaCategorias->;__ ("[sin categoria]"))
If ($l_posicion>0)
	LISTBOX SET ROW FONT STYLE:C1268(*;"lb_categoria";$l_posicion;Plain:K14:1)
End if 



