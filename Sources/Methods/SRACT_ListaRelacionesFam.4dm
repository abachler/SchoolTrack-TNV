//%attributes = {}
  //SRACT_ListaRelacionesFam

ARRAY LONGINT:C221($aRecNumCtas;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aRecNumCtas;"")
ARRAY TEXT:C222(atNombreListado;0)
ARRAY TEXT:C222(atCursoListado;0)
_O_ARRAY STRING:C218(15;atRutListaSeguro;0)
ARRAY TEXT:C222(atFechaListado;0)
ARRAY TEXT:C222(atParentesco;0)


READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Personas:7])

For ($i;1;Size of array:C274($aRecNumCtas))
	If ($aRecNumCtas{$i}#-1)
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNumCtas{$i})
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		AT_Insert (0;1;->atNombreListado;->atCursoListado;->atRutListaSeguro;->atFechaListado;->atParentesco)
		atNombreListado{Size of array:C274(atNombreListado)}:=[Alumnos:2]apellidos_y_nombres:40
		atCursoListado{Size of array:C274(atCursoListado)}:=[Alumnos:2]curso:20
		atRutListaSeguro{Size of array:C274(atRutListaSeguro)}:=[Alumnos:2]RUT:5
		atFechaListado{Size of array:C274(atFechaListado)}:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
		atParentesco{Size of array:C274(atParentesco)}:="Alumno"
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[ACT_CuentasCorrientes:175]ID_Familia:2;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#0)
		ARRAY LONGINT:C221($alRecFamNum;0)
		LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$alRecFamNum;"")
		For ($j;1;Size of array:C274($alRecFamNum))
			GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$alRecFamNum{$j})
			QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
			AT_Insert (0;1;->atNombreListado;->atCursoListado;->atRutListaSeguro;->atFechaListado;->atParentesco)
			atNombreListado{Size of array:C274(atNombreListado)}:=[Personas:7]Apellidos_y_nombres:30
			atCursoListado{Size of array:C274(atCursoListado)}:=""
			atRutListaSeguro{Size of array:C274(atRutListaSeguro)}:=[Personas:7]RUT:6
			atFechaListado{Size of array:C274(atFechaListado)}:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
			atParentesco{Size of array:C274(atParentesco)}:=[Familia_RelacionesFamiliares:77]Parentesco:6
		End for 
	End if 
End for 