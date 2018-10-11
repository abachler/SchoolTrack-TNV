//%attributes = {}
  //UD_v20130516_NewAliasPerGroup
  // MONO: Hubo un cambio de Alias en el método AL_EliminaInasistencia en el shell,
  // pero no así en los permisos ya asignados sobre este alias y para desasignar el permiso 
  //busca por alias y no por método, así que con este script actualizo el alias en los permisos dados antes del cambio.


C_LONGINT:C283($fia;$i;$l_IdProceso)
$l_IdProceso:=IT_Progress (1;0;0;"Revisando Permisos")
ARRAY LONGINT:C221(aQR_longint1;0)
READ ONLY:C145([xShell_UserGroups:17])
ALL RECORDS:C47([xShell_UserGroups:17])
LONGINT ARRAY FROM SELECTION:C647([xShell_UserGroups:17];aQR_longint1;"")

For ($i;1;Size of array:C274(aQR_longint1))
	GOTO RECORD:C242([xShell_UserGroups:17];aQR_longint1{$i})
	
	ARRAY TEXT:C222(aQR_text1;0)  //alias
	ARRAY TEXT:C222(aQR_text2;0)  //metodo
	
	If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)>0)
		
		BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->aQR_text1;->aQR_text2)
		$fia:=Find in array:C230(aQR_text2;"AL_EliminaInasistencia")
		
		If ($fia>0)
			aQR_text1{$fia}:="Modificar asistencias e inasistencias ya ingresadas"
			READ WRITE:C146([xShell_UserGroups:17])
			GOTO RECORD:C242([xShell_UserGroups:17];aQR_longint1{$i})
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->aQR_text1;->aQR_text2)
			SAVE RECORD:C53([xShell_UserGroups:17])
			KRL_UnloadReadOnly (->[xShell_UserGroups:17])
		End if 
		
	End if 
	$l_IdProceso:=IT_Progress (0;$l_IdProceso;$i/Size of array:C274(aQR_longint1);"Revisando Permisos")
End for 
$l_IdProceso:=IT_Progress (-1;$l_IdProceso)