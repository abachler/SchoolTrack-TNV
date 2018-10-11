  // [xShell_Queries].QueryEditor.criterio1_btnCampo()
  //
  //
  // creado por: Alberto Bachler Klein: 23-02-16, 10:36:40
  // -----------------------------------------------------------
C_LONGINT:C283($l_campo;$l_elemento;$l_fila;$l_posicion;$l_tabla;$l_tipo)
C_POINTER:C301($y_Campo;$y_Condicion;$y_index;$y_menuCampo;$y_menuLista;$y_menuRef;$y_variable)
C_TEXT:C284($t_campo;$t_nombreTabla;$t_refCampo)
C_OBJECT:C1216($ob_opciones)

ARRAY LONGINT:C221($al_numeroTablas;0)
ARRAY TEXT:C222($at_nombreTablas;0)

$l_fila:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
$y_menuCampo:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_campo")
$y_menuLista:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_lista")
$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_variable")
$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"refMenuCampos")
$y_Condicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_condicion")
$l_posicion:=Find in array:C230($y_index->;$l_fila)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		If (atQRY_NombreVirtualCampo{$l_posicion}#"")
			IT_MuestraTip (atQRY_NombreVirtualCampo{$l_posicion})
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		GET TABLE TITLES:C803($at_nombreTablas;$al_numeroTablas)
		
		$t_refCampo:=Dynamic pop up menu:C1006($y_menuRef->)
		If ($t_refCampo#"")
			  //20170921 ASM Ticket 188086 para validar cuando el campo propio tambien contiene puntos
			ARRAY TEXT:C222($at_LineasTexto;0)
			AT_Text2Array (->$at_LineasTexto;$t_refCampo;".")
			If (Size of array:C274($at_LineasTexto)>3)
				DELETE FROM ARRAY:C228($at_LineasTexto;1)
				DELETE FROM ARRAY:C228($at_LineasTexto;1)
				$t_campo:=AT_array2text (->$at_LineasTexto;".")
			Else 
				$t_campo:=ST_GetWord ($t_refCampo;3;".")
			End if 
			
			$l_tabla:=Num:C11(ST_GetWord ($t_refCampo;1;"."))
			$l_campo:=Num:C11(ST_GetWord ($t_refCampo;2;"."))
			$l_elemento:=Find in array:C230($al_numeroTablas;$l_tabla)
			If ($l_elemento>0)
				$t_nombreTabla:=$at_nombreTablas{$l_elemento}
			Else 
				$t_nombreTabla:=Table name:C256($l_tabla)
			End if 
			
			If ($l_campo>0)
				$y_Campo:=Field:C253($l_tabla;$l_campo)
				$l_tipo:=Type:C295($y_campo->)
				
				$l_posicion:=Find in array:C230($y_index->;$l_fila)
				alQRY_numeroCampo{$l_posicion}:=$l_campo
				atQRY_NombreVirtualCampo{$l_posicion}:="["+$t_nombreTabla+"]"+$t_campo
				atQRY_NombreInternoCampo{$l_posicion}:="["+Table name:C256($l_tabla)+"]"+Field name:C257($y_campo)
				ayQRY_Campos{$l_posicion}:=$y_Campo
			End if 
			alQRY_numeroTabla{$l_posicion}:=$l_tabla
			
			Case of 
				: ($l_tipo=Is picture:K8:10)
					AT_Initialize ($y_Condicion)
					APPEND TO ARRAY:C911($y_Condicion->;__ ("No existe"))
					atQRY_Operador_Literal{$l_fila}:=aDelims{2}
					$y_variable->:="0"
					
					
				: ($l_tipo=Is boolean:K8:9)
					AT_Initialize ($y_menuLista)
					APPEND TO ARRAY:C911($y_menuLista->;__ ("Verdadero"))
					APPEND TO ARRAY:C911($y_menuLista->;__ ("Falso"))
					COPY ARRAY:C226(aDelims;$y_Condicion->)
					$y_Condicion->:=2
					$y_menuLista->:=2
					
				: ($l_campo>0)
					$ob_opciones:=XS_GetFieldChoicesArray ($y_Campo)
					If (OB Is defined:C1231($ob_opciones))
						OB GET ARRAY:C1229($ob_opciones;"opciones";$y_menuLista->)
					End if 
					$y_menuLista->:=0
					
				: ($l_campo=-7)
					alQRY_numeroCampo{$l_posicion}:=-7
					EXECUTE FORMULA:C63("yFieldname:=»"+"["+Table name:C256($l_tabla)+"]Userfields'Value")  //get the field pointer
					atQRY_NombreVirtualCampo{$l_posicion}:="["+$t_nombreTabla+"]"+$t_campo
					ayQRY_Campos{$l_fila}:=yfieldname
					atQRY_NombreInternoCampo{$l_posicion}:="["+Table name:C256($l_tabla)+"]Userfields'Value"
					$ob_opciones:=XS_GetFieldChoicesArray (Table:C252($l_tabla);$t_campo)
					If (OB Is defined:C1231($ob_opciones))
						OB GET ARRAY:C1229($ob_opciones;"opciones";$y_menuLista->)
					End if 
					$y_menuLista->:=0
			End case 
			
			If ($l_tipo=Is picture:K8:10)
				OBJECT SET VISIBLE:C603($y_menuLista->;False:C215)
				OBJECT SET VISIBLE:C603($y_variable->;False:C215)
			Else 
				OBJECT SET VISIBLE:C603($y_menuLista->;Size of array:C274($y_menuLista->)>0)
				OBJECT SET VISIBLE:C603($y_variable->;(Size of array:C274($y_menuLista->)=0))
			End if 
			
			
			If (atQRY_NombreVirtualCampo{$l_posicion}#"")
				If (Size of array:C274($y_menuCampo->)=0)
					APPEND TO ARRAY:C911($y_menuCampo->;atQRY_NombreVirtualCampo{$l_posicion})
				Else 
					$y_menuCampo->{1}:=atQRY_NombreVirtualCampo{$l_posicion}
				End if 
				$y_menuCampo->:=1
				OBJECT SET HELP TIP:C1181((OBJECT Get pointer:C1124(Object current:K67:2))->;atQRY_NombreVirtualCampo{$l_posicion})
				OBJECT SET HELP TIP:C1181(*;"criterio"+String:C10($l_fila)+"_variable";$t_campo)
				
				  //If (False)
				  // provoca el cierre de la aplicación cuando
				OBJECT SET PLACEHOLDER:C1295(*;"criterio"+String:C10($l_fila)+"_variable";$t_campo)
				  //End if 
			End if 
		End if 
		
End case 





