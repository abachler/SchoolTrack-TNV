//%attributes = {}
  //UD_v20140703_VerificaMatricesAs 

ARRAY LONGINT:C221($al_RecNumAsig;0)
C_BOOLEAN:C305($readOnlyState)
C_LONGINT:C283($el;$ignore;$p)
C_TEXT:C284($area)

QUERY:C277([Asignaturas:18];[Asignaturas:18]EVAPR_IdMatriz:91=0)
SELECTION TO ARRAY:C260([Asignaturas:18];$al_RecNumAsig)

$l_ProgressProcID:=IT_Progress (1;0;0;"Verificando asignación de Matrices...")

For ($l_indice;1;Size of array:C274($al_RecNumAsig))
	GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsig{$l_indice})
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		$el:=Find in array:C230(<>aAsign;[Asignaturas:18]Asignatura:3)
		If ($el>0)
			$area:=<>aAsgAreaMPA{$el}
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Area:13;=;$area;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
		End if 
	End if 
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		$readOnlyState:=Read only state:C362([Asignaturas:18])
		If ($readOnlyState)
			KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		End if 
		[Asignaturas:18]EVAPR_IdMatriz:91:=MPA_CreaMatrizPorDefecto 
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
	Else 
		$readOnlyState:=Read only state:C362([Asignaturas:18])
		If ($readOnlyState)
			KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		End if 
		[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indice/Size of array:C274($al_RecNumAsig))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Asignaturas:18])

