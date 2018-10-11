Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(vtACTcr_emisor;vtACTcr_emisorDV;vtACTcr_receptor;vtACTcr_receptorDV;vtACTcr_tipoDTE;vtACTcr_folioDoc;vtACTcr_montoDoc;vtACTcr_recinto;vtACTcr_nombreAprob;vtACTcr_fechaEmision)
		C_DATE:C307(vdACTcr_fechaEmision)
		
		vtACTcr_emisor:=""
		vtACTcr_emisorDV:=""
		vtACTcr_receptor:=Substring:C12(<>vsACT_RUT;1;Length:C16(<>vsACT_RUT)-1)
		vtACTcr_receptorDV:=ST_Uppercase (Substring:C12(<>vsACT_RUT;Length:C16(<>vsACT_RUT)))
		vtACTcr_tipoDTE:=""
		vtACTcr_folioDoc:=""
		vtACTcr_montoDoc:=""
		vtACTcr_recinto:=""
		vtACTcr_nombreAprob:=""
		vdACTcr_fechaEmision:=Current date:C33(*)
		vtACTcr_fechaEmision:=String:C10(Year of:C25(vdACTcr_fechaEmision);"0000")+"-"+String:C10(Month of:C24(vdACTcr_fechaEmision);"00")+"-"+String:C10(Day of:C23(vdACTcr_fechaEmision);"00")
		
End case 