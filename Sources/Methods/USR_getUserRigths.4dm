//%attributes = {}
  //USR_getUserRigths

C_TEXT:C284(theText)
C_LONGINT:C283($i)
ARRAY INTEGER:C220(ai_g1;0)
ARRAY TEXT:C222(at_g1;0)
ARRAY LONGINT:C221(alUSR_Membership;0)

$0:=True:C214

$userID:=USR_GetUserID 

If (<>lUSR_CurrentUserID<0)
	COPY ARRAY:C226(<>alUSR_GroupIds;alUSR_Membership)
Else 
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
End if 

READ ONLY:C145([xShell_UserGroups:17])
READ ONLY:C145([xShell_Users:47])
If (Size of array:C274(alUSR_Membership)>0)
	ARRAY INTEGER:C220(<>aAccesFile;0)
	ARRAY INTEGER:C220(<>aAccesPriv;0)
	ARRAY TEXT:C222(<>ATUSR_AUTHORIZEDCOMMANDS;0)
	ARRAY TEXT:C222(<>atUSR_AuthModules;0)
	
	For ($i_groups;1;Size of array:C274(alUSR_Membership))
		QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=alUSR_Membership{$i_groups})
		If (Records in selection:C76([xShell_UserGroups:17])=1)
			If (BLOB size:C605([xShell_UserGroups:17]xTableAcces:4)>0)
				BLOB_Blob2Vars (->[xShell_UserGroups:17]xTableAcces:4;0;-><>aUserPriv)
				For ($i;1;Size of array:C274(<>aUserPriv))
					$tableNumber:=Int:C8(<>aUserPriv{$i})
					$accesLevel:=Dec:C9(<>aUserPriv{$i})*10
					$pos:=Find in array:C230(<>aAccesFile;$tableNumber)
					If ($pos<0)
						$s:=Size of array:C274(<>aAccesFile)+1
						AT_Insert ($s;1;-><>aAccesFile;-><>aAccesPriv)
						<>aAccesFile{$s}:=$tableNumber
						<>aAccesPriv{$s}:=$accesLevel
					Else 
						If ($accesLevel><>aAccesPriv{$pos})
							<>aAccesPriv{$pos}:=$accesLevel
						End if 
					End if 
				End for 
			End if 
			
			If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)>0)
				BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;-><>aProcName)
				For ($i;1;Size of array:C274(<>aProcName))
					$methodName:=<>aProcName{$i}
					$pos:=Find in array:C230(<>ATUSR_AUTHORIZEDCOMMANDS;$methodName)
					If ($pos<0)
						$s:=Size of array:C274(<>ATUSR_AUTHORIZEDCOMMANDS)+1
						AT_Insert ($s;1;-><>ATUSR_AUTHORIZEDCOMMANDS)
						<>ATUSR_AUTHORIZEDCOMMANDS{$s}:=$methodName
					End if 
				End for 
			End if 
			
			
			ARRAY TEXT:C222(at_g2;0)
			BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->at_g2)
			
			  //20150226 RCH Por algun motivo el grupo administradoción no tiene permiso permisos para ingresar a ningún módulo...
			If ((Size of array:C274(at_g2)=0) & (alUSR_Membership{$i_groups}=-15001))
				APPEND TO ARRAY:C911(at_g2;"SchoolTrack")
			End if 
			
			For ($i;1;Size of array:C274(at_g2))
				$module:=at_g2{$i}
				$pos:=Find in array:C230(<>atUSR_AuthModules;$module)
				If ($pos<0)
					$s:=Size of array:C274(<>atUSR_AuthModules)+1
					AT_Insert ($s;1;-><>atUSR_AuthModules)
					<>atUSR_AuthModules{$s}:=$module
				End if 
			End for 
			
		End if 
	End for 
	If (<>lUSR_CurrentUserID>0)
		<>tUSR_CurrentUser:=[xShell_Users:47]login:9
		<>lUSR_CurrentUserID:=[xShell_Users:47]No:1
		<>lUSR_RelatedTableUserID:=[xShell_Users:47]NoEmployee:7
		<>tUSR_RelatedTableUserName:=[xShell_Users:47]Name:2
		dhUG_CurrentUserProperties 
	Else 
		<>bUSR_EsProfesorJefe:=False:C215
		<>lUSR_RelatedTableUserID:=-1
		<>tUSR_RelatedTableUserName:=""
		<>tUSR_Curso:=""
		<>lSTR_IDTutor_USR:=0
	End if 
Else 
	CD_Dlog (0;__ ("Usted no pertenece a ningún grupo.\r\rSolo los usuarios pertenecientes a al menos un grupo pueden utilizar la aplicación."))
	$0:=False:C215
End if 
AT_Initialize (-><>aUserPriv)


<>lUSR_CurrentUserID:=USR_GetUserID 
<>tUSR_CurrentUser:=USR_CurrentUser 