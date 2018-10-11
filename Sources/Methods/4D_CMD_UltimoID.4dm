//%attributes = {}
  // 4D_CMD_UltimoID()
  // Por: Alberto Bachler: 24/02/13, 09:30:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_posicion;$l_ultimoID;$l_eventoSAX)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_IdComando;$t_nombreElemento;$t_PrefijoElemento;$t_rutaDocumento)

ARRAY TEXT:C222($at_nombreAtributos;0)
ARRAY TEXT:C222($at_valorAtributos;0)
If (False:C215)
	C_LONGINT:C283(4D_CMD_UltimoID ;$0)
End if 

  // There is an assumption here that this XLIFF file contains all 4D commands.
$t_rutaDocumento:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+"en.lproj"+Folder separator:K24:12+"4DSyntaxEN.xlf"
$h_refDocumento:=Open document:C264($t_rutaDocumento;Read mode:K24:5)

If (OK=1)
	
	Repeat 
		$l_eventoSAX:=SAX Get XML node:C860($h_refDocumento)
		
		Case of 
			: ($l_eventoSAX=XML start element:K45:10)
				SAX GET XML ELEMENT:C876($h_refDocumento;$t_nombreElemento;$t_PrefijoElemento;$at_nombreAtributos;$at_valorAtributos)
				
				Case of 
					: ($t_nombreElemento="trans-unit")
						$l_posicion:=Find in array:C230($at_nombreAtributos;"id")
						If ($l_posicion>0)
							$t_IdComando:=$at_valorAtributos{$l_posicion}
							If ($l_ultimoID<Num:C11($t_IdComando))
								$l_ultimoID:=Num:C11($t_IdComando)
							End if 
						End if 
				End case 
		End case 
		
	Until ($l_eventoSAX=XML end document:K45:15)
	
	CLOSE DOCUMENT:C267($h_refDocumento)
End if 

$0:=$l_ultimoID

