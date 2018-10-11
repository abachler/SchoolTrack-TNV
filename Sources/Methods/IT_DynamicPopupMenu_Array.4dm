//%attributes = {}
  // IT_DynamicPopupMenu_Array(arreglo:Y{;objeto:Y) <- itemSeleccionado
  // Por: Alberto Bachler: 17/09/13, 13:43:27
  //  ---------------------------------------------
  // muestra un menú construido a partir de un arreglo
  // -> arreglo: puntero sobre una variable de tipo arreglo texto: contiene los items a mostrar
  // <-> objeto: puntero sobre variable o campo alfa o texto a la que se asignará automaticamente el valor del item seleccionado
  // itemSeleccionado: numérico, el item seleccionado por el usuario
  // los items con texto igual a "(-" serán mostrados como líneas separadoras
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$l_itemPreseleccionado;$l_itemSeleccionado)
C_POINTER:C301($y_menuContentArray;$y_Object)
C_TEXT:C284($t_referenciaMenu)
If (False:C215)
	C_LONGINT:C283(IT_DynamicPopupMenu_Array ;$0)
End if 
$y_menuContentArray:=$1

Case of 
	: (Count parameters:C259=2)
		$y_Object:=$2
		
	: (Count parameters:C259=3)
		$y_Object:=$2
		$t_objetoReferenciaPosicion:=$3
		OBJECT GET COORDINATES:C663(*;$t_objetoReferenciaPosicion;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
End case 

If (Not:C34(Is nil pointer:C315($y_Object)))
	Case of 
		: ((Type:C295($y_Object->)=Is text:K8:3) | (Type:C295($y_Object->)=Is string var:K8:2) | (Type:C295($y_Object->)=Is alpha field:K8:1))
			$l_itemPreseleccionado:=Find in array:C230($y_menuContentArray->;$y_Object->)
		: ((Type:C295($y_Object->)=Is longint:K8:6) | (Type:C295($y_Object->)=Is longint:K8:6) | (Type:C295($y_Object->)=Is real:K8:4))
			$l_itemPreseleccionado:=Int:C8($y_Object->)
	End case 
End if 

  //20140516 ASM , se agrega validación para cuando existen mas de 255 elementos.
  //Cuando son menos de 255 el comportamiento se mantiene.
If (Size of array:C274($y_menuContentArray->)>255)
	C_TEXT:C284(vRespName)
	ARRAY TEXT:C222($at_ArrayContent;0)
	$l_sumar:=0
	COPY ARRAY:C226($y_menuContentArray->;$at_ArrayContent)
	For ($i;Size of array:C274($at_ArrayContent);1;-1)
		Case of 
			: ($at_ArrayContent{$i}="(@")
				$l_sumar:=$l_sumar+1
				DELETE FROM ARRAY:C228($at_ArrayContent;$i)
			: ($at_ArrayContent{$i}="(-")
				$l_sumar:=$l_sumar+1
				DELETE FROM ARRAY:C228($at_ArrayContent;$i)
		End case 
	End for 
	
	SRtbl_ShowChoiceList (0;"";2;->vRespName;False:C215;->$at_ArrayContent)
	If (choiceIdx>0)
		$l_itemSeleccionado:=choiceIdx+$l_sumar
	Else 
		$l_itemSeleccionado:=$l_itemPreseleccionado
	End if 
Else 
	
	$t_referenciaMenu:=Create menu:C408("popup")
	For ($i;1;Size of array:C274($y_menuContentArray->))
		Case of 
			: ($y_menuContentArray->{$i}="(@")
				APPEND MENU ITEM:C411($t_referenciaMenu;$y_menuContentArray->{$i};"";0)
			: ($y_menuContentArray->{$i}="(-")
				APPEND MENU ITEM:C411($t_referenciaMenu;$y_menuContentArray->{$i};"";0)
			Else 
				APPEND MENU ITEM:C411($t_referenciaMenu;$y_menuContentArray->{$i};"";0;*)
		End case 
		  //SET MENU ITEM PARAMETER($t_referenciaMenu;$i;String($i))
		SET MENU ITEM PARAMETER:C1004($t_referenciaMenu;-1;String:C10($i))
	End for 
	If ($l_itemPreseleccionado>0)
		SET MENU ITEM MARK:C208($t_referenciaMenu;$l_itemPreseleccionado;Char:C90(18))
	End if 
	
	Case of 
		: (Count parameters:C259=3)
			$l_itemSeleccionado:=Num:C11(Dynamic pop up menu:C1006($t_referenciaMenu;String:C10($l_itemPreseleccionado);$l_izquierda;$l_abajo+3))
		: (Count parameters:C259=2)
			$l_itemSeleccionado:=Num:C11(Dynamic pop up menu:C1006($t_referenciaMenu;String:C10($l_itemPreseleccionado)))
		: (Count parameters:C259=1)
			$l_itemSeleccionado:=Num:C11(Dynamic pop up menu:C1006($t_referenciaMenu))
	End case 
	
	If (($l_itemSeleccionado>0) & (Count parameters:C259=2))
		If ((Type:C295($y_Object->)=Is text:K8:3) | (Type:C295($y_Object->)=Is string var:K8:2) | (Type:C295($y_Object->)=Is alpha field:K8:1))
			$y_Object->:=$y_menuContentArray->{$l_itemSeleccionado}
		End if 
	End if 
	RELEASE MENU:C978($t_referenciaMenu)
End if 
$0:=$l_itemSeleccionado
