//%attributes = {}
  //USR_CreateDefaultGroups

C_TEXT:C284($password)
USR_BuildAccesTables 


  //**** ELIMINA GRUPOS POR DEFECTOS DUPLICADOS (el ultimo añadido) ****
  // ABK 2013 03 19
ARRAY LONGINT:C221(al_recNums;0)
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=-15001)
If (Records in selection:C76([xShell_UserGroups:17])>1)
	LONGINT ARRAY FROM SELECTION:C647([xShell_UserGroups:17];al_recNums)
	SORT ARRAY:C229(al_recNums;<)
	KRL_GotoRecord (->[xShell_UserGroups:17];al_recNums{1})
	KRL_DeleteRecord (->[xShell_UserGroups:17])
End if 

ARRAY LONGINT:C221(al_recNums;0)
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=-15002)
If (Records in selection:C76([xShell_UserGroups:17])>1)
	LONGINT ARRAY FROM SELECTION:C647([xShell_UserGroups:17];al_recNums)
	SORT ARRAY:C229(al_recNums;<)
	KRL_GotoRecord (->[xShell_UserGroups:17];al_recNums{1})
	KRL_DeleteRecord (->[xShell_UserGroups:17])
End if 
  // ABK 2013 03 19
  //****.


ARRAY LONGINT:C221($aGroupsID;0)
LIST TO ARRAY:C288("XS_UserGroups";$aGroups;$aGroupsID)
For ($groupIndex;1;Size of array:C274($aGroups))
	READ WRITE:C146([xShell_UserGroups:17])
	QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=$aGroupsID{$groupIndex})
	If (Records in selection:C76([xShell_UserGroups:17])=0)
		CREATE RECORD:C68([xShell_UserGroups:17])
	End if 
	[xShell_UserGroups:17]IDGroup:1:=$aGroupsID{$groupIndex}
	[xShell_UserGroups:17]GroupName:2:=$aGroups{$groupIndex}
	If ([xShell_UserGroups:17]Propietary:3=0)
		[xShell_UserGroups:17]PropietaryName:9:="Administrador"
		[xShell_UserGroups:17]Propietary:3:=1
	End if 
	Case of 
		: ([xShell_UserGroups:17]IDGroup:1=-15001)  //administración
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;-><>atUSR_Commands)
			ARRAY REAL:C219($tempRealArray;0)
			AT_RedimArrays (Size of array:C274(<>aPriv);->$tempRealArray)
			For ($i;1;Size of array:C274(<>aPriv))
				$tempRealArray{$i}:=<>aPriv{$i}+0.4
			End for 
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xTableAcces:4;0;->$tempRealArray)
			
		: ([xShell_UserGroups:17]IDGroup:1>=-15002)  // invitados
			  //20150805 ASM Ticket 148102 . para NO resetear los valores configurados al grupo de invitados.
			  //ARRAY TEXT($tempTextArray;0)
			  //BLOB_Variables2Blob (->[xShell_UserGroups]xCommands;0;->$tempTextArray)
			  //ARRAY REAL($tempRealArray;0)
			  //AT_RedimArrays (Size of array(<>aPriv);->$tempRealArray)
			  //For ($i;1;Size of array(<>aPriv))
			  //$tempRealArray{$i}:=<>aPriv{$i}+0,1
			  //End for 
			  //BLOB_Variables2Blob (->[xShell_UserGroups]xTableAcces;0;->$tempRealArray)
			
		Else 
			ARRAY REAL:C219($tempRealArray;0)
			AT_RedimArrays (Size of array:C274(<>aPriv);->$tempRealArray)
			For ($i;1;Size of array:C274(<>aPriv))
				$tempRealArray{$i}:=<>aPriv{$i}+0.1
			End for 
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xTableAcces:4;0;->$tempRealArray)
			
			ARRAY TEXT:C222($tempTextArray;0)
			BLOB_Variables2Blob (->[xShell_UserGroups:17]xCommands:5;0;->$tempTextArray)
	End case 
	SAVE RECORD:C53([xShell_UserGroups:17])
End for 

  //habilitación de todos los módulos licenciados para el grupo Administración (por defecto tiene permisos para todo)
READ WRITE:C146([xShell_UserGroups:17])
QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=-15001)
ARRAY TEXT:C222(<>atUSR_AuthModules;0)
If (LICENCIA_esModuloAutorizado (2;SchoolTrack))
	APPEND TO ARRAY:C911(<>atUSR_AuthModules;"SchoolTrack")
End if 
If (LICENCIA_esModuloAutorizado (2;AccountTrack))
	APPEND TO ARRAY:C911(<>atUSR_AuthModules;"AccountTrack")
End if 
If (LICENCIA_esModuloAutorizado (2;MediaTrack))
	APPEND TO ARRAY:C911(<>atUSR_AuthModules;"MediaTrack")
End if 
If (LICENCIA_esModuloAutorizado (2;AdmissionTrack))
	APPEND TO ARRAY:C911(<>atUSR_AuthModules;"AdmissionTrack")
End if 

BLOB_Variables2Blob (->[xShell_UserGroups:17]Modules:11;0;-><>atUSR_AuthModules)
SAVE RECORD:C53([xShell_UserGroups:17])


If (Records in table:C83([xShell_Users:47])=0)
	  // si no hay ningun registros en la tabla nos aseguramos que no exista ningun registro para esta tabla en la tabla de secuencias
	QUERY:C277([xShell_SequenceNumbers:67];[xShell_SequenceNumbers:67]Table_Number:1=Table:C252(->[xShell_Users:47]);*)
	QUERY:C277([xShell_SequenceNumbers:67]; & ;[xShell_SequenceNumbers:67]FieldNumber:4=Field:C253(->[xShell_Users:47]No:1))
	KRL_DeleteSelection (->[xShell_SequenceNumbers:67])
	
	CREATE RECORD:C68([xShell_Users:47])
	[xShell_Users:47]login:9:="Administrador"
	[xShell_Users:47]Name:2:="Administrador"
	[xShell_Users:47]No:1:=1
	If ($password="")
		$password:="admin"
		[xShell_Users:47]PasswordVersion:10:=3
	End if 
	[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($password)
	[xShell_Users:47]Password_ExpiresOn:11:=Current date:C33(*)
	ARRAY TEXT:C222(<>atUSR_AuthModules;1)
	<>atUSR_AuthModules{1}:="SchoolTrack"
	BLOB_Variables2Blob (->[xShell_UserGroups:17]Modules:11;0;-><>atUSR_AuthModules)
	SAVE RECORD:C53([xShell_Users:47])
	
	ARRAY LONGINT:C221($aUserIds;1)
	$aUserIds{1}:=[xShell_Users:47]No:1
	USR_AddUserMembership ([xShell_Users:47]No:1;-15001)
	USR_AddUserMembership ([xShell_Users:47]No:1;-15002)
	SAVE RECORD:C53([xShell_Users:47])
	USR_SetGroupMemberList (-15001;->$aUserIds)
	USR_SetGroupMemberList (-15002;->$aUserIds)
	KRL_UnloadReadOnly (->[xShell_UserGroups:17])
	KRL_UnloadReadOnly (->[xShell_Users:47])
End if 

