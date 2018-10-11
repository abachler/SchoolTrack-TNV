//%attributes = {}
  //STRal_CreaHistorico
  // 20110503 RCH Al crear un agno historico no se creaba el registro de alumnos historico...

C_TEXT:C284($vt_llave;$1;$vt_llaveHistorico)
C_LONGINT:C283($vl_year;$vl_nivel;$vl_numAlumno;$recNum)

$vt_llave:=$1

$vl_year:=Num:C11(ST_GetWord ($vt_llave;2;"."))
$vl_nivel:=Num:C11(ST_GetWord ($vt_llave;3;"."))
$vl_numAlumno:=Num:C11(ST_GetWord ($vt_llave;4;"."))
$vt_llaveHistorico:=String:C10($vl_numAlumno)+"."+String:C10($vl_year)

If ($vl_year>0)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Llave:42;->$vt_llaveHistorico)
	If ($recNum=-1)
		CREATE RECORD:C68([Alumnos_Historico:25])
		[Alumnos_Historico:25]Año:2:=$vl_year
		[Alumnos_Historico:25]Alumno_Numero:1:=Abs:C99($vl_numAlumno)
		[Alumnos_Historico:25]Nivel:11:=$vl_nivel
		SAVE RECORD:C53([Alumnos_Historico:25])
	End if 
End if 