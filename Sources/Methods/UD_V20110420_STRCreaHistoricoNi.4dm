//%attributes = {}
  //UD_V20110420_STRCreaHistoricoNi 

ARRAY LONGINT:C221($al_Nonivel;0)
ARRAY INTEGER:C220($ai_year;0)
C_LONGINT:C283($i;$j)

READ ONLY:C145([xxSTR_HistoricoNiveles:191])
READ ONLY:C145([Alumnos_Historico:25])
READ ONLY:C145([xxSTR_Niveles:6])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando niveles históricos...")
ALL RECORDS:C47([Alumnos_Historico:25])

AT_DistinctsFieldValues (->[Alumnos_Historico:25]Año:2;->$ai_year)
AT_DistinctsFieldValues (->[Alumnos_Historico:25]Nivel:11;->$al_Nonivel)
For ($i;1;Size of array:C274($al_Nonivel))
	
	For ($j;1;Size of array:C274($ai_year))
		
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2=$ai_year{$j};*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]NumeroNivel:3=$al_Nonivel{$i})
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$al_Nonivel{$i})
		
		If (Records in selection:C76([xxSTR_HistoricoNiveles:191])=0)
			CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
			[xxSTR_HistoricoNiveles:191]Año:2:=$ai_year{$j}
			[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
			[xxSTR_HistoricoNiveles:191]NombreDeCiclo:14:=[xxSTR_Niveles:6]Sección:9
			[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12:=[xxSTR_Niveles:6]Abreviatura:19
			[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13:=[xxSTR_Niveles:6]Abreviatura_Oficial:35
			[xxSTR_HistoricoNiveles:191]DirectorResponsable:15:=[xxSTR_Niveles:6]Director:13
			[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_Niveles:6]EvStyle_oficial:23
			[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_Niveles:6]EvStyle_oficial:23
			[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
			[xxSTR_HistoricoNiveles:191]NombreInterno:5:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
			[xxSTR_HistoricoNiveles:191]NombreOficial:6:=[xxSTR_Niveles:6]Nivel:1
			[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=2
			  //20121031 ASM se agrega nuevo campo
			[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=[xxSTR_Niveles:6]AttendanceMode:3
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_Nonivel))
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
KRL_UnloadReadOnly (->[Alumnos_Historico:25])
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
