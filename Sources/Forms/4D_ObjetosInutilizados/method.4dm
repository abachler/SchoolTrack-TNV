  // 4D_ObjetosInutilizados()
  // Por: Alberto Bachler K.: 29-07-15, 17:12:07
  //  ---------------------------------------------
C_BLOB:C604($x_Blob;$x_reportData)
C_BOOLEAN:C305($b_lineaValida)
C_LONGINT:C283($i;$i_archivos;$i_linea;$i_lineas;$i_metodos;$i_registros;$i_secciones;$l_anchoColumna;$l_AreaQR;$l_campo)
C_LONGINT:C283($l_columna;$l_columnaOculta;$l_columnas_objetos;$l_elemento;$l_elementos;$l_error;$l_indexObjeto;$l_llamados;$l_llamantes;$l_posicion)
C_LONGINT:C283($l_proceso;$l_recNum;$l_tabla;$l_tamaño;$l_valoresRepetidos)
C_POINTER:C301($y_Carpetas;$y_codigo;$y_comandos;$y_comandosObjeto;$y_ejecutables;$y_Informes;$y_macros;$y_Metodos;$y_rutas;$y_usoCodigo)
C_POINTER:C301($y_usoRuta;$y_usoRutas;$y_webServices)
C_TEXT:C284($t_BodyScript;$t_codigo;$t_encabezado;$t_EndScript;$t_formatoColumna;$t_html1;$t_html2;$t_itemSeleccionado;$t_lineaCodigo;$t_macros)
C_TEXT:C284($t_metodo;$t_nombreObjeto;$t_refMenu;$t_ruta;$t_rutaMetodo;$t_script;$t_StartScript;$t_subMenuCarpetas;$t_texto)
C_OBJECT:C1216($ob_llamados;$ob_llamadosMetodo)

ARRAY LONGINT:C221($al_FilasRetorno;0)
ARRAY LONGINT:C221($al_lineasCodigo;0)
ARRAY LONGINT:C221($al_NoLinea;0)
ARRAY LONGINT:C221($al_objetosIds;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY POINTER:C280($y_jerarquia;0)
ARRAY TEXT:C222($at_ArchivosMacros;0)
ARRAY TEXT:C222($at_carpetas;0)
ARRAY TEXT:C222($at_lineasCodigo;0)
ARRAY TEXT:C222($at_llamante;0)
ARRAY TEXT:C222($at_metodosXS;0)
ARRAY TEXT:C222($at_objetos;0)
ARRAY TEXT:C222($at_TextoLinea;0)

$y_Metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")
$y_comandos:=OBJECT Get pointer:C1124(Object named:K67:5;"comandos")
$y_comandosObjeto:=OBJECT Get pointer:C1124(Object named:K67:5;"comandosObjeto")
$y_Informes:=OBJECT Get pointer:C1124(Object named:K67:5;"informes")
$y_macros:=OBJECT Get pointer:C1124(Object named:K67:5;"macros")
$y_webServices:=OBJECT Get pointer:C1124(Object named:K67:5;"webServices")
$y_Carpetas:=OBJECT Get pointer:C1124(Object named:K67:5;"carpeta")
$y_rutas:=OBJECT Get pointer:C1124(Object named:K67:5;"rutas")
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
$y_usoRutas:=OBJECT Get pointer:C1124(Object named:K67:5;"usoRuta")
$y_usoCodigo:=OBJECT Get pointer:C1124(Object named:K67:5;"usoCodigo")
$y_ejecutables:=OBJECT Get pointer:C1124(Object named:K67:5;"ejecutables")



Case of 
	: (Form event:C388=On Load:K2:1)
		
		METHOD GET FOLDERS:C1206($at_carpetas;*)
		$t_subMenuCarpetas:=Create menu:C408
		APPEND MENU ITEM:C411($t_subMenuCarpetas;"Nivel superior")
		SET MENU ITEM PARAMETER:C1004($t_subMenuCarpetas;-1;"sacar")
		For ($i;1;Size of array:C274($at_carpetas))
			APPEND MENU ITEM:C411($t_subMenuCarpetas;$at_carpetas{$i})
			SET MENU ITEM PARAMETER:C1004($t_subMenuCarpetas;-1;$at_carpetas{$i})
		End for 
		
		$t_refMenu:=Create menu:C408
		APPEND MENU ITEM:C411($t_refMenu;"Mover a...";$t_subMenuCarpetas)
		APPEND MENU ITEM:C411($t_refMenu;"(-")
		APPEND MENU ITEM:C411($t_refMenu;"Editar método...")
		SET MENU ITEM PARAMETER:C1004($t_refMenu;-1;"editar")
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"refMenuContextual"))->:=$t_refMenu
		
		
		$l_proceso:=Progress New 
		Progress SET PROGRESS ($l_proceso;-1;"Leyendo el código…";True:C214)
		METHOD GET PATHS:C1163(Path all objects:K72:16;$y_rutas->;*)
		METHOD GET CODE:C1190($y_rutas->;$y_codigo->;*)
		Progress QUIT ($l_proceso)
		
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		  //$t_nombreObjeto:=OBJECT Get name(Object with focus)
		  //$t_refMenu:=(OBJECT Get pointer(Object named;"refMenuContextual"))->
		  //Case of 
		  //: ($t_nombreObjeto="lb_metodos")
		  //$t_rutaMetodo:=$y_Metodos->{$y_Metodos->}
		  //$l_posicion:=$y_Metodos->
		  //: ($t_nombreObjeto="comandos")
		  //$t_rutaMetodo:=$y_comandos->{$y_comandos->}
		  //$l_posicion:=$y_comandos->
		  //: ($t_nombreObjeto="informes")
		  //$t_rutaMetodo:=$y_Informes->{$y_Informes->}
		  //$l_posicion:=$y_Informes->
		  //: ($t_nombreObjeto="macros")
		  //$t_rutaMetodo:=$y_macros->{$y_macros->}
		  //$l_posicion:=$y_macros->
		  //: ($t_nombreObjeto="webServices")
		  //$t_rutaMetodo:=$y_webServices->{$y_webServices->}
		  //$l_posicion:=$y_webServices->
		  //End case 
		  //$t_rutaMetodo:=$y_Metodos->{$y_Metodos->}
		  //$t_itemSeleccionado:=Dynamic pop up menu($t_refMenu)
		  //Case of 
		  //: ($t_itemSeleccionado="editar")
		  //METHOD OPEN PATH($y_Metodos->{$y_Metodos->};*)
		  //: ($t_itemSeleccionado="sacar")
		  //METHOD SET ATTRIBUTE($t_rutaMetodo;Attribute folder name;"";*)
		  //$y_Carpetas->{$y_Carpetas->}:="Nivel superior"
		  //Else 
		  //METHOD SET ATTRIBUTE($t_rutaMetodo;Attribute folder name;$t_itemSeleccionado;*)
		  //$y_Carpetas->{$y_Carpetas->}:=$t_itemSeleccionado
		  //End case 
		
	: (Form event:C388=On Unload:K2:2)
		RELEASE MENU:C978($t_refMenu)
		RELEASE MENU:C978($t_subMenuCarpetas)
		
	: (Form event:C388=On Drop:K2:12)
		$t_texto:=Get text from pasteboard:C524
		AT_Text2Array ($y_Metodos;$t_Texto;"\r")
		SORT ARRAY:C229($y_Metodos->)
		  // analisis de los metodos no utilizados
		AT_Initialize ($y_comandos)
		AT_Initialize ($y_comandosObjeto)
		AT_Initialize ($y_ejecutables)
		AT_Initialize ($y_Informes)
		AT_Initialize ($y_macros)
		AT_Initialize ($y_webServices)
		$t_ruta:=Get 4D folder:C485(Active 4D Folder:K5:10)+"Macros v2"+Folder separator:K24:12
		DOCUMENT LIST:C474($t_ruta;$at_ArchivosMacros;Absolute path:K24:14+Ignore invisible:K24:16+Recursive parsing:K24:13)
		$t_macros:=""
		
		
		
		  // determino si los métodos sin llamados detectados por 4D
		  // son llamados desde macros
		For ($i_archivos;1;Size of array:C274($at_ArchivosMacros);1)
			If ($at_ArchivosMacros{$i_archivos}="@.xml")
				DOCUMENT TO BLOB:C525($at_ArchivosMacros{$i_archivos};$x_Blob)
				$t_macros:=$t_macros+BLOB to text:C555($x_Blob;UTF8 text without length:K22:17)+"\r"
			End if 
		End for 
		For ($i;Size of array:C274($y_Metodos->);1;-1)
			If ($y_Metodos->{$i}="4DMK@")
			End if 
			If (Position:C15($y_Metodos->{$i};$t_macros)>0)
				APPEND TO ARRAY:C911($y_macros->;$y_Metodos->{$i})
			End if 
		End for 
		
		  // determino si los métodos sin llamados detectados por 4D
		  // pueden ser llamados externos a web services locales
		If (Not:C34(Is compiled mode:C492))
			For ($i;Size of array:C274($y_Metodos->);1;-1)
				METHOD GET CODE:C1190($y_Metodos->{$i};$t_codigo;*)
				If (Position:C15("SOAP DECLARATION";$t_codigo)>0)
					APPEND TO ARRAY:C911($y_webServices->;$y_Metodos->{$i})
				End if 
			End for 
		Else 
			ALERT:C41("La aplicación está compilada. No es posible determinar si hay métodos ofrecidos como web services sin ser llamados desde otros comandos")
		End if 
		
		  // determino si los métodos sin llamados detectados por 4D
		  // son llamados desde los comandos ejecutables
		For ($i;Size of array:C274($y_Metodos->);1;-1)
			$l_recNum:=Find in field:C653([xShell_ExecutableCommands:19]MethodName:2;$y_Metodos->{$i})
			If ($l_recNum>No current record:K29:2)
				APPEND TO ARRAY:C911($y_ejecutables->;$y_Metodos->{$i})
			End if 
		End for 
		
		  // busco los llamados en el código, directamente o como literales
		$l_proceso:=IT_Progress (1;0;0;"Buscando métodos llamados como literales... ")
		For ($i;1;Size of array:C274($y_Metodos->))
			$t_metodo:=$y_Metodos->{$i}
			$y_codigo->{0}:=$t_metodo
			  // busco los llamados a este método en todos los demas métodos
			$l_llamantes:=AT_SearchArray ($y_codigo;"@";->$al_FilasRetorno)
			
			If ($l_llamantes>0)
				AT_Initialize (->$al_NoLinea;->$at_TextoLinea;->$at_llamante)
				For ($i_metodos;1;$l_llamantes)
					If ($t_metodo#$y_Rutas->{$al_FilasRetorno{$i_metodos}})
						$t_codigo:=$y_codigo->{$al_FilasRetorno{$i_metodos}}
						AT_Text2Array (->$at_lineasCodigo;$t_codigo;"\r")
						$at_lineasCodigo{0}:=$t_metodo
						$l_llamados:=AT_SearchArray (->$at_lineasCodigo;"@";->$al_lineasCodigo)
						For ($i_lineas;1;$l_llamados)
							$t_lineaCodigo:=Replace string:C233($at_lineasCodigo{$al_lineasCodigo{$i_lineas}};"\t";"")
							If (Position:C15("  //";$t_lineaCodigo)#1)
								APPEND TO ARRAY:C911($at_llamante;$y_rutas->{$al_FilasRetorno{$i_metodos}})
								APPEND TO ARRAY:C911($al_NoLinea;$al_lineasCodigo{$i_lineas}-1)  // decremento para omitir la linea oculta de atributos del método
								APPEND TO ARRAY:C911($at_TextoLinea;$t_lineaCodigo)
							End if 
						End for 
					End if 
				End for 
				If (Size of array:C274($al_NoLinea)>0)
					For ($i_linea;1;Size of array:C274($al_NoLinea))
						$at_TextoLinea{$i_linea}:="Línea Nº "+String:C10($al_NoLinea{$i_linea})+" : "+$at_TextoLinea{$i_linea}
					End for 
					$ob_llamadosMetodo:=OB_Create 
					OB_SET ($ob_llamadosMetodo;->$at_llamante;"metodo")
					OB_SET ($ob_llamadosMetodo;->$at_TextoLinea;"codigo")
					APPEND TO ARRAY:C911($y_comandos->;$y_Metodos->{$i})
					APPEND TO ARRAY:C911($y_comandosObjeto->;$ob_llamadosMetodo)
					CLEAR VARIABLE:C89($ob_llamadosMetodo)
				End if 
			End if 
			
			IT_Progress (0;$l_proceso;$i/Size of array:C274($y_Metodos->))
		End for 
		IT_Progress (-1;$l_proceso)
		LISTBOX SORT COLUMNS:C916(*;"lb_comandos";1)
		
		  // determino si los métodos sin llamados detectados por 4D
		  // son llamados desde comandos ejecutables definidos en xShell
		For ($i;Size of array:C274($y_Metodos->);1;-1)
			$l_recNum:=Find in field:C653([xShell_ExecutableCommands:19]MethodName:2;$y_Metodos->{$i})
			If ($l_recNum>No current record:K29:2)
				APPEND TO ARRAY:C911($y_ejecutables->;$y_Metodos->{$i})
			End if 
		End for 
		
		  // determino si los métodos sin llamados detectados por 4D
		  // son llamados desde panel de configuración, herramientas y asistentes
		ALL RECORDS:C47([XShell_ExecutableObjects:280])
		DISTINCT VALUES:C339([XShell_ExecutableObjects:280]Object_MethodName:3;$at_metodosXS)
		For ($i;Size of array:C274($y_Metodos->);1;-1)
			$l_elemento:=Find in array:C230($at_metodosXS;$y_Metodos->{$i})
			If ($l_elemento>No current record:K29:2)
				APPEND TO ARRAY:C911($y_ejecutables->;$y_Metodos->{$i})
			End if 
		End for 
		SORT ARRAY:C229($y_ejecutables->)
		
		  // determino si los métodos sin llamados detectados por 4D
		  // son llamados desde desde informes
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportType:2="gSR2";*)
		QUERY:C277([xShell_Reports:54]; | ;[xShell_Reports:54]ReportType:2="4DSE")
		LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_RecNums;"")
		AT_Initialize (->$at_objetos)
		$l_proceso:=IT_Progress (1;0;0;"Analizando el código en informes... ")
		vlSRP_AreaRef:=SR New Offscreen Area 
		$l_AreaQR:=QR New offscreen area:C735
		For ($i_registros;1;Size of array:C274($al_RecNums);1)
			GOTO RECORD:C242([xShell_Reports:54];$al_RecNums{$i_registros})
			If ([xShell_Reports:54]ReportName:26="Alumnos por nivel copia")
			End if 
			IT_Progress (0;$l_proceso;$i_registros/Size of array:C274($al_RecNums);"Analizando el código en informes... \r"+[xShell_Reports:54]ReportName:26+" ("+String:C10($i_registros)+"/"+String:C10(Size of array:C274($al_RecNums))+")")
			Case of 
					  //----------------------------------------
				: ([xShell_Reports:54]ReportType:2="gSR2")
					$x_reportData:=[xShell_Reports:54]xReportData_:29
					$l_error:=SR Set Area (vlSRP_AreaRef;$x_reportData)
					$l_error:=SR Get Scripts (vlSRP_AreaRef;$t_StartScript;$t_BodyScript;$t_EndScript)
					If (Length:C16($t_StartScript)#0)
						APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_StartScript))
					End if 
					If (Length:C16($t_BodyScript)#0)
						APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_BodyScript))
					End if 
					If (Length:C16($t_EndScript)#0)
						APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_EndScript))
					End if 
					For ($i_secciones;0;15;1)
						$l_error:=SR Get Section Scripts (vlSRP_AreaRef;$i_secciones;$t_script;$t_html1;$t_html2)
						If (Length:C16($t_script)#0)
							APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_script))
						End if 
					End for 
					$l_error:=SR Get Object IDs (vlSRP_AreaRef;SR All Objects;$al_objetosIds)
					For ($l_indexObjeto;1;Size of array:C274($al_objetosIds);1)
						$l_error:=SR Get Object Scripts (vlSRP_AreaRef;$al_objetosIds{$l_indexObjeto};$t_script;$t_html1;$t_html2)
						If (Length:C16($t_script)#0)
							APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_script))
						End if 
					End for 
					  //----------------------------------------
				: ([xShell_Reports:54]ReportType:2="4DSE")
					ON ERR CALL:C155("ERR_GenericOnError")
					QR BLOB TO REPORT:C771($l_AreaQR;[xShell_Reports:54]xReportData_:29)
					If (error#200)
						$l_columnas_objetos:=QR Count columns:C764($l_AreaQR)
						For ($l_columna;1;$l_columnas_objetos;1)
							QR GET INFO COLUMN:C766($l_AreaQR;$l_columna;$t_encabezado;$t_script;$l_columnaOculta;$l_anchoColumna;$l_valoresRepetidos;$t_formatoColumna)
							$l_tabla:=0
							API Resolve Fieldname ($t_script;$l_tabla;$l_campo)
							If ($l_tabla<=0)
								APPEND TO ARRAY:C911($at_objetos;ST_ClearSpaces ($t_script))
							End if 
						End for 
					End if 
					ON ERR CALL:C155("")
					  //----------------------------------------
			End case 
		End for 
		IT_Progress (-1;$l_proceso)
		SR DELETE OFFSCREEN AREA (vlSRP_AreaRef)
		QR DELETE OFFSCREEN AREA:C754($l_AreaQR)
		  //$t_Codigo:=AT_array2text (->$at_objetos;"\r\r")
		  //$l_tamaño:=Length($t_Codigo)
		
		
		  // busco los métodos en el código de los informes
		$l_proceso:=IT_Progress (1;0;0;"Buscando métodos utilizados en scripts de informes... ")
		For ($i;1;Size of array:C274($y_Metodos->);1)
			$t_metodo:=$y_Metodos->{$i}
			If ($t_metodo="0000_TestsABK2")
				  // solo para debug
			End if 
			$at_objetos{0}:=$t_metodo
			$l_elementos:=AT_SearchArray (->$at_objetos;"@";->$al_FilasRetorno)
			  //If (Position($t_metodo;$t_codigo)>0)
			If ($l_elementos>0)
				APPEND TO ARRAY:C911($y_Informes->;$t_metodo)
			End if 
			IT_Progress (0;$l_proceso;$i/Size of array:C274($y_Metodos->);"Buscando métodos utilizados en scripts de informes... \r"+$t_metodo)
		End for 
		IT_Progress (-1;$l_proceso)
		
		AT_DistinctsArrayValues ($y_comandos)
		For ($i;1;Size of array:C274($y_comandos->))
			$l_elemento:=Find in array:C230($y_Metodos->;$y_comandos->{$i})
			If ($l_elemento>0)
				DELETE FROM ARRAY:C228($y_Metodos->;$l_elemento)
			End if 
		End for 
		
		AT_DistinctsArrayValues ($y_Informes)
		For ($i;1;Size of array:C274($y_Informes->))
			$l_elemento:=Find in array:C230($y_Metodos->;$y_Informes->{$i})
			If ($l_elemento>0)
				DELETE FROM ARRAY:C228($y_Metodos->;$l_elemento)
			End if 
		End for 
		
		AT_DistinctsArrayValues ($y_macros)
		For ($i;1;Size of array:C274($y_macros->))
			$l_elemento:=Find in array:C230($y_Metodos->;$y_macros->{$i})
			If ($l_elemento>0)
				DELETE FROM ARRAY:C228($y_Metodos->;$l_elemento)
			End if 
		End for 
		
		AT_DistinctsArrayValues ($y_webServices)
		For ($i;1;Size of array:C274($y_webServices->))
			$l_elemento:=Find in array:C230($y_Metodos->;$y_webServices->{$i})
			If ($l_elemento>0)
				DELETE FROM ARRAY:C228($y_Metodos->;$l_elemento)
			End if 
		End for 
		
		  //AT_ResizeArrays ($y_Carpetas;Size of array($y_Metodos->))
		  //For ($i;1;Size of array($y_Metodos->))
		  //$y_Carpetas->{$i}:=4D_GetMethodFolder ($y_Metodos->{$i})
		  //End for 
		  //APPEND TO ARRAY($y_jerarquia;$y_Carpetas)
		  //LISTBOX SORT COLUMNS(*;"lb_metodos";1;>;2;>)
		  //LISTBOX SET HIERARCHY(*;"lb_metodos";True;$y_jerarquia)
		
	: (Form event:C388=On Close Box:K2:21)
		If (FORM Get current page:C276=2)
			FORM GOTO PAGE:C247(1)
		Else 
			CANCEL:C270
		End if 
		
End case 