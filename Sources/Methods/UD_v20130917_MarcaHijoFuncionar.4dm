//%attributes = {}
  //UD_v20130917_MarcaHijoFuncionar 

C_LONGINT:C283($i;$l_therm)
ARRAY LONGINT:C221($al_NoPersona;0)

$l_therm:=IT_UThermometer (1;0;"Marcando campo [Alumnos]Hijo_funcionario")
READ ONLY:C145([Personas:7])
QUERY:C277([Personas:7];[Personas:7]ID_Profesor:78#0;*)
QUERY:C277([Personas:7]; & ;[Personas:7]Inactivo:46=False:C215)
SELECTION TO ARRAY:C260([Personas:7]No:1;$al_NoPersona)
For ($i;1;Size of array:C274($al_NoPersona))
	AL_MarcaCampoHijoFuncionario ($al_NoPersona{$i})
End for 
IT_UThermometer (-2;$l_therm)

