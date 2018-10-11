  // Método: Método de Formulario: [xxACT_MonedaParidad]CambioDeParidad
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 15-02-10, 18:06:30
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
		C_TEXT:C284(vtBtn1;vtBtn2;vtBtn3;vtMsg)
		C_TEXT:C284(vtDesc1;vtDesc2;vtDesc3)
		If (vtBtn1="")
			vtBtn1:="Opción 1"
		End if 
		If (vtBtn2="")
			vtBtn2:="Opción 2"
		End if 
		If (vtBtn3="")
			vtBtn3:="Opción 3"
		End if 
		If (vtMsg="")
			vtMsg:="Seleccione una opción"
		End if 
		
		OBJECT SET TITLE:C194(ob_opcion1;vtBtn1)
		OBJECT SET TITLE:C194(ob_opcion2;vtBtn2)
		OBJECT SET TITLE:C194(ob_opcion3;vtBtn3)
		WDW_SlideDrawer (->[xxACT_MonedaParidad:147];"CambioDeParidad")
		ob_opcion1:=1
		ob_opcion2:=0
		ob_opcion3:=0
	: (Form event:C388=On Close Box:K2:21)
		POST KEY:C465(27;0)
End case 

