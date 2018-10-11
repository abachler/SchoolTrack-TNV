//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 25-09-18, 14:25:12
  // ----------------------------------------------------
  // Método: STC_ObtieneDatosXS
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_OBJECT:C1216($o_objeto;$1;$0)
ARRAY TEXT:C222($at_items;0)
ARRAY TEXT:C222($at_uuids;0)

$o_objeto:=$1

Case of 
	: (OB Get:C1224($o_objeto;"accion")="obtienemenu")
		APPEND TO ARRAY:C911($at_items;__ ("Opciones Generales"))
		APPEND TO ARRAY:C911($at_uuids;"AB7E9F56BB2A814CBF6660F777EBA09C")
		
		APPEND TO ARRAY:C911($at_items;__ ("Opciones de Publicación"))
		APPEND TO ARRAY:C911($at_uuids;"2A9DDD0CA6BD5347960332A2313C02C5")
		
		APPEND TO ARRAY:C911($at_items;__ ("Plantillas de Publicación"))
		APPEND TO ARRAY:C911($at_uuids;"C5CA860182A55F41A7B721A48D4DDCD6")
		
		APPEND TO ARRAY:C911($at_items;__ ("Usuarios y Contraseñas"))
		APPEND TO ARRAY:C911($at_uuids;"0EE82915F1B04244985EDCAE60B72941")
		
		APPEND TO ARRAY:C911($at_items;__ ("Opciones de Envío"))
		APPEND TO ARRAY:C911($at_uuids;"A70B8AE96E87B64B94344A6818E1F4D7")
		
		APPEND TO ARRAY:C911($at_items;__ ("Consulta de Usuarios"))
		APPEND TO ARRAY:C911($at_uuids;"325B7748129B094CB5E5C1421A67C0F8")
		
		APPEND TO ARRAY:C911($at_items;__ ("Registro de Actividades"))
		APPEND TO ARRAY:C911($at_uuids;"80D1DDDF9635F64FAD9109C94F9D1104")
		
		APPEND TO ARRAY:C911($at_items;__ ("Actualización de Datos"))
		APPEND TO ARRAY:C911($at_uuids;"053ACE33076F7E48873F39BF333F9B0E")
		
		OB SET ARRAY:C1227($o_objeto;"items";$at_items)
		OB SET ARRAY:C1227($o_objeto;"uuids";$at_uuids)
		
	Else 
		
		TRACE:C157
		
End case 

$0:=$o_objeto