//%attributes = {"executedOnServer":true}
  // Método: 4D_XLIFF_Texts
  // llamado desde 4D_XLIFF_CreateFiles (puede ser ejecutado directamente)
  // se ejecuta en el servidor y solo en modo interpretado
  // genera un archivos con los textos llamados en el método __( ) en texts.xlf en <carpeta de la estructura>/xliff
  //
  // creado por Alberto Bachler Klein
  // el 20/02/18, 13:52:50
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

If (Not:C34(Is compiled mode:C492))
	
	C_LONGINT:C283($hl_lenguas;$hl_Paises;$i;$i_lenguas;$i_paises;$l_enArreglo;$l_final;$l_item;$l_linea;$l_posicion)
	C_LONGINT:C283($l_unitID)
	C_TEXT:C284($t_bodyXML;$t_cierre;$t_codigo;$t_finMensaje;$t_footerXML;$t_headerXML;$t_inicioMensaje;$t_mensaje;$t_ruta;$t_archivo)
	C_LONGINT:C283($l_proc)
	C_BOOLEAN:C305($b_errorAlEliminar;$0;$b_hecho)
	
	ARRAY TEXT:C222($at_codigo;0)
	ARRAY TEXT:C222($at_countryCodes;0)
	ARRAY TEXT:C222($at_langageCodes;0)
	ARRAY TEXT:C222($at_mensajes;0)
	ARRAY TEXT:C222($at_resource;0)
	ARRAY TEXT:C222($at_rutas;0)
	ARRAY TEXT:C222($at_mensajeError;0)
	ARRAY TEXT:C222($at_resourceError;0)
	
	$y_pointerObjeto:=$1
	
	OB SET ARRAY:C1227($y_pointerObjeto->;"mensaje";$at_mensajeError)
	OB SET ARRAY:C1227($y_pointerObjeto->;"resource";$at_resourceError)
	
	$t_ruta:=Get 4D folder:C485(Database folder:K5:14)+"xliff"+Folder separator:K24:12+"es-cl.lproj"+Folder separator:K24:12
	$t_archivo:=$t_ruta+"texts.xlf"
	
	$t_headerXML:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\r"
	$t_headerXML:=$t_headerXML+"<xliff version=\"1.0\">\r"
	$t_headerXML:=$t_headerXML+"<file original=\"undefined\" source-language=\"es\" target-language=\"es-cl\">\r\r"
	$t_headerXML:=$t_headerXML+"<body>\r"
	
	$t_headerXML:=$t_headerXML+"<group>\r"
	
	
	METHOD GET PATHS:C1163(Path all objects:K72:16;$at_rutas)
	$l_unitID:=0
	$t_inicioMensaje:="@__ (\"@"
	$t_finMensaje:="\")"
	
	$l_proc:=IT_Progress (1;0;0;"Buscando información para archivo texts.xlf...")
	For ($i;1;Size of array:C274($at_rutas))
		METHOD GET CODE:C1190($at_rutas{$i};$t_codigo)
		AT_Text2Array (->$at_codigo;$t_codigo;"\r")
		$l_linea:=Find in array:C230($at_codigo;$t_inicioMensaje)
		While ($l_linea>0)
			$l_posicion:=1
			While ($l_posicion>0)  // Para dar soporte a mas de un texto traducido en la misma línea
				$l_posicion:=Position:C15("__ (\"";$at_codigo{$l_linea})
				$t_mensaje:=Substring:C12($at_codigo{$l_linea};$l_posicion+5)
				$l_final1:=Position:C15($t_finMensaje;$t_mensaje)
				$l_final2:=Position:C15("\";";$t_mensaje)  //20180307 RCH Da soporte a posibles parametros de __(
				Case of 
					: ($l_final1=0)  // para cuando se pasan parametros y esto esta en una linea __(
						$l_final:=$l_final2
					: ($l_final2=0)  // para cuando no se pasan parametros a __(
						$l_final:=$l_final1
					: ($l_final1<$l_final2)  // para cuando no se pasan parametros y se llama, por ejemplo, a cd_dlog en la misma linea
						$l_final:=$l_final1
					: ($l_final2<$l_final1)  // para cuando se pasan parametros y se llama, por ejemplo, a cd_dlog en la misma linea
						$l_final:=$l_final2
				End case 
				$t_mensaje:=Substring:C12($t_mensaje;1;$l_final-1)
				
				$l_enArreglo:=Find in array:C230($at_mensajes;$t_mensaje)
				If ($l_enArreglo<0)
					$b_error:=False:C215
					
					Case of 
						: (Position:C15("<";$t_mensaje)>0)
							$b_error:=True:C214
						: (Position:C15("<";$t_mensaje)>0)
					End case 
					
					If (Not:C34($b_error))
						APPEND TO ARRAY:C911($at_mensajes;$t_mensaje)
						APPEND TO ARRAY:C911($at_resource;METHOD Get path:C1164(Path project method:K72:1;$at_rutas{$i})+".L"+String:C10($l_linea-1))
					Else 
						APPEND TO ARRAY:C911($at_mensajeError;$t_mensaje)
						APPEND TO ARRAY:C911($at_resourceError;METHOD Get path:C1164(Path project method:K72:1;$at_rutas{$i})+".L"+String:C10($l_linea-1))
					End if 
				End if 
				$at_codigo{$l_linea}:=Replace string:C233($at_codigo{$l_linea};$t_mensaje;"")
				$at_codigo{$l_linea}:=Replace string:C233($at_codigo{$l_linea};"__ (\"\")";"")
				$at_codigo{$l_linea}:=Replace string:C233($at_codigo{$l_linea};"__ (\"\";";"")
				$l_posicion:=Position:C15("__ (\"";$at_codigo{$l_linea})
			End while 
			$l_linea:=Find in array:C230($at_codigo;$t_inicioMensaje;$l_linea+1)
		End while 
		IT_Progress (0;$l_proc;$i/Size of array:C274($at_rutas))
	End for 
	IT_Progress (-1;$l_proc)
	
	OB SET ARRAY:C1227($y_pointerObjeto->;"mensaje";$at_mensajeError)
	OB SET ARRAY:C1227($y_pointerObjeto->;"resource";$at_resourceError)
	
	
	$l_proc:=IT_Progress (1;0;0;"Generando archivo texts.xlf...")
	For ($i;1;Size of array:C274($at_mensajes))
		$t_mensaje:=$at_mensajes{$i}
		$t_mensaje:=Replace string:C233($t_mensaje;":xliff:";"")
		$t_bodyXML:=$t_bodyXML+"   <trans-unit id=\""+String:C10($i)+"\" resname=\""+$at_resource{$i}+"\">\r"
		$t_bodyXML:=$t_bodyXML+"      <source>"+$t_mensaje+"</source>\r"
		$t_bodyXML:=$t_bodyXML+"      <target>"+$t_mensaje+"</target>\r"
		$t_bodyXML:=$t_bodyXML+"   </trans-unit>\r"
		IT_Progress (0;$l_proc;$i/Size of array:C274($at_mensajes))
	End for 
	$t_footerXML:="</group>\r\r</body>\r</file>\r</xliff>"
	IT_Progress (-1;$l_proc)
	
	CREATE FOLDER:C475($t_ruta;*)
	$t_metodoOnErr:=Method called on error:C704
	Error:=0
	ON ERR CALL:C155("ERR_EventoError")
	TEXT TO DOCUMENT:C1237($t_archivo;$t_headerXML+$t_bodyXML+$t_footerXML)
	If (Error=0)
		$b_hecho:=True:C214
	End if 
	ON ERR CALL:C155($t_metodoOnErr)
	
End if 
$0:=$b_hecho

