//%attributes = {}
  //dhSR_SetWizardsMenu

C_TEXT:C284($menuItems;$methods)
ARRAY TEXT:C222(atBWR_CommandsPopup;0)
ARRAY TEXT:C222(atBWR_MethodsPopup;0)
$menuItems:=""
$methods:=""

Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				$menuItems:="Aprendizajes Esperados"
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Familia:78]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				$menuItems:=""
				$methods:=""
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Actividades:29]))
			Else 
				
		End case 
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				$menuItems:=""
				$methods:=""
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				$text:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				$menuItems:=""
				$methods:=""
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				$menuItems:=""
				$methods:=""
			Else 
				
		End case 
End case 

