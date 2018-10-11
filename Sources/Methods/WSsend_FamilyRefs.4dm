//%attributes = {"publishedSoap":true}
  //WSsend_FamilyRefs





  //`xShell, Alberto Bachler
  //Metodo: WS_Familias
  //Por abachler
  //Creada el 05/11/2003, 12:08:41
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_TIME:C306($time)
C_TEXT:C284($1;$2;$3;$4;$schoolID;$userName;$password;$dateTime_DTS;vtWS_ErrorString)
C_POINTER:C301($datePointer;$timePointer)
C_LONGINT:C283($logged)
ARRAY TEXT:C222(atWS_NombresFamilia;0)
ARRAY LONGINT:C221(alWS_IdsFamilia;0)

SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"schoolID")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"userName")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"dateTime_DTS")
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"ERRstring")
SOAP DECLARATION:C782(atWS_NombresFamilia;Text array:K8:16;SOAP output:K46:2;"familias_nombres")
SOAP DECLARATION:C782(alWS_IdsFamilia;LongInt array:K8:19;SOAP output:K46:2;"familias_Ids")

  //****INICIALIZACIONES****
$schoolID:=$1
$userName:=$2
$password:=$3
$dateTime_DTS:=$4
vtWS_ErrorString:=""

  //****CUERPO****
$date:=DTS_GetDate ($dateTime_DTS)
$time:=DTS_GetTime ($dateTime_DTS)

If ($schoolID=<>gRolBD)
	If (($userName="demoWS") & ($password="demoWS"))
		$logged:=1
	Else 
		$logged:=dhUG_ProcessLogin ($userName;$password)
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 

If ($logged=1)
	If ($dateTime_DTS="")
		QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3#"";*)
		QUERY:C277([Familia:78]; & ;[Familia:78]Nombre_de_la_familia:3#" ")
	Else 
		QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3#"";*)
		QUERY:C277([Familia:78]; & ;[Familia:78]Nombre_de_la_familia:3#" ";*)
		QUERY:C277([Familia:78]; & ;[Familia:78]DTS_ModifiedOn_GMT:30>$dateTime_DTS)
	End if 
	SELECTION TO ARRAY:C260([Familia:78]Numero:1;alWS_IdsFamilia;[Familia:78]Nombre_de_la_familia:3;atWS_NombresFamilia)
Else 
	vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
End if 

  //****LIMPIEZA****







