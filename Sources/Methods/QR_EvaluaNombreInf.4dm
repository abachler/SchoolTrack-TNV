//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 03-10-18, 13:43:57
  // ----------------------------------------------------
  // Método: QR_EvaluaNombreInf
  // Descripción
  // Parámetros
  // ----------------------------------------------------
C_POINTER:C301($y_table;$1)
C_TEXT:C284($t_expresionNombreArchivo;$0)
$y_table:=$1
Case of 
	: ($y_table=->[Alumnos:2])
		$t_expresionNombreArchivo:=[Alumnos:2]curso:20+" - "+[Alumnos:2]apellidos_y_nombres:40
	: ($y_table=->[Familia:78])
		$t_expresionNombreArchivo:="Familia "+[Familia:78]Nombre_de_la_familia:3
	: ($y_table=->[Cursos:3])
		$t_expresionNombreArchivo:=[Cursos:3]Curso:1
	: ($y_table=->[Profesores:4])
		$t_expresionNombreArchivo:=[Profesores:4]Apellidos_y_nombres:28
	: ($y_table=->[Asignaturas:18])
		$t_expresionNombreArchivo:=[Asignaturas:18]denominacion_interna:16+" - "+[Asignaturas:18]Curso:5
	: ($y_table=->[Actividades:29])
		$t_expresionNombreArchivo:=[Actividades:29]Nombre:2
	: ($y_table=->[Personas:7])
		$t_expresionNombreArchivo:=[Personas:7]Apellidos_y_nombres:30
	: ($y_table=->[BBL_Items:61])
		$t_expresionNombreArchivo:=[BBL_Items:61]Primer_título:4
	: ($y_table=->[BBL_Lectores:72])
		$t_expresionNombreArchivo:=[BBL_Lectores:72]NombreCompleto:3
	: ($y_table=->[BBL_Subscripciones:117])
		$t_expresionNombreArchivo:=[BBL_Subscripciones:117]Titulo:2
	: ($y_table=->[ADT_Contactos:95])
		$t_expresionNombreArchivo:=[ADT_Contactos:95]Apellidos_y_Nombres:5
	: ($y_table=->[ADT_Candidatos:49])
		RELATE ONE:C42([ADT_Candidatos:49]Candidato_numero:1)
		$t_expresionNombreArchivo:=[Alumnos:2]apellidos_y_nombres:40
	: ($y_table=->[ACT_CuentasCorrientes:175])
		RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
		$t_expresionNombreArchivo:=[Alumnos:2]apellidos_y_nombres:40
	: ($y_table=->[ACT_Terceros:138])
		$t_expresionNombreArchivo:=[ACT_Terceros:138]Nombre_Completo:9
	: ($y_table=->[ACT_Avisos_de_Cobranza:124])
		$t_expresionNombreArchivo:=[ACT_Avisos_de_Cobranza:124]NombreRelacionado:27+"_Emitido_"+String:C10([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
	: ($y_table=->[ACT_Pagares:184])
		$t_expresionNombreArchivo:=String:C10([ACT_Pagares:184]ID:12)+"_Emitido_"+String:C10([ACT_Pagares:184]Fecha_Generacion:9)
	: ($y_table=->[ACT_Pagos:172])
		$t_expresionNombreArchivo:=String:C10([ACT_Pagos:172]ID:1)+"_Pagado_"+String:C10([ACT_Pagos:172]Fecha:2)
	: ($y_table=->[ACT_Boletas:181])
		$t_expresionNombreArchivo:=String:C10([ACT_Boletas:181]Numero:11)+"_Emitida_"+String:C10([ACT_Boletas:181]FechaEmision:3)
	: ($y_table=->[ACT_Documentos_en_Cartera:182])
		$t_expresionNombreArchivo:=String:C10([ACT_Documentos_en_Cartera:182]ID:1)+"_Vence_"+String:C10([ACT_Documentos_en_Cartera:182]Fecha_Doc:5)
	: ($y_table=->[ACT_Documentos_de_Pago:176])
		$t_expresionNombreArchivo:=String:C10([ACT_Documentos_de_Pago:176]ID:1)+"_Vence_"+String:C10([ACT_Documentos_de_Pago:176]FechaPago:4)
End case 

$t_expresionNombreArchivo:=ST_CleanFileName ($t_expresionNombreArchivo)
$0:=$t_expresionNombreArchivo
