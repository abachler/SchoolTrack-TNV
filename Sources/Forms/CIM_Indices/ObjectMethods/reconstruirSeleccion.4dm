  // CIM_Indices.Botón1()
  // Por: Alberto Bachler K.: 08-04-15, 13:20:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
_O_C_INTEGER:C282($i_campos;$i_indexes)
C_LONGINT:C283($l_filaSeleccionada;$l_idProgreso;$l_posicionNodo;$l_tipo)
C_POINTER:C301($y_listBox;$y_tabla;$y_uuidIndex)
C_TEXT:C284($t_nombreCampo;$t_nombreIndex;$t_nombreIndexSeleccionado;$t_refNodoIndex;$t_refRaiz;$t_rutaDefinicionIndexes;$t_textoJson;$t_uuid;$t_uuidSeleccionado;$t_variante)

ARRAY LONGINT:C221($al_Campos;0)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY LONGINT:C221($al_tablas;0)
ARRAY LONGINT:C221($al_tipoNodos;0)
ARRAY POINTER:C280($ay_Campos;0)
ARRAY TEXT:C222($at_nombreNodo;0)
ARRAY TEXT:C222($at_refNodos;0)

$y_uuidIndex:=OBJECT Get pointer:C1124(Object named:K67:5;"ID_indice")

CIM_RespaldaIndex 

If (Application type:C494#4D Remote mode:K5:5)
	$t_rutaDefinicionIndexes:=Get 4D folder:C485(Database folder:K5:14)+"indexacionSchooltrack.json"
	DOCUMENT TO BLOB:C525($t_rutaDefinicionIndexes;$x_blob)
Else 
	$x_blob:=KRL_GetFileFromServer ("indexacionSchooltrack.json")
End if 

If (BLOB size:C605($x_blob)>0)
	ARRAY OBJECT:C1221($ao_Objetos;0)
	
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	
	$t_textoJson:=Convert to text:C1012($x_blob;"UTF-8")
	$ob:=JSON Parse:C1218($t_textoJson)
	OB_GetChildNodes ($ob;->$at_nombreNodo;->$ao_Objetos)
	
	  // Modificado por: Alexis Bustamante (12-06-2017)
	  //TICKET 179869
	
	  //$t_textoJson:=BLOB to text($x_blob;UTF8 text without length)
	  //$t_refRaiz:=JSON Parse text ($t_textoJson)
	  //JSON GET CHILD NODES ($t_refRaiz;$at_refNodos;$al_tipoNodos;$at_nombreNodo)
	
	$y_listBox:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxIndexes")
	$l_filaSeleccionada:=LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
	$l_idProgreso:=Progress New 
	For ($i_indexes;1;Size of array:C274($al_filasSeleccionadas))
		$t_uuidSeleccionado:="Index "+$y_uuidIndex->{$al_filasSeleccionadas{$i_indexes}}
		$l_posicionNodo:=Find in array:C230($at_nombreNodo;$t_uuidSeleccionado)
		
		If ($l_posicionNodo>0)
			OB_GET ($ao_Objetos{$l_posicionNodo};->$t_uuid;"uuid")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$t_nombreIndex;"nombreIndex")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$t_nombreCampo;"nombreCampo")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$l_tipo;"tipo")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$t_variante;"varianteTipo")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$al_tablas;"tabla")
			OB_GET ($ao_Objetos{$l_posicionNodo};->$al_Campos;"campo")
			
			  //$t_refNodoIndex:=JSON Get child by position ($t_refRaiz;$l_posicionNodo)
			  //$t_refNodoIndex:=$at_refNodos{$l_posicionNodo}
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$t_uuid;"uuid")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$t_nombreIndex;"nombreIndex")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$t_nombreCampo;"nombreCampo")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$l_tipo;"tipo")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$t_variante;"varianteTipo")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$al_tablas;"tabla")
			  //JSON_ExtraeValorElemento ($t_refNodoIndex;->$al_Campos;"campo")
			AT_Initialize (->$ay_Campos)
			For ($i_campos;1;Size of array:C274($al_tablas))
				APPEND TO ARRAY:C911($ay_campos;Field:C253($al_tablas{$i_campos};$al_Campos{$i_campos}))
			End for 
			
			If ($t_nombreIndex#"")
				DELETE INDEX:C967($t_nombreIndex)
				$y_tabla:=Table:C252($al_tablas{1})
				CREATE INDEX:C966($y_tabla->;$ay_campos;$l_tipo;$t_nombreIndex)
			End if 
		End if 
		
		Progress SET TITLE ($l_idProgreso;"Reconstruyendo indexes";$i_indexes/Size of array:C274($al_filasSeleccionadas);$t_nombreIndex;True:C214)
	End for 
	  //JSON CLOSE ($t_refRaiz)  //20150421 RCH Se agrega cierre
	Progress QUIT ($l_idProgreso)
	USR_RegisterUserEvent (UE_SIM_IndexRebuild;0;__ ("Reconstrucción parcial"))
End if 


