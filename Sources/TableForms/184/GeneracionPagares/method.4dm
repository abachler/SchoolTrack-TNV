  // Método: Método de Formulario: [ACT_Pagares]GeneracionPagares
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 16:51:22
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
		XS_SetInterface 
		
		ACTcfg_OpcionesGeneracionP ("OnLoadVars")
		
		ARRAY TEXT:C222(aMeses;0)
		ARRAY TEXT:C222(aMeses2;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		COPY ARRAY:C226(aMeses;aMeses2)
		
		ACTcfg_OpcionesGeneracionP ("CargaDatosMonedas")
		ACTinit_LoadPrefs 
		If (bAvisoApoderado=1)
			CD_Dlog (0;__ ("A pesar de su configuración de emisión de avisos de cobranza por apoderado, esta emisión se hará por cuenta corriente."))
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		If (cs_genPagareC=1)
			_O_ENABLE BUTTON:C192(cs_imprimirPagareC)
		Else 
			cs_imprimirPagareC:=0
			_O_DISABLE BUTTON:C193(cs_imprimirPagareC)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		
	: (Form event:C388=On Outside Call:K2:11)
		
End case 


