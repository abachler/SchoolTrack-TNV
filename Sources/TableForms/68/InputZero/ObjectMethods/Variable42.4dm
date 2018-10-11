_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_elemento;$l_idTermometro;$l_opcion)
C_TEXT:C284($t_antesEdicion;$t_mensaje;$t_refjSon)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_Materias;0)

Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		
	: (Form event:C388=On Data Change:K2:15)
		$t_antesEdicion:=Old:C35([BBL_Thesaurus:68]Materia:13)
		QRY_BusquedaTextosIndexados ($t_antesEdicion;->[BBL_Items:61]Materias_json:53;Contiene todas las palabras)
		BBL_BuscaMateriaEnItems ($t_antesEdicion)
		
		If (Records in selection:C76([BBL_Items:61])>0)
			$t_mensaje:=__ ("^0 es una materia utilizada a ^1 ítems")+"\r"+__ ("La modificación sera aplicada a todos los ítems")+"\r\r"+__ ("¿Confirma usted  la modificación?")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";Substring:C12($t_antesEdicion;4))
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";String:C10(Records in selection:C76([BBL_Items:61])))
			$l_opcion:=ModernUI_Notificacion (__ ("Edición de materias");$t_mensaje;__ ("Aceptar");__ ("Cancelar"))
			If ($l_opcion=1)
				LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
				$l_idTermometro:=IT_Progress (1;0;0;"...")
				For ($i_registros;1;Size of array:C274($al_RecNums))
					READ WRITE:C146([BBL_Items:61])
					GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
					
					C_OBJECT:C1216($ob_raiz;$ob_temp)
					$ob_raiz:=OB_Create 
					$ob_raiz:=JSON Parse:C1218([BBL_Items:61]Materias_json:53;Is object:K8:27)
					
					
					  // Modificado por: Alexis Bustamante (10-06-2017)
					  //TICKET 179869 
					
					  //$t_refjSon:=JSON Parse text ([BBL_Items]Materias_json)
					OB_GET ($ob_raiz;->$at_Materias;"materiasCatalogacion_KW")
					  //JSON_ExtraeValorElemento ($t_refjSon;->$at_Materias;"materiasCatalogacion_KW")
					  //JSON CLOSE ($t_refjSon)
					$l_elemento:=Find in array:C230($at_Materias;$t_antesEdicion)
					If ($l_elemento>0)
						$at_Materias{$l_elemento}:=[BBL_Thesaurus:68]Materia:13
						$ob_temp:=OB_Create 
						OB_SET ($ob_temp;->$at_materias;"materiasCatalogacion_KW")
						  //$t_refJson:=JSON New 
						
						  //JSON_AgregaElemento ($t_refJson;->$at_materias;"materiasCatalogacion_KW")
						  //[BBL_Items]Materias_json:=JSON Export to text ($t_refJson;JSON_WITH_WHITE_SPACE)
						[BBL_Items:61]Materias_json:53:=OB_Object2Json ($ob_temp)
						  //JSON CLOSE ($t_refjSon)
					End if 
					SAVE RECORD:C53([BBL_Items:61])
					$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
				End for 
				$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
				KRL_UnloadReadOnly (->[BBL_Items:61])
			End if 
		End if 
		
		Self:C308->:=ST_Format (Self:C308;->[BBL_Thesaurus:68]Materia:13)
		SET WINDOW TITLE:C213(__ ("Thesaurus: ")+Self:C308->)
End case 