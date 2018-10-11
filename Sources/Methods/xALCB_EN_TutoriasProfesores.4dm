//%attributes = {}
  //xALCB_EN_TutoriasProfesores

If (False:C215)
	<>ST_v461:=False:C215  //15/8/98 at 16:53:36 by: Alberto Bachler
	  //implementación de bimestres
	  //20110426 RCH Se cambia tabla de alumnos a sintesis_anual
End if 
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
C_TEXT:C284($key)
AL_GetCurrCell (xALP_Tutoria3;vCol;vRow)
If (Records in selection:C76([Alumnos:2])=1)
	$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
	If (ok=0)
		AL_ExitCell (xALP_Tutoria3)
		BEEP:C151
	End if 
Else 
	AL_ExitCell (xALP_Tutoria3)
	BEEP:C151
End if 