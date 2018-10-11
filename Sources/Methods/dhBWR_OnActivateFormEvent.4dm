//%attributes = {}
  //dhBWR_OnActivateFormEvent

Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		AL_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		CU_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
		PF_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		PP_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		AS_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Actividades:29]))
		XCR_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
		BBLitm_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Lectores:72]))
		BBLusr_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Registros:66]))
		BBLcpy_OnActivation 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_RegistrosAnaliticos:74]))
		BBLanl_OnActivation 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
		FM_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Subscripciones:117]))
		BBLss_OnActivate 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		ACTcc_OnActivate 
		
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
		ACTbol_OnActivated 
		
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
		ACTter_OnActivate 
End case 
