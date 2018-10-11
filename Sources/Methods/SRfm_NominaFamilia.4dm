//%attributes = {}
  //SRfm_NominaFamilia

QUERY SELECTION:C341([Familia:78];[Familia:78]Inactiva:31;=;False:C215)
ARRAY LONGINT:C221($aRecNumFamilia;0)
LONGINT ARRAY FROM SELECTION:C647([Familia:78];$aRecNumFamilia;"")
ARRAY TEXT:C222(atNombreListado;0)
ARRAY TEXT:C222(atCursoListado;0)
ARRAY TEXT:C222(atFechaListado;0)
ARRAY TEXT:C222(atParentesco;0)
_O_ARRAY STRING:C218(15;atRutListaSeguro;0)
READ ONLY:C145([Alumnos:2])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando datos de familias..."))
For ($i;1;Size of array:C274($aRecNumFamilia))
	If ($aRecNumFamilia{$i}#-1)
		GOTO RECORD:C242([Familia:78];$aRecNumFamilia{$i})
		SRfm_Padres_a_variables ([Familia:78]Numero:1)
		AT_Insert (0;1;->atNombreListado;->atCursoListado;->atRutListaSeguro;->atFechaListado;->atParentesco)
		atNombreListado{Size of array:C274(atNombreListado)}:=vPadre_Apellidos_y_nombres
		atCursoListado{Size of array:C274(atCursoListado)}:=""
		atRutListaSeguro{Size of array:C274(atRutListaSeguro)}:=vPadre_RUT
		atFechaListado{Size of array:C274(atFechaListado)}:=String:C10(vPadre_Fecha_de_nacimiento;7)
		atParentesco{Size of array:C274(atParentesco)}:="1er Sostenedor"
		AT_Insert (0;1;->atNombreListado;->atCursoListado;->atRutListaSeguro;->atFechaListado;->atParentesco)
		atNombreListado{Size of array:C274(atNombreListado)}:=vMadre_Apellidos_y_nombres
		atCursoListado{Size of array:C274(atCursoListado)}:=""
		atRutListaSeguro{Size of array:C274(atRutListaSeguro)}:=vMadre_RUT
		atFechaListado{Size of array:C274(atFechaListado)}:=String:C10(vMadre_Fecha_de_nacimiento;7)
		atParentesco{Size of array:C274(atParentesco)}:="2do Sostenedor"
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24;=;[Familia:78]Numero:1;*)
		QUERY:C277([Alumnos:2];[Alumnos:2]Status:50;=;"Activo")
		ARRAY LONGINT:C221($IdAlumnos;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$IdAlumnos;"")
		For ($x;1;Size of array:C274($IdAlumnos))
			GOTO RECORD:C242([Alumnos:2];$IdAlumnos{$x})
			AT_Insert (0;1;->atNombreListado;->atCursoListado;->atRutListaSeguro;->atFechaListado;->atParentesco)
			atNombreListado{Size of array:C274(atNombreListado)}:=[Alumnos:2]apellidos_y_nombres:40
			atCursoListado{Size of array:C274(atCursoListado)}:=[Alumnos:2]curso:20
			atRutListaSeguro{Size of array:C274(atRutListaSeguro)}:=String:C10(Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1));"##.###.###-")+[Alumnos:2]RUT:5[[Length:C16([Alumnos:2]RUT:5)]]
			atFechaListado{Size of array:C274(atFechaListado)}:=String:C10([Alumnos:2]Fecha_de_nacimiento:7;7)
			atParentesco{Size of array:C274(atParentesco)}:="Alumno"
		End for 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNumFamilia);"")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)