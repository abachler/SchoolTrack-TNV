//%attributes = {}

C_BOOLEAN:C305($sn_activo;$1)

If (Count parameters:C259=1)
	$sn_activo:=$1
End if 

C_TEXT:C284($resultado)
For ($i;Size of array:C274(SN3_GAFE_Alu_IDNiveles);1;-1)
	$el:=Find in array:C230(<>al_NumeroNivelesSchoolNet;SN3_GAFE_Alu_IDNiveles{$i})
	If ($el=-1)
		AT_Delete ($i;1;->SN3_GAFE_Alu_IDNiveles;->SN3_GAFE_Alu_Mail;->SN3_GAFE_Alu_Drive;->SN3_GAFE_Alu_Cal)
	End if 
End for 
SN3_SaveGAFESettings 

$go:=False:C215
If (SN3_CheckNotColegium )
	$go:=True:C214
Else 
	$r:=CD_Dlog (0;__ ("Al parecer usted está trabajando en Colegium o la versión no está compilada. ¿Desea enviar las configuraciones al servidor de SchoolNet?");__ ("");__ ("No");__ ("Si"))
	$go:=($r=2)
End if 
If ($go)
	WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
	WEB SERVICE SET PARAMETER:C777("rol";<>gRolBD)
	
	WEB SERVICE SET PARAMETER:C777("tipousuario_relfam";SN3_LoginTypeSelGAFE)
	WEB SERVICE SET PARAMETER:C777("tipousuario_alu";SN3_LoginTypeSelAluGAFE)
	WEB SERVICE SET PARAMETER:C777("tipousuario_prof";SN3_LoginTypeSelProfGAFE)
	
	WEB SERVICE SET PARAMETER:C777("relfam_disponible";cb_GAFE_RelFam)
	WEB SERVICE SET PARAMETER:C777("relfam_mail";cb_GAFE_RelFam_Mail)
	WEB SERVICE SET PARAMETER:C777("relfam_drive";cb_GAFE_RelFam_Drive)
	WEB SERVICE SET PARAMETER:C777("relfam_cal";cb_GAFE_RelFam_Cal)
	
	WEB SERVICE SET PARAMETER:C777("prof_disponible";cb_GAFE_Prof)
	WEB SERVICE SET PARAMETER:C777("prof_mail";cb_GAFE_Prof_Mail)
	WEB SERVICE SET PARAMETER:C777("prof_drive";cb_GAFE_Prof_Drive)
	WEB SERVICE SET PARAMETER:C777("prof_cal";cb_GAFE_Prof_Cal)
	
	WEB SERVICE SET PARAMETER:C777("alu_disponible";cb_GAFE_Alu)
	WEB SERVICE SET PARAMETER:C777("alu_niveles";SN3_GAFE_Alu_IDNiveles)
	WEB SERVICE SET PARAMETER:C777("alu_mail";SN3_GAFE_Alu_Mail)
	WEB SERVICE SET PARAMETER:C777("alu_drive";SN3_GAFE_Alu_Drive)
	WEB SERVICE SET PARAMETER:C777("alu_cal";SN3_GAFE_Alu_Cal)
	
	$p:=IT_UThermometer (1;0;__ ("Enviando configuraciones GAFE a SchoolNet..."))
	$err:=SN3_CallWebService ("sn3ws_configuracionesGafe_proceso.configura")
	IT_UThermometer (-2;$p)
	If ($err="")
		WEB SERVICE GET RESULT:C779($resultado;"resultado";*)
		If ($resultado#"")
			CD_Dlog (0;__ ("Se ha producido un error al almacenar la configuración GAFE en SchoolNet. Por favor intente otra vez más tarde."))
			SN3_RegisterLogEntry (SN3_Log_Error;"Error al almacenar la configuración GAFE en SchoolNet.";-1)
		Else 
			SN3_RegisterLogEntry (SN3_Log_Info;"Configuraciones GAFE almacenadas correctamente.")
		End if 
	Else 
		SET TEXT TO PASTEBOARD:C523($err)
		CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
		SN3_RegisterLogEntry (SN3_Log_Error;"No se pudo establecer la conexión con SchoolNet.";-1;$err)
	End if 
	
	If ($sn_activo)
		C_LONGINT:C283($l_process_idgafe)
		$l_process_idgafe:=Execute on server:C373("GAFE_Send_SN_Usr";128000;"Envio de Datos SN usr para GAFE")
	End if 
	
	GAFESettingsModificados:=False:C215
End if 