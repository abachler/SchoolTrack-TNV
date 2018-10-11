//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:07:43
  // ----------------------------------------------------
  // Método: STWA2_OWC_download
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

$uuid:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"UUID")
If (STWA2_Session_UpdateLastSeen ($uuid))
	$recNum:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
	If (KRL_GotoRecord (->[xShell_Documents:91];$recNum;False:C215))
		  // EL CAMBIO EN EL CÓDIGO PRODUJO VARIOS PROBLEMAS ADICIONALES AL REPORTADO. FAVOR PONER UN POCO MAS DE ATENCIÓN Y CUIDADO
		  //ABC190358 
		  //If ($extension#"")
		  //$fileName:=[xShell_Documents]DocumentName
		  //  //$fileName:=String([xShell_Documents]DocID)+"."+$extension
		  //Else 
		  //  //$fileName:=String([xShell_Documents]id) 
		  //$fileName:=String([xShell_Documents]DocumentName)
		  //End if 
		
		$extension:=[xShell_Documents:91]DocumentType:5
		If ($extension#"")
			$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
		Else 
			$fileName:=String:C10([xShell_Documents:91]DocID:9)
		End if 
		  //20171015 TICKET 190358 ASM Agrego el nombre del documento para que sea con este con el que se guarde en el cliente.
		$fileNameSTWA:=[xShell_Documents:91]DocumentName:3
		$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
		$filepath:=SYS_RetrieveFile_v11 ($serverFolder;$fileName)
		If (SYS_TestPathName ($filepath)=Is a document:K24:1)
			C_BLOB:C604($docBlob;0)
			DOCUMENT TO BLOB:C525($filepath;$docBlob)
			ARRAY TEXT:C222($hNames;2)
			ARRAY TEXT:C222($hValues;2)
			$hNames{1}:="Content-Type"
			$hNames{2}:="Content-Disposition"
			$hValues{1}:="x-please-download"
			  //$hValues{2}:="attachment; filename="+$fileName
			$hValues{2}:="attachment; filename="+$fileNameSTWA
			WEB SET HTTP HEADER:C660($hNames;$hValues)
			WEB SEND RAW DATA:C815($docBlob;*)
		Else 
			  //error
		End if 
	Else 
		  //error
	End if 
Else 
	  //error
End if 