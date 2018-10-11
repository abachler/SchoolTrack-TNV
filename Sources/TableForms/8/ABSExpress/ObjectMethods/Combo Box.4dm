If (Form event:C388=On Clicked:K2:4)
	$sCurso:=<>aCursos{0}
Else 
	IT_Clairvoyance (-><>aCursos{0};-><>aCursos;"")
	$sCurso:=<>aCursos{0}
	CU_LoadArrays   // reestablezco los arreglos de cursos que se desordena en IT_Clairvoyance
	<>aCursos:=Find in array:C230(<>aCursos;$sCurso)
End if 
If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
	If ($sCurso#"")
		<>aCursos{0}:=$sCurso
		$index:=Find in array:C230(<>aCursos;$sCurso)
		$nivelCurso:=<>aCUNivNo{$index}
		$modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelCurso;->[xxSTR_Niveles:6]AttendanceMode:3)
		If ($modoRegistroInasistencia#1)
			CD_Dlog (0;__ ("Este nivel no ha sido configurado para el ingreso diario de inasistencias."))
			$sCurso:=""
			<>aCursos{0}:=""
		End if 
		If ($sCurso#"")
			If ($nivelCurso#vlABS_NivelActual)
				PERIODOS_LoadData ($nivelCurso)
				vlABS_NivelActual:=$nivelCurso
			End if 
		End if 
		OBJECT SET ENTERABLE:C238(dDate;($sCurso#""))
		OBJECT SET ENABLED:C1123(bCalendar1;($sCurso#""))
		$r:=DateIsValid (dDate;0)
		If (Not:C34($r))
			dDate:=!00-00-00!
			GOTO OBJECT:C206(dDate)
		End if 
		If (($sCurso="") | (dDate=!00-00-00!))
			OBJECT SET ENTERABLE:C238(sName;False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(sName;True:C214)
		End if 
	End if 
	If ($sCurso#vtABS_CursoActual)
		  //guardar inasistencias y resetear...
		If ((vtABS_CursoActual#"") & (Size of array:C274(alABS_AlumnosID)>0))
			  //guardar inasistencias
			$d:=CD_Dlog (0;Replace string:C233(__ ("¿Desea guardar las inasistencias ingresadas para ^0?");"^0";vtABS_CursoActual);"";__ ("Si");__ ("No"))
			If ($d=1)
				AL_GuardaInasistenciaDiaria 
			End if 
			ARRAY TEXT:C222(atABS_Alumnos;0)
			ARRAY LONGINT:C221(alABS_AlumnosID;0)
			sName:=""
			OBJECT SET ENABLED:C1123(bDelLines;False:C215)
			OBJECT SET ENABLED:C1123(bOK;False:C215)
		End if 
		vtABS_CursoActual:=$sCurso
	End if 
End if 