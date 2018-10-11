//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 30-06-17, 14:54:38
  // ----------------------------------------------------
  // Método: xliff_CargaFormatos
  // Descripción
  // Crea archivo con formatos localizados segun el cliente que abra la aplicación
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_idioma;$t_rutaXLF;$t_metodoOnErr)
C_TEXT:C284($t_raiz;$t_refXML;$t_subElem;$t_subElem2;$t_subElem3;$t_subElem4;$t_valor)
C_LONGINT:C283($l_indice)

  //$t_idioma:=Get database localization(Current localization)
  //If (Application type#4D Server) //20170804 ASM Ticket 174553 


C_TEXT:C284($t_dir)
ARRAY TEXT:C222($at_DocumentosLocalizacion;0)
ARRAY LONGINT:C221($al_posiciones;0)
$t_dir:=Get 4D folder:C485(Current resources folder:K5:16)
FOLDER LIST:C473($t_dir;$at_DocumentosLocalizacion)

$at_DocumentosLocalizacion{0}:=".lproj"
AT_SearchArray (->$at_DocumentosLocalizacion;"@";->$al_posiciones)

For ($l_indiceXliff;1;Size of array:C274($al_posiciones))
	$t_idioma:=Substring:C12($at_DocumentosLocalizacion{$al_posiciones{$l_indiceXliff}};1;Position:C15(".";$at_DocumentosLocalizacion{$al_posiciones{$l_indiceXliff}})-1)
	$t_rutaXLF:=$t_dir+$t_idioma+".lproj"+Folder separator:K24:12+"XS_Formatos.xlf"
	If (Test path name:C476($t_rutaXLF)=Is a document:K24:1)
		$t_metodoOnErr:=Method called on error:C704
		ON ERR CALL:C155("ERR_EventoError")
		SYS_DeleteFile ($t_rutaXLF)
		ON ERR CALL:C155($t_metodoOnErr)
	Else 
		ok:=1
	End if 
	If (ok=1)
		$t_raiz:="xliff"
		$t_refXML:=DOM Create XML Ref:C861($t_raiz;"";"version";"1.0")
		
		$t_subElem:=DOM Create XML element:C865($t_refXML;"/"+$t_raiz+"/file";"original";"undefined";"source-language";"es";"target-language";$t_idioma)
		$t_subElem2:=DOM Create XML element:C865($t_subElem;"/file/body/group";"id";"19000";"resname";"formatos")
		For ($l_indice;1;Size of array:C274($1->))
			$t_subElem3:=DOM Create XML element:C865($t_subElem2;"/group/trans-unit";"id";String:C10($l_indice);"resname";"formato")
			$t_valor:=$1->{$l_indice}
			$t_subElem4:=DOM Create XML element:C865($t_subElem3;"/trans-unit/source")
			DOM SET XML ELEMENT VALUE:C868($t_subElem4;$t_valor)
			$t_valor:=$1->{$l_indice}
			$t_subElem4:=DOM Create XML element:C865($t_subElem3;"/trans-unit/target")
			DOM SET XML ELEMENT VALUE:C868($t_subElem4;$t_valor)
		End for 
		DOM EXPORT TO FILE:C862($t_refXML;$t_rutaXLF)
		DOM CLOSE XML:C722($t_refXML)
		
	End if 
End for 

  //End if 
