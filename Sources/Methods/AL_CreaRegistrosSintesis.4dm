//%attributes = {}
  // AL_CreaRegistrosSintesis()
  // Por: Alberto Bachler K.: 14-05-14, 11:34:28
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

  // Alberto Bachler K.: 14-05-14, 11:34:45
  // Cambio la verificación de numero de nivel para evitar que se creen regiostros de sintesis anual de nivel 0
  // hasta ahora se verificaba ($l_numeroNivel>-1000) & ($l_numeroNivel>Nivel_AdmisionDirecta) & ($l_numeroNivel<Nivel_Egresados)
  // lo que permitia la creación de registros de síntesis anual de nivel 0
  // ---------------------------------------------



C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($l_IdAlumno;$l_año;$l_institucion;$l_numeroNivel;$l_recNumSintesis)
C_TEXT:C284($t_llaveRegistro;$t_curso)
If (False:C215)
	C_LONGINT:C283(AL_CreaRegistrosSintesis ;$1)
	C_LONGINT:C283(AL_CreaRegistrosSintesis ;$2)
	C_LONGINT:C283(AL_CreaRegistrosSintesis ;$3)
	C_LONGINT:C283(AL_CreaRegistrosSintesis ;$4)
End if 

$l_IdAlumno:=$1
$l_año:=<>gYear
$l_institucion:=<>gInstitucion

Case of 
	: (Count parameters:C259=4)
		$l_año:=$2
		$l_numeroNivel:=$3
		$l_institucion:=$4
	: (Count parameters:C259=3)
		$l_año:=$2
		$l_numeroNivel:=$3
	: (Count parameters:C259=2)
		$l_año:=$2
End case 

KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno;False:C215)
If ($l_numeroNivel=0)
	$l_numeroNivel:=[Alumnos:2]nivel_numero:29
	$t_curso:=[Alumnos:2]curso:20
End if 

If ($t_curso="")
	$t_curso:=[Alumnos:2]curso:20
End if 

If (($l_numeroNivel#0) & ($l_numeroNivel>Nivel_AdmisionDirecta) & ($l_numeroNivel<Nivel_Egresados) & ($l_IdAlumno#0))
	$t_llaveRegistro:=String:C10(<>gInstitucion)+"."+String:C10($l_año)+"."+String:C10($l_numeroNivel)+"."+String:C10(Abs:C99($l_IdAlumno))
	$l_recNumSintesis:=Find in field:C653([Alumnos_SintesisAnual:210]LlavePrincipal:5;$t_llaveRegistro)
	If ($l_recNumSintesis<0)
		CREATE RECORD:C68([Alumnos_SintesisAnual:210])
		[Alumnos_SintesisAnual:210]ID_Institucion:1:=$l_institucion
		[Alumnos_SintesisAnual:210]Año:2:=$l_año
		[Alumnos_SintesisAnual:210]ID_Alumno:4:=$l_IdAlumno
		[Alumnos_SintesisAnual:210]NumeroNivel:6:=$l_numeroNivel
		[Alumnos_SintesisAnual:210]LlavePrincipal:5:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_SintesisAnual:210]Año:2;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos_SintesisAnual:210]ID_Alumno:4)
		If ($l_año<<>gYear)
			[Alumnos_SintesisAnual:210]ID_Alumno:4:=-Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
		Else 
			[Alumnos_SintesisAnual:210]ID_Alumno:4:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
		End if 
		Case of 
			: (($l_año=<>gYear) & ($l_numeroNivel=[Alumnos:2]nivel_numero:29))
				[Alumnos_SintesisAnual:210]Curso:7:=$t_curso
				[Alumnos_SintesisAnual:210]ID_Curso:90:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$t_curso;->[Cursos:3]Numero_del_curso:6)
			: ($l_año<<>gYear)
				$t_curso:=KRL_GetTextFieldData (->[Alumnos_Historico:25]ID_SintesisAnual:44;->$t_llaveRegistro;->[Alumnos_Historico:25]Curso:3)
				[Alumnos_SintesisAnual:210]Curso:7:=$t_curso
				[Alumnos_SintesisAnual:210]ID_Curso:90:=[Alumnos_Historico:25]ID_Curso:34
		End case 
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
		
		$0:=Record number:C243([Alumnos_SintesisAnual:210])
	Else 
		$0:=$l_recNumSintesis
	End if 
Else 
	$0:=-1
End if 
