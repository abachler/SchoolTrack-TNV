//%attributes = {}
  //xALCB_EN_NotasSubasignaturas

C_LONGINT:C283($1;$2)
AL_GetCurrCell (xALP_SubEvals;vCol;vRow)

If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
	$offset:=4
Else 
	$offset:=3
End if 
If ([Asignaturas:18]Seleccion:17)
	$offset:=$offset+1
End if 

$pos:=Size of array:C274(aSubEvalArrPtr)+1
Case of 
	: (vCol=3)
		$value:=aCpySubEvalP1{vRow}
		$arrPtr:=->aCpySubEvalP1
	: ((vCol=4) & ([xxSTR_Subasignaturas:83]ModoControles:5>0))
		$value:=aCpySubEvalControles{vRow}
		$arrPtr:=->aCpySubEvalControles
	Else 
		$value:=aCpySubEvalPtr{vCol-$offset}->{vRow}
		$arrPtr:=aCpySubEvalPtr{vCol-$offset}
End case 

  //If (($value#"") & ((<>viSTR_NoModificarNotas=1) & ((Not(USR_IsGroupMember_by_GrpID (-15001))) | (vb_calificacionesEditables=False))))
  //CD_Dlog (0;__ ("Ud. no esta autorizado para modificar esta nota."))
  //AL_ExitCell (xALP_SubEvals)
  //End if 
  //MONO Ticket 148508 La validación queda igual que en xALCB_EN_Evaluaciones
If ((<>viSTR_NoModificarNotas=1) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
	If (($value#"") & ($value#"P") & ($value#"*"))
		CD_Dlog (0;"Ud. no está autorizado para modificar esta nota.")
		AL_ExitCell (xALP_SubEvals)
	End if 
End if 



If ((aSubEvalStatus{vRow}="X") | (aSubEvalStatus{vRow}="R") | (aSubEvalStatus{vRow}="Ret@"))
	  //AL_GotoCell (xALP_SubEvals;vcol;vRow+1)
	AL_SkipCell (xALP_SubEvals)
End if 

