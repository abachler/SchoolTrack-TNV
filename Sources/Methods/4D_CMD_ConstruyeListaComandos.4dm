//%attributes = {}
  // 4D_CMD_ConstruyeLista()
  // Por: Alberto Bachler: 20/02/13, 12:18:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_IdComando;$l_NodoSax;$l_posicion;$l_ultimoID)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_codigoLenguaje;$t_documentoXliff;$t_IdComando;$t_nombreElemento;$t_PrefijoElemento;$t_rutaDocumento;$t_sintaxis;$t_valorAtributo;$t_descripcion)

ARRAY TEXT:C222($at_nombreAtributos;0)
ARRAY TEXT:C222($at_valorAtributos;0)

$t_codigoLenguaje:=ST_GetWord (Get database localization:C1009(Default localization:K5:21);1;"-")
$t_documentoXliff:="4DSyntax"+Uppercase:C13($t_codigoLenguaje)+".xlf"

  // There is an assumption here that this XLIFF file contains all 4D commands.
$t_rutaDocumento:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+$t_codigoLenguaje+".lproj"+Folder separator:K24:12+$t_documentoXliff
$h_refDocumento:=Open document:C264($t_rutaDocumento;Read mode:K24:5)


hl_comandos:=New list:C375

If (OK=1)
	
	Repeat 
		$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
		
		Case of 
			: ($l_NodoSax=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
				  //SAX GET XML ELEMENT VALUE($h_refDocumento;$t_sintaxis)
				Case of 
					: ($t_nombreElemento="trans-unit")
						$l_posicion:=Find in array:C230($at_nombreAtributos;"id")
						If ($l_posicion>0)
							$t_IdComando:=$at_valorAtributos{$l_posicion}
							$l_IdComando:=Num:C11($t_IdComando)
							$t_valorAtributo:="cmd"+$t_IdComando
							$l_posicion:=Find in array:C230($at_valorAtributos;$t_valorAtributo)
							If ($l_posicion>0)
								Repeat 
									$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
								Until ($l_NodoSax=XML start element:K45:10)
								SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
								Repeat 
									$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
								Until ($l_NodoSax=XML start element:K45:10)
								SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
								If ($t_nombreElemento="target")
									Repeat 
										$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
									Until ($l_NodoSax=XML DATA:K45:12)
									SAX GET XML ELEMENT VALUE:C877($h_refDocumento;$t_sintaxis)
									Repeat 
										$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
									Until ($l_NodoSax=XML start element:K45:10)
									SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
									If ($t_nombreElemento="trans-unit")
										$t_valorAtributo:="desc"+$t_IdComando
										$l_posicion:=Find in array:C230($at_valorAtributos;$t_valorAtributo)
										If ($l_posicion>0)
											Repeat 
												$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
											Until ($l_NodoSax=XML start element:K45:10)
											SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
											Repeat 
												$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
											Until ($l_NodoSax=XML start element:K45:10)
											SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
											If ($t_nombreElemento="target")
												Repeat 
													$l_NodoSax:=SAX Get XML node:C860($h_refDocumento)
												Until ($l_NodoSax=XML DATA:K45:12)
												SAX GET XML ELEMENT VALUE:C877($h_refDocumento;$t_descripcion)
											End if 
										End if 
									End if 
									$l_nombreCommando:=Command name:C538($l_IdComando)
									APPEND TO LIST:C376(hl_comandos;$l_nombreCommando;$l_IdComando)
									SET LIST ITEM PARAMETER:C986(hl_comandos;$l_IdComando;"Sintaxis";$t_sintaxis)
									SET LIST ITEM PARAMETER:C986(hl_comandos;$l_IdComando;"Descripcion";$t_descripcion)
								End if 
							End if 
						End if 
				End case 
		End case 
		
	Until ($l_NodoSax=XML end document:K45:15)
	
	CLOSE DOCUMENT:C267($h_refDocumento)
End if 
SORT LIST:C391(hl_comandos)


