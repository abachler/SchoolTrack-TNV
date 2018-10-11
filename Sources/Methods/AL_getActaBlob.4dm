//%attributes = {}
  //AL_getActaBlob
  //Si no se detecta acta para el curso, entonces se utiliza la del nivel.

C_LONGINT:C283($2;$vl_nivel;$3;$vl_ano)
C_TEXT:C284($1;$vt_curso)
C_BLOB:C604($0)

$vt_curso:=$1
$vl_nivel:=$2
$vl_ano:=$3

READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6=$vt_curso)
If ((BLOB size:C605([Cursos:3]Acta:34)>0) & ([Cursos:3]ActaEspecificaAlCurso:35))
	$0:=[Cursos:3]Acta:34
Else 
	QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=$vl_nivel;*)
	QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$vl_ano)
	$0:=[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
End if 

