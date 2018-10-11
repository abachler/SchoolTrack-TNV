//%attributes = {}
  // SRP_EvaluaNombreArchivo()
  //
  //
  // creado por: Alberto Bachler Klein: 04-04-16, 12:20:35
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_dts;$t_expresionNombreArchivo;$t_scriptNombreArchivo)


If (False:C215)
	C_TEXT:C284(SRP_EvaluaNombreArchivo ;$0)
	C_TEXT:C284(SRP_EvaluaNombreArchivo ;$1)
End if 
C_TEXT:C284(vt_nombreArchivo)

$t_expresionNombreArchivo:=$1
If ($t_expresionNombreArchivo="")
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11=True:C214;*)
	QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]MainTable:3=2)
	If ([xShell_Reports:54]isOneRecordReport:11)
		
		Case of 
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Alumnos:2])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Alumnos]Apellidos_y_Nombres+\".\"+[Alumnos]curso"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Familia:78])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - Familia \"+[Familia]Nombre_de_la_familia"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Cursos:3])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Cursos]Curso"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Profesores:4])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Profesores]Apellidos_y_nombres"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Asignaturas:18])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Asignaturas]Denominación_interna+\".\"+[Asignaturas]Curso"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Actividades:29])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Actividades]Nombre"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Personas:7])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres"
				
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[BBL_Items:61])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[BBL_Items]Primer_título"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[BBL_Lectores:72])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[BBL_Lectores]NombreCompleto"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[BBL_Subscripciones:117])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[BBL_Subscripciones]Titulo"
				
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ADT_Contactos:95])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[ADT_Contactos]Apellidos_y_Nombres"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ADT_Candidatos:49])
				RELATE ONE:C42([ADT_Candidatos:49]Candidato_numero:1)
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Alumnos]Apellidos_y_Nombres"
				
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_CuentasCorrientes:175])
				RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Alumnos]Apellidos_y_Nombres"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Terceros:138])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[ACT_Terceros]Nombre_Completo"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Avisos_de_Cobranza:124])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[ACT_Avisos_de_Cobranza]NombreRelacionado+\".Emitido el \"+string([ACT_Avisos_de_Cobranza]Fecha_Emision)"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Pagares:184])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres+\".Emitido el \"+string([ACT_Pagares]Fecha_Generacion)"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Pagos:172])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres+\".Pagado el \"+string([ACT_Pagos]Fecha)"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Boletas:181])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres+\".Emitido el \"+string([ACT_Boletas]FechaEmision)"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Documentos_en_Cartera:182])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres+\".Vence el \"+string([ACT_Documentos_en_Cartera]Fecha_Doc)"
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[ACT_Documentos_de_Pago:176])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Personas]Apellidos_y_nombres+\".Vence el \"+string([ACT_Documentos_de_Pago]FechaPago)"
		End case 
	Else 
		$t_expresionNombreArchivo:="XSvs_nombreTablaLocal_numero ([xShell_Reports]MainTable)+\" - \"+[xShell_Reports]ReportName"
	End if 
End if 

If ($t_expresionNombreArchivo#"")
	  //$t_expresionNombreArchivo:=Replace string($t_expresionNombreArchivo;"+";"+\". \"+")
	$t_scriptNombreArchivo:="vt_nombreArchivo:="+$t_expresionNombreArchivo
	SR_RunScript ($t_scriptNombreArchivo)
	$t_dts:=Replace string:C233(String:C10(Current date:C33;ISO date:K1:8;Current time:C178);"\\";"-")
	$t_dts:=Replace string:C233(String:C10(Current date:C33;ISO date:K1:8;Current time:C178);":";"-")
	vt_nombreArchivo:=vt_nombreArchivo+" {"+$t_dts+"}"
	$0:=vt_nombreArchivo
	CLEAR VARIABLE:C89(vt_nombreArchivo)
	
End if 



