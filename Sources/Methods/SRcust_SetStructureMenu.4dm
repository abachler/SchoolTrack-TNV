//%attributes = {}
  //SRcust_SetStructureMenu

C_BOOLEAN:C305($0;$trapped)
$trapped:=False:C215
Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
		
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		
		
End case 
$0:=$trapped