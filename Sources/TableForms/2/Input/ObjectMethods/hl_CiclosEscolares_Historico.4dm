C_TEXT:C284($text)
C_LONGINT:C283(vl_referenciaCiclo_Historico)

GET LIST ITEM:C378(hl_CiclosEscolares_Historico;*;vl_referenciaCiclo_Historico;$text)

If (vl_referenciaCiclo_Historico#0)
	If (vl_referenciaCiclo_Histórico>0)
		$stringRef:=String:C10(vl_referenciaCiclo_Histórico)
		vl_Year_Historico:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo_Histórico);1;4))
		vl_NivelSeleccionado_Historico:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo_Histórico);5;2))
		
	Else 
		$absoluteRef:=Abs:C99(vl_referenciaCiclo_Histórico)
		$stringRef:=String:C10($absoluteRef)
		vl_Year_Historico:=Num:C11(Substring:C12(String:C10($absoluteRef);1;4))
		vl_NivelSeleccionado_Historico:=-Num:C11(Substring:C12($stringRef;5;2))
	End if 
End if 

AL_ExitCell (xALP_HNotasECursos)

$page:=Selected list items:C379(hlTab_STR_alumnosHistorico)
asigHist:=""
vtSTR_AL_Observaciones:=""
vtSTR_AL_LabelObservaciones:=""

If ((vl_NivelSeleccionado_Historico#0) & (vl_Year_Historico>0))
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;vl_NivelSeleccionado_Historico;vl_Year_Historico)
End if 

ALP_RemoveAllArrays (xALP_HNotasECursos)
al_LoadHNotas 

Case of 
	: ($page=1)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_Year_Historico)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10([Alumnos:2]numero:1)
		$recNUm:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;vb_HistoricoEditable)
		AL_SetEnterable (xALP_HNotasECursos;0;0)
		
	: ($page=2)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_Year_Historico)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10([Alumnos:2]numero:1)
		$recNUm:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;vb_HistoricoEditable)
		ALP_RemoveAllArrays (xALP_HNotasECursos)
		AL_HistoricoObservacionesPJ 
		
		
	: ($page=3)
		ALP_RemoveAllArrays (xALP_HNotasECursos)
		
		
		If (Size of array:C274(aNtaRecNum)>0)
			aNtaAsignatura:=1
			GOTO RECORD:C242([Alumnos_Calificaciones:208];aNtaRecNum{1})
			AL_LeeObservacionesHistoricas (aNtaRecNum{1})
		End if 
		
	: ($page=4)
		ALP_RemoveAllArrays (xALP_HNotasECursos)
		al_LoadECursos (xALP_HNotasECursos;2)
		AL_UpdateArrays (xALP_HNotasECursos;-2)
		AL_SetEnterable (xALP_HNotasECursos;0;0)
		
End case 

  //SET COLOR(*;"Historic@";-3078)
If (Not:C34(vb_HistoricoEditable))  //20101110 RCH Cuando estaba el candado abierto y se cambiaban de año, el candado quedaba abierto pero los campos bloqueados
	KRL_ReloadAsReadOnly (->[Alumnos_SintesisAnual:210])
	OBJECT SET TITLE:C194(bModHistoric;"Editar Histórico")
	OBJECT SET VISIBLE:C603(*;"unlocked";False:C215)
	OBJECT SET VISIBLE:C603(*;"locked";True:C214)
	OBJECT SET ENTERABLE:C238(*;"Historic@";False:C215)
	OBJECT SET COLOR:C271(*;"Historic@";-3078)
Else 
	KRL_ReloadInReadWriteMode (->[Alumnos_SintesisAnual:210])
	OBJECT SET TITLE:C194(bModHistoric;"Bloquear Histórico")
	OBJECT SET VISIBLE:C603(*;"unlocked";True:C214)
	OBJECT SET VISIBLE:C603(*;"locked";False:C215)
	OBJECT SET ENTERABLE:C238(*;"Historic@";True:C214)
	OBJECT SET COLOR:C271(*;"Historic@";-6)
End if 

OBJECT SET VISIBLE:C603(*;"nivelhistorico@";False:C215)
OBJECT SET VISIBLE:C603(*;"NewNotasH@";($page=1) | ($page=2))
OBJECT SET VISIBLE:C603(*;"coment@";($page=2) | ($page=3))
OBJECT SET VISIBLE:C603(*;"comentPopUp";$page=3)
OBJECT SET VISIBLE:C603(*;"coment4";$page=3)
OBJECT SET VISIBLE:C603(*;"NotasH@";$page=1)

  //vb_HistoricoEditable:=False
  //If (Not(vb_HistoricoEditable))
  //DISABLE BUTTON(bEditaHistoricos)
  //SET VISIBLE(*;"unlocked";False)
  //SET VISIBLE(*;"locked";True)
  //SET ENTERABLE(*;"Historic@";False)
  //SET COLOR(*;"Historic@";-3078)
  //
  //Else 
  //ENABLE BUTTON(bEditaHistoricos)
  //SET VISIBLE(*;"unlocked";True)
  //SET VISIBLE(*;"locked";False)
  //SET ENTERABLE(*;"Historic@";True)
  //SET COLOR(*;"Historic@";-6)
  //End if 

