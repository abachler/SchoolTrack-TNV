//%attributes = {}
  // BBL_BusquedaItems()
  // Por: Alberto Bachler K.: 12-02-15, 18:16:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_buscarEnTodasPartes)
C_LONGINT:C283($i;$i_contenedor;$i_items;$i_palabras;$i_refs;$i_registros;$l_ElementoEncontrado;$l_milisegundos;$l_modoComparacion;$l_alto;$l_ancho)
C_POINTER:C301($y_comparador;$y_menuRef)
C_TEXT:C284($t_campoBusqueda;$t_expresion;$t_ExpresionesCruzadas;$t_ms;$t_palabra;$t_registros;$t_palabra)
C_OBJECT:C1216($o_materias)
C_BOOLEAN:C305($b_palabrasCompletas)  //20170512 RCH

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY POINTER:C280($ay_contenedores;0)
ARRAY TEXT:C222($at_materias;0)
ARRAY TEXT:C222($at_palabras;0)
ARRAY TEXT:C222($at_referencias;0)
ARRAY TEXT:C222($at_titulos;0)


If (False:C215)
	C_TEXT:C284(BBL_BusquedaItems ;$1)
	C_TEXT:C284(BBL_BusquedaItems ;$2)
	C_LONGINT:C283(BBL_BusquedaItems ;$3)
End if 

If (KRL_IsWebProcess )
	$t_expresion:=$1
	$t_campoBusqueda:=$2
	$l_modoComparacion:=$3
	If ($t_campoBusqueda="")
		$b_buscarEnTodasPartes:=True:C214
	End if 
	
Else 
	$l_milisegundos:=Milliseconds:C459
	$y_menuRef:=OBJECT Get pointer:C1124(Object named:K67:5;"menuRef")
	
	  // obtengo el modo de comparacion
	$y_comparador:=OBJECT Get pointer:C1124(Object named:K67:5;"comparador")
	$l_modoComparacion:=$y_comparador->
	
	Case of 
		: (Character code:C91(Get menu item mark:C428($y_menuRef->;1))=0)
			  // si Buscar en todas partes no esta activado en el menu determino cual es el contenedor activado
			  // y almaceno el parametro de la opción activada entre las lineas 4 y 10 del menú
			For ($i_items;4;10)
				If (Character code:C91(Get menu item mark:C428($y_menuRef->;$i_items))=18)
					$t_campoBusqueda:=Get menu item parameter:C1003($y_menuRef->;$i_items)
					$i_items:=10
				End if 
			End for 
			$b_buscarEnTodasPartes:=False:C215
			
		: (Character code:C91(Get menu item mark:C428($y_menuRef->;1))=18)
			$b_buscarEnTodasPartes:=True:C214
			
	End case 
	
	$t_expresion:=Get edited text:C655
	
	$b_palabrasCompletas:=(Character code:C91(Get menu item mark:C428($y_menuRef->;20))=18)  //20170512 RCH
End if 

CREATE EMPTY SET:C140([BBL_Items:61];"$resultado")
CREATE EMPTY SET:C140([BBL_Items:61];"$items")


If ($t_expresion="")
	REDUCE SELECTION:C351([BBL_Items:61];0)
	OBJECT SET TITLE:C194(*;"tipoBusqueda";"")
	OBJECT SET TITLE:C194(*;"resultadoBusqueda";"")
Else 
	$t_ExpresionesCruzadas:=$t_expresion
	$l_milisegundos:=Milliseconds:C459
	If (($b_buscarEnTodasPartes) | ($t_campoBusqueda="_F01_encabezado"))
		If ($l_modoComparacion=Contiene alguna de las palabras)
			For ($i;1;ST_CountWords ($t_expresion))
				$t_palabra:=ST_GetWord ($t_expresion;$i)
				QUERY:C277([BBL_Thesaurus_CrossRefs:246];[BBL_Thesaurus_CrossRefs:246]References:1;=;$t_palabra)
				For ($i_refs;1;Records in selection:C76([BBL_Thesaurus_CrossRefs:246]))
					QUERY BY FORMULA:C48([BBL_Thesaurus:68];Get subrecord key:C1137([BBL_Thesaurus:68]CrossRefs:3)=[BBL_Thesaurus_CrossRefs:246]id_added_by_converter:2)
					$t_ExpresionesCruzadas:=$t_ExpresionesCruzadas+" "+[BBL_Thesaurus:68]Materia:13
				End for 
			End for 
		End if 
		
		If (($l_modoComparacion=Contiene todas las palabras) | ($l_modoComparacion=Contiene alguna de las palabras))
			QRY_BusquedaTextosIndexados ($t_expresion;->[BBL_Items:61]Materias_json:53;$l_modoComparacion)
			If (($l_modoComparacion=Contiene todas las palabras) | ($l_modoComparacion=Contiene alguna de las palabras))
				LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
				CREATE EMPTY SET:C140([BBL_Items:61];"$resultado")
				For ($i_registros;1;Size of array:C274($al_RecNums))
					GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
					$o_materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
					OB_GET ($o_materias;->$at_materias;"materiasCatalogacion_KW")
					  // Modificado por: Alexis Bustamante (30/08/2017) TICKET188050 
					For ($i;1;ST_CountWords ($t_expresion))
						$t_palabra:=ST_GetWord ($t_expresion;$i)
						$t_palabra:="@"+$t_palabra+"@"
						$l_ElementoEncontrado:=Find in array:C230($at_materias;$t_palabra)
						If ($l_ElementoEncontrado>0)
							ADD TO SET:C119([BBL_Items:61];"$resultado")
						End if 
						  //
					End for 
				End for 
				UNION:C120("$items";"$resultado";"$items")
			Else 
				CREATE SET:C116([BBL_Items:61];"$resultado")
				UNION:C120("$items";"$resultado";"$items")
			End if 
		End if 
	End if 
End if 


If ($b_buscarEnTodasPartes)
	AT_AppendToPointerArray (->$ay_contenedores;->[BBL_Items:61]Titulos:5;->[BBL_Items:61]Autores:7;->[BBL_Items:61]Editores:9;->[BBL_Items:61]Serie_Nombre:26;->[BBL_Items:61]Resumen:17;->[BBL_Items:61]NotasDeContenido:50;->[BBL_Items:61]Notas:16)
Else 
	Case of 
		: ($t_campoBusqueda="_F02_titulo")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Titulos:5)
			
		: ($t_campoBusqueda="_F03_autor")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Autores:7)
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Primer_autor:6)
			  //ABC Agrego otro criterio de busqueda.
			  //TICKET 188042 
			
		: ($t_campoBusqueda="_F04_editor")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Editores:9)
			
		: ($t_campoBusqueda="_F05_serie")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Serie_Nombre:26)
			
		: ($t_campoBusqueda="_F06_resumen")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Resumen:17)
			
		: ($t_campoBusqueda="_F07_notas")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Notas:16)
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]NotasDeContenido:50)
			
		: ($t_campoBusqueda="encabezamientoExacto")
			APPEND TO ARRAY:C911($ay_contenedores;->[BBL_Items:61]Materias_json:53)
			
	End case 
End if 

  //$b_palabrasCompletas:=(Character code(Get menu item mark($y_menuRef->;20))=18)//20170512 RCH Moví esta línea al else del proceso web
$b_palabrasCompletas:=$b_palabrasCompletas & ($l_modoComparacion=Contiene alguna de las palabras)
$b_palabrasCompletas:=$b_palabrasCompletas | ($l_modoComparacion=Contiene todas las palabras)

If ($b_palabrasCompletas)
	  //obtengo la lista de palabras utilizando el algoritmo ICU implementado en 4D (http://userguide.icu-project.org/boundaryanalysis)
	$t_vacio:=""
	KRL_FindAndLoadRecordByIndex (->[xShell_KeywordQueries:120]Keywords:1;->$t_vacio;True:C214)
	If (OK=0)
		CREATE RECORD:C68([xShell_KeywordQueries:120])
	End if 
	[xShell_KeywordQueries:120]Keywords:1:=$t_expresion
	SAVE RECORD:C53([xShell_KeywordQueries:120])
	DISTINCT VALUES:C339([xShell_KeywordQueries:120]Keywords:1;$at_palabras)
	[xShell_KeywordQueries:120]Keywords:1:=""
	SAVE RECORD:C53([xShell_KeywordQueries:120])
	For ($i_palabras;1;Size of array:C274($at_palabras))
		For ($i_contenedor;1;Size of array:C274($ay_contenedores))
			QRY_BusquedaTextosIndexados ($t_expresion;$ay_contenedores{$i_contenedor};$l_modoComparacion)
			CREATE SET:C116([BBL_Items:61];"$resultado")
			UNION:C120("$items";"$resultado";"$items")
		End for 
	End for 
Else 
	
	If (Size of array:C274($ay_contenedores)>0)
		Case of 
			: ($l_modoComparacion=Comienza con)
				$t_expresion:=$t_expresion+"@"
			: ($l_modoComparacion=Termina con)
				$t_expresion:="@"+$t_expresion
			: ($l_modoComparacion=Contiene la expresion exacta)
				$t_expresion:="@"+$t_expresion+"@"
			: ($l_modoComparacion=Es exactamente)
		End case 
		
		QUERY:C277([BBL_Items:61];$ay_contenedores{1}->;=;$t_expresion;*)
		For ($i_contenedor;2;Size of array:C274($ay_contenedores))
			QUERY:C277([BBL_Items:61]; | ;$ay_contenedores{$i_contenedor}->;=;$t_expresion;*)
		End for 
		QUERY:C277([BBL_Items:61])
		CREATE SET:C116([BBL_Items:61];"$resultado")
		UNION:C120("$items";"$resultado";"$items")
	End if 
End if 

USE SET:C118("$items")
ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_título:4;>)

SET_ClearSets ("$items";"$resultado")

If (Records in selection:C76([BBL_Items:61])>0)
	
End if 
$l_milisegundos:=Milliseconds:C459-$l_milisegundos
$t_registros:=String:C10(Records in selection:C76([BBL_Items:61]))
$t_ms:=String:C10($l_milisegundos)+__ (" ms")
OBJECT SET TITLE:C194(*;"resultadoBusqueda";$t_registros+" "+__ ("items")+__ (" en ")+$t_ms)
OBJECT SET VISIBLE:C603(*;"resultadoBusqueda";Records in selection:C76([BBL_Items:61])>0)
OBJECT GET BEST SIZE:C717(*;"resultadoBusqueda";$l_ancho;$l_alto;145)
OBJECT GET COORDINATES:C663(*;"resultadoBusqueda";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
OBJECT SET COORDINATES:C1248(*;"resultadoBusqueda";$l_izquierda;$l_arriba;$l_izquierda+$l_ancho+30;$l_abajo)



