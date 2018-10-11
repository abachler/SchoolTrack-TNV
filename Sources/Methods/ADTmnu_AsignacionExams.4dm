//%attributes = {}
  //ADTmnu_AsignacionExams

ADTmnu_CheckFamSexGroup 
IT_MODIFIERS 
TRACE:C157
READ WRITE:C146([ADT_Candidatos:49])
If ((<>option) & (<>command) & (<>Shift))
	ok:=CD_Dlog (0;Replace string:C233(__ ("Usted ha solicitado reasignar horarios para ˆ0. \rSi realiza esta operación deberá comunicar esta modificación a todas las personas que ya tenían horario asignado.\r\r¿Desea realmente reasignar horarios para ˆ0?");__ ("ˆ0");__ ("EXAMENES"));__ ("");__ ("No");__ ("Sí"))
	If (ok=2)
		ALL RECORDS:C47([ADT_Candidatos:49])
	End if 
Else 
	CD_Dlog (0;__ ("Las fechas de exámen serán asignadas automáticamente a todos los candidatos sin fecha asignada."))
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Exam:29=0)
	ok:=2
End if 

If (ok=2)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando fechas para examenes…"))
	FIRST RECORD:C50([ADT_Candidatos:49])
	While (Not:C34(End selection:C36([ADT_Candidatos:49])))
		[ADT_Candidatos:49]ID_Exam:29:=0
		SAVE RECORD:C53([ADT_Candidatos:49])
		PST_AsignExamsDate (False:C215)
		NEXT RECORD:C51([ADT_Candidatos:49])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ADT_Candidatos:49])/Records in selection:C76([ADT_Candidatos:49]);__ ("Asignando fechas para examenes"))
	End while 
End if 
KRL_UnloadReadOnly (->[ADT_Candidatos:49])