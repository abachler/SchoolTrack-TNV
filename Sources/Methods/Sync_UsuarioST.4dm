//%attributes = {}
  //Sync_UsuarioST 
  //El objetivo es tomar el uuid que viene desde Condor y buscar al profesor para encontrar su usuario en ST([xShell_Users])
  //Inicialmente se busca en la tabla profesores pero si no encontramos un profesor buscamos una persona,
  //si encontramos una persona buscamos un profesor con el RUT de la persona.
  //si encontramos al profesor y no un registro en [xShell_Users] este será creado y dejado en selección en read write

C_TEXT:C284($1;$uuid_registro;$rut)
C_LONGINT:C283($0;$idprof)

$uuid_registro:=$1

READ ONLY:C145([Profesores:4])
READ ONLY:C145([Personas:7])

$idprof:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$uuid_registro;->[Profesores:4]Numero:1)
If ($idprof>0)
	$l_recnum2:=KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]NoEmployee:7;->$idprof;True:C214)
Else 
	$rut:=KRL_GetTextFieldData (->[Personas:7]Auto_UUID:36;->$uuid_registro;->[Personas:7]RUT:6)
	If ($rut#"")
		$idprof:=KRL_GetNumericFieldData (->[Profesores:4]RUT:27;->$rut;->[Profesores:4]Numero:1)
		If ($idprof>0)
			$l_recnum2:=KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]NoEmployee:7;->$idprof;True:C214)
		Else 
			$l_recNum2:=No current record:K29:2
			UNLOAD RECORD:C212([xShell_Users:47])
		End if 
	Else 
		$l_recNum2:=No current record:K29:2
		UNLOAD RECORD:C212([xShell_Users:47])
	End if 
End if 

  //actualmente no se va a generar el registro del usuario 
  //If (($l_recNum2=No current record) & ($idprof>0))
  //$nComun:=KRL_GetTextFieldData (->[Profesores]Numero;->$idprof;->[Profesores]Nombre_comun)
  //READ WRITE([xShell_Users])
  //CREATE RECORD([xShell_Users])
  //[xShell_Users]Name:=$nComun
  //[xShell_Users]login:=ST_ReplaceAccentedChars (ST_Lowercase ($nComun[[1]]+ST_GetWord ($nComun;2)))
  //[xShell_Users]No:=SQ_SeqNumber (->[xShell_Users]No)
  //[xShell_Users]NoEmployee:=$idprof
  //[xShell_Users]PasswordVersion:=3
  //SAVE RECORD([xShell_Users])
  //KRL_UnloadReadOnly (->[xShell_Users])
  //$l_recnum2:=KRL_FindAndLoadRecordByIndex (->[xShell_Users]NoEmployee;->$idprof;True)
  //End if 

$0:=$l_recnum2