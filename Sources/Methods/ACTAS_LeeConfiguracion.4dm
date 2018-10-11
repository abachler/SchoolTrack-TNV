//%attributes = {}
  // Método: ACTAS_LeeConfiguracion
  //
  //
  // por Alberto Bachler Klein
  // creación 14/07/17, 12:47:59
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_actaEspecificaAlCurso;$b_tablaEnEscritura)
C_LONGINT:C283($l_año;$l_nivel;$l_recNum)
C_POINTER:C301($y_blob;$y_tabla)
C_TEXT:C284($t_curso)
C_OBJECT:C1216($ob_ObjetoActa)


If (False:C215)
	C_LONGINT:C283(ACTAS_LeeConfiguracion ;$1)
	C_TEXT:C284(ACTAS_LeeConfiguracion ;$2)
	C_LONGINT:C283(ACTAS_LeeConfiguracion ;$3)
End if 


$l_nivel:=$1
$t_curso:=""
$l_año:=<>gYear
Case of 
	: (Count parameters:C259=3)
		$t_curso:=$2
		$l_año:=$3
	: (Count parameters:C259=2)
		$t_curso:=$2
End case 


If ($t_curso#"")
	$b_actaEspecificaAlCurso:=KRL_GetBooleanFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]ActaEspecificaAlCurso:35)
	If (Not:C34($b_actaEspecificaAlCurso))
		$t_curso:=""
	End if 
End if 

If ($l_año=0)
	$l_año:=<>gYear
End if 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos_Calificaciones:208])


  // determino cual es el blob en el que está almacenado el objeto Actas y lo cargo
Case of 
	: ((($t_curso="") | ($b_actaEspecificaAlCurso=False:C215)) & ($l_año=<>gYear))
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel)
		$y_blob:=->[xxSTR_Niveles:6]Actas_y_Certificados:43
		$l_recNum:=Record number:C243([xxSTR_Niveles:6])
		OB_BlobToObject ($y_blob;->$ob_ObjetoActa)
		
	: (($t_curso="") & ($l_año<<>gYear))
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3;=;$l_nivel;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & [xxSTR_HistoricoNiveles:191]Año:2;=;$l_año)
		$y_blob:=->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
		OB_BlobToObject ($y_blob;->$ob_ObjetoActa)
		$l_recNum:=Record number:C243([xxSTR_HistoricoNiveles:191])
		
	: (($t_curso#"") & ($l_año=<>gYear) & ($b_actaEspecificaAlCurso))
		KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->$t_curso)
		$y_blob:=->[Cursos:3]Acta:34
		$l_recNum:=Record number:C243([Cursos:3])
		OB_BlobToObject ($y_blob;->$ob_ObjetoActa)
		
	: (($t_curso#"") & ($l_año<<>gYear) & ($b_actaEspecificaAlCurso))
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=$t_curso;*)
		QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=$l_año)
		$y_blob:=->[Cursos_SintesisAnual:63]Actas_y_Certificados:11
		$l_recNum:=Record number:C243([Cursos_SintesisAnual:63])
		OB_BlobToObject ($y_blob;->$ob_ObjetoActa)
		
End case 

$y_tabla:=Table:C252(Table:C252($y_Blob))
$b_tablaEnEscritura:=Not:C34(Read only state:C362($y_Tabla->))

If (Not:C34(OB Is defined:C1231($ob_ObjetoActa)) | (OB Is empty:C1297($ob_ObjetoActa)))
	ACTAS_ConfiguracionPorDefecto ($l_nivel)
	ACTAS_GuardaObjeto ($y_blob;$l_recNum)
End if 
ACTAS_LeeObjeto ($y_blob;$l_recNum)
ACTAS_ActualizaListaAsignaturas ($l_nivel;$t_curso;$l_año)
ACTAS_Ajustes_y_Orden ($l_nivel;$l_año)
ACTAS_GuardaObjeto ($y_blob;$l_recNum)

KRL_GotoRecord ($y_tabla;$l_recNum;$b_tablaEnEscritura)







