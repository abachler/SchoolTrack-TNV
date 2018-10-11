If (Self:C308->>0)
	  //Case of 
	  //: (Self->=1)
	  //READ ONLY([xSTR_Niveles])
	  //QUERY([xSTR_Niveles];[xSTR_Niveles]NoNivel=[Alumnos]Nivel_Número)
	  //vi_EvStyleToUse:=[xSTR_Niveles]EvStyle_oficial
	  //EVS_ReadStyleData (vi_EvStyleToUse)
	  //: (Self->=2)
	  //READ ONLY([xSTR_Niveles])
	  //QUERY([xSTR_Niveles];[xSTR_Niveles]NoNivel=[Alumnos]Nivel_Número)
	  //$evStyleID:=[xSTR_Niveles]EvStyle_interno
	  //EVS_ReadStyleData (vi_EvStyleToUse)
	  //: (Self->=3)
	  //vi_EvStyleToUse:=0
	  //$evStyleID:=0
	  //End case 
End if 