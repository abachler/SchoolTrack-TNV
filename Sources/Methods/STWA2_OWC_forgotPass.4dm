//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:09:01
  // ----------------------------------------------------
  // Método: STWA2_OWC_forgotPass
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$vtWEB_HTTPHost:=$4

$mail:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"mail")
$saludo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_saludo")
$saludoprof:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_saludoprof")
$confidencialidad:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_confidencialidad")
$despedida:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_despedida")
$colegium:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_colegium")
$noresponder:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_noresponder")
$asunto:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_subject")
$descripcion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_descripcion")
$cultura:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ml_cultura")
$mailFileTemplatePath:=Get 4D folder:C485(HTML Root folder:K5:20)+"stwa"+Folder separator:K24:12+"maildatos.html"
C_BLOB:C604($blob2)
C_TEXT:C284($template;$output)
DOCUMENT TO BLOB:C525($mailFileTemplatePath;$blob2)
$template:=BLOB to text:C555($blob2;UTF8 text without length:K22:17)
$output:=""
vtstwa_Saludo:=$saludo
SET QUERY LIMIT:C395(1)
READ ONLY:C145([xShell_Users:47])
QUERY:C277([xShell_Users:47];[xShell_Users:47]email:20=$mail)
SET QUERY LIMIT:C395(0)
If (Records in selection:C76([xShell_Users:47])=1)
	$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
	If ($storedPassword#"")
		vtstwa_Saludoprof:=$saludoprof+" "+[xShell_Users:47]Name:2+","
		vtstwa_confidencialidad:=$confidencialidad
		vtstwa_despedida:=$despedida
		vtstwa_colegium:=$colegium
		vtstwa_noresponder:=$noresponder
		vtstwa_Descripcion:=$descripcion
		$code:=Generate UUID:C1066+DTS_MakeFromDateTime (Current date:C33+1)
		$url:=$vtWEB_HTTPHost+"/stwa/renewpass?c="+$code+"&cul="+$cultura
		vtstwa_url:="<a style=\"color: #FFF\" href=\""+$url+"\" target=\"blank\">"+$url+"</a>"
		PROCESS 4D TAGS:C816($template;$output)
		  //TEXT TO BLOB($output;$blob;UTF8 text without length)
		  //$output:=Convert to text($blob;"MacRoman")  //convertimos el texto que genera PHT (MacROman) a unicode (o el interno de 4D)
		C_TEXT:C284($err)
		$to:=$mail
		$body:=$output
		$subject:=$asunto
		$err:=STWA2_SendHTMLMail ("mail.colegium.com";"appSchoolTrack@colegium.com";$to;$subject;$body;"appSchoolTrack@colegium.com";"quasimodo";1;"";"";"";"")
		If ($err#"")
			$json:=STWA2_JSON_SendError (-80001)
		Else 
			$json:=STWA2_JSON_SendError (0)
			KRL_ReloadInReadWriteMode (->[xShell_Users:47])
			[xShell_Users:47]passRegenerationCode:23:=$code
			SAVE RECORD:C53([xShell_Users:47])
			KRL_UnloadReadOnly (->[xShell_Users:47])
		End if 
	Else 
		$json:=STWA2_JSON_SendError (-80004)
	End if 
Else 
	$json:=STWA2_JSON_SendError (-80000)
End if 
C_BLOB:C604($blob)
TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($blob;*)

$0:=$json