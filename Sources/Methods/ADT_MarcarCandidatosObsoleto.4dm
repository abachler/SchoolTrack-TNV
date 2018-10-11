//%attributes = {}
  //ADT_MarcarCandidatosObsoleto 
  //Mono 17-05-2010 ICIF requiere esto para que no le aparezcan siempre todos los candidatos por que acumulan muchos de admisiones anteriores.
  //Son marcados de esta forma aquí y en dhQF_RefineQuery es filtrada la búsqueda
C_BOOLEAN:C305($seleccionados)
If ((Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49])) & (Size of array:C274(alBWR_recordNumber)>0))
	If (Size of array:C274(abrSelect)>0)
		$seleccionados:=True:C214
		$resp:=CD_Dlog (0;__ ("¿Desea marcar como obsoletos a los candidatos seleccionados o a los listados?");"";__ ("Seleccionados");__ ("Listados");__ ("No Marcar"))
		If ($resp=2)
			$resp:=1
			$seleccionados:=False:C215
		End if 
	Else 
		$resp:=CD_Dlog (0;__ ("¿Desea marcar como obsoletos a los candidatos listados en el explorador?");"";__ ("Si");__ ("No"))
	End if 
	If ($resp=1)
		$vt_log:="Los siguientes candidatos han cambiado su estado a obsoleto: "
		ARRAY TEXT:C222($at_nom;0)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Marcando candidatos obsoletos: "))
		If ($seleccionados)
			For ($d;1;Size of array:C274(abrSelect))
				KRL_GotoRecord (->[ADT_Candidatos:49];alBWR_recordNumber{abrSelect{$d}};True:C214)
				If (Not:C34([ADT_Candidatos:49]Candidato_Obsoleto:67))
					$recnum_alu:=Find in field:C653([Alumnos:2]numero:1;[ADT_Candidatos:49]Candidato_numero:1)
					If ($recnum_alu>=0)
						[ADT_Candidatos:49]Candidato_Obsoleto:67:=True:C214
						SAVE RECORD:C53([ADT_Candidatos:49])
						$alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;->[Alumnos:2]apellidos_y_nombres:40)
						APPEND TO ARRAY:C911($at_nom;$alumno)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$d/Size of array:C274(abrSelect);__ ("Marcando candidatos obsoletos: ")+$alumno)
					End if 
				End if 
			End for 
		Else 
			For ($d;1;Size of array:C274(alBWR_recordNumber))
				KRL_GotoRecord (->[ADT_Candidatos:49];alBWR_recordNumber{$d};True:C214)
				If (Not:C34([ADT_Candidatos:49]Candidato_Obsoleto:67))
					$recnum_alu:=Find in field:C653([Alumnos:2]numero:1;[ADT_Candidatos:49]Candidato_numero:1)
					If ($recnum_alu>=0)
						[ADT_Candidatos:49]Candidato_Obsoleto:67:=True:C214
						SAVE RECORD:C53([ADT_Candidatos:49])
						$alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;->[Alumnos:2]apellidos_y_nombres:40)
						APPEND TO ARRAY:C911($at_nom;$alumno)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$d/Size of array:C274(alBWR_recordNumber);__ ("Marcando candidatos obsoletos: ")+$alumno)
					End if 
				End if 
			End for 
		End if 
		KRL_UnloadReadOnly (->[ADT_Candidatos:49])
		$vt_cand:=AT_array2text (->$at_nom;", ")
		LOG_RegisterEvt ($vt_log+$vt_cand)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
Else 
	CD_Dlog (0;__ ("Para ejecutar debe estar en el panel de candidatos y tener candidatos listados en el explorador."))
End if 