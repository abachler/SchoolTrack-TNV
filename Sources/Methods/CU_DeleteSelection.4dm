//%attributes = {}
  // CU_DeleteSelection 
  // 20110518 RCH No existia metodo para eliminacion masiva...
C_LONGINT:C283($r;$0;$vl_alumnos)
$0:=0
If (USR_checkRights ("D";->[Cursos:3]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar los registros seleccionados?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		ARRAY LONGINT:C221($alSTR_recNumCursos;0)
		LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$alSTR_recNumCursos;"")
		
		CREATE EMPTY SET:C140([Cursos:3];"setCursos")
		For ($i;1;Size of array:C274($alSTR_recNumCursos))
			GOTO RECORD:C242([Cursos:3];$alSTR_recNumCursos{$i})
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_alumnos)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($vl_alumnos=0)
				ADD TO SET:C119([Cursos:3];"setCursos")
			End if 
		End for 
		
		If (Records in set:C195("setCursos")>0)
			USE SET:C118("setCursos")
			$0:=CU_DeleteRec (True:C214)
			If (Records in set:C195("setCursos")#Size of array:C274($alSTR_recNumCursos))
				CD_Dlog (0;"Algunos registros no pudieron ser eliminados debido a que existen alumnos asociad"+"os.")
			End if 
		Else 
			$0:=0
			CD_Dlog (0;"Ningún registro seleccionado pudo ser eliminado debido a que existen alumnos asoc"+"iados.")
		End if 
		SET_ClearSets ("setCursos")
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 