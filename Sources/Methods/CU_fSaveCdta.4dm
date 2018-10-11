//%attributes = {}
  //CU_fSaveCdta

C_LONGINT:C283($0)
If (modCdt)
	USE NAMED SELECTION:C332("$Conducta")
	ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;>)
	SORT ARRAY:C229(aIDAlumno;aStdName;aInasist;aPctAsist;aAtrasos;aAntP;aAntN;aAntNeutras;aCastigos;aSusp;>)
	OK:=KRL_Array2Selection (->aInasist;->[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;->aAtrasos;->[Alumnos_SintesisAnual:210]Atrasos_Jornada:40)
	If (OK=1)
		$0:=1
	End if 
	UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
End if 