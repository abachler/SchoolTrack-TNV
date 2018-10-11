If (False:C215)
	<>ST_v461:=False:C215  //10/8/98 at 18:58:30 by: Alberto Bachler
	  //implementación de bimestres
End if 

$line:=AL_GetLine (xALP_MethodProperties)

If ($line>0)
	If (alXS_Methods_RecNum{$line}#-1)
		READ WRITE:C146([xShell_ExecutableCommands:19])
		GOTO RECORD:C242([xShell_ExecutableCommands:19];alXS_Methods_RecNum{$line})
		DELETE RECORD:C58([xShell_ExecutableCommands:19])
		KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
	End if 
	AL_UpdateArrays (xALP_MethodProperties;0)
	AT_Delete ($line;1;->alXS_MethodsRecID;->alXS_Methods_RecNum;->atXS_Methods_Module;->atXS_Methods_Alias;->atXS_Methods_Name;->alXS_Methods_ID;->abXS_Methods_Executable;->abXS_Methods_AuthRequired;->abXS_Methods_ExecOnClient;->atXS_Methods_Description)
	AL_UpdateArrays (xALP_MethodProperties;-2)
	For ($I;1;Size of array:C274(alXS_Methods_RecNum))
		If (abXS_Methods_AuthRequired{$i})
			AL_SetRowColor (xALP_MethodProperties;$i;"Red")
		Else 
			AL_SetRowColor (xALP_MethodProperties;$i;"Green")
		End if 
	End for 
	vt_NumComandos:="Hay "+String:C10(Size of array:C274(atXS_Methods_Alias))+" comandos definidos."
End if 