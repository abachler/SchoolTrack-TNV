//%attributes = {}
  //LOG_RegisterEvt

If (False:C215)
	  //Method: lg_RegisterEvt
	  //Written by  Alberto Bachler on 10/3/98
	  //Module: log manager
	  //Purpose: record a log entry
	  //Syntax:  lg_RegisterEvt(&L;&S;&T;&4;&5)
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
	
End if 

C_LONGINT:C283(<>lUSR_CurrentUserID)
C_TEXT:C284(<>tUSR_CurrentUser)
C_BOOLEAN:C305(<>noLogs)
C_LONGINT:C283($2;$3;$userID;$table;$recordID)
C_TEXT:C284($1;$event;$userName;vsBWR_CurrentModule)



If (<>noLogs=False:C215)
	$userID:=<>lUSR_CurrentUserID
	$userName:=<>tUSR_CurrentUser
	$event:=$1
	If (vsBWR_CurrentModule#"")
		$module:=vsBWR_CurrentModule
	Else 
		$module:="Entorno diseño"
	End if 
	If (Count parameters:C259>1)
		$table:=$2
	End if 
	If (Count parameters:C259>2)
		$recordID:=$3
	End if 
	If (Count parameters:C259>3)
		$userID:=$4
		$userName:=USR_GetUserName ($userID)
	End if 
	If (Count parameters:C259>4)
		$module:=$5
	End if 
	If (Count parameters:C259>5)  //20181008 RCH Ticket 217734. Para permitir guardar un "usuario" que no existe.
		$userName:=$6
	End if 
	CREATE RECORD:C68([xShell_Logs:37])
	[xShell_Logs:37]UserID:1:=$userID
	[xShell_Logs:37]UserName:2:=$userName
	[xShell_Logs:37]Event_Date:3:=Current date:C33(*)
	[xShell_Logs:37]Event_Time:4:=Current time:C178(*)
	[xShell_Logs:37]Event_Description:5:=ST Get plain text:C1092($event)
	[xShell_Logs:37]File_number:6:=$table
	[xShell_Logs:37]Record_Id:7:=$recordID
	[xShell_Logs:37]Module:8:=$module
	[xShell_Logs:37]DTS:12:=Timestamp:C1445
	SAVE RECORD:C53([xShell_Logs:37])
	UNLOAD RECORD:C212([xShell_Logs:37])
End if 

