  // [BBL_Items].Busqueda.listboxMaterias()
  // Por: Alberto Bachler K.: 07-01-15, 18:09:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


If (Form event:C388=On Selection Change:K2:29)
	CUT NAMED SELECTION:C334([BBL_Thesaurus:68];"$listaMaterias")
	COPY SET:C600("$ListboxSetMaterias";"$Materias")
	USE SET:C118("$Materias")
	SELECTION TO ARRAY:C260([BBL_Thesaurus:68]Materia:13;$at_materias)
	CREATE EMPTY SET:C140([BBL_Items:61];"$items")
	For ($i;1;Size of array:C274($at_materias))
		QRY_BusquedaTextosIndexados ($at_materias{$i};->[BBL_Items:61]Materias_json:53;Contiene todas las palabras)
		CREATE SET:C116([BBL_Items:61];"$resultado")
		UNION:C120("$items";"$resultado";"$items")
	End for 
	USE NAMED SELECTION:C332("$listaMaterias")
	COPY SET:C600("$Materias";"$ListboxSetMaterias")
End if 