//%attributes = {}
  //prueba tres veces si podemos enviar archivos...
C_LONGINT:C283($0;$SN3_AllowedCounter)

If (Count parameters:C259=0)
	$SN3_AllowedCounter:=1
Else 
	$SN3_AllowedCounter:=$1
End if 

$0:=-1
$result:=""
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)

$err:=SN3_CallWebService ("sn3ws_consulta_archivos_ftp.consultaArchivos")

If ($err="")
	WEB SERVICE GET RESULT:C779($result;"resultado";*)
	If ($result="false")
		$0:=1
	Else 
		If ($SN3_AllowedCounter<3)
			$SN3_AllowedCounter:=$SN3_AllowedCounter+1
			DELAY PROCESS:C323(Current process:C322;30)
			$0:=SN3_IsAllowed2Send ($SN3_AllowedCounter)
		End if 
	End if 
Else 
	$0:=0
End if 