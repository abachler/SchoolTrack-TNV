//%attributes = {}
C_TIME:C306($h_connectionTime;$h_time1;$h_Time2)
ARRAY LONGINT:C221($al_UserIds;0)
ARRAY TEXT:C222($at_Connections;0)

ALL RECORDS:C47([xShell_UserConnections:281])
AT_DistinctsFieldValues (->[xShell_UserConnections:281]UserID:1;->$al_UserIds)

For ($i;1;Size of array:C274($al_UserIds))
	QUERY:C277([xShell_UserConnections:281];[xShell_UserConnections:281]UserID:1=$al_UserIds{$i})
	  // $l_connections:=Sum([xShell_UserConnections]Connections_Number)
	
	CREATE SET:C116([xShell_UserConnections:281];"conex")
	ORDER BY:C49([xShell_UserConnections:281];[xShell_UserConnections:281]FirstConnection_DTS:3;>)
	$d_firstConnection:=[xShell_UserConnections:281]FirstConnection_DTS:3
	
	$h_ConnectionTime:=0
	SELECTION TO ARRAY:C260([xShell_UserConnections:281]Connections_History:11;$at_Connections)
	For ($ii;Size of array:C274($at_Connections);1;-1)
		If ($at_Connections{$ii}="@broken con@")
			DELETE FROM ARRAY:C228($at_Connections;$ii)
		Else 
			$t_start:=Substring:C12($at_Connections{$ii};9;6)
			$t_end:=Substring:C12($at_Connections{$ii};24;6)
			
			$h_time1:=Time:C179(Substring:C12($t_start;1;2)+":"+Substring:C12($t_start;3;2)+":"+Substring:C12($t_Start;5;2))
			$h_time2:=Time:C179(Substring:C12($t_end;1;2)+":"+Substring:C12($t_end;3;2)+":"+Substring:C12($t_end;5;2))
			
			$h_ConnectionTime:=$h_ConnectionTime+($h_time2-$h_time1)
		End if 
		
	End for 
	
	
	
	READ WRITE:C146([xShell_UserConnections:281])
	LAST RECORD:C200([xShell_UserConnections:281])
	[xShell_UserConnections:281]FirstConnection_DTS:3:=$d_firstConnection
	[xShell_UserConnections:281]Connections_History:11:=AT_array2text (->$at_Connections;"\r")
	[xShell_UserConnections:281]Connections_Number:8:=Size of array:C274($at_Connections)
	[xShell_UserConnections:281]Connections_TotalTime:9:=$h_ConnectionTime
	SAVE RECORD:C53([xShell_UserConnections:281])
	
	REMOVE FROM SET:C561([xShell_UserConnections:281];"conex")
	USE SET:C118("conex")
	
	KRL_DeleteSelection (->[xShell_UserConnections:281])
	
	
End for 

