//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  // Método: WS_DatosMonjasInglesas
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 26-03-10, 10:05:06
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //WS_DatosMonjasInglesas

  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$schoolID;$userName;$password;vtWS_ErrorString)
C_LONGINT:C283($logged)

ARRAY TEXT:C222(alu_nom_y_ape;0)
ARRAY TEXT:C222(alu_curso;0)
ARRAY TEXT:C222(alu_rut;0)
ARRAY TEXT:C222(alu_email;0)
ARRAY TEXT:C222(alu_fec_de_nac;0)
ARRAY TEXT:C222(alu_direccion;0)
ARRAY TEXT:C222(alu_comuna;0)
ARRAY TEXT:C222(alu_telefono;0)
ARRAY TEXT:C222(mad_nom_y_ape;0)
ARRAY TEXT:C222(mad_email;0)
ARRAY TEXT:C222(mad_celular;0)
ARRAY TEXT:C222(mad_profesion;0)
ARRAY TEXT:C222(pad_nom_y_ape;0)
ARRAY TEXT:C222(pad_email;0)
ARRAY TEXT:C222(pad_celular;0)
ARRAY TEXT:C222(pad_profesion;0)


  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorColegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")

  //****INICIALIZACIONES****
$schoolID:=$1
$userName:=$2
$password:=$3

vtWS_ErrorString:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")
SOAP DECLARATION:C782(alu_nom_y_ape;Text array:K8:16;SOAP output:K46:2;"ws_alu_nom_y_ape")
SOAP DECLARATION:C782(alu_curso;Text array:K8:16;SOAP output:K46:2;"ws_alu_curso")
SOAP DECLARATION:C782(alu_rut;Text array:K8:16;SOAP output:K46:2;"ws_alu_rut")
SOAP DECLARATION:C782(alu_email;Text array:K8:16;SOAP output:K46:2;"ws_alu_email")
SOAP DECLARATION:C782(alu_fec_de_nac;Text array:K8:16;SOAP output:K46:2;"ws_alu_fec_de_nac")
SOAP DECLARATION:C782(alu_direccion;Text array:K8:16;SOAP output:K46:2;"ws_alu_direccion")
SOAP DECLARATION:C782(alu_comuna;Text array:K8:16;SOAP output:K46:2;"ws_alu_comuna")
SOAP DECLARATION:C782(alu_telefono;Text array:K8:16;SOAP output:K46:2;"ws_alu_telefono")
SOAP DECLARATION:C782(mad_nom_y_ape;Text array:K8:16;SOAP output:K46:2;"ws_mad_nom_y_ape")
SOAP DECLARATION:C782(mad_email;Text array:K8:16;SOAP output:K46:2;"ws_mad_email")
SOAP DECLARATION:C782(mad_celular;Text array:K8:16;SOAP output:K46:2;"ws_mad_celular")
SOAP DECLARATION:C782(mad_profesion;Text array:K8:16;SOAP output:K46:2;"ws_mad_profesion")
SOAP DECLARATION:C782(pad_nom_y_ape;Text array:K8:16;SOAP output:K46:2;"ws_pad_nom_y_ape")
SOAP DECLARATION:C782(pad_email;Text array:K8:16;SOAP output:K46:2;"ws_pad_email")
SOAP DECLARATION:C782(pad_celular;Text array:K8:16;SOAP output:K46:2;"ws_pad_celular")
SOAP DECLARATION:C782(pad_profesion;Text array:K8:16;SOAP output:K46:2;"ws_pad_profesion")


  //****CUERPO****
vtWS_ErrorString:=""
TRACE:C157
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])

C_LONGINT:C283($vl_idFamilia)

If (($schoolID=[Colegio:31]Rol Base Datos:9) & ($schoolID="88781"))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	TRACE:C157
	If ($logged=1)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Personas:7])
		ALL RECORDS:C47([Alumnos:2])
		ARRAY LONGINT:C221($al_familiaNumero;0)
		ARRAY DATE:C224($alu_fec_de_nac;0)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;alu_nom_y_ape;[Alumnos:2]curso:20;alu_curso;[Alumnos:2]RUT:5;alu_rut;[Alumnos:2]eMAIL:68;alu_email;[Alumnos:2]Fecha_de_nacimiento:7;$alu_fec_de_nac;[Alumnos:2]Direccion:12;alu_direccion;[Alumnos:2]Comuna:14;alu_comuna;[Alumnos:2]Telefono:17;alu_telefono;[Alumnos:2]Familia_Número:24;$al_familiaNumero)
		AT_RedimArrays (Size of array:C274($al_familiaNumero);->alu_fec_de_nac;->mad_nom_y_ape;->mad_email;->mad_celular;->mad_profesion;->pad_nom_y_ape;->pad_email;->pad_celular;->pad_profesion)
		For ($i;1;Size of array:C274($al_familiaNumero))
			$vl_idFamilia:=$al_familiaNumero{$i}
			KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->$vl_idFamilia)
			REDUCE SELECTION:C351([Personas:7];0)
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[Familia:78]Madre_Número:6)
			mad_nom_y_ape{$i}:=[Personas:7]Apellidos_y_nombres:30
			mad_email{$i}:=[Personas:7]eMail:34
			mad_celular{$i}:=[Personas:7]Celular:24
			mad_profesion{$i}:=[Personas:7]Profesion:13
			REDUCE SELECTION:C351([Personas:7];0)
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[Familia:78]Padre_Número:5)
			pad_nom_y_ape{$i}:=[Personas:7]Apellidos_y_nombres:30
			pad_email{$i}:=[Personas:7]eMail:34
			pad_celular{$i}:=[Personas:7]Celular:24
			pad_profesion{$i}:=[Personas:7]Profesion:13
			
			alu_fec_de_nac{$i}:=DTS_MakeFromDateTime ($alu_fec_de_nac{$i})
		End for 
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 