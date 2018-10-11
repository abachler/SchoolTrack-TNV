If (aYearsACT#1)
	alProEvt:=1
End if 
Case of 
	: (alProEvt=1)
		AL_UpdateArrays (xALP_DesglosePago;0)
		$line:=AL_GetLine (xALP_Pagos)
		ACTpp_CargaDetallePago (aYearsACT{aYearsACT};1;aACT_ApdosPIDPagos{$line};"pagos";[Personas:7]No:1)
		AL_UpdateArrays (xALP_DesglosePago;-2)
	: (alProEvt=2)
		$line:=AL_GetLine (xALP_Pagos)
		$xALP_DesglosePago:=xALP_DesglosePago
		AL_UpdateArrays ($xALP_DesglosePago;0)
		
		  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
		$xALP_DesglosePago:=xALP_DesglosePago
		$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
		$yBWR_currentTable:=yBWR_currentTable
		$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
		$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
		
		  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
		ACTpp_CargaDetallePago (aYearsACT{aYearsACT};2;aACT_ApdosPIDPagos{$line};"pagos";$line)
		
		  //reestablecemos el metodo de navegación previo
		vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
		yBWR_currentTable:=$yBWR_currentTable
		vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
		vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
		xALP_DesglosePago:=$xALP_DesglosePago
		BWR_SetInputFormButtons 
		
		$line:=AL_GetLine (xALP_Pagos)
		AL_UpdateArrays ($xALP_DesglosePago;0)
		ACTpp_CargaDetallePago (aYearsACT{aYearsACT};1;aACT_ApdosPIDPagos{$line};"pagos";[Personas:7]No:1)
		AL_UpdateArrays ($xALP_DesglosePago;-2)
		xALP_DesglosePago:=$xALP_DesglosePago
End case 