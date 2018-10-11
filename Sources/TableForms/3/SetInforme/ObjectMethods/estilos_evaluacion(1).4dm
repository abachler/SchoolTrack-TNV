Case of 
	: (Self:C308->=1)
		vi_ConvertGradesTo:=0
	: (Self:C308->>2)
		vi_ConvertGradesTo:=Self:C308->-2
End case 

Case of 
	: (aEvStyleType=1)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_oficial:23
		EVS_ReadStyleData ($evStyleID)
	: (aEvStyleType=2)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_interno:33
		EVS_ReadStyleData ($evStyleID)
	: (aEvStyleType=3)
		vlEVS_CurrentEvStyleID:=0
		$evStyleID:=0
End case 
vi_StyleType:=Self:C308->