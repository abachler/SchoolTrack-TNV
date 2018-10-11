//%attributes = {}
  //ACTcc_DeterminaFechasGeneracion

Case of 
		
	: ((dDeudaTodo=1) & (mMesComenzado=1))
		
		aMeses:=1
		aMeses2:=12
		
	: ((dDeudaTodo=1) & (mMesVencido=1))
		
		aMeses:=2
		aMeses2:=13
		
	: ((dDeudaMes=1) & (mMesComenzado=1))
		
		aMeses:=Month of:C24(Current date:C33(*))
		aMeses2:=aMeses
		
	: ((dDeudaMes=1) & (mMesVencido=1))
		
		aMeses:=Month of:C24(Current date:C33(*))+1
		aMeses2:=aMeses
		
End case 