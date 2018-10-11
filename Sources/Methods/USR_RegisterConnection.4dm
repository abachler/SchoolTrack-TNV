//%attributes = {}
  // Método: USR_RegisterConnection
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/09/10, 17:42:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($l_IdUsuario;$1)
C_TEXT:C284($t_aliasUsuario;$2;$t_nombreUsuario;$3;$t_nombreMaquina;$4;$connectionName;$5)
$l_IdUsuario:=$1
$t_aliasUsuario:=$2
$t_nombreUsuario:=$3
$t_nombreMaquina:=$4
$t_nombreConexion:=$5

  // Código principal

If ($l_IdUsuario>0)
	KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]No:1;->$l_IdUsuario;True:C214)
	[xShell_Users:47]Nb_sesions:8:=[xShell_Users:47]Nb_sesions:8+1
	[xShell_Users:47]SessionDate:5:=Current date:C33(*)
	[xShell_Users:47]SessionTime:6:=Current time:C178(*)
	[xShell_Users:47]CambiarPassw_PrimeraSesion:25:=False:C215
	[xShell_Users:47]CambiarPassw_proximaSesion:26:=False:C215
	SAVE RECORD:C53([xShell_Users:47])
	
	READ WRITE:C146([xShell_UserConnections:281])
	QUERY:C277([xShell_UserConnections:281];[xShell_UserConnections:281]UserID:1;=;$l_IdUsuario;*)
	QUERY:C277([xShell_UserConnections:281]; & ;[xShell_UserConnections:281]Login:2=$t_aliasUsuario)
	
	If (Records in selection:C76([xShell_UserConnections:281])=0)
		CREATE RECORD:C68([xShell_UserConnections:281])
		[xShell_UserConnections:281]UserID:1:=$l_IdUsuario
		[xShell_UserConnections:281]Login:2:=$t_aliasUsuario
		[xShell_UserConnections:281]Name:10:=$t_nombreUsuario
		[xShell_UserConnections:281]LastConnection_CNXname:12:=$t_nombreConexion
		[xShell_UserConnections:281]FirstConnection_DTS:3:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[xShell_UserConnections:281]LastConnection_DTS:5:=[xShell_UserConnections:281]FirstConnection_DTS:3
		[xShell_UserConnections:281]Connections_Number:8:=[xShell_UserConnections:281]Connections_Number:8+1
		[xShell_UserConnections:281]Connections_History:11:=[xShell_UserConnections:281]FirstConnection_DTS:3
		[xShell_UserConnections:281]LastConnection_MachineName:13:=$t_nombreMaquina
		[xShell_UserConnections:281]IsAlive:14:=True:C214
		SAVE RECORD:C53([xShell_UserConnections:281])
	Else 
		[xShell_UserConnections:281]LastConnection_CNXname:12:=$t_nombreConexion
		[xShell_UserConnections:281]LastConnection_DTS:5:=DTS_MakeFromDateTime (Current date:C33(*);Current time:C178(*))
		[xShell_UserConnections:281]Connections_Number:8:=[xShell_UserConnections:281]Connections_Number:8+1
		[xShell_UserConnections:281]Connections_History:11:=[xShell_UserConnections:281]Connections_History:11+Char:C90(Carriage return:K15:38)+";"+[xShell_UserConnections:281]LastConnection_DTS:5
		[xShell_UserConnections:281]LastConnection_MachineName:13:=$t_nombreMaquina
		[xShell_UserConnections:281]IsAlive:14:=True:C214
		SAVE RECORD:C53([xShell_UserConnections:281])
	End if 
	KRL_UnloadReadOnly (->[xShell_UserConnections:281])
End if 

