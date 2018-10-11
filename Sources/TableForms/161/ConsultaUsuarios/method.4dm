  // Método: Método de Formulario: [SN3_PublicationPrefs]ConsultaUsuarios
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:18:13
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
		SN3_InitConsultaUsuarios 
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

