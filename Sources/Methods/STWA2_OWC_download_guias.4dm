//%attributes = {}
  //STWA2_OWC_download_guias

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$uuid:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"UUID")
If (STWA2_Session_UpdateLastSeen ($uuid))
	$recNum:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
	If (KRL_GotoRecord (->[xShell_Documents:91];$recNum;False:C215))
		$extension:=[xShell_Documents:91]DocumentType:5
		If ($extension#"")
			$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
		Else 
			$fileName:=String:C10([xShell_Documents:91]DocID:9)
		End if 
		QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]ID:1=[xShell_Documents:91]RelatedID:2)
		$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"
		$filepath:=SYS_RetrieveFile_v11 ($serverFolder;$fileName)
		If (SYS_TestPathName ($filepath)=Is a document:K24:1)
			C_BLOB:C604($docBlob;0)
			DOCUMENT TO BLOB:C525($filepath;$docBlob)
			ARRAY TEXT:C222($hNames;2)
			ARRAY TEXT:C222($hValues;2)
			$hNames{1}:="Content-Type"
			$hNames{2}:="Content-Disposition"
			$hValues{1}:="x-please-download"
			  //$hValues{2}:="attachment; filename="+[xShell_Documents]DocumentName
			$hValues{2}:="attachment; filename="+[Asignaturas_Adjuntos:230]nombre_adjunto:10  //20180709 ASM Ticket 210221 
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