//%attributes = {}
  // MÉTODO: ASev2_refrescaPlanilla
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/03/12, 17:10:29
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_refrescaPlanilla()
  // ----------------------------------------------------



  // CODIGO PRINCIPAL
ARRAY INTEGER:C220($al_arregloD2Celdas;2;0)
ARRAY TEXT:C222($at_ArrayNames;0)
$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
$y_arregloColumnaActivaReal:=Get pointer:C304("aReal"+Substring:C12($at_ArrayNames{vCol};2))



AL_UpdateArrays (xALP_ASNotas;-2)
ARRAY INTEGER:C220(aInt2D1;0;0)
NTA_SetSingleCellColor ($y_arregloColumnaActivaReal->{vRow})
If ([Asignaturas:18]Electiva:11 | [Asignaturas:18]Seleccion:17)
	vCol:=4
Else 
	vCol:=3
End if 
If (Find in array:C230($at_ArrayNames;"alSTR_InasistenciasPeriodo")>0)
	vCol:=vCol+1
End if 
NTA_SetSingleCellColor (aRealNtaP1{vRow})
vCol:=vCol+1
If (viSTR_Periodos_NumeroPeriodos>=2)
	NTA_SetSingleCellColor (aRealNtaP2{vRow})
	vCol:=vCol+1
End if 
If (viSTR_Periodos_NumeroPeriodos>=3)
	NTA_SetSingleCellColor (aRealNtaP3{vRow})
	vCol:=vCol+1
End if 
If (viSTR_Periodos_NumeroPeriodos>=4)
	NTA_SetSingleCellColor (aRealNtaP4{vRow})
	vCol:=vCol+1
End if 
If (viSTR_Periodos_NumeroPeriodos=5)
	NTA_SetSingleCellColor (aRealNtaP5{vRow})
	vCol:=vCol+1
End if 

If (vi_UsarExamenes=1)
	NTA_SetSingleCellColor (aRealNtaPF{vRow})
	vCol:=vCol+1
	NTA_SetSingleCellColor (aRealNtaEX{vRow})
	vCol:=vCol+1
End if 

If (vi_UsarExamenExtra=1)
	NTA_SetSingleCellColor (aRealNtaEXX{vRow})
	vCol:=vCol+1
End if 

NTA_SetSingleCellColor (aRealNtaF{vRow})


ASev2_AtributosCeldaNotaFinal 


AL_SetCellStyle (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;0;"Tahoma")
If (aNtaReprobada{vRow})
	AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Red";0;"";0)
Else 
	AL_SetCellColor (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;"Black";0;"";0)
End if 

$b_calificacionEditable:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
If (<>vb_BloquearModifSituacionFinal)
	$b_calificacionEditable:=False:C215
End if 

$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
If ($b_calculosSobreCompetencias)
	$b_calificacionEditable:=False:C215
End if 









