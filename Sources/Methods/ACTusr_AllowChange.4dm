//%attributes = {}
  //ACTusr_AllowChange

C_LONGINT:C283(viACT_fechaModificable)
C_TEXT:C284($1;$accion)
C_POINTER:C301($2;$ptr)
C_BOOLEAN:C305($0;$visible;$retorno)
$accion:=$1
$ptr:=$2
Case of 
	: (Count parameters:C259=3)
		$visible:=$3
	Else 
		$visible:=True:C214
End case 
$retorno:=True:C214
If ($accion="visible")
	OBJECT SET VISIBLE:C603($ptr->;$visible)
Else 
	If (<>gCountryCode="mx")
		Case of 
			: ($accion="onLoad")
				viACT_fechaModificable:=0
				IT_SetEnterable (viACT_fechaModificable=1;0;$ptr)
				OBJECT SET VISIBLE:C603(*;"padlockUnlocked";viACT_fechaModificable=1)
				OBJECT SET VISIBLE:C603(*;"padlockLocked";viACT_fechaModificable=0)
				$retorno:=False:C215
			: ($accion="onClicked")
				If (viACT_fechaModificable=0)
					If (USR_GetMethodAcces (Current method name:C684;0))  //si no tiene el proceso autorizado, se pregunta por la clave. Si lo tiene, se puede cambiar la fecha...
						$result:=True:C214
					Else 
						$result:=USR_EmergencyUser ("Esta acción requiere autorización.")
					End if 
					viACT_fechaModificable:=Num:C11(Not:C34($result))
					If (viACT_fechaModificable=0)
						viACT_fechaModificable:=1
						GOTO OBJECT:C206($ptr->)
						HIGHLIGHT TEXT:C210($ptr->;Length:C16(String:C10($ptr->))+1;Length:C16(String:C10($ptr->))+1)
					Else 
						viACT_fechaModificable:=0
						$retorno:=False:C215
					End if 
					IT_SetEnterable (viACT_fechaModificable=1;0;$ptr)
					OBJECT SET VISIBLE:C603(*;"padlockUnlocked";viACT_fechaModificable=1)
					OBJECT SET VISIBLE:C603(*;"padlockLocked";viACT_fechaModificable=0)
				End if 
		End case 
	Else 
		IT_SetEnterable (True:C214;0;$ptr)
		OBJECT SET VISIBLE:C603(bPadlock;False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";False:C215)
	End if 
End if 
$0:=$retorno