//%attributes = {}
  //ADT_CargaArreglosCambioEstado

READ ONLY:C145([xxADT_LogCambioEstado:162])
QUERY:C277([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]ID_Candidato:1=[ADT_Candidatos:49]Candidato_numero:1)
CREATE SET:C116([xxADT_LogCambioEstado:162];"estados")
CREATE EMPTY SET:C140([xxADT_LogCambioEstado:162];"sitfinales")
While (Not:C34(End selection:C36([xxADT_LogCambioEstado:162])))
	If ([xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4=[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3)
		REMOVE FROM SET:C561([xxADT_LogCambioEstado:162];"estados")
		ADD TO SET:C119([xxADT_LogCambioEstado:162];"sitfinales")
	End if 
	NEXT RECORD:C51([xxADT_LogCambioEstado:162])
End while 
USE SET:C118("estados")
CLEAR SET:C117("estados")
_O_ARRAY STRING:C218(14;$aDTS;0)
ARRAY LONGINT:C221($aIDOld;0)
ARRAY LONGINT:C221($aIDNew;0)
ARRAY LONGINT:C221($aUser;0)
ARRAY DATE:C224(aDateState;0)
ARRAY TEXT:C222(aTimeState;0)
ARRAY TEXT:C222(aOldNameState;0)
ARRAY TEXT:C222(aNewNameState;0)
ARRAY TEXT:C222(aUserState;0)
ORDER BY:C49([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]DTS:2;>)
SELECTION TO ARRAY:C260([xxADT_LogCambioEstado:162]DTS:2;$aDTS;[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4;$aIDNew;[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3;$aIDOld;[xxADT_LogCambioEstado:162]ID_Usuario:5;$aUser)
For ($i;1;Size of array:C274($aDTS))
	APPEND TO ARRAY:C911(aDateState;DTS_GetDate ($aDTS{$i}))
	APPEND TO ARRAY:C911(aTimeState;String:C10(DTS_GetTime ($aDTS{$i});HH MM:K7:2))
	APPEND TO ARRAY:C911(aUserState;USR_GetUserName ($aUser{$i}))
	$foundold:=HL_FindInListByReference (hl_EstadosGeneral;$aIDOld{$i})
	$foundnew:=HL_FindInListByReference (hl_EstadosGeneral;$aIDNew{$i})
	If ($foundold#"")
		APPEND TO ARRAY:C911(aOldNameState;$foundold)
	Else 
		If ($aIDOld{$i}=0)
			APPEND TO ARRAY:C911(aOldNameState;"Indeterminado")
		Else 
			APPEND TO ARRAY:C911(aOldNameState;"Estado Eliminado")
		End if 
	End if 
	If ($foundnew#"")
		APPEND TO ARRAY:C911(aNewNameState;$foundnew)
	Else 
		If ($aIDNew{$i}=0)
			APPEND TO ARRAY:C911(aNewNameState;"Indeterminado")
		Else 
			APPEND TO ARRAY:C911(aNewNameState;"Estado Eliminado")
		End if 
	End if 
End for 
USE SET:C118("sitfinales")
_O_ARRAY STRING:C218(14;$aDTS;0)
ARRAY LONGINT:C221($aIDOld;0)
ARRAY LONGINT:C221($aIDNew;0)
ARRAY LONGINT:C221($aUser;0)
ARRAY LONGINT:C221($state;0)
ARRAY DATE:C224(aDateStateSF;0)
ARRAY TEXT:C222(aTimeStateSF;0)
ARRAY TEXT:C222(aStateSF;0)
ARRAY TEXT:C222(aOldNameStateSF;0)
ARRAY TEXT:C222(aNewNameStateSF;0)
ARRAY TEXT:C222(aUserStateSF;0)
ORDER BY:C49([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]DTS:2;>)
SELECTION TO ARRAY:C260([xxADT_LogCambioEstado:162]DTS:2;$aDTS;[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7;$aIDNew;[xxADT_LogCambioEstado:162]ID_SitFinal_Viejo:6;$aIDOld;[xxADT_LogCambioEstado:162]ID_Usuario:5;$aUser;[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4;$state)
For ($i;1;Size of array:C274($aDTS))
	APPEND TO ARRAY:C911(aDateStateSF;DTS_GetDate ($aDTS{$i}))
	APPEND TO ARRAY:C911(aTimeStateSF;String:C10(DTS_GetTime ($aDTS{$i});HH MM:K7:2))
	APPEND TO ARRAY:C911(aUserStateSF;USR_GetUserName ($aUser{$i}))
	$foundold:=HL_FindInListByReference (hl_EstadosGeneral;$aIDOld{$i})
	$foundnew:=HL_FindInListByReference (hl_EstadosGeneral;$aIDNew{$i})
	$foundstate:=HL_FindInListByReference (hl_EstadosGeneral;$state{$i})
	If ($foundold#"")
		APPEND TO ARRAY:C911(aOldNameStateSF;$foundold)
	Else 
		If ($aIDOld{$i}=0)
			APPEND TO ARRAY:C911(aOldNameStateSF;"Indeterminado")
		Else 
			APPEND TO ARRAY:C911(aOldNameStateSF;"Sit. Final Eliminada")
		End if 
	End if 
	If ($foundnew#"")
		APPEND TO ARRAY:C911(aNewNameStateSF;$foundnew)
	Else 
		If ($aIDNew{$i}=0)
			APPEND TO ARRAY:C911(aNewNameStateSF;"Indeterminado")
		Else 
			APPEND TO ARRAY:C911(aNewNameStateSF;"Sit. Final Eliminada")
		End if 
	End if 
	APPEND TO ARRAY:C911(aStateSF;$foundstate)
End for 
KRL_UnloadReadOnly (->[xxADT_LogCambioEstado:162])