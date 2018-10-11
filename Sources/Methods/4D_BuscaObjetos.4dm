//%attributes = {}
  //4D_BuscaObjetos

C_TEXT:C284($0;$t_texto;$1;$t_objetosABuscar)
C_BOOLEAN:C305($b_continuar)

ARRAY TEXT:C222($at_forms;0)

C_POINTER:C301($y_table;$y_table)
C_LONGINT:C283($l_proc;$i_forms;$i_table;$i)
C_TEXT:C284($t_groupXML;$t_bodyXML;$t_tableName)

ARRAY TEXT:C222($at_tabla;0)
ARRAY TEXT:C222($at_formulario;0)
ARRAY TEXT:C222($at_objetosSinFuente;0)
ARRAY LONGINT:C221($al_PagObjetosSinFuente;0)

ARRAY LONGINT:C221($al_tiposExcluidos;0)
ARRAY LONGINT:C221($al_tiposIncluidos;0)

$t_objetosABuscar:=$1

Case of 
	: ($t_objetosABuscar="SinFuente")
		APPEND TO ARRAY:C911($al_tiposExcluidos;2)  //picture
		APPEND TO ARRAY:C911($al_tiposExcluidos;32)  //linea
		APPEND TO ARRAY:C911($al_tiposExcluidos;18)  //botón invisible
		APPEND TO ARRAY:C911($al_tiposExcluidos;31)  //Rectángulo
		APPEND TO ARRAY:C911($al_tiposExcluidos;38)  //Plugin area
		APPEND TO ARRAY:C911($al_tiposExcluidos;35)  //Matriz
		APPEND TO ARRAY:C911($al_tiposExcluidos;21)  //línea
		APPEND TO ARRAY:C911($al_tiposExcluidos;39)  //Sub form
		APPEND TO ARRAY:C911($al_tiposExcluidos;33)  //rectangulo redondeado
		APPEND TO ARRAY:C911($al_tiposExcluidos;19)  //picture button
		APPEND TO ARRAY:C911($al_tiposExcluidos;40)  //web area
		APPEND TO ARRAY:C911($al_tiposExcluidos;34)  //Object type oval
		APPEND TO ARRAY:C911($al_tiposExcluidos;4)  //Object type picture input
		APPEND TO ARRAY:C911($al_tiposExcluidos;17)  //Object type highlight button
		APPEND TO ARRAY:C911($al_tiposExcluidos;36)  //Object type splitter
		APPEND TO ARRAY:C911($al_tiposExcluidos;27)  //Object type progress indicator //20180625 RCH
		APPEND TO ARRAY:C911($al_tiposExcluidos;29)  //Object type ruler //20180626 RCH
		
		APPEND TO ARRAY:C911($al_tiposIncluidos;21)  //grupo
		APPEND TO ARRAY:C911($al_tiposIncluidos;15)  //Object type push button
		APPEND TO ARRAY:C911($al_tiposIncluidos;16)  //botón 3d
		APPEND TO ARRAY:C911($al_tiposIncluidos;30)  //cuadro de grupo
		APPEND TO ARRAY:C911($al_tiposIncluidos;3)  //Object type text input
		APPEND TO ARRAY:C911($al_tiposIncluidos;1)  //Object type static text
		APPEND TO ARRAY:C911($al_tiposIncluidos;25)  //Checkbox
		APPEND TO ARRAY:C911($al_tiposIncluidos;13)  //Object type hierarchical popup menu
		APPEND TO ARRAY:C911($al_tiposIncluidos;22)  //Object type radio button
		APPEND TO ARRAY:C911($al_tiposIncluidos;37)  //Object type tab control
		APPEND TO ARRAY:C911($al_tiposIncluidos;5)  //Object type radio button field
		APPEND TO ARRAY:C911($al_tiposIncluidos;6)  //Object type hierarchical list
		APPEND TO ARRAY:C911($al_tiposIncluidos;12)  //Object type popup dropdown list //20180514 RCH
		APPEND TO ARRAY:C911($al_tiposIncluidos;7)  //Object type listbox
		
		$b_continuar:=True:C214
End case 

