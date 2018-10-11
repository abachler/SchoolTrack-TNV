C_LONGINT:C283($i;$l_estadoProceso;$l_tiempoProceso)
C_POINTER:C301($y_search)
C_TEXT:C284($t_nombreProceso;$t_textoEditado)

ARRAY TEXT:C222($at_Palabras;0)

PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estadoProceso;$l_tiempoProceso)
OBJECT SET ENABLED:C1123(*;"eliminar";Records in set:C195("$materiasSeleccionadas")=1)
OBJECT SET ENABLED:C1123(*;"asignar";Records in set:C195("$materiasSeleccionadas")>0)
OBJECT SET VISIBLE:C603(*;"asignar";$t_nombreProceso="Explorador MediaTrack")


$y_tipoRelacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoReferencia")
$y_materiaRelacionada:=OBJECT Get pointer:C1124(Object named:K67:5;"materiaRelacionada")


Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_popCrossRefType;0)
		AT_Text2Array (->at_popCrossRefType;__ ("Término genérico;Término específico;Término asociado;Utilizar;Utilizado para;Inglés;Español;Francés;Italiano;Alemán;Portugués"))
		
		  //If (vs_SearchedHeader#"")
		  //$t_textoEditado:=vs_SearchedHeader
		  //vSearch:=$t_textoEditado
		  //QUERY([BBL_Thesaurus];[BBL_Thesaurus]Materia;=;"@"+$t_textoEditado+"@")
		  //ORDER BY([BBL_Thesaurus];[BBL_Thesaurus]Materia;>)
		  //End if 
		
		
	: (Form event:C388=On After Keystroke:K2:26)
		
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
		
	: (Form event:C388=On Unload:K2:2)
		If ($t_nombreProceso="Explorador MediaTrack")
			SET_UseSet ("$materiasSeleccionadas")
		End if 
		SET_ClearSets ("$materiasSeleccionadas";"$materiasEnLista";"$materiaActual")
		ARRAY TEXT:C222(at_popCrossRefType;0)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
End case 

