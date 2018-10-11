//%attributes = {}
  //WS_ErrorHandler

vtWS_ErrorNum:=""
vtWS_ErrorString:=""

vtWS_ErrorNum:=WEB SERVICE Get info:C780(Web Service error code:K48:5)
Case of 
	: (vtWS_ErrorNum="9910")
		vtWS_ErrorString:=WEB SERVICE Get info:C780(Web Service detailed message:K48:6)+"\r"+WEB SERVICE Get info:C780(Web Service fault actor:K48:8)
		
	: (vtWS_ErrorNum="9911")
		vtWS_ErrorString:=WEB SERVICE Get info:C780(Web Service detailed message:K48:6)
		
	: (vtWS_ErrorNum="9912")
		vtWS_ErrorString:=WEB SERVICE Get info:C780(Web Service detailed message:K48:6)+"\r"+WEB SERVICE Get info:C780(Web Service HTTP status code:K48:7)
		
	: (vtWS_ErrorNum="9913")
		vtWS_ErrorString:=WEB SERVICE Get info:C780(Web Service detailed message:K48:6)
		
	: (vtWS_ErrorNum="9914")
		vtWS_ErrorString:=WEB SERVICE Get info:C780(Web Service detailed message:K48:6)
		
End case 