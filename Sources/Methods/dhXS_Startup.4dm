//%attributes = {}
  // dhXS_Startup()
  // Por: Alberto Bachler K.: 23-07-14, 09:35:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



C_LONGINT:C283(<>l_BatchProcessID)
READ ONLY:C145(*)
MESSAGES OFF:C175

Compiler_SchoolTrack 
STR_VerificaBloqueoSitFinal 
STR_Inicializaciones 
STR_LeeConfiguracion 
BBL_LeeConfiguracion 
EVS_CargaMatrizEstilosEval 
XML_LoadInvalidCharsArray 

Case of 
	: ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2) | (Application type:C494=4D Server:K5:6))
		WEB_StartWebServer2 
		Sync_LeeRefSincronizacion 
		
	: (Application type:C494=4D Remote mode:K5:5)
		WEB_LoadSettings 
End case 

STWA2_CreaImagenAlumnosEnDisco ("VerificaDirectorio")  //20180917 RCH