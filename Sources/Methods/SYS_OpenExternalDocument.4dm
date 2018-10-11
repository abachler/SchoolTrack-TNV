//%attributes = {}
  //SYS_OpenExternalDocument

C_TEXT:C284($1;$document)
C_LONGINT:C283($errCode;$err)
$document:=$1
OK:=0

  //$errCode:=AP ShellExecute ($document;0)
  //If ($errCode#0)
$document:=Replace string:C233($document;"http://";"")
If (Position:C15("/";$document)>0)
	$host:=Substring:C12($document;1;Position:C15("/";$document)-1)
	If ($host#"")
		$err:=TCP_Open ($host;80;$c)
		$err:=TCP_Close ($c)
	End if 
Else 
	$host:=$document
End if 
If (($document="@ftp.@") & ($document#"ftp://@"))
	$document:="ftp://"+$document
End if 

If ($err=0)
	OPEN URL:C673($document)
Else 
	CD_Dlog (0;__ ("No fue posible abrir el documento solicitado.\rPor favor verique que se trate de un documento o página web existente."))
End if 
  //End if 