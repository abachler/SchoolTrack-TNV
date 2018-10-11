  // Método: Método de Formulario: [SN3_PublicationPrefs]ActivacionMasiva
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:14:54
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
		SN3_LoadActivationSettings 
		WDW_SlideDrawer (->[SN3_PublicationPrefs:161];"ActivacionMasiva")
		OBJECT SET TITLE:C194(C_op1;<>vt_IDNacional1_name)
		OBJECT SET TITLE:C194(C_op2;<>vt_IDNacional2_name)
		OBJECT SET TITLE:C194(C_op3;<>vt_IDNacional3_name)
		_O_DISABLE BUTTON:C193(bImport)
		vt_g1:=""
	: (Form event:C388=On Unload:K2:2)
		SN3_SaveActivationSettings 
End case 


