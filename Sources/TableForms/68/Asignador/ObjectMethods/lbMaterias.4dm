  // [BBL_Thesaurus].Asignador.List Box()
  // Por: Alberto Bachler K.: 23-07-14, 17:09:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_accion;$l_items;$l_tipoRelacion)
C_POINTER:C301($y_materiaRelacionada;$y_tipoRelacion)



$y_tipoRelacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoReferencia")
$y_materiaRelacionada:=OBJECT Get pointer:C1124(Object named:K67:5;"materiaRelacionada")
$y_notasAplicacion:=OBJECT Get pointer:C1124(Object named:K67:5;"notasAplicacion")
OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("$materiasSeleccionadas")=1)


ARRAY TEXT:C222($at_ItemsMenu;0)
ARRAY TEXT:C222($y_materiaRelacionada->;0)
$l_accion:=0
Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			APPEND TO ARRAY:C911($at_ItemsMenu;__ ("Agregar…"))
			If (Records in set:C195("$materiasSeleccionadas")=1)
				APPEND TO ARRAY:C911($at_ItemsMenu;__ ("Editar…"))
				APPEND TO ARRAY:C911($at_ItemsMenu;"(-")
				APPEND TO ARRAY:C911($at_ItemsMenu;__ ("Eliminar…"))
			Else 
				APPEND TO ARRAY:C911($at_ItemsMenu;"("+__ ("Editar…"))
				APPEND TO ARRAY:C911($at_ItemsMenu;"(-")
				APPEND TO ARRAY:C911($at_ItemsMenu;"("+__ ("Eliminar…"))
			End if 
			APPEND TO ARRAY:C911($at_ItemsMenu;"(-")
			
			If (Records in selection:C76([BBL_Thesaurus:68])>0)
				APPEND TO ARRAY:C911($at_ItemsMenu;__ ("Imprimir lista actual…"))
			Else 
				APPEND TO ARRAY:C911($at_ItemsMenu;"("+__ ("Imprimir lista actual…"))
			End if 
			APPEND TO ARRAY:C911($at_ItemsMenu;__ ("Imprimir todo…"))
			
			$l_accion:=IT_DynamicPopupMenu_Array (->$at_ItemsMenu)
		End if 
		
		
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		$l_accion:=2
		
		
		
	: (Form event:C388=On Selection Change:K2:29)
		Case of 
			: (Records in set:C195("$materiasSeleccionadas")=1)
				BBL_AccionesThesaurus ("detallesRegistro")
				OBJECT SET VISIBLE:C603(*;"notasAplicacion";True:C214)
				OBJECT SET VISIBLE:C603(*;"tipoReferencia";True:C214)
				OBJECT SET VISIBLE:C603(*;"materiaRelacionada";True:C214)
				
				
				
			: (Records in set:C195("$materiasSeleccionadas")>1)
				(OBJECT Get pointer:C1124(Object named:K67:5;"usoMateria"))->:=""
				OBJECT SET VISIBLE:C603(*;"notasAplicacion";False:C215)
				OBJECT SET VISIBLE:C603(*;"tipoReferencia";False:C215)
				OBJECT SET VISIBLE:C603(*;"materiaRelacionada";False:C215)
				AT_Initialize ($y_tipoRelacion;$y_materiaRelacionada)
				
				
			: (Records in set:C195("$materiasSeleccionadas")=0)
				(OBJECT Get pointer:C1124(Object named:K67:5;"usoMateria"))->:=""
				OBJECT SET VISIBLE:C603(*;"notasAplicacion";False:C215)
				OBJECT SET VISIBLE:C603(*;"tipoReferencia";False:C215)
				OBJECT SET VISIBLE:C603(*;"materiaRelacionada";False:C215)
				AT_Initialize ($y_tipoRelacion;$y_materiaRelacionada)
				
		End case 
		
		
		
End case 


Case of 
	: ($l_accion=1)
		BBL_AccionesThesaurus ("agregar")
		
	: ($l_accion=2)
		BBL_AccionesThesaurus ("editar")
		
	: ($l_accion=4)
		BBL_AccionesThesaurus ("eliminar")
		
	: ($l_accion=6)
		BBL_AccionesThesaurus ("imprimirSeleccion")
		
	: ($l_accion=7)
		BBL_AccionesThesaurus ("imprimirTodo")
		
End case 

OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("$materiasSeleccionadas")=1)