If ($b_continuar)
	  //formularios de proyecto
	FORM GET NAMES:C1167($at_forms)
	For ($i_forms;1;Size of array:C274($at_forms))
		FORM GET NAMES:C1167($at_forms)
		For ($i_forms;1;Size of array:C274($at_forms))
			$t_formName:=$at_forms{$i_forms}
			$t_tableName:="[Formularios de proyecto]"
			FORM LOAD:C1103($t_formName)
			ARRAY TEXT:C222($at_nombreObjetos;0)
			ARRAY POINTER:C280($ay_nombreValiables;0)
			ARRAY LONGINT:C221($al_paginas;0)
			FORM GET OBJECTS:C898($at_nombreObjetos;$ay_nombreValiables;$al_paginas)
			For ($i;1;Size of array:C274($at_nombreObjetos))
				$l_tipoObjeto:=OBJECT Get type:C1300(*;$at_nombreObjetos{$i})
				If (Find in array:C230($al_tiposExcluidos;$l_tipoObjeto)=-1)
					$t_hoja:=OBJECT Get style sheet:C1258(*;$at_nombreObjetos{$i})
					$t_fuente:=OBJECT Get font:C1069(*;$at_nombreObjetos{$i})
					
					Case of 
						: ($t_objetosABuscar="SinFuente")
							If ($t_fuente="")
								APPEND TO ARRAY:C911($at_tabla;$t_tableName)
								APPEND TO ARRAY:C911($at_formulario;$t_formName)
								APPEND TO ARRAY:C911($at_objetosSinFuente;$at_nombreObjetos{$i})
								APPEND TO ARRAY:C911($al_PagObjetosSinFuente;$al_paginas{$i})
							End if 
					End case 
					
					  //20180531 RCH Para obtener las fuentes de los objetos incluidos en un LB
					If ($l_tipoObjeto=Object type listbox:K79:8)
						LISTBOX GET OBJECTS:C1302(*;$at_nombreObjetos{$i};$at_nombreObjetos2)
						For ($j;1;Size of array:C274($at_nombreObjetos2))
							$t_fuente:=OBJECT Get font:C1069(*;$at_nombreObjetos2{$j})
							Case of 
								: ($t_objetosABuscar="SinFuente")
									If ($t_fuente="")
										APPEND TO ARRAY:C911($at_tabla;$t_tableName)
										APPEND TO ARRAY:C911($at_formulario;$t_formName)
										APPEND TO ARRAY:C911($at_objetosSinFuente;$at_nombreObjetos{$i}+"/"+$at_nombreObjetos2{$j})
										APPEND TO ARRAY:C911($al_PagObjetosSinFuente;$al_paginas{$i})
									End if 
							End case 
						End for 
					End if 
					
				End if 
			End for 
			FORM UNLOAD:C1299
		End for 
	End for 
	
	$l_proc:=IT_Progress (1;0;0;"Verificando en formularios...")
	For ($i_table;1;Get last table number:C254)
		If (Is table number valid:C999($i_table))
			$y_table:=Table:C252($i_table)
			FORM GET NAMES:C1167($y_table->;$at_forms)
			For ($i_forms;1;Size of array:C274($at_forms))
				$t_formName:=$at_forms{$i_forms}
				$t_tableName:="["+Table name:C256($y_table)+"]"
				FORM LOAD:C1103($y_table->;$t_formName)
				ARRAY TEXT:C222($at_nombreObjetos;0)
				ARRAY POINTER:C280($ay_nombreValiables;0)
				ARRAY LONGINT:C221($al_paginas;0)
				FORM GET OBJECTS:C898($at_nombreObjetos;$ay_nombreValiables;$al_paginas)
				For ($i;1;Size of array:C274($at_nombreObjetos))
					$l_tipoObjeto:=OBJECT Get type:C1300(*;$at_nombreObjetos{$i})
					If (Find in array:C230($al_tiposExcluidos;$l_tipoObjeto)=-1)
						$t_hoja:=OBJECT Get style sheet:C1258(*;$at_nombreObjetos{$i})
						$t_fuente:=OBJECT Get font:C1069(*;$at_nombreObjetos{$i})
						
						Case of 
							: ($t_objetosABuscar="SinFuente")
								If ($t_fuente="")
									APPEND TO ARRAY:C911($at_tabla;$t_tableName)
									APPEND TO ARRAY:C911($at_formulario;$t_formName)
									APPEND TO ARRAY:C911($at_objetosSinFuente;$at_nombreObjetos{$i})
									APPEND TO ARRAY:C911($al_PagObjetosSinFuente;$al_paginas{$i})
								End if 
						End case 
						
						  //20180531 RCH Para obtener las fuentes de los objetos incluidos en un LB
						If ($l_tipoObjeto=Object type listbox:K79:8)
							LISTBOX GET OBJECTS:C1302(*;$at_nombreObjetos{$i};$at_nombreObjetos2)
							For ($j;1;Size of array:C274($at_nombreObjetos2))
								$t_fuente:=OBJECT Get font:C1069(*;$at_nombreObjetos2{$j})
								Case of 
									: ($t_objetosABuscar="SinFuente")
										If ($t_fuente="")
											APPEND TO ARRAY:C911($at_tabla;$t_tableName)
											APPEND TO ARRAY:C911($at_formulario;$t_formName)
											APPEND TO ARRAY:C911($at_objetosSinFuente;$at_nombreObjetos{$i}+"/"+$at_nombreObjetos2{$j})
											APPEND TO ARRAY:C911($al_PagObjetosSinFuente;$al_paginas{$i})
										End if 
								End case 
							End for 
						End if 
						
					End if 
				End for 
				FORM UNLOAD:C1299
			End for 
		End if 
		IT_Progress (0;$l_proc;$i_table/Get last table number:C254)
	End for 
	IT_Progress (-1;$l_proc)
	
	If (Size of array:C274($at_tabla)>0)
		$t_texto:="Tabla\tFormulario\tNombre objeto\tPágina\n"
		$t_texto:=$t_texto+AT_Arrays2Text ("\n";"\t";->$at_tabla;->$at_formulario;->$at_objetosSinFuente;->$al_PagObjetosSinFuente)
	End if 
Else 
	TRACE:C157
End if 

$0:=$t_texto