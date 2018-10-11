//%attributes = {}
  // QR_EvaluaNombreDocumento()
  // 
  //
  // creado por: Alberto Bachler Klein: 06-04-16, 16:49:37
  // -----------------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_dts;$t_expresionNombreArchivo;$t_scriptNombreArchivo)


If (False:C215)
	C_TEXT:C284(QR_EvaluaNombreDocumento ;$0)
	C_TEXT:C284(QR_EvaluaNombreDocumento ;$1)
End if 
C_TEXT:C284(vt_nombreArchivo)
C_BOOLEAN:C305($b_destinoSNT)
C_LONGINT:C283($l_CambioPorRelatedTable)

$t_expresionNombreArchivo:=$1
$t_destinoImpresion:=$2

If (Count parameters:C259=3)
	$b_destinoSNT:=$3
End if 

  //MONO 205131
If (([xShell_Reports:54]MainTable:3#[xShell_Reports:54]RelatedTable:14) & ([xShell_Reports:54]RelatedTable:14>0))
	$l_CambioPorRelatedTable:=[xShell_Reports:54]MainTable:3
	[xShell_Reports:54]MainTable:3:=[xShell_Reports:54]RelatedTable:14
End if 

If ($t_expresionNombreArchivo="")
	If ([xShell_Reports:54]isOneRecordReport:11)
		Case of 
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Alumnos:2])
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Alumnos]Curso+\" - \"+[Alumnos]Apellidos_y_Nombres"
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
			: (Table:C252([xShell_Reports:54]MainTable:3)=->[Alumnos_FichaMedica:13])  //MONO 205131
				RELATE ONE:C42([Alumnos_FichaMedica:13]Alumno_Numero:1)
				$t_expresionNombreArchivo:="[xShell_Reports]ReportName+\" - \"+[Alumnos]Apellidos_y_Nombres"
		End case 
	Else 
		$t_expresionNombreArchivo:="XSvs_nombreTablaLocal_numero ([xShell_Reports]MainTable)+\" - \"+[xShell_Reports]ReportName"
	End if 
End if 

If ($l_CambioPorRelatedTable>0)  //MONO 205131
	[xShell_Reports:54]MainTable:3:=$l_CambioPorRelatedTable
End if 

If ($t_expresionNombreArchivo#"")
	$t_expresionNombreArchivo:=Replace string:C233($t_expresionNombreArchivo;",";".")
	$t_scriptNombreArchivo:="vt_nombreArchivo:="+$t_expresionNombreArchivo
	SR_RunScript ($t_scriptNombreArchivo)
	Case of 
		: (($t_destinoImpresion="PDF") & (Not:C34($b_destinoSNT)))  //MONO ticket 156446
			$dts:=DTS_MakeFromDateTime 
			vt_nombreArchivo:="inf_"+$dts+"."+vt_nombreArchivo
		: ($t_destinoImpresion="preview")  //MONO 208538
			vt_nombreArchivo:=vt_nombreArchivo+"_"+DTS_MakeFromDateTime 
	End case 
	
	$0:=ST_CleanFileName (vt_nombreArchivo+Choose:C955(($t_destinoImpresion#"printer") & ($t_destinoImpresion#"");"."+$t_destinoImpresion;""))
	CLEAR VARIABLE:C89(vt_nombreArchivo)
End if 



