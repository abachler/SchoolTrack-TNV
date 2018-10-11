//%attributes = {}
  // DIAG_VerifActasYCertificados()
  // Por: Alberto Bachler K.: 27-02-14, 08:57:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($el;$i;$j;$l_IdProgreso;$l_mostrarNombresApellidos;$l_recNumNivel)
C_TEXT:C284($t_textoError)

ARRAY LONGINT:C221($al_recNumCursos;0)
ARRAY LONGINT:C221($al_recNumNiveles;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_firmantesAsignatura;0)
ARRAY TEXT:C222($at_firmantesAutorizacion;0)
ARRAY TEXT:C222($at_firmantesCodigoAsignatura;0)
ARRAY TEXT:C222($at_firmantesNombres;0)
ARRAY TEXT:C222($at_firmantesRut;0)
ARRAY TEXT:C222($at_firmantesUUID;0)


MESSAGES ON:C181
READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Alumnos_Calificaciones:208])

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5>=<>al_NumeroNivelesActivos{1};*)
QUERY:C277([xxSTR_Niveles:6]; & ;[xxSTR_Niveles:6]NoNivel:5<=<>al_NumeroNivelesActivos{Size of array:C274(<>al_NumeroNivelesActivos)})
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_recNumNiveles;"")
For ($i;1;Size of array:C274($al_recNumNiveles))
	If ([xxSTR_Niveles:6]Abreviatura_Oficial:35="")
		If (Find in array:C230(aDiagnosticErrors;9)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=9
		End if 
		$t_textoError:=[xxSTR_Niveles:6]Nivel:1+" [9]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$t_textoError)
	End if 
End for 


QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7>=1;*)
QUERY:C277([Cursos:3]; & [Cursos:3]Nivel_Numero:7<=12;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNumCursos)
$l_IdProgreso:=IT_Progress (1;0;0;__ ("Verificando Actas y profesores firmantes..."))
For ($i_cursos;1;Size of array:C274($al_recNumCursos))
	$l_IdProgreso:=IT_Progress (0;$l_IdProgreso;$i_cursos/Size of array:C274($al_recNumCursos);__ ("Verificando Actas y profesores firmantes...")+"\r"+[Cursos:3]Curso:1)
	GOTO RECORD:C242([Cursos:3];$al_recNumCursos{$i_cursos})
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	EV2_Calificaciones_SeleccionAL 
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_asignaturas)
	
	ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
	
	$t_textoError:=""
	For ($j;1;Size of array:C274($at_asignaturas))
		$el:=Find in array:C230(atActas_Subsectores;$at_asignaturas{$j})
		If ($el<0)
			If (Find in array:C230(aDiagnosticErrors;22)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=22
			End if 
			$t_textoError:=[Cursos:3]Curso:1+", Columna para "+$at_asignaturas{$j}+" no definida en modelo de acta [22]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$t_textoError)
		End if 
	End for 
	
	CU_Firmas_LeeFirmantes (->$at_firmantesAsignatura;->$at_firmantesCodigoAsignatura;->$at_firmantesUUID;->$at_firmantesNombres;->$at_firmantesRut;->$at_firmantesAutorizacion;->$l_mostrarNombresApellidos)
	For ($i_firmas;1;Size of array:C274($at_firmantesAsignatura))
		If (($at_firmantesNombres{$i_firmas}="") & ($at_firmantesAsignatura{$i_firmas}#""))
			If (Find in array:C230(aDiagnosticErrors;12)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=12
			End if 
			$t_textoError:=[Cursos:3]Curso:1+", "+$at_firmantesAsignatura{$i_firmas}+" [12]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$t_textoError)
		End if 
	End for 
	
	If ([Cursos:3]Letra_Oficial_del_Curso:18="")
		If (Find in array:C230(aDiagnosticErrors;5)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=5
		End if 
		$t_textoError:=[Cursos:3]Curso:1+" [5]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$t_textoError)
	End if 
	
End for 
$l_IdProgreso:=IT_Progress (-1;$l_IdProgreso)