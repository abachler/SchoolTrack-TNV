//%attributes = {}
  //UD_20110428_ActualizaSintesisCU 

  // Actualiza los campos 
  //[Cursos_SintesisAnual]cl_CodigoEspecialidadTP
  //[Cursos_SintesisAnual]cl_EspecialidadTP
  //[Cursos_SintesisAnual]cl_SectorEconomicoTP


READ WRITE:C146([Cursos_SintesisAnual:63])
ARRAY LONGINT:C221(al_RecNum;0)
C_LONGINT:C283($i;$proc)
ALL RECORDS:C47([Cursos:3])
SELECTION TO ARRAY:C260([Cursos:3];al_RecNum)
$proc:=IT_UThermometer (1;0;"Verificando Sintesis anual de Cursos...")
For ($i;1;Size of array:C274(al_RecNum))
	GOTO RECORD:C242([Cursos:3];al_RecNum{$i})
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=<>gyear;*)
	QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1)
	[Cursos_SintesisAnual:63]cl_CodigoEspecialidadTP:54:=[Cursos:3]cl_CodigoEspecialidadTP:29
	[Cursos_SintesisAnual:63]cl_EspecialidadTP:55:=[Cursos:3]cl_EspecialidadTP:28
	[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56:=[Cursos:3]cl_SectorEconomicoTP:27
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
End for 
IT_UThermometer (-2;$proc)
KRL_ReloadAsReadOnly (->[Cursos_SintesisAnual:63])