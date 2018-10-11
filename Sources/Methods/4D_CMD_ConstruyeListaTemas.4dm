//%attributes = {}
  // 4D_CMD_ConstruyeListaTemas()
  // Por: Alberto Bachler: 24/02/13, 09:31:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_desplegada)
C_LONGINT:C283($l_error;$l_IdTema;$l_NodoSax;$l_posicion;$l_subLista;$l_ultimoID)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_codigoLenguaje;$t_documentoXliff;$t_IdTema;$t_nombreElemento;$t_PrefijoElemento;$t_rutaDocumento;$t_sintaxis;$t_TemaEN;$t_temaLocalizado;$t_textoItem)
C_TEXT:C284($t_valorAtributo)

ARRAY TEXT:C222($at_nombreAtributos;0)
ARRAY TEXT:C222($at_valorAtributos;0)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_codigoLenguaje;$t_documentoXliff;$t_IdTema;$t_nombreElemento;$t_PrefijoElemento;$t_rutaDocumento;$t_sintaxis;$t_TemaEN;$t_temaLocalizado;$t_valorAtributo)

ARRAY TEXT:C222($at_nombreAtributos;0)
ARRAY TEXT:C222($at_valorAtributos;0)

$t_codigoLenguaje:=ST_GetWord (Get database localization:C1009(Default localization:K5:21);1;"-")
$t_documentoXliff:="4D_Themes"+Uppercase:C13($t_codigoLenguaje)+".xlf"

  // There is an assumption here that this XLIFF file contains all 4D commands.
$t_rutaDocumento:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+$t_codigoLenguaje+".lproj"+Folder separator:K24:12+$t_documentoXliff
$h_refDocumento:=Open document:C264($t_rutaDocumento;Read mode:K24:5)

$x_Blob:=KRL_GetFileFromServer ("Resources"+Folder separator:K24:12+"4DCommandList_"+$t_codigoLenguaje+".blob")

If (BLOB size:C605($x_Blob)=0)
	hl_temas:=New list:C375
Else 
	hl_temas:=BLOB to list:C557($x_blob)
End if 

If (OK=1)
	
	Repeat 
		$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
		
		Case of 
			: ($l_NodoSax=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
				Case of 
					: ($t_nombreElemento="trans-unit")
						$l_posicion:=Find in array:C230($at_nombreAtributos;"id")
						If ($l_posicion>0)
							$t_IdTema:=$at_valorAtributos{$l_posicion}
							$l_IdTema:=-Num:C11($t_IdTema)
							Repeat 
								$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
							Until ($l_NodoSax=XML start element:K45:10)
							SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
							If ($t_nombreElemento="source")
								Repeat 
									$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
								Until ($l_NodoSax=XML DATA:K45:12)
								SAX GET XML ELEMENT VALUE:C877($h_refDocumento;$t_TemaEN)
							End if 
							Repeat 
								$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
							Until ($l_NodoSax=XML start element:K45:10)
							SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
							If ($t_nombreElemento="target")
								Repeat 
									$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
								Until ($l_NodoSax=XML DATA:K45:12)
								SAX GET XML ELEMENT VALUE:C877($h_refDocumento;$t_temaLocalizado)
							End if 
							$t_textoItem:=HL_FindInListByReference (hl_temas;$l_IdTema)
							Case of 
								: ($t_textoItem="")
									APPEND TO LIST:C376(hl_temas;$t_temaLocalizado;$l_IdTema)
								: ($t_textoItem#$t_temaLocalizado)
									SELECT LIST ITEMS BY REFERENCE:C630(hl_temas;$l_IdTema)
									GET LIST ITEM:C378(hl_temas;*;$l_IdTema;$t_TextoItem;$l_subLista;$b_desplegada)
									SET LIST ITEM:C385(hl_temas;$l_IdTema;$t_temaLocalizado;$l_IdTema;$l_subLista;$b_desplegada)
								Else 
									  //SELECT LIST ITEMS BY REFERENCE(hl_temas;$l_IdTema)
									  //GET LIST ITEM(hl_temas;*;$l_IdTema;$t_TextoItem;$l_subLista;$b_desplegada)
									  //SET LIST ITEM(hl_temas;$l_IdTema;$t_TextoItem;-Abs($l_IdTema);$l_subLista;$b_desplegada)
							End case 
							SET LIST ITEM PARAMETER:C986(hl_temas;-Abs:C99($l_IdTema);"temaEN";$t_TemaEN)
						End if 
				End case 
		End case 
	Until ($l_NodoSax=XML end document:K45:15)
	SORT LIST:C391(hl_temas)
	HL_ExpandAll (hl_temas)
	For ($i;1;Count list items:C380(hl_temas))
		GET LIST ITEM:C378(hl_temas;$i;$l_IdElemento;$t_TextoItem;$l_subLista;$b_desplegada)
		GET LIST ITEM PARAMETER:C985(hl_temas;$l_IdElemento;"Autorizado";$t_autorizado)
		GET LIST ITEM PROPERTIES:C631(hl_temas;$l_IdElemento;$b_editable;$l_estilo;$l_icon;$l_color)
		Case of 
			: ($t_autorizado="")
				$l_color:=0
			: ($t_autorizado="1")
				$l_color:=0x7F00
			: ($t_autorizado="0")
				$l_color:=0x00FF0000
		End case 
		SET LIST ITEM PROPERTIES:C386(hl_temas;$l_IdElemento;$b_editable;$l_estilo;$l_icon;$l_color)
		If (List item parent:C633(hl_temas;$l_IdElemento)<0)
			$t_nombreComando:=HL_FindInListByReference (hl_comandos;$l_IdElemento)
			If ($t_nombreComando#"")
				DELETE FROM LIST:C624(hl_comandos;$l_IdElemento)
			End if 
		End if 
	End for 
	HL_CollapseAll (hl_temas)
	
	CLOSE DOCUMENT:C267($h_refDocumento)
	LIST TO BLOB:C556(hl_temas;$x_Blob)
	$t_error:=KRL_SendFileToServer ("Resources"+Folder separator:K24:12+"4DCommandList_"+$t_codigoLenguaje+".blob";$x_Blob)
End if 

