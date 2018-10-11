  // CIM_Principal.Subformulario()
  // Por: Alberto Bachler Klein: 21-10-15, 09:41:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_evento;$l_Glass)
C_POINTER:C301($y_materiaRelacionada;$y_search;$y_tipoRelacion)
C_TEXT:C284($t_Texto;$t_textoEditado)

ARRAY TEXT:C222($at_Palabras;0)

$y_tipoRelacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoReferencia")
$y_materiaRelacionada:=OBJECT Get pointer:C1124(Object named:K67:5;"materiaRelacionada")

$l_evento:=SearchBox_FormEvent (OBJECT Get name:C1087(Object current:K67:2))
SearchBox_EnableButton (OBJECT Get name:C1087(Object current:K67:2);True:C214)

Case of 
	: ($l_evento=On Data Change:K2:15)
		SearchBox_EnableButton (OBJECT Get name:C1087(Object current:K67:2);True:C214)
		$t_Texto:=(OBJECT Get pointer:C1124(Object named:K67:5;"SearchBox"))->
		$y_search:=OBJECT Get pointer:C1124(Object named:K67:5;"SearchPicker")
		$t_textoEditado:="@"+Get edited text:C655+"@"
		READ ONLY:C145([BBL_Thesaurus:68])
		If ($t_textoEditado#"")
			AT_Text2Array (->$at_Palabras;$t_textoEditado;" ")
			If (Size of array:C274($at_Palabras)>1)
				$t_textoEditado:=$at_Palabras{1}
				QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Campo semántico:1=$t_textoEditado;*)
				QUERY:C277([BBL_Thesaurus:68]; | ;[BBL_Thesaurus:68]Materia:13=$t_textoEditado;*)
				For ($i;2;Size of array:C274($at_Palabras))
					$t_textoEditado:=$at_Palabras{$i}
					QUERY:C277([BBL_Thesaurus:68]; | [BBL_Thesaurus:68]Campo semántico:1=$t_textoEditado;*)
					QUERY:C277([BBL_Thesaurus:68]; | ;[BBL_Thesaurus:68]Materia:13=$t_textoEditado;*)
				End for 
			Else 
				QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Campo semántico:1=$t_textoEditado;*)
				QUERY:C277([BBL_Thesaurus:68]; | ;[BBL_Thesaurus:68]Materia:13=$t_textoEditado;*)
			End if 
			QUERY:C277([BBL_Thesaurus:68]; & ;[BBL_Thesaurus:68]Materia:13#"")
			ORDER BY:C49([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13;>)
			(OBJECT Get pointer:C1124(Object named:K67:5;"usoMateria"))->:=""
			OBJECT SET VISIBLE:C603(*;"notasAplicacion";False:C215)
			OBJECT SET VISIBLE:C603(*;"tipoReferencia";False:C215)
			OBJECT SET VISIBLE:C603(*;"materiaRelacionada";False:C215)
			AT_Initialize ($y_tipoRelacion;$y_materiaRelacionada)
		End if 
		
		  //CIM_Log_FiltraEventos
		
	: ($l_evento=-On Clicked:K2:4)
		If (Contextual click:C713)
			$l_Glass:=(OBJECT Get pointer:C1124(Object named:K67:5;"Glass";"SearchBox"))->
		End if 
End case 


