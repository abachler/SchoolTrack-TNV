//%attributes = {}
  //dbu_ReparaConducta
PERIODOS_Init 
EVS_initialize 


MESSAGES OFF:C175

If (Not:C34(<>onServer))
	
End if 

EVS_initialize 
MESSAGES ON:C181
READ ONLY:C145([Alumnos:2])
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Compilando informaciones conductuales… "))
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$idAlumnos)
For ($i;1;Size of array:C274($idAlumnos))
	AL_CuentaEventosConducta ($idAlumnos{$i})
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($idAlumnos);__ ("Compilando informaciones conductuales… "))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

dbu_CuentaHorasDeClase   //ASM 20140527 ticket 130669

UNLOAD RECORD:C212([Alumnos:2])
READ ONLY:C145([Alumnos:2])
MESSAGES OFF:C175