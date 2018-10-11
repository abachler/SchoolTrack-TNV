  // [xxSTR_Materias].Input.Botón 3D()
  //
  //
  // creado por: Alberto Bachler Klein: 10-12-15, 15:05:52
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_expanded;$b_isFolder)
C_LONGINT:C283($i;$l_idCategoria;$l_nivelActual;$l_posicion)
C_POINTER:C301($y_nivelNombre_at;$y_nivelNumero_al;$y_refNivel_t)
C_TEXT:C284($t_categoria;$t_item;$t_llave;$t_llaveNivelSeleccionado;$t_nivel;$t_nivelActual;$t_refMenu;$t_refSubMenu;$t_refSubMenuDesde;$t_refSubMenuHacia)
C_TEXT:C284($t_textoItem)
C_OBJECT:C1216($ob_nivel;$ob_nodoCategoria;$ob_nodoNivel;[xxSTR_Materias:20]ob_Observaciones:7)

ARRAY OBJECT:C1221($ao_categorias;0)
ARRAY OBJECT:C1221($ao_Observaciones;0)

$y_refNivel_t:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelActual")
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$y_nivelNombre_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")

$l_nivelActual:=Num:C11($y_refNivel_t->)


$t_refSubMenuDesde:=Create menu:C408
For ($i;1;Size of array:C274($y_nivelNumero_al->))
	If ($y_nivelNumero_al->{$i}#$l_nivelActual)
		APPEND MENU ITEM:C411($t_refSubMenuDesde;$y_nivelNombre_at->{$i})
		SET MENU ITEM PARAMETER:C1004($t_refSubMenuDesde;-1;"Desde:"+String:C10($y_nivelNumero_al->{$i}))
	Else 
		APPEND MENU ITEM:C411($t_refSubMenuDesde;"("+$y_nivelNombre_at->{$i})
	End if 
End for 

$t_refSubMenuHacia:=Create menu:C408
For ($i;1;Size of array:C274($y_nivelNumero_al->))
	If ($y_nivelNumero_al->{$i}#$l_nivelActual)
		APPEND MENU ITEM:C411($t_refSubMenuHacia;$y_nivelNombre_at->{$i})
		SET MENU ITEM PARAMETER:C1004($t_refSubMenuHacia;-1;"Hacia:"+String:C10($y_nivelNumero_al->{$i}))
	Else 
		APPEND MENU ITEM:C411($t_refSubMenuHacia;"("+$y_nivelNombre_at->{$i})
	End if 
End for 
APPEND MENU ITEM:C411($t_refSubMenuHacia;"-")
APPEND MENU ITEM:C411($t_refSubMenuHacia;"Todos los niveles")
SET MENU ITEM PARAMETER:C1004($t_refSubMenuHacia;-1;"Hacia:0")


$t_refMenu:=Create menu:C408
$t_textoItem:=Replace string:C233(__ ("En ^0, usar observaciones definidas en…");"^0";$y_nivelNombre_at->{$y_nivelNombre_at->})
APPEND MENU ITEM:C411($t_refMenu;$t_textoItem;$t_refSubMenuDesde)
$t_textoItem:=Replace string:C233(__ ("Copiar observaciones definidas en ^0 a…");"^0";$y_nivelNombre_at->{$y_nivelNombre_at->})
APPEND MENU ITEM:C411($t_refMenu;$t_textoItem;$t_refSubMenuHacia)
APPEND MENU ITEM:C411($t_refMenu;"-")
APPEND MENU ITEM:C411($t_refMenu;__ ("Borrar Observaciones definidas en ")+$y_nivelNombre_at->{$y_nivelNombre_at->})
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"borrar")
APPEND MENU ITEM:C411($t_refMenu;"-")
APPEND MENU ITEM:C411($t_refMenu;__ ("Añadir categoría"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"addcat")
APPEND MENU ITEM:C411($t_refMenu;__ ("Añadir observación"))
SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"addobs")

[xxSTR_Materias:20]ob_Observaciones:7:=[xxSTR_Materias:20]ob_Observaciones:7
$t_item:=Dynamic pop up menu:C1006($t_refMenu)
Case of 
	: ($t_item="Desde:@")
		$t_llaveNivelSeleccionado:=String:C10(Num:C11($t_item))
		OB_GET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$t_llaveNivelSeleccionado)
		OB_SET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$y_refNivel_t->)
		SAVE RECORD:C53([xxSTR_Materias:20])
		CFGstr_LeeObsSubsectores 
		
	: ($t_item="Hacia:0")
		OB_GET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$y_refNivel_t->)
		For ($i;1;Size of array:C274($y_nivelNumero_al->))
			$t_llaveDestino:=String:C10($y_nivelNumero_al->{$i})
			OB_SET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$t_llaveDestino)
		End for 
		SAVE RECORD:C53([xxSTR_Materias:20])
		
	: ($t_item="Hacia:@")
		$t_llaveNivelSeleccionado:=String:C10(Num:C11($t_item))
		OB_GET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$y_refNivel_t->)
		OB_SET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nivel;$t_llaveNivelSeleccionado)
		SAVE RECORD:C53([xxSTR_Materias:20])
		$l_posicion:=Find in array:C230($y_nivelNumero_al->;Num:C11($t_item))
		If ($l_posicion>0)
			LISTBOX SELECT ROW:C912(*;"listbox.niveles";$l_posicion)
		End if 
		$y_refNivel_t->:=String:C10(Num:C11($t_item))
		CFGstr_LeeObsSubsectores 
		
	: ($t_item="borrar")
		$ob_nodoCategoria:=OB_Create 
		$t_categoria:="none"
		$l_idCategoria:=-1
		OB_SET ($ob_nodoCategoria;->$t_categoria;"title")
		OB_SET ($ob_nodoCategoria;->$l_idCategoria;"id")
		OB_SET ($ob_nodoCategoria;->$b_isFolder;"is folder")
		OB_SET ($ob_nodoCategoria;->$b_expanded;"expand")
		AT_Initialize (->$ao_categorias;->$ao_Observaciones)
		OB_SET ($ob_nodoCategoria;->$ao_observaciones;"children")
		APPEND TO ARRAY:C911($ao_categorias;$ob_nodoCategoria)
		
		$ob_nodoNivel:=OB_Create 
		OB_SET ($ob_nodoNivel;->$ao_categorias;"categorias")
		OB_SET ([xxSTR_Materias:20]ob_Observaciones:7;->$ob_nodoNivel;$y_refNivel_t->)
		
		CFGstr_LeeObsSubsectores 
		
		
	: ($t_item="addcat")
		POST KEY:C465(Character code:C91("+");Shift key mask:K16:3+Command key mask:K16:1)
	: ($t_item="addobs")
		POST KEY:C465(Character code:C91("+");Command key mask:K16:1)
End case 






RELEASE MENU:C978($t_refMenu)