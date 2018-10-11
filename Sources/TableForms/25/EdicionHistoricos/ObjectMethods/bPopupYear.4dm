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

  //20111018 As. cuando en la base de datos no hay sintesis de curso no se podia seleccionar ningun curso
If (Records in selection:C76([Cursos_SintesisAnual:63])=0)
	QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[Alumnos_SintesisAnual:210]NumeroNivel:6)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos;[Cursos:3];$aRecNumCursos)
End if 

$choice:=Pop up menu:C542(AT_array2text (->$aCursos;";"))

If ($choice>0)
	[Alumnos_SintesisAnual:210]Curso:7:=$aCursos{$choice}
	vb_RecordWasModified:=True:C214
End if 


