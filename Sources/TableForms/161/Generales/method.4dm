  // Método: Método de Formulario: [SN3_PublicationPrefs]Generales
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:19:36
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		SN3_LoadGeneralSettings 
		If ((Application type:C494#4D Server:K5:6) & (Application type:C494#4D Remote mode:K5:5))
			IT_SetButtonState (False:C215;->SN3_SendFrom_Server;->SN3_SendFrom_Workstation;->bSame2)
			OBJECT SET ENTERABLE:C238(SN3_SendFrom_SelectedWS;False:C215)
			OBJECT SET VISIBLE:C603(*;"textoMono";True:C214)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		SN3_SaveGeneralSettings 
		CANCEL:C270
End case 



