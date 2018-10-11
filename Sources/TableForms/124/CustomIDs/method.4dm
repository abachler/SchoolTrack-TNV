If ([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=0)
	OBJECT SET VISIBLE:C603(*;"Codigo@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"Codigo@";True:C214)
End if 

  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If (Num:C11(Substring:C12(vRUT;1;Length:C16(vRUT)-1))>0)
			OBJECT SET FORMAT:C236(vRUT;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236(vRUT;"")
		End if 
End case 

