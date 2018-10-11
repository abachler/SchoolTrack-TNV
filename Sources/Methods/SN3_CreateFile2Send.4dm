//%attributes = {}
  //SN3_CreateFile2Send
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)
C_LONGINT:C283($tipoDatos;$3)
C_POINTER:C301($5;$ref)

$accion:=$1
$path:=$2
$tipoXML:="dom"
Case of 
	: (Count parameters:C259=3)
		$tipoDatos:=$3
	: (Count parameters:C259>3)
		$tipoDatos:=$3
		$tipoXML:=$4
		$ref:=$5
End case 

Case of 
	: ($accion="crear")
		$vt_FileName:=SN3_GetFilesPath +SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_"+String:C10($tipoDatos)+".snt"
		If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
			DELAY PROCESS:C323(Current process:C322;30)  //20180404 RCH Si se genera un archivo con el mismo nombre, se espera 0,5 seg para crear un nuevo nombre de archivo.
			$vt_FileName:=SN3_GetFilesPath +SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_"+String:C10($tipoDatos)+".snt"
			If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
				DELETE DOCUMENT:C159($vt_FileName)
			End if 
		End if 
		Case of 
			: ($tipoXML="dom")
				SET CHANNEL:C77(12;$vt_FileName)
				SET CHANNEL:C77(11)
			: ($tipoXML="sax")
				$ref->:=Create document:C266($vt_FileName)
				XML SET OPTIONS:C1090($ref->;XML String encoding:K45:21;XML raw data:K45:23)
		End case 
		$0:=$vt_FileName
	: ($accion="comprimir")
		$zipFileName:=Replace string:C233($path;".snt";".zip")
		$z7FileName:=Replace string:C233($path;".snt";".7z")
		If (SYS_TestPathName ($zipFileName)=Is a document:K24:1)
			DELETE DOCUMENT:C159($zipFileName)
		End if 
		If (SYS_TestPathName ($z7FileName)=Is a document:K24:1)
			DELETE DOCUMENT:C159($z7FileName)
		End if 
		
		  //<comprime y elimina archivo
		$b_archivoComprimido:=SYS_CompresionDescompresion ($path;$zipFileName;"";->$t_resultadoCompresion)
		If ($b_archivoComprimido)
			DELAY PROCESS:C323(Current process:C322;30)  //para permitir que ZIP Save File "suelte" el archivo para poder eliminarlo...
			DELETE DOCUMENT:C159($path)
		End if 
End case 