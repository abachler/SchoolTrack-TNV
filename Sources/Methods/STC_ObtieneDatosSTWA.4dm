//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 25-09-18, 14:25:12
  // ----------------------------------------------------
  // Método: STC_ObtieneDatosSTWA
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
	: (OB Get:C1224($o_objeto;"accion")="obtieneayuda")
		  //modulo STWA
		APPEND TO ARRAY:C911($at_items;"Menu")
		APPEND TO ARRAY:C911($at_uuids;"C5DB9B4AD0524CB99A95027B855F4B0E")
		
		APPEND TO ARRAY:C911($at_items;"Asistencia y Atraso")
		APPEND TO ARRAY:C911($at_uuids;"81CB585464C3488784BB7C1E488200AD")
		
		APPEND TO ARRAY:C911($at_items;"Conducta Responsive")
		APPEND TO ARRAY:C911($at_uuids;"3A926C5224DF4003877829776D2A457D")
		
		APPEND TO ARRAY:C911($at_items;"Anotaciones")
		APPEND TO ARRAY:C911($at_uuids;"5571E67A7A764FB7868898750EE61613")
		
		APPEND TO ARRAY:C911($at_items;"Medidas Disciplinarias")
		APPEND TO ARRAY:C911($at_uuids;"3FC3CD2964E94F499B399F66A9BD6AB7")
		
		APPEND TO ARRAY:C911($at_items;"Suspensiones")
		APPEND TO ARRAY:C911($at_uuids;"8F44FDE1E2D744EFA16922E1838C06BF")
		
		APPEND TO ARRAY:C911($at_items;"Licencias")
		APPEND TO ARRAY:C911($at_uuids;"2FFB63A12C30494EA7A87D9662363796")
		
		APPEND TO ARRAY:C911($at_items;"UUID PROPIEDADES DE EVALUACIÓN STWA")
		APPEND TO ARRAY:C911($at_uuids;"306AC74E7BC88B49BB23214515FA7505")
		
		APPEND TO ARRAY:C911($at_items;"Bloqueo de parciales")
		APPEND TO ARRAY:C911($at_uuids;"3F103A3D98B26F4BAD4AD59710AA340C")
		
		APPEND TO ARRAY:C911($at_items;"Nombre de parciales en subasignaturas")
		APPEND TO ARRAY:C911($at_uuids;"A424D1DBF51018448A67A1945085B0AB")
		
		APPEND TO ARRAY:C911($at_items;"Importar configuración desde otra asignatura")
		APPEND TO ARRAY:C911($at_uuids;"8748D84ACF40D44C9638C73212C15E76")
		
		APPEND TO ARRAY:C911($at_items;"Material docente")
		APPEND TO ARRAY:C911($at_uuids;"AAF874B3502BBD43A9CA51F387F915E4")
		
		
		
		OB SET ARRAY:C1227($o_objeto;"items";$at_items)
		OB SET ARRAY:C1227($o_objeto;"uuids";$at_uuids)
		
	Else 
		
		TRACE:C157
		
End case 

$0:=$o_objeto