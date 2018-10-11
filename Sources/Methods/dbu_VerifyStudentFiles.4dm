//%attributes = {}
  //dbu_VerifyStudentFiles

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando archivos de alumnos..."))


QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
ARRAY LONGINT:C221($aRecNum;0)

LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNum;"")

For ($i;1;Size of array:C274($aRecNum))
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	AL_CreaRegistros 
	If (Dec:C9($i/20)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);__ ("Verificando archivos de alumnos..."))
	End if 
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)