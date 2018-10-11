//%attributes = {}
  // PICTLib_GetPictures()
  //
  //
  // creado por: Alberto Bachler Klein: 01-09-16, 14:16:36
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_editable)
C_LONGINT:C283($i;$i_elementos;$i_expresiones;$i_form;$i_items;$i_objeto;$i_registros;$l_altoCampo;$l_altoLib;$l_anchoCampo)
C_LONGINT:C283($l_anchoLib;$l_elemento;$l_estilos;$l_idImagen;$l_idLista;$l_numeroDeTablas;$l_numeroTabla;$l_ProgressProcID;$l_recNum;$l_refImagen)
C_LONGINT:C283($l_tamañoCampo;$l_tamañoLib;$l_tipoObjeto)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_formato;$t_imagen;$t_nombreComando;$t_nombreDocumento;$t_nombreForm;$t_nombreImagen;$t_nombreLista;$t_nombreTabla;$t_objeto;$t_rutaExport)
C_TEXT:C284($t_rutaImagen;$t_rutaRelativa)
C_OBJECT:C1216($ob_uso)

ARRAY LONGINT:C221($al_idImagenesLibreria;0)
ARRAY LONGINT:C221($al_pagina;0)
ARRAY LONGINT:C221($al_recNum;0)
ARRAY LONGINT:C221($al_refLista;0)
ARRAY POINTER:C280($ay_Objetos_Variable;0)
ARRAY TEXT:C222($at_Codigo;0)
ARRAY TEXT:C222($at_docs;0)
ARRAY TEXT:C222($at_enMetodos;0)
ARRAY TEXT:C222($at_expresiones;0)
ARRAY TEXT:C222($at_Forms;0)
ARRAY TEXT:C222($at_metodos;0)
ARRAY TEXT:C222($at_nombreImagenesLibreria;0)
ARRAY TEXT:C222($at_nombreLista;0)
ARRAY TEXT:C222($at_objetosNombre;0)
ARRAY OBJECT:C1221($ao_Usos;0)




  //inicializo la tabla PictLibrary
ALL RECORDS:C47([xShell_PictLibrary:194])
KRL_DeleteSelection (->[xShell_PictLibrary:194])


  // creo registros en la tabla PictLibrary a partir de la imagenes almacenadas en la librería
PICTURE LIBRARY LIST:C564($al_idImagenesLibreria;$at_nombreImagenesLibreria)
For ($i;1;Size of array:C274($al_idImagenesLibreria))
	$t_nombreImagen:=$at_nombreImagenesLibreria{$i}
	$t_nombreImagen:=Replace string:C233($t_nombreImagen;":";"-")
	$t_nombreImagen:=Replace string:C233($t_nombreImagen;"\\";"-")
	$t_nombreImagen:=Replace string:C233($t_nombreImagen;"/";"-")
	$t_nombreDocumento:=$t_rutaExport+Folder separator:K24:12+$t_nombreImagen
	
	$l_recNum:=Find in field:C653([xShell_PictLibrary:194]Id_imagen:4;$al_idImagenesLibreria{$i})
	If ($l_recNum=No current record:K29:2)
		CREATE RECORD:C68([xShell_PictLibrary:194])
		[xShell_PictLibrary:194]Id_imagen:4:=$al_idImagenesLibreria{$i}
		[xShell_PictLibrary:194]Nombre:2:=$t_nombreImagen
		GET PICTURE FROM LIBRARY:C565($al_idImagenesLibreria{$i};[xShell_PictLibrary:194]pict:3)
		PICTURE PROPERTIES:C457([xShell_PictLibrary:194]pict:3;$l_anchoCampo;$l_altoCampo)
		[xShell_PictLibrary:194]alto:6:=$l_altoCampo
		[xShell_PictLibrary:194]ancho:5:=$l_anchoCampo
		[xShell_PictLibrary:194]tamaño:7:=Picture size:C356([xShell_PictLibrary:194]pict:3)
		SAVE RECORD:C53([xShell_PictLibrary:194])
	Else 
		GOTO RECORD:C242([xShell_PictLibrary:194];$l_recNum)
	End if 
End for 


  // analizo el uso de lmagenes de la librería en las listas
LIST OF CHOICE LISTS:C957($al_refLista;$at_nombreLista)
For ($i;1;Size of array:C274($al_refLista))
	AT_Initialize (->$ao_Usos)
	$t_nombreLista:=$at_nombreLista{$i}
	$l_idLista:=Load list:C383($t_nombreLista)
	HL_ExpandAll ($l_idLista)
	For ($i_items;1;Count list items:C380($l_idLista))
		SELECT LIST ITEMS BY POSITION:C381($l_idLista;$i_items)
		GET LIST ITEM PROPERTIES:C631($l_idLista;*;$b_editable;$l_estilos;$l_refImagen)
		If ($l_refImagen>Use PicRef:K28:4)
			$l_idImagen:=$l_refImagen-Use PicRef:K28:4
			READ WRITE:C146([xShell_PictLibrary:194])
			QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]Id_imagen:4=$l_IdImagen)
			If (Records in selection:C76([xShell_PictLibrary:194])=1)
				OB GET ARRAY:C1229([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
				OB SET:C1220($ob_uso;"tipoObjeto";"listaJerarquica")
				OB SET:C1220($ob_uso;"nombreLista";$t_nombreLista)
				APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
				OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
				AT_Initialize (->$ao_Usos)
				[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
				SAVE RECORD:C53([xShell_PictLibrary:194])
				CLEAR VARIABLE:C89($ob_uso)
			End if 
		End if 
	End for 
	CLEAR LIST:C377($l_idLista)
End for 

  // analizo los formularios proyecto
$t_nombreTabla:="none"
$l_numeroTabla:=0
FORM GET NAMES:C1167($at_Forms)
$l_ProgressProcID:=IT_Progress (1;0;0;"Buscando referencias a imagenes en formulario de tablas…")
For ($i_form;1;Size of array:C274($at_Forms))
	$t_nombreForm:=$at_Forms{$i_form}
	FORM LOAD:C1103($t_nombreForm)
	FORM GET OBJECTS:C898($at_objetosNombre;$ay_Objetos_Variable;$al_pagina)
	For ($i_objeto;1;Size of array:C274($at_objetosNombre))
		$t_objeto:=$at_objetosNombre{$i_objeto}
		$l_tipoObjeto:=OBJECT Get type:C1300(*;$t_objeto)
		$t_formato:=OBJECT Get format:C894(*;$t_objeto)
		$l_IdImagen:=0
		$t_imagen:=""
		$t_rutaImagen:=""
		If ($t_nombreForm="PropiedadesBD")
			
		End if 
		Case of 
			: (($l_tipoObjeto=Object type 3D button:K79:17) | ($l_tipoObjeto=Object type 3D checkbox:K79:27) | ($l_tipoObjeto=Object type 3D radio button:K79:24))
				$t_imagen:=ST_GetWord ($t_formato;2;";")
				Case of 
					: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
						  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
						  // nada, no hay imagen referenciada
					: (($t_imagen="#@") & ($t_imagen#"#"))
						$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
						$l_IdImagen:=-1  //archivo externo
					: ($t_imagen="?@")
						If (Position:C15("/";$t_imagen)=0)
							$l_IdImagen:=Num:C11($t_imagen)
						Else 
							$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
						End if 
					Else 
						  //
				End case 
				
				  //$t_imagen:=ST_GetWord ($t_formato;3;";")
				  //Case of 
				  //: (($t_imagen="#") | ($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
				  //  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
				  //  // nada, no hay imagen referenciada
				  //: (($t_imagen="#@") & ($t_imagen#"#"))
				  //$t_rutaImagen:=Get 4D folder(Current resources folder)+Substring($t_imagen;2)
				  //$l_IdImagen:=-1  //archivo externo
				  //: ($t_imagen="?@")
				  //If (Position("/";$t_imagen)=0)
				  //$l_IdImagen:=Num($t_imagen)
				  //Else 
				  //$l_IdImagen:=Num(ST_GetWord ($t_imagen;2;"/"))
				  //End if 
				  //Else 
				  //  //
				  //End case 
				
				
			: ($l_tipoObjeto=Object type static picture:K79:3)
				$t_imagen:=ST_GetWord ($t_formato;1;";")
				Case of 
					: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
						  // "!": variable, "0": id imagen no definida, "": nada
						  // nada, no hay imagen referenciada
					: (($t_imagen="#@") & ($t_imagen#"#"))
						$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
						$l_IdImagen:=-1  //archivo externo
						
					: ($t_imagen="?@")
						If (Position:C15("/";$t_imagen)=0)
							$l_IdImagen:=Num:C11($t_imagen)
						Else 
							$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
						End if 
					Else 
						  //
				End case 
				
				
				
			: (($l_tipoObjeto=Object type picture button:K79:20) | ($l_tipoObjeto=Object type picture popup menu:K79:15))
				$t_imagen:=ST_GetWord ($t_formato;3;";")
				Case of 
					: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
						  // "!": variable, "0": id imagen no definida, "": nada
						  // nada, no hay imagen referenciada
					: (($t_imagen="#@") & ($t_imagen#"#"))
						$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
						$l_IdImagen:=-1  //archivo externo
					: ($t_imagen="?@")
						If (Position:C15("/";$t_imagen)=0)
							$l_IdImagen:=Num:C11($t_imagen)
						Else 
							$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
						End if 
					Else 
						  //
				End case 
		End case 
		
		Case of 
			: ($l_IdImagen<0)  // el objeto formulario hace referencia a una imagen externa
				AT_Initialize (->$ao_Usos)
				READ WRITE:C146([xShell_PictLibrary:194])
				$t_rutaImagen:=Replace string:C233($t_rutaImagen;":";Folder separator:K24:12)
				$t_rutaImagen:=Replace string:C233($t_rutaImagen;"\\";Folder separator:K24:12)
				$t_rutaImagen:=Replace string:C233($t_rutaImagen;"/";Folder separator:K24:12)
				$t_nombreImagen:=SYS_Path2FileName ($t_rutaImagen)
				$t_rutaRelativa:=Replace string:C233($t_rutaImagen;Get 4D folder:C485(Database folder:K5:14);"")
				$t_rutaRelativa:=Replace string:C233($t_rutaRelativa;":";"/")
				$t_rutaRelativa:=Replace string:C233($t_rutaRelativa;":";"/")
				QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]rutaExterna:9=$t_rutaRelativa)
				If (Records in selection:C76([xShell_PictLibrary:194])=0)
					READ PICTURE FILE:C678($t_rutaImagen;$p_imagen)
					CREATE RECORD:C68([xShell_PictLibrary:194])
					[xShell_PictLibrary:194]Id_imagen:4:=-1
					[xShell_PictLibrary:194]Nombre:2:=$t_nombreImagen
					[xShell_PictLibrary:194]rutaExterna:9:=$t_rutaRelativa
					[xShell_PictLibrary:194]pict:3:=$p_imagen
					PICTURE PROPERTIES:C457([xShell_PictLibrary:194]pict:3;$l_anchoCampo;$l_altoCampo)
					[xShell_PictLibrary:194]alto:6:=$l_altoCampo
					[xShell_PictLibrary:194]ancho:5:=$l_anchoCampo
					[xShell_PictLibrary:194]tamaño:7:=Picture size:C356([xShell_PictLibrary:194]pict:3)
					SAVE RECORD:C53([xShell_PictLibrary:194])
					OB SET:C1220($ob_uso;"tipoObjeto";"objetoFormulario")
					OB SET:C1220($ob_uso;"tablaNumero";$l_numeroTabla)
					OB SET:C1220($ob_uso;"tablaNombre";$t_nombreTabla)
					OB SET:C1220($ob_uso;"nombreFormulario";$t_nombreForm)
					OB SET:C1220($ob_uso;"paginaFormulario";$al_pagina{$i_objeto})
					APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
					OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
					[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
					SAVE RECORD:C53([xShell_PictLibrary:194])
				End if 
				CLEAR VARIABLE:C89($ob_uso)
				
			: ($l_IdImagen>0)  // el objeto formulario hace referencia a una imagen externa
				AT_Initialize (->$ao_Usos)
				READ WRITE:C146([xShell_PictLibrary:194])
				QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]Id_imagen:4=$l_IdImagen)
				OB GET ARRAY:C1229([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
				OB SET:C1220($ob_uso;"tipoObjeto";"objetoFormulario")
				OB SET:C1220($ob_uso;"tablaNumero";$l_numeroTabla)
				OB SET:C1220($ob_uso;"tablaNombre";$t_nombreTabla)
				OB SET:C1220($ob_uso;"nombreFormulario";$t_nombreForm)
				OB SET:C1220($ob_uso;"paginaFormulario";$al_pagina{$i_objeto})
				APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
				OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
				[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
				SAVE RECORD:C53([xShell_PictLibrary:194])
				CLEAR VARIABLE:C89($ob_uso)
		End case 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_form/Size of array:C274($at_Forms);"Buscando referencias a imagenes en formularios proyecto…\r"+$t_nombreForm)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


  // analizo los formularios de tablas
$l_numeroDeTablas:=Get last table number:C254
$l_ProgressProcID:=IT_Progress (1;0;0;"Buscando referencias a imagenes en formulario de tablas…")
For ($i;1;$l_numeroDeTablas)
	If (Is table number valid:C999($i))
		$l_numeroTabla:=$i
		FORM GET NAMES:C1167(Table:C252($i)->;$at_Forms)
		$t_nombreTabla:=Table name:C256($i)
		For ($i_form;1;Size of array:C274($at_Forms))
			$t_nombreForm:=$at_Forms{$i_form}
			FORM LOAD:C1103(Table:C252($i)->;$t_nombreForm)
			FORM GET OBJECTS:C898($at_objetosNombre;$ay_Objetos_Variable;$al_pagina)
			If ($t_nombreForm="xshellBrowser")
				
			End if 
			For ($i_objeto;1;Size of array:C274($at_objetosNombre))
				$t_objeto:=$at_objetosNombre{$i_objeto}
				$l_tipoObjeto:=OBJECT Get type:C1300(*;$t_objeto)
				$t_formato:=OBJECT Get format:C894(*;$t_objeto)
				$l_IdImagen:=0
				$t_imagen:=""
				$t_rutaImagen:=""
				Case of 
					: (($l_tipoObjeto=Object type 3D button:K79:17) | ($l_tipoObjeto=Object type 3D checkbox:K79:27) | ($l_tipoObjeto=Object type 3D radio button:K79:24))
						$t_imagen:=ST_GetWord ($t_formato;2;";")
						Case of 
							: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
								  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
								  // nada, no hay imagen referenciada
							: (($t_imagen="#@") & ($t_imagen#"#"))
								$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
								$l_IdImagen:=-1  //archivo externo
							: ($t_imagen="?@")
								If (Position:C15("/";$t_imagen)=0)
									$l_IdImagen:=Num:C11($t_imagen)
								Else 
									$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
								End if 
							Else 
								  //
						End case 
						
						  //$t_imagen:=ST_GetWord ($t_formato;3;";")
						  //Case of 
						  //: (($t_imagen="#") | ($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
						  //  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
						  //  // nada, no hay imagen referenciada
						  //: (($t_imagen="#@") & ($t_imagen#"#"))
						  //$t_rutaImagen:=Get 4D folder(Current resources folder)+Substring($t_imagen;2)
						  //$l_IdImagen:=-1  //archivo externo
						  //: ($t_imagen="?@")
						  //If (Position("/";$t_imagen)=0)
						  //$l_IdImagen:=Num($t_imagen)
						  //Else 
						  //$l_IdImagen:=Num(ST_GetWord ($t_imagen;2;"/"))
						  //End if 
						  //Else 
						  //  //
						  //End case 
						
						
					: ($l_tipoObjeto=Object type static picture:K79:3)
						$t_imagen:=ST_GetWord ($t_formato;1;";")
						Case of 
							: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
								  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
								  // nada, no hay imagen referenciada
							: (($t_imagen="#@") & ($t_imagen#"#"))
								$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
								$l_IdImagen:=-1  //archivo externo
							: ($t_imagen="?@")
								If (Position:C15("/";$t_imagen)=0)
									$l_IdImagen:=Num:C11($t_imagen)
								Else 
									$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
								End if 
							Else 
								  //
						End case 
						
					: (($l_tipoObjeto=Object type picture button:K79:20) | ($l_tipoObjeto=Object type picture popup menu:K79:15))
						$t_imagen:=ST_GetWord ($t_formato;3;";")
						Case of 
							: (($t_imagen="0") | ($t_imagen="") | ($t_imagen="!@"))
								  // "!": variable, "#": ruta no definida, "0": id imagen no definida, "": nada
								  // nada, no hay imagen referenciada
							: (($t_imagen="#@") & ($t_imagen#"#"))
								$t_rutaImagen:=Get 4D folder:C485(Current resources folder:K5:16)+Substring:C12($t_imagen;2)
								$l_IdImagen:=-1  //archivo externo
							: ($t_imagen="?@")
								If (Position:C15("/";$t_imagen)=0)
									$l_IdImagen:=Num:C11($t_imagen)
								Else 
									$l_IdImagen:=Num:C11(ST_GetWord ($t_imagen;2;"/"))
								End if 
							Else 
								  //
						End case 
				End case 
				
				
				
				Case of 
					: ($l_IdImagen<0)  // el objeto formulario hace referencia a una imagen externa
						AT_Initialize (->$ao_Usos)
						READ WRITE:C146([xShell_PictLibrary:194])
						$t_rutaImagen:=Replace string:C233($t_rutaImagen;":";Folder separator:K24:12)
						$t_rutaImagen:=Replace string:C233($t_rutaImagen;"\\";Folder separator:K24:12)
						$t_rutaImagen:=Replace string:C233($t_rutaImagen;"/";Folder separator:K24:12)
						$t_nombreImagen:=SYS_Path2FileName ($t_rutaImagen)
						$t_rutaRelativa:=Replace string:C233($t_rutaImagen;Get 4D folder:C485(Database folder:K5:14);"")
						$t_rutaRelativa:=Replace string:C233($t_rutaRelativa;":";"/")
						$t_rutaRelativa:=Replace string:C233($t_rutaRelativa;":";"/")
						QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]rutaExterna:9=$t_rutaRelativa)
						If (Records in selection:C76([xShell_PictLibrary:194])=0)
							READ PICTURE FILE:C678($t_rutaImagen;$p_imagen)
							CREATE RECORD:C68([xShell_PictLibrary:194])
							[xShell_PictLibrary:194]Id_imagen:4:=-1
							[xShell_PictLibrary:194]Nombre:2:=$t_nombreImagen
							[xShell_PictLibrary:194]rutaExterna:9:=$t_rutaRelativa
							[xShell_PictLibrary:194]pict:3:=$p_imagen
							PICTURE PROPERTIES:C457([xShell_PictLibrary:194]pict:3;$l_anchoCampo;$l_altoCampo)
							[xShell_PictLibrary:194]alto:6:=$l_altoCampo
							[xShell_PictLibrary:194]ancho:5:=$l_anchoCampo
							[xShell_PictLibrary:194]tamaño:7:=Picture size:C356([xShell_PictLibrary:194]pict:3)
							SAVE RECORD:C53([xShell_PictLibrary:194])
							OB SET:C1220($ob_uso;"tipoObjeto";"objetoFormulario")
							OB SET:C1220($ob_uso;"tablaNumero";$l_numeroTabla)
							OB SET:C1220($ob_uso;"tablaNombre";$t_nombreTabla)
							OB SET:C1220($ob_uso;"nombreFormulario";$t_nombreForm)
							OB SET:C1220($ob_uso;"paginaFormulario";$al_pagina{$i_objeto})
							APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
							OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
							[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
							SAVE RECORD:C53([xShell_PictLibrary:194])
						End if 
						CLEAR VARIABLE:C89($ob_uso)
						
						
					: ($l_IdImagen>0)
						AT_Initialize (->$ao_Usos)
						READ WRITE:C146([xShell_PictLibrary:194])
						QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]Id_imagen:4=$l_IdImagen)
						OB GET ARRAY:C1229([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
						OB SET:C1220($ob_uso;"tipoObjeto";"objetoFormulario")
						OB SET:C1220($ob_uso;"tablaNumero";$l_numeroTabla)
						OB SET:C1220($ob_uso;"tablaNombre";$t_nombreTabla)
						OB SET:C1220($ob_uso;"nombreFormulario";$t_nombreForm)
						OB SET:C1220($ob_uso;"paginaFormulario";$al_pagina{$i_objeto})
						APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
						OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
						[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
						SAVE RECORD:C53([xShell_PictLibrary:194])
						CLEAR VARIABLE:C89($ob_uso)
				End case 
				
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_numeroDeTablas;"Buscando referencias a imagenes en formularios de tabla…\r"+$t_nombreTabla;$i_form/Size of array:C274($at_Forms);$t_nombreForm)
		End for 
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

  //analizo las referencias a imagenes en los comandos ejecutables
QUERY:C277([XShell_ExecutableObjects:280]; & ;[XShell_ExecutableObjects:280]IconRef:10>0)
$y_tabla:=->[XShell_ExecutableObjects:280]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"Buscando referencias a imagenes en comandos ejecutables…")
For ($i_registros;1;Size of array:C274($al_recNum))
	AT_Initialize (->$ao_Usos)
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};False:C215)
	If (OK=1)
		$l_numeroTabla:=0
		$t_nombreComando:=[XShell_ExecutableObjects:280]Object_Alias:5
		READ WRITE:C146([xShell_PictLibrary:194])
		QUERY:C277([xShell_PictLibrary:194];[xShell_PictLibrary:194]Id_imagen:4=[XShell_ExecutableObjects:280]IconRef:10)
		If (Records in selection:C76([xShell_PictLibrary:194])>0)
			OB GET ARRAY:C1229([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
			OB SET:C1220($ob_uso;"tipoObjeto";"comandoEjecutable")
			OB SET:C1220($ob_uso;"modulo";[XShell_ExecutableObjects:280]ModuleName:9)
			OB SET:C1220($ob_uso;"aliasComando";[XShell_ExecutableObjects:280]Object_Alias:5)
			OB SET:C1220($ob_uso;"nombreMetodo";[XShell_ExecutableObjects:280]Object_MethodName:3)
			APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
			OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
			[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
			SAVE RECORD:C53([xShell_PictLibrary:194])
			CLEAR VARIABLE:C89($ob_uso)
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"Buscando referencias a imagenes en comandos ejecutables…\r"+[XShell_ExecutableObjects:280]Object_Alias:5)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


UNLOAD RECORD:C212($y_tabla->)




