//%attributes = {}
  //SN3_MenuHandler

$menu:=$1

Case of 
	: ($menu=1)
		SN3_OpenConfig_Generales 
		
	: ($menu=2)
		SN3_OpenConfig_OpcPublicacion 
		
	: ($menu=3)
		SN3_OpenConfig_Plantillas 
		
	: ($menu=4)
		SN3_OpenConfig_UsersAndPass 
		
	: ($menu=5)
		SN3_OpenConfig_OpcEnvios 
		
	: ($menu=6)
		SN3_OpenConfig_ConsultaUsuarios 
		
	: ($menu=7)
		SN3_OpenConfig_Logs 
		
	: ($menu=8)
		SN3_OpenConfig_ActuaDatos 
		
		  //: ($menu=9)//mono 149575 
		  //SN3_OpenConfig_GAFE 
		
End case 

