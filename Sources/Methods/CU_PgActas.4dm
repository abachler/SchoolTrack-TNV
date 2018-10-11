//%attributes = {}
  // CU_PgActas()
  // Por: Alberto Bachler K.: 28-02-14, 17:01:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_nivel;$i_nivelndexCursos;$i_primerNivel;$l_idxNivel;$l_refSublista)

ARRAY LONGINT:C221($al_NivelCurso;0)
ARRAY LONGINT:C221($al_numeroNivel;0)
ARRAY TEXT:C222($at_nombreCurso;0)
ARRAY TEXT:C222($at_nombreNivel;0)

AT_MultiLevelSort (">>";-><>aCUNivNo;-><>aCursos;-><>aCUSection;-><>aCUNivNme)

COPY ARRAY:C226(<>al_NumeroNivelesActivos;$al_numeroNivel)
COPY ARRAY:C226(<>at_NombreNivelesActivos;$at_nombreNivel)
COPY ARRAY:C226(<>aCursos;$at_nombreCurso)
COPY ARRAY:C226(<>aCuNivNo;$al_NivelCurso)
hl_Cursos:=New list:C375
APPEND TO LIST:C376(hl_Cursos;"Seleccione aquí...";-32000)
APPEND TO LIST:C376(hl_Cursos;"-";0)
SORT ARRAY:C229($al_numeroNivel;$at_nombreNivel;>)
For ($i_nivel;1;12)
	$l_idxNivel:=Find in array:C230($al_numeroNivel;$i_nivel)
	If ($l_idxNivel>0)
		$i_primerNivel:=Find in array:C230($al_NivelCurso;$al_numeroNivel{$l_idxNivel})
		If ($i_primerNivel>0)
			$l_refSublista:=New list:C375
			APPEND TO LIST:C376($l_refSublista;$at_nombreNivel{$l_idxNivel};$al_numeroNivel{$l_idxNivel})
			APPEND TO LIST:C376($l_refSublista;"-";0)
			For ($i_nivelndexCursos;$i_primerNivel;Size of array:C274($al_NivelCurso))
				If ($al_NivelCurso{$i_nivelndexCursos}#$al_numeroNivel{$l_idxNivel})
					$i_nivelndexCursos:=Size of array:C274($al_NivelCurso)
				Else 
					APPEND TO LIST:C376($l_refSublista;$at_nombreCurso{$i_nivelndexCursos};0)
				End if 
			End for 
			APPEND TO LIST:C376(hl_Cursos;$at_nombreNivel{$l_idxNivel};$al_numeroNivel{$l_idxNivel};$l_refSublista;False:C215)
		Else 
			APPEND TO LIST:C376(hl_Cursos;$at_nombreNivel{$l_idxNivel};$al_numeroNivel{$l_idxNivel})
		End if 
	End if 
End for 
SELECT LIST ITEMS BY REFERENCE:C630(hl_Cursos;-32000)


  // Modificado por: Alexis Bustamante (11/08/2017)
  //TICKET183744 

ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
ACTAS_ConfiguraFormActa ([Cursos:3]ActaEspecificaAlCurso:35)


  //If (Not([Cursos]ActaEspecificaAlCurso))
  //_o_DISABLE BUTTON(*;"actas@")
  //OBJECT SET ENTERABLE(*;"actas@";False)
  //Else 
  //_o_ENABLE BUTTON(*;"actas@")
  //OBJECT SET ENTERABLE(*;"actas@";True)
  //End if 

READ WRITE:C146([Cursos:3])
LOAD RECORD:C52([Cursos:3])
FORM GOTO PAGE:C247(6)


IT_SetButtonState (USR_checkRights ("M";->[Cursos:3]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Cursos:3]);1;5)