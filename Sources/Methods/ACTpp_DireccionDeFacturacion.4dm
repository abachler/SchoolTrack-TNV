//%attributes = {}
  //ACTpp_DireccionDeFacturacion
C_TEXT:C284($t_accion;$1)
C_OBJECT:C1216($ob_direccion;$ob_direccion2)
C_OBJECT:C1216($ob_retorno)

$t_accion:=$1

Case of 
	: ($t_accion="GuardaDesdeInput")
		
		  //20171229 RCH
		C_POINTER:C301($y_persona;$y_profesional;$y_otra;$y_ec)
		C_LONGINT:C283($l_valor)
		$y_persona:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_personal")
		$y_profesional:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_profesional")
		$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")
		$y_ec:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_ec")
		Case of 
			: ($y_otra->=1)
				$l_valor:=$l_valor ?+ 4
			: ($y_ec->=1)
				$l_valor:=$l_valor ?+ 3
			: ($y_profesional->=1)
				$l_valor:=$l_valor ?+ 2
			Else 
				$l_valor:=$l_valor ?+ 1
		End case 
		OB SET:C1220([Personas:7]OB_ACT_Direccion_Facturacion:117;"tipo_direccion_facturacion";$l_valor)
		
	: ($t_accion="ObtieneObjetoDireccionFacturacion")
		
		ARRAY LONGINT:C221($al_punterosP;0)
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Direccion:14))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Numero_exterior:115))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Numero_interior:116))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Codigo_postal:15))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Comuna:16))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Ciudad:17))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Region_o_Estado:18))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]eMail:34))
		APPEND TO ARRAY:C911($al_punterosP;Field:C253(->[Personas:7]Telefono_domicilio:19))
		
		ARRAY LONGINT:C221($al_punterosT;0)
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Direccion:5))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Numero_exterior:80))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Numero_interior:81))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Codigo_Postal:15))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Comuna:6))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Ciudad:7))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Region_estado:83))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]EMail:13))
		APPEND TO ARRAY:C911($al_punterosT;Field:C253(->[ACT_Terceros:138]Telefono:11))
		
		  //Los textos varian dependiendo del país
		Case of 
			: (<>gCountryCode="mx")
				ARRAY TEXT:C222($atACT_Datos;0)
				APPEND TO ARRAY:C911($atACT_Datos;"Calle")
				APPEND TO ARRAY:C911($atACT_Datos;"Número exterior")
				APPEND TO ARRAY:C911($atACT_Datos;"Número interior")
				APPEND TO ARRAY:C911($atACT_Datos;"Código Postal")
				APPEND TO ARRAY:C911($atACT_Datos;"Colonia")
				APPEND TO ARRAY:C911($atACT_Datos;"Delegación o municipio")
				APPEND TO ARRAY:C911($atACT_Datos;"Estado")
				APPEND TO ARRAY:C911($atACT_Datos;"Correo electrónico")
				APPEND TO ARRAY:C911($atACT_Datos;"Teléfono")
				
			Else 
				ARRAY TEXT:C222($atACT_Datos;0)
				APPEND TO ARRAY:C911($atACT_Datos;"Calle")
				APPEND TO ARRAY:C911($atACT_Datos;"Número")
				APPEND TO ARRAY:C911($atACT_Datos;"Número interior")
				APPEND TO ARRAY:C911($atACT_Datos;"Código Postal")
				APPEND TO ARRAY:C911($atACT_Datos;"Comuna")
				APPEND TO ARRAY:C911($atACT_Datos;"Ciudad")
				APPEND TO ARRAY:C911($atACT_Datos;"Región")
				APPEND TO ARRAY:C911($atACT_Datos;"Correo electrónico")
				APPEND TO ARRAY:C911($atACT_Datos;"Teléfono")
				
		End case 
		
		OB SET ARRAY:C1227($ob_direccion2;"nombres";$atACT_Datos)
		OB SET ARRAY:C1227($ob_direccion2;"apoderados";$al_punterosP)
		OB SET ARRAY:C1227($ob_direccion2;"terceros";$al_punterosT)
		
		OB SET:C1220($ob_retorno;"campos_direccion_facturacion";$ob_direccion2)
		
		If (False:C215)
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ob_retorno;*))
			TRACE:C157
		End if 
		
	: ($t_accion="IngresoDireccionFacturacionDesdeApoderados")
		WDW_OpenFormWindow (->[Personas:7];"ACT_DireccionFacturacion";-1;4;__ ("Dirección de Facturación"))
		DIALOG:C40([Personas:7];"ACT_DireccionFacturacion")
		CLOSE WINDOW:C154
		
	: ($t_accion="IngresoDireccionFacturacionDesdeTerceros")
		WDW_OpenFormWindow (->[ACT_Terceros:138];"ACT_DireccionFacturacion";-1;4;__ ("Dirección de Facturación"))
		DIALOG:C40([ACT_Terceros:138];"ACT_DireccionFacturacion")
		CLOSE WINDOW:C154
		
	: ($t_accion="GuardaEnPersona")
		C_OBJECT:C1216($ob_objetoPersona)
		C_POINTER:C301($y_datos;$y_valores;$y_campos)
		
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"atACTdf_valores")
		$y_campos:=OBJECT Get pointer:C1124(Object named:K67:5;"alACTdf_campos")
		
		OB SET ARRAY:C1227($ob_objetoPersona;"campos";$y_campos->)
		OB SET ARRAY:C1227($ob_objetoPersona;"valores";$y_valores->)
		
		If (False:C215)
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ob_objetoPersona;*))
			SET TEXT TO PASTEBOARD:C523(JSON Stringify array:C1228($ob_objetoPersona;*))
			TRACE:C157
		End if 
		
		OB SET:C1220([Personas:7]OB_ACT_Direccion_Facturacion:117;"objeto_facturacion";$ob_objetoPersona)
		ACCEPT:C269
		
		
	: ($t_accion="GuardaEnTercero")
		C_OBJECT:C1216($ob_objetoTercero)
		C_POINTER:C301($y_datos;$y_valores;$y_campos)
		
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"atACTdf_valores")
		$y_campos:=OBJECT Get pointer:C1124(Object named:K67:5;"alACTdf_campos")
		
		OB SET ARRAY:C1227($ob_objetoTercero;"campos";$y_campos->)
		OB SET ARRAY:C1227($ob_objetoTercero;"valores";$y_valores->)
		
		If (False:C215)
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($ob_objetoTercero;*))
			SET TEXT TO PASTEBOARD:C523(JSON Stringify array:C1228($ob_objetoTercero;*))
			TRACE:C157
		End if 
		
		OB SET:C1220([ACT_Terceros:138]OB_Direccion_Facturacion:82;"objeto_facturacion";$ob_objetoTercero)
		ACCEPT:C269
		
	: ($t_accion="GuardaTerceroDesdeInput")
		  //20171229 RCH
		C_POINTER:C301($y_general;$y_otra)
		C_LONGINT:C283($l_valor)
		$y_general:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_general")
		$y_otra:=OBJECT Get pointer:C1124(Object named:K67:5;"rbdf_otra")
		Case of 
			: ($y_otra->=1)
				$l_valor:=$l_valor ?+ 2
			Else 
				$l_valor:=$l_valor ?+ 1
		End case 
		OB SET:C1220([ACT_Terceros:138]OB_Direccion_Facturacion:82;"tipo_direccion_facturacion";$l_valor)
		
End case 

$0:=$ob_retorno
