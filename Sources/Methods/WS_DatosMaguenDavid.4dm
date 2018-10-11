//%attributes = {"publishedSoap":true,"publishedWsdl":true}
  //WS_DatosMaguenDavid

  //****DECLARACIONES****
C_TEXT:C284($1;$2;$3;$4;$5;$schoolID;$userName;$password;$tipo_Persona;$status;vtWS_ErrorString;vtWS_XML)
C_BLOB:C604(vxWS_Blob1;vxWS_Blob2;vxWS_Blob3;vxWS_Blob4;$blob;$compressedBlob)
C_LONGINT:C283($logged)
C_TEXT:C284($folderPath)

  //****SOAP INPUTS****
SOAP DECLARATION:C782($1;Is text:K8:3;SOAP input:K46:1;"identificadorColegio")
SOAP DECLARATION:C782($2;Is text:K8:3;SOAP input:K46:1;"usuario")
SOAP DECLARATION:C782($3;Is text:K8:3;SOAP input:K46:1;"password")
SOAP DECLARATION:C782($4;Is text:K8:3;SOAP input:K46:1;"datosRequeridos")
SOAP DECLARATION:C782($5;Is text:K8:3;SOAP input:K46:1;"codigo")

  //****INICIALIZACIONES****
C_TEXT:C284($clase_datos;$t_codigo)
$schoolID:=$1
$userName:=$2
$password:=$3
$clase_datos:=$4
$t_codigo:=$5
vtWS_ErrorString:=""
vtWS_XML:=""

  //****SOAP OUTPUTS****
SOAP DECLARATION:C782(vtWS_ErrorString;Is text:K8:3;SOAP output:K46:2;"mensajeError")
SOAP DECLARATION:C782(vtWS_XML;Is XML:K46:7;SOAP output:K46:2;"xml")

  //  //****CUERPO****

vtWS_ErrorString:=""
  //If (true)
If ((($schoolID=<>gRolBD) & ($schoolID="CHMD")) | (Not:C34(Is compiled mode:C492)))
	vs_Name:=$userName
	vs_Password:=$password
	$logged:=USR_ProcessLogin 
	
	If ($logged=1)
		
		Case of 
			: ($clase_datos="Archivo1")
				READ ONLY:C145([Familia:78])
				READ ONLY:C145([Familia_RelacionesFamiliares:77])
				READ ONLY:C145([Personas:7])
				
				If ($t_codigo="TODO")
					QUERY:C277([Personas:7];[Personas:7]Inactivo:46=False:C215)
				Else 
					QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=$t_codigo)
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
				End if 
				
				QUERY SELECTION:C341([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
				
				If (Records in selection:C76([Personas:7])>0)
					
					$t_raizXML:=DOM Create XML Ref:C861("Archivo1")
					DOM SET XML DECLARATION:C859($t_raizXML;"UTF-8")
					
					ARRAY LONGINT:C221($al_recNum;0)
					LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_recNum;"")
					For ($i;1;Size of array:C274($al_recNum))
						GOTO RECORD:C242([Personas:7];$al_recNum{$i})
						
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
						KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
						FIRST RECORD:C50([Familia:78])
						
						$t_refApdo:=DOM_SetElementValueAndAttr ($t_raizXML;"Apoderado")
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_numero_familia";[Familia:78]Codigo_interno:14;True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_nombre";ST_CleanString ([Personas:7]Apellidos_y_nombres:30);True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_direccion";ST_CleanString ([Personas:7]Direccion:14);True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_colonia";ST_CleanString ([Personas:7]Comuna:16);True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_ciudad";ST_CleanString ([Personas:7]Ciudad:17);True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_codigo_postal";ST_CleanString ([Personas:7]Codigo_postal:15);True:C214)
						DOM_SetElementValueAndAttr ($t_refApdo;"A1_rfc";_CampoPropio ("R.F.C");True:C214)
						
					End for 
					
					DOM EXPORT TO VAR:C863($t_raizXML;vtWS_XML)
					SET TEXT TO PASTEBOARD:C523(vtWS_XML)
					DOM CLOSE XML:C722($t_raizXML)
					
				End if 
				
				
			: ($clase_datos="Archivo2")
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Familia:78])
				READ ONLY:C145([xxSTR_Niveles:6])
				
				If ($t_codigo="TODO")
					  //QUERY([Alumnos];[Alumnos]Nivel_Número>=Nivel_AdmissionTrack;*)
					  //QUERY([Alumnos]; & ;[Alumnos]Nivel_Número<Nivel_Egresados)
					QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo")
				Else 
					QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=$t_codigo)
					KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia:78]Numero:1;"")
				End if 
				
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados)
				
				If (Records in selection:C76([Alumnos:2])>0)
					
					$t_raizXML:=DOM Create XML Ref:C861("Archivo2")
					DOM SET XML DECLARATION:C859($t_raizXML;"UTF-8")
					
					ARRAY LONGINT:C221($al_recNum;0)
					LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNum;"")
					
					For ($i;1;Size of array:C274($al_recNum))
						GOTO RECORD:C242([Alumnos:2];$al_recNum{$i})
						QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)
						
						QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
						
						$t_refAlumno:=DOM_SetElementValueAndAttr ($t_raizXML;"Alumno")
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_numero_familia";[Familia:78]Codigo_interno:14;True:C214)
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_nombre_alumno";ST_CleanString ([Alumnos:2]apellidos_y_nombres:40);True:C214)
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_grado";ST_CleanString ([Alumnos:2]Nivel_Nombre:34);True:C214)
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_grupo";ST_CleanString ([xxSTR_Niveles:6]Sección:9);True:C214)
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[Familia:78]Padre_Número:5)
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_padre_nombre";ST_CleanString ([Personas:7]Apellidos_y_nombres:30);True:C214)
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[Familia:78]Madre_Número:6)
						DOM_SetElementValueAndAttr ($t_refAlumno;"A2_madre_nombre";ST_CleanString ([Personas:7]Apellidos_y_nombres:30);True:C214)
					End for 
					
					DOM EXPORT TO VAR:C863($t_raizXML;vtWS_XML)
					SET TEXT TO PASTEBOARD:C523(vtWS_XML)
					DOM CLOSE XML:C722($t_raizXML)
					
				End if 
				
		End case 
	Else 
		vtWS_ErrorString:="Nombre de usuario o contraseña incorrecto (Error -2)"
	End if 
Else 
	vtWS_ErrorString:="Identificador de la institución incorrecto (Error -1)"
End if 