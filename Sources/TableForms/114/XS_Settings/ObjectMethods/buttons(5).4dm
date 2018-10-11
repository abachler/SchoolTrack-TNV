AL_UpdateArrays (xALP_MethodProperties;0)
AT_Insert (1;1;->alXS_MethodsRecID;->alXS_Methods_RecNum;->atXS_Methods_Module;->atXS_Methods_Alias;->atXS_Methods_Name;->alXS_Methods_ID;->abXS_Methods_Executable;->abXS_Methods_AuthRequired;->abXS_Methods_ExecOnClient;->atXS_Methods_Description)
alXS_Methods_RecNum{1}:=-1
AL_UpdateArrays (xALP_MethodProperties;-2)
GOTO OBJECT:C206(xALP_MethodProperties)
AL_GotoCell (xALP_MethodProperties;2;1)
For ($I;1;Size of array:C274(alXS_Methods_RecNum))
	If (abXS_Methods_AuthRequired{$i})
		AL_SetRowColor (xALP_MethodProperties;$i;"Red")
	Else 
		AL_SetRowColor (xALP_MethodProperties;$i;"Green")
	End if 
End for 
vt_NumComandos:="Hay "+String:C10(Size of array:C274(atXS_Methods_Alias))+" comandos definidos."