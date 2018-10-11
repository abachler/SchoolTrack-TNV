//%attributes = {}
  //USR_EmergencyUser

C_BOOLEAN:C305($0)
C_TEXT:C284($1;vt_Message)
C_TEXT:C284($textVariable)
C_LONGINT:C283($longintVariable)
If (USR_IsGroupMember_by_GrpID (-15001))
	$0:=True:C214
Else 
	If (<>vlXS_SpecialAuthCount<3)
		$tempUserID:=<>lUSR_CurrentUserID
		$tempUsername:=<>tUSR_CurrentUser
		$tempUsermail:=<>tUSR_CurrentUserEmail
		ARRAY LONGINT:C221($tempLongArray;0)
		USR_GetGroupProperties (-15001;->$textVariable;->$longintVariable;->$tempLongArray)
		If (Count parameters:C259=1)
			vt_Message:=$1+"\r\rPor favor solicite la autorización a un usuario miembro del grupo "+$textVariable+"."
		Else 
			vt_Message:="Esta acción requiere la autorización de un usuario miembro del grupo "+$textVariable+".\r\rPor favor solicite la autorización a un usuario miembro del grupo "+$textVariable+"."
		End if 
		$ref:=WDW_OpenFormWindow (->[xShell_Users:47];"Emergencia";-1;4)
		DIALOG:C40([xShell_Users:47];"Emergencia")
		CLOSE WINDOW:C154
		If (Ok=1)
			If ((USR_IsGroupMember_by_GrpID (-15001;[xShell_Users:47]No:1)) | (<>lUSR_CurrentUserID<0))
				$0:=True:C214
				LOG_RegisterEvt ("Autorización Especial: Contraseña de usuario del grupo Administración ingresada c"+"orrectamente.")
				<>vlXS_SpecialAuthCount:=0
			Else 
				$0:=False:C215
				LOG_RegisterEvt ("Autorización Especial: Contraseña ingresada no corresponde a un usuario del grupo"+" Administración.")
			End if 
		End if 
		<>lUSR_CurrentUserID:=$tempUserID
		<>tUSR_CurrentUser:=$tempUsername
		<>tUSR_CurrentUserEmail:=$tempUsermail
		<>tUSR_CurrentUserName:=<>tUSR_CurrentUser
	Else 
		CD_Dlog (0;__ ("Esta acción requiere la autorización de un usuario del grupo Administración. Lamentablemente la solicitud de autorización ha sido denegada debido a que se ha alcanzado el máximo de intentos permitidos para ingresar una contraseña correcta."))
		$0:=False:C215
	End if 
End if 