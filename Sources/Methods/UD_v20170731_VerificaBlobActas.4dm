//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 31-07-17, 12:26:06
  // ----------------------------------------------------
  // Método: UD_v20170731_VerificaBlobActas
  // Descripción
  // MONO 24-10-2017: corrección debido a que en la búsqueda por curso estaba eliminando las configuraciones del nivel
  //
  // Parámetros
  // ----------------------------------------------------

ARRAY LONGINT:C221($al_recnumNiveles;0)
ARRAY LONGINT:C221($al_recnumCursos;0)
C_LONGINT:C283($l_therm;$i)

$l_therm:=IT_UThermometer (1;0;"Verificando blob de Actas y Certificados ")
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
QUERY SELECTION BY FORMULA:C207([xxSTR_Niveles:6];BLOB size:C605([xxSTR_Niveles:6]Actas_y_Certificados:43)=0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_recnumNiveles;"")

For ($i;1;Size of array:C274($al_recnumNiveles))
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_recnumNiveles{$i})
	ACTAS_ConfiguracionPorDefecto ([xxSTR_Niveles:6]NoNivel:5)
	ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
End for 

  //MONO FIX
QUERY:C277([Cursos:3];[Cursos:3]ActaEspecificaAlCurso:35=True:C214)
QUERY SELECTION BY FORMULA:C207([Cursos:3];BLOB size:C605([Cursos:3]Acta:34)=0)
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recnumCursos;"")

For ($i;1;Size of array:C274($al_recnumCursos))
	GOTO RECORD:C242([Cursos:3];$al_recnumCursos{$i})
	ACTAS_ConfiguracionPorDefecto ([Cursos:3]Nivel_Numero:7)
	ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
End for 

IT_UThermometer (-2;$l_therm)