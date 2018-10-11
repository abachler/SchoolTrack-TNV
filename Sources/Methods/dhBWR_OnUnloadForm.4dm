//%attributes = {}
  //dhBWR_OnUnloadForm

Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		AL_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
		FM_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		CU_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
		PF_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		AS_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Actividades:29]))
		XCR_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		PP_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
		BBLitm_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Lectores:72]))
		BBLusr_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Subscripciones:117]))
		BBLss_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		ACTcc_OnUnload 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ADT_Candidatos:49]))
		ADTcdd_OnUnloadRecord 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
		ACTpgs_OnUnLoad 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Boletas:181]))
		ACTbol_OnUnLoad 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
		ACTter_OnUnLoad 
		
	: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagares:184]))
		ACTpgr_OnUnLoad 
		
End case 
KRL_ReloadAsReadOnly (yBWR_currentTable)