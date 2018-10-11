C_LONGINT:C283(vAñoCierre;vPrevAñoCierre)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vAñoCierre:=Year of:C25(Current date:C33(*))
		vPrevAñoCierre:=vAñoCierre
		ACTcm_LoadYear (vAñoCierre)
End case 
