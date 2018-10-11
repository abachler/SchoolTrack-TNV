//%attributes = {}
  //dhSR_SetVariables

C_BOOLEAN:C305($0;$trapped)

$trapped:=False:C215

dhSR_InitVariables 
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				SRcust_SetStudentVariables 
				$trapped:=True:C214
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
				SRcust_SetFamilyVariables 
				$trapped:=True:C214
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
				
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				SRcust_SetParentsVariables 
				$trapped:=True:C214
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
				SRcust_SetStudentVariables 
				$trapped:=True:C214
				
		End case 
	: (vsBWR_CurrentModule="AccountTrack")
		Case of 
			: (Abs:C99(vlQR_SRMainTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				SRcust_SetAvisosVariables 
				$trapped:=True:C214
			: (Abs:C99(vlQR_SRMainTable)=Table:C252(->[ACT_Boletas:181]))
				SRcust_SetBoletasVariables 
				$trapped:=True:C214
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				SRcust_SetParentsVariables 
				$trapped:=True:C214
		End case 
	: (vsBWR_CurrentModule="AdmissionTrack")
		Case of 
				
		End case 
	: (vsBWR_CurrentModule="MediaTrack")
		Case of 
				
		End case 
End case 
$0:=$trapped