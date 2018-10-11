  // Método: Método de Formulario: [ACT_Pagares]Configuracion
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 15:39:41
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		
		XS_SetInterface 
		
		C_LONGINT:C283(HL_pagares)
		C_LONGINT:C283(vlACTp_Dia;vlACTp_Cuota)
		C_TEXT:C284(vtACTp_Regimen)
		
		C_TEXT:C284(vtACT_Item;vtACT_RegimenDcto;vtACT_ItemCargo)
		C_LONGINT:C283(vlACT_Item;vlACT_ItemCargo)
		C_TEXT:C284(vtACT_RegimenCargo;vtACT_RegimenDcto)
		
		vtACT_Item:=""
		vtACT_RegimenDcto:=""
		vtACT_ItemCargo:=""
		vtACT_RegimenCargo:=""
		vtACT_RegimenDcto:=""
		
		vlACT_Item:=0
		vlACT_ItemCargo:=0
		
		ACTcfg_OpcionesPagares ("OnLoadFormConf")
		$vl_multiLine:=1
		ACTcfg_OpcionesPagares ("ConfiguraALP";->$vl_multiLine)
		FORM GOTO PAGE:C247(2)
		  //HL_pagares:=New list
		  //APPEND TO LIST(HL_pagares;"Configuración";1)
		  //APPEND TO LIST(HL_pagares;"Pagarés";2)
		
		OBJECT SET VISIBLE:C603(*;"vt_agregado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado1";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_agregado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado2";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_agregado3";False:C215)
		OBJECT SET VISIBLE:C603(*;"vt_eliminado3";False:C215)
		
		  //LISTA CARRERA / DESCUENTOS
		C_LONGINT:C283(hl_Pagina1)
		hl_Pagina1:=New list:C375
		APPEND TO LIST:C376(hl_Pagina1;"Carreras";1)
		APPEND TO LIST:C376(hl_Pagina1;"Cargos";2)
		APPEND TO LIST:C376(hl_Pagina1;"Descuentos";3)
		SELECT LIST ITEMS BY POSITION:C381(hl_Pagina1;1)
		ACTcfg_OpcionesPagares ("OcultaAreasCarreras_Dctos")
		
		If (cs_genPagare=0)
			cs_imprimirPagare:=0
			_O_DISABLE BUTTON:C193(cs_imprimirPagare)
		Else 
			_O_ENABLE BUTTON:C192(cs_imprimirPagare)
		End if 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		ACTcfg_OpcionesPagares ("OcultaAreasCarreras_Dctos")
		
		ACTcfg_OpcionesPagares ("SetEstadoTacho")
		ACTcfg_OpcionesPagares ("SetEstadoTachoDctos")
		
		If (cs_genPagare=0)
			cs_imprimirPagare:=0
			_O_DISABLE BUTTON:C193(cs_imprimirPagare)
		Else 
			_O_ENABLE BUTTON:C192(cs_imprimirPagare)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		HL_ClearList (HL_pagares;hl_Pagina1)
End case 

