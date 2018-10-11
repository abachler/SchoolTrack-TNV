//%attributes = {}
  //DIAG_EvaluationStyles

EVS_LoadStyles 

READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
$text:=""
While (Not:C34(End selection:C36([xxSTR_EstilosEvaluacion:44])))
	EVS_ReadStyleData 
	If ((iEValuationMode<1) | (iEValuationMode>4))
		If (Find in array:C230(aDiagnosticErrors;13)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=13
		End if 
		$text:=[xxSTR_EstilosEvaluacion:44]Name:2+" [13]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$text)
	End if 
	
	If ((iEvaluationMode<1) | (iEvaluationMode>4))
		If (Find in array:C230(aDiagnosticErrors;14)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=14
		End if 
		$text:=[xxSTR_EstilosEvaluacion:44]Name:2+" [14]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$text)
	End if 
	
	If ((iPrintMode<1) | (iPrintMode>4))
		If (Find in array:C230(aDiagnosticErrors;15)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=15
		End if 
		$text:=[xxSTR_EstilosEvaluacion:44]Name:2+" [15]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$text)
	End if 
	
	If ((iViewMode<1) | (iViewMode>4))
		If (Find in array:C230(aDiagnosticErrors;16)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=16
		End if 
		$text:=[xxSTR_EstilosEvaluacion:44]Name:2+" [16]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$text)
	End if 
	
	If ((iPrintActa<1) | (iPrintActa>4))
		If (Find in array:C230(aDiagnosticErrors;17)=-1)
			INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
			aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=17
		End if 
		$text:=[xxSTR_EstilosEvaluacion:44]Name:2+" [17]"+"\r"
		IO_SendPacket (vhDIAG_docRef;$text)
	End if 
	
	NEXT RECORD:C51([xxSTR_EstilosEvaluacion:44])
End while 

READ ONLY:C145([Asignaturas:18])
ALL RECORDS:C47([Asignaturas:18])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando estilos de evaluación en asignaturas..."))
$text:=""
While (Not:C34(End selection:C36([Asignaturas:18])))
	If ([Asignaturas:18]Numero_de_alumnos:49>0)
		If ([Asignaturas:18]Numero_de_EstiloEvaluacion:39=0)
			If (Find in array:C230(aDiagnosticErrors;1)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=1
			End if 
			$text:=String:C10([Asignaturas:18]Numero:1)+", "+[Asignaturas:18]Curso:5+", "+[Asignaturas:18]Asignatura:3+", "+"[1]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		Else 
			$l_ItemEncontrado:=Find in array:C230(aEvStyleId;[Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			If ($l_ItemEncontrado<0)
				If (Find in array:C230(aDiagnosticErrors;2)=-1)
					INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
					aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=2
				End if 
				$text:=String:C10([Asignaturas:18]Numero:1)+", "+[Asignaturas:18]Curso:5+", "+[Asignaturas:18]Asignatura:3+", "+"[2]"+"\r"
				IO_SendPacket (vhDIAG_docRef;$text)
			End if 
		End if 
	End if 
	$text:=""
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([Asignaturas:18])/Records in selection:C76([Asignaturas:18]);__ ("Verificando estilos de evaluación en asignaturas..."))
	NEXT RECORD:C51([Asignaturas:18])
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



READ ONLY:C145([xxSTR_Niveles:6])
QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando estilos de evaluación en niveles..."))
While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
	Case of 
		: ([xxSTR_Niveles:6]EvStyle_oficial:23=0)
			If (Find in array:C230(aDiagnosticErrors;3)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=3
			End if 
			$text:=[xxSTR_Niveles:6]Nivel:1+" [3]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		: (Find in array:C230(aEvStyleId;[xxSTR_Niveles:6]EvStyle_oficial:23)=-1)
			If (Find in array:C230(aDiagnosticErrors;4)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=4
			End if 
			$text:=[xxSTR_Niveles:6]Nivel:1+" [4]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
	End case 
	$text:=""
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxSTR_Niveles:6])/Records in selection:C76([xxSTR_Niveles:6]);__ ("Verificando estilos de evaluación en niveles..."))
	NEXT RECORD:C51([xxSTR_Niveles:6])
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)