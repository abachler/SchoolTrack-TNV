//%attributes = {}
  //SN3_AskForUsersList

SN3_LoadUsersSettings 
$result:=""
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
WEB SERVICE SET PARAMETER:C777("todos";h1_Todos)
WEB SERVICE SET PARAMETER:C777("nuevos";h2_SoloNuevos)
WEB SERVICE SET PARAMETER:C777("menor";r1_AgruparCursoMenor)
WEB SERVICE SET PARAMETER:C777("mayor";r2_AgruparCursoMayor)
WEB SERVICE SET PARAMETER:C777("mail";SN3_MailAddress)
WEB SERVICE SET PARAMETER:C777("xls";cb_FormatoXLS)
WEB SERVICE SET PARAMETER:C777("pdf";cb_FormatoPDF)

$err:=SN3_CallWebService ("sn3ws_listado_usuarios.listado")

If ($err="")
	WEB SERVICE GET RESULT:C779($result;"resultado";*)
	If ($result="1")
		CD_Dlog (0;__ ("La lista de usuarios fue solicitada. En los próximos minutos debe recibirlas por eMail (en la cuenta ")+SN3_MailAddress+__ (")."))
	Else 
		Case of 
			: ($result="-1")
				CD_Dlog (0;__ ("No se especificó cuales usuarios deben incluirse en la lista."))
			: ($result="-2")
				CD_Dlog (0;__ ("No se especificó el formato en que requiere la lista."))
		End case 
	End if 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 