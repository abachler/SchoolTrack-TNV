C_LONGINT:C283(hl_Fields;vlTableNumber;$table)
C_TEXT:C284($itemText)
If (Selected list items:C379(hl_TablasFotos)>0)
	GET LIST ITEM:C378(hl_TablasFotos;Selected list items:C379(hl_TablasFotos);$table;$itemText)
	HL_ClearList (hl_Fields)
	vlTableNumber:=$table
	hl_Fields:=New list:C375
	
	Case of 
		: ($table=Table:C252(->[Alumnos:2]))
			APPEND TO LIST:C376(hl_Fields;"Identificador interno SchoolTrack";Field:C253(->[Alumnos:2]numero:1))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Alumnos:2]Codigo_interno:6));Field:C253(->[Alumnos:2]Codigo_interno:6))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Alumnos:2]RUT:5));Field:C253(->[Alumnos:2]RUT:5))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Alumnos:2]IDNacional_2:71));Field:C253(->[Alumnos:2]IDNacional_2:71))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Alumnos:2]IDNacional_3:70));Field:C253(->[Alumnos:2]IDNacional_3:70))
			vlFieldNumber:=Field:C253(->[Alumnos:2]numero:1)
		: ($table=Table:C252(->[Profesores:4]))
			APPEND TO LIST:C376(hl_Fields;"Identificador interno SchoolTrack";Field:C253(->[Profesores:4]Numero:1))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Profesores:4]Codigo_interno:30));Field:C253(->[Profesores:4]Codigo_interno:30))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Profesores:4]RUT:27));Field:C253(->[Profesores:4]RUT:27))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Profesores:4]IDNacional_2:42));Field:C253(->[Profesores:4]IDNacional_2:42))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Profesores:4]IDNacional_3:43));Field:C253(->[Profesores:4]IDNacional_3:43))
			vlFieldNumber:=Field:C253(->[Profesores:4]Numero:1)
		: ($table=Table:C252(->[Personas:7]))
			APPEND TO LIST:C376(hl_Fields;"Identificador interno SchoolTrack";Field:C253(->[Personas:7]No:1))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Personas:7]Codigo_interno:22));Field:C253(->[Personas:7]Codigo_interno:22))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Personas:7]RUT:6));Field:C253(->[Personas:7]RUT:6))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Personas:7]IDNacional_2:37));Field:C253(->[Personas:7]IDNacional_2:37))
			APPEND TO LIST:C376(hl_Fields;API Get Virtual Field Name ($table;Field:C253(->[Personas:7]IDNacional_3:38));Field:C253(->[Personas:7]IDNacional_3:38))
			vlFieldNumber:=Field:C253(->[Personas:7]No:1)
		: ($table=Table:C252(->[Familia:78]))
			APPEND TO LIST:C376(hl_Fields;"Identificador interno SchoolTrack";Field:C253(->[Familia:78]Numero:1))
			APPEND TO LIST:C376(hl_Fields;__ ("Código interno");Field:C253(->[Familia:78]Codigo_interno:14))
			vlFieldNumber:=Field:C253(->[Familia:78]Numero:1)
	End case 
	
	SELECT LIST ITEMS BY REFERENCE:C630(hl_Fields;vlFieldNumber)
	
	OBJECT SET VISIBLE:C603(*;"Campos@";True:C214)
End if 