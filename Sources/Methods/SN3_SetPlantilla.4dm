//%attributes = {}
C_TEXT:C284($resultado)
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
WEB SERVICE SET PARAMETER:C777("idplantilla";vPlantillaSel)

$err:=SN3_CallWebService ("sn3ws_plantillas_proceso.establecer")

If ($err="")
	WEB SERVICE GET RESULT:C779($resultado;"resultado";*)
	If ($resultado="-1")
		CD_Dlog (0;__ ("No se pudo establecer la plantilla para el colegio. Por favor intente más tarde."))
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 