//%attributes = {}
  // PICTLib_ReferencesInCode()
  // 
  //
  // creado por: Alberto Bachler Klein: 08-09-16, 12:13:33
  // -----------------------------------------------------------
C_LONGINT:C283($i;$i_expresiones;$i_metodos;$i_registros;$l_posicion;$l_ProgressProcID)
C_POINTER:C301($y_tabla)
C_OBJECT:C1216($ob_uso)

ARRAY LONGINT:C221($al_recNum;0)
ARRAY TEXT:C222($at_Codigo;0)
ARRAY TEXT:C222($at_CodigoDelMetodo;0)
ARRAY TEXT:C222($at_expresiones;0)
ARRAY TEXT:C222($at_metodos;0)
ARRAY TEXT:C222($at_usoEnMetodos;0)
ARRAY OBJECT:C1221($ao_Usos;0)


  // analizo llamados directos a imagenes en el codigo usando la constante
  // leo todo el código y lo cargo en arreglos
METHOD GET PATHS:C1163(Path all objects:K72:16;$at_metodos;*)
METHOD GET CODE:C1190($at_metodos;$at_Codigo;*)

  // recorro todos los registros para determinar si hay llamados a la imagen en el código
READ WRITE:C146([xShell_PictLibrary:194])
ALL RECORDS:C47([xShell_PictLibrary:194])
$y_tabla:=->[xShell_PictLibrary:194]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"Buscando referencias a imagenes en el código…")

For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
	If (OK=1)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"Buscando referencias a imagenes en el código…\r"+[xShell_PictLibrary:194]Nombre:2)
		
		AT_Initialize (->$at_expresiones)
		Case of 
			: ([xShell_PictLibrary:194]Id_imagen:4>0)
				  // defino las expresiones a buscar en el codigo y las pongo en un arreglo
				APPEND TO ARRAY:C911($at_expresiones;"_o_Use PicRef+"+String:C10([xShell_PictLibrary:194]Id_imagen:4))
				APPEND TO ARRAY:C911($at_expresiones;String:C10([xShell_PictLibrary:194]Id_imagen:4)+"+"+"_o_Use PicRef")
				APPEND TO ARRAY:C911($at_expresiones;"13072+"+String:C10([xShell_PictLibrary:194]Id_imagen:4))
				APPEND TO ARRAY:C911($at_expresiones;String:C10([xShell_PictLibrary:194]Id_imagen:4)+"+13072")
				
			: (([xShell_PictLibrary:194]Id_imagen:4<0) & ([xShell_PictLibrary:194]rutaExterna:9#""))
				APPEND TO ARRAY:C911($at_expresiones;[xShell_PictLibrary:194]rutaExterna:9)
				APPEND TO ARRAY:C911($at_expresiones;Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";"+Folder separator"))
				APPEND TO ARRAY:C911($at_expresiones;Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";"SYS_FolderDelimiter"))
				APPEND TO ARRAY:C911($at_expresiones;Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";"SYS_FolderDelimiterOnServer"))
				APPEND TO ARRAY:C911($at_expresiones;Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";"\\"))
				APPEND TO ARRAY:C911($at_expresiones;Replace string:C233([xShell_PictLibrary:194]rutaExterna:9;"/";":"))
		End case 
		
		$l_posicion:=0
		$l_ms:=Milliseconds:C459
		For ($i_metodos;1;Size of array:C274($at_metodos))
			  //METHOD GET CODE($at_metodos{$i_metodos};$t_codigo)
			For ($i_expresiones;1;Size of array:C274($at_expresiones))
				  //$l_posicion:=Position($at_expresiones{$i_expresiones};$t_codigo)
				$l_posicion:=Position:C15($at_expresiones{$i_expresiones};$at_Codigo{$i_metodos})
				  //$l_posicion:=Find in array($at_CodigoDelMetodo;"@"+$at_expresiones{$i_expresiones}+"@")
				If ($l_posicion>0)
					OB GET ARRAY:C1229([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
					OB SET:C1220($ob_uso;"tipoObjeto";"codigo")
					OB SET:C1220($ob_uso;"ruta";$at_metodos{$i_metodos})
					APPEND TO ARRAY:C911($ao_Usos;$ob_uso)
					OB SET ARRAY:C1227([xShell_PictLibrary:194]usos:8;"usos";$ao_Usos)
					[xShell_PictLibrary:194]numeroObjetos:10:=[xShell_PictLibrary:194]numeroObjetos:10+1
					SAVE RECORD:C53([xShell_PictLibrary:194])
					CLEAR VARIABLE:C89($ob_uso)
					SAVE RECORD:C53($y_Tabla->)
					$i_Expresiones:=Size of array:C274($at_expresiones)+1
				End if 
			End for 
		End for 
		$l_ms:=Milliseconds:C459-$l_ms
		
		
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)