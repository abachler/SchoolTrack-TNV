//%attributes = {}
  // MÉTODO: dhBWR_TableInitialisations
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 19:10:24
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dhBWR_TableInitialisations()
  // ----------------------------------------------------




  // CODIGO PRINCIPAL
Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
				AS_InitVariables 
				
		End case 
		
		
	: (<>vsXS_CurrentModule="AccountTrack")
		
End case 

