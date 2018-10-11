//%attributes = {}
ARRAY TEXT:C222(<>atSTWA2_Session_UUIDs;0)
ARRAY LONGINT:C221(<>alSTWA2_Session_UserID;0)
ARRAY LONGINT:C221(<>alSTWA2_Session_ProfID;0)
ARRAY LONGINT:C221(<>alSTWA2_Session_LastSeen;0)
ARRAY TEXT:C222(<>atSTWA2_Session_BrowserIP;0)

C_LONGINT:C283(<>vlSTWA2_Timeout;<>vlSTWA2_SessionExpiracyWarning;<>vlSTWA_SessionDaemonCycle)  //en segundos
C_BOOLEAN:C305(<>vbSTWA2_UseArrayBasedSessions)

<>vlSTWA2_Timeout:=Num:C11(PREF_fGet (0;"TimeoutSTWA";"600"))

<>vlSTWA2_SessionExpiracyWarning:=120
<>vlSTWA_SessionDaemonCycle:=10

<>vbSTWA2_UseArrayBasedSessions:=False:C215

STWA2_Session_SessionDaemon 