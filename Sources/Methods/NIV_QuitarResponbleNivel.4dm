//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 22-05-18, 10:52:29
  // ----------------------------------------------------
  // Método: NIV_QuitarResponbleNivel
  // Descripción: Al inactivar o fallecer un funcionario, lo quitamos como responsable de nivel.
  // Parámetros: 1 id profesor ofuncionario
  // ----------------------------------------------------

READ ONLY:C145([xxSTR_Niveles:6])
C_LONGINT:C283($1;$l_idProfesor;$i;$l_fia)
ARRAY LONGINT:C221($al_rnNivel;0)

ARRAY LONGINT:C221($al_IdFuncionario;0)
ARRAY TEXT:C222($at_funcionarioNombre;0)
ARRAY TEXT:C222($at_cargoFuncionario;0)

$l_idProfesor:=$1

QUERY BY ATTRIBUTE:C1331([xxSTR_Niveles:6];[xxSTR_Niveles:6]OB_responsable:28;"id[]";=;$l_idProfesor)

LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_rnNivel;"")

For ($i;1;Size of array:C274($al_rnNivel))
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_rnNivel{$i})
	OB GET ARRAY:C1229([xxSTR_Niveles:6]OB_responsable:28;"id";$al_IdFuncionario)
	OB GET ARRAY:C1229([xxSTR_Niveles:6]OB_responsable:28;"nombre";$at_funcionarioNombre)
	OB GET ARRAY:C1229([xxSTR_Niveles:6]OB_responsable:28;"cargo";$at_cargoFuncionario)
	$l_fia:=Find in array:C230($al_IdFuncionario;$l_idProfesor)
	
	If ($l_fia>0)
		AT_Delete ($l_fia;1;->$al_IdFuncionario;->$at_funcionarioNombre;->$at_cargoFuncionario)
		OB SET ARRAY:C1227([xxSTR_Niveles:6]OB_responsable:28;"id";$al_IdFuncionario)
		OB SET ARRAY:C1227([xxSTR_Niveles:6]OB_responsable:28;"nombre";$at_funcionarioNombre)
		OB SET ARRAY:C1227([xxSTR_Niveles:6]OB_responsable:28;"cargo";$at_cargoFuncionario)
		SAVE RECORD:C53([xxSTR_Niveles:6])
		
		$t_nombreProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_idProfesor;->[Profesores:4]Apellidos_y_nombres:28)
		$t_log:=__ ("El profesor o funcionario ^0, fue quitado como responsable del nivel ^1, por ser inactivado.";$t_nombreProfesor;[xxSTR_Niveles:6]Nivel:1)
		LOG_RegisterEvt ($t_log)
	End if 
	
	KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
	
End for 