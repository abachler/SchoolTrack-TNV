//%attributes = {}
  // MÉTODO: ASev2_AtributosCeldaNotaFinal
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 30/03/12, 11:45:05
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // ASev2_AtributosCeldaNotaFinal()
  // ----------------------------------------------------
C_LONGINT:C283($l_columnaNotaFinal;$l_errorALP)

ARRAY INTEGER:C220($al_arregloD2Celdas;0)
ARRAY TEXT:C222($at_ArrayNames;0)







  // CODIGO PRINCIPAL
$b_calificacionEditable:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_calificacionEditable:=$b_calificacionEditable & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
$b_calificacionEditable:=$b_calificacionEditable | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))

aRealEXRecuperatorio{vRow}:=[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95

$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
$l_columnaNotaFinal:=Find in array:C230($at_ArrayNames;"aNtaF")
  // si calificacion editable y examen recuperatorio permitido y minimo final requerido para recuperatorio es superior al mínimo de la escala y los promedios son calculados
If ((vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia) & (vi_UsarExRecuperatorio=1) & AS_PromediosSonCalculados  & $b_calificacionEditable)
	
	Case of 
			  // examenes normal y extraordinario evaluados
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEXX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaF{vRow}<vr_MinimoExRecuperatorio))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
			
			  // si el examen normal no fue rendido y el examen extraordinario fue evaluado
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{vRow}=-4) & (aRealNtaEXX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaF{vRow}<vr_MinimoExRecuperatorio))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
			
			  // si el examen normal fue evaluado y el examen extraordinario no rendido (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEXX{vRow}=-4) & (aRealNtaF{vRow}<vr_MinimoExRecuperatorio))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
			
			  // si el examen normal fue evaluado y el examen extraordinario no fueron rendidos (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{vRow}=-4) & (aRealNtaEXX{vRow}=-4) & (aRealNtaF{vRow}<vr_MinimoExRecuperatorio))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
			
			  // si el examen normal y el examen extraordinario no fueron rendidos (asterisco)
			  // la celda Nota final es ingresable para recibir el examen recuperatorio
		: ((aRealNtaEX{vRow}=-4) & (aRealNtaEXX{vRow}=-4))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
			
			  // si no hay evaluaciones para el examen final o el examen extraordinario
			  // la celda nota final no es ingresable (no se puede registrar examen recuperatorio
			  // sin haber registrado examen anual y extraordinario
		Else 
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry off)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2)
			
	End case 
	
	  //si se registró examen recuperatorio la celda nota final queda ingresable
	  // su contenido se muestra en negrillas, subrayado y cursivas:
	  // - cursiva indica que hay recuperatorio evaluado
	  // - subrayado solo indica que es posible registrar examen recuperatorio
	  // - subrayado y cursiva indica que es posible modificar el examen recuperatorio rendido
	Case of 
		: (aRealEXRecuperatorio{vRow}>=vrNTA_MinimoEscalaReferencia)
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Underline:K14:4+Bold:K14:2+Italic:K14:3)
		: ((aRealNtaEX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealNtaEXX{vRow}>=vrNTA_MinimoEscalaReferencia) & (aRealEXRecuperatorio{vRow}=-10) & (aRealNtaF{vRow}<vr_MinimoExRecuperatorio))
			AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
			AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
	End case 
	
Else 
	
	If (AS_PromediosSonCalculados )
		AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry off)
	Else 
		AL_SetCellEnter (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;AL Cell entry on)
	End if 
	AL_SetCellStyle (xALP_ASNotas;$l_columnaNotaFinal;vRow;$l_columnaNotaFinal;vRow;$al_arregloD2Celdas;Bold:K14:2)
End if 


