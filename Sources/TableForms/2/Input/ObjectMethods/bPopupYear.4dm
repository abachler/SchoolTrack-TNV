  // Método: Método de Objeto: STR_NuevoHistorico.bPopupYear
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/06/10, 12:49:56
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
ARRAY TEXT:C222($aCursos;0)

  // Código principal
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=[Alumnos_SintesisAnual:210]Año:2;*)
QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]NumeroNivel:3=[Alumnos_SintesisAnual:210]NumeroNivel:6)

SELECTION TO ARRAY:C260([Cursos_SintesisAnual:63]Curso:5;$aCursos;[Cursos_SintesisAnual:63];$aRecNumCursos)

$choice:=Pop up menu:C542(AT_array2text (->$aCursos;";"))

If ((vb_HistoricoEditable) & ($choice>0))
	[Alumnos_SintesisAnual:210]Curso:7:=$aCursos{$choice}
	[Alumnos_Historico:25]Curso:3:=[Alumnos_SintesisAnual:210]Curso:7
	SAVE RECORD:C53([Alumnos_SintesisAnual:210])
	SAVE RECORD:C53([Alumnos_Historico:25])
End if 

