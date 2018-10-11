  // CIM_Indices.Botón 3D()
  // Por: Alberto Bachler K.: 02-01-15, 15:21:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_habilitarEliminacion)
_O_C_INTEGER:C282($i_compuestos;$i_index)
C_LONGINT:C283($i;$l_campo;$l_elemento;$l_filasSeleccionadas;$l_indexes;$l_indexesKeywords;$l_tabla;$l_tipoIndex)
C_POINTER:C301($y_Campo;$y_IdCampo;$y_IdTabla;$y_listBox;$y_nombreIndex;$y_Tabla;$y_tipoCampo;$y_TipoIndex;$y_tipoIndexNum;$y_tipoNoAmbiguo)
C_POINTER:C301($y_uuidIndex)
C_TEXT:C284($t_accion;$t_nombreCampo;$t_nombreIndex;$t_nombreIndexActual;$t_refCampos;$t_refJson;$t_refMenu;$t_refNodo;$t_text;$t_uuidIndex)
C_TEXT:C284($t_varianteTipo)

ARRAY LONGINT:C221($al_campo;0)
ARRAY LONGINT:C221($al_elementosEncontrados;0)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY LONGINT:C221($al_tabla;0)
ARRAY POINTER:C280($ay_campos;0)
ARRAY TEXT:C222($at_uuidIndexCompuestos;0)
ARRAY TEXT:C222($at_uuidIndexSimples;0)

$y_IdTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_Tabla")
$y_IdCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"Id_campo")
$y_Tabla:=OBJECT Get pointer:C1124(Object named:K67:5;"Tabla")
$y_Campo:=OBJECT Get pointer:C1124(Object named:K67:5;"campo")
$y_TipoIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex")
$y_nombreIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreIndex")
$y_tipoCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoCampo")
$y_tipoIndexNum:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoIndex_L")
$y_uuidIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_indice")
$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")

$b_habilitarEliminacion:=True:C214
$l_filasSeleccionadas:=LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
For ($i;1;Size of array:C274($al_filasSeleccionadas))
	If ($y_nombreIndex->{$al_filasSeleccionadas{$i}}="")
		$b_habilitarEliminacion:=False:C215
		$i:=Size of array:C274($al_filasSeleccionadas)
	End if 
End for 

$t_refMenu:=Create menu:C408
MNU_Append ($t_refMenu;__ ("Normalizar nombres de index");"normalizarNombres")
MNU_Append ($t_refMenu;"(-")
MNU_Append ($t_refMenu;__ ("Respaldar indexación");"respaldar")
If ($b_habilitarEliminacion)
	MNU_Append ($t_refMenu;__ ("Eliminar index");"eliminar")
Else 
	MNU_Append ($t_refMenu;"("+__ ("Eliminar index");"eliminar")
End if 
MNU_Append ($t_refMenu;__ ("Reconstruir indexes");"reconstruir")
MNU_Append ($t_refMenu;"(-")
MNU_Append ($t_refMenu;__ ("Actualizar");"actualizar")

$t_accion:=Dynamic pop up menu:C1006($t_refMenu)
Case of 
	: ($t_accion="normalizarNombres")
		CIM_NormalizaNombresIndex 
		
		
	: ($t_accion="respaldar")
		CIM_RespaldaIndex 
		
	: ($t_accion="actualizar")
		POST KEY:C465(Character code:C91("*");Command key mask:K16:1)
		
	: ($t_accion="eliminar")
		For ($i;1;Size of array:C274($al_filasSeleccionadas))
			DELETE INDEX:C967($y_nombreIndex->{$al_filasSeleccionadas{$i}})
		End for 
		
End case 

