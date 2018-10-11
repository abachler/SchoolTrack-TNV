//%attributes = {}
  //ACTcc_AsignaCodInterno

C_LONGINT:C283($1;$vl_idAlumno;$index;$vl_existe)
C_TEXT:C284($vt_codInterno)
C_BOOLEAN:C305($0;$ok)

If (Count parameters:C259=1)
	$vl_idAlumno:=$1
	If ($vl_idAlumno>0)
		$index:=Find in field:C653([Alumnos:2]numero:1;$vl_idAlumno)
		If ($index#-1)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$vl_idAlumno)
			If ([Alumnos:2]Codigo_interno:6#"")
				REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
				$index:=Find in field:C653([ACT_CuentasCorrientes:175]ID_Alumno:3;$vl_idAlumno)
				If ($index#-1)
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$vl_idAlumno;True:C214)
					If (ok=1)
						$vt_codInterno:=ACTcc_DVCodigoCta ([Alumnos:2]Codigo_interno:6)
						$vl_existe:=Find in field:C653([ACT_CuentasCorrientes:175]Codigo:19;$vt_codInterno)
						If ($vl_existe=-1)  //si el cod no existe se asigna. Habia casos en que podía quedar duplicado.
							[ACT_CuentasCorrientes:175]Codigo:19:=$vt_codInterno
						End if 
						SAVE RECORD:C53([ACT_CuentasCorrientes:175])
						$ok:=True:C214
					End if 
					KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				Else 
					$ok:=True:C214
				End if 
			Else 
				$ok:=True:C214
			End if 
		Else 
			$ok:=True:C214
		End if 
	Else 
		$ok:=True:C214
	End if 
	$0:=$ok
	
Else 
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
	If (([ACT_CuentasCorrientes:175]Codigo:19="") & ([Alumnos:2]Codigo_interno:6#""))
		$ok:=ACTcc_AsignaCodInterno ([Alumnos:2]numero:1)
		If (Not:C34($ok))
			BM_CreateRequest ("AsignaCodInternoCtaCte";String:C10([Alumnos:2]numero:1);String:C10([Alumnos:2]numero:1))
		End if 
	End if 
End if 