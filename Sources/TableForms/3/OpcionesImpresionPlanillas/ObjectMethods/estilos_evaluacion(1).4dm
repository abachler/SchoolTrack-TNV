Case of 
	: (Self:C308->=1)
		vi_ConvertGradesTo:=0
	: (Self:C308->>2)
		vi_ConvertGradesTo:=Self:C308->-2
End case 

  //Case of 
  //: (aEvStyleType=1)
  //READ ONLY([xSTR_Niveles])
  //QUERY([xSTR_Niveles];[xSTR_Niveles]NoNivel=[Alumnos]Nivel_Número)
  //$evStyleID:=[xSTR_Niveles]EvStyle_oficial
  //EVS_ReadStyleData ($evStyleID)
  //: (aEvStyleType=2)
  //READ ONLY([xSTR_Niveles])
  //QUERY([xSTR_Niveles];[xSTR_Niveles]NoNivel=[Alumnos]Nivel_Número)
  //$evStyleID:=[xSTR_Niveles]EvStyle_interno
  //EVS_ReadStyleData ($evStyleID)
  //: (aEvStyleType=3)
  //vlEVS_CurrentEvStyleID:=0
  //$evStyleID:=0
  //End case 