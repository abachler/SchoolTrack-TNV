//%attributes = {}
  // Licencia_Inicio()
  // Por: Alberto Bachler K.: 29-08-14, 12:05:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_LONGINT:C283($l_error;$l_resultadoVerificacionLicencia)
C_TEXT:C284($t_informacionesRed;$t_mensajeError;$t_nombreDominio;$t_nombreMaquina_OS;$t_nombreUsuario_OS)

ARRAY TEXT:C222($at_informacionesRed;0)

HLPR_DLParameters 

READ ONLY:C145([xShell_ApplicationData:45])
QUERY:C277([xShell_ApplicationData:45];[xShell_ApplicationData:45]ProductName:16="Main")
If (Records in selection:C76([xShell_ApplicationData:45])=0)
	CREATE RECORD:C68([xShell_ApplicationData:45])
	[xShell_ApplicationData:45]ProductName:16:="Main"
	[xShell_ApplicationData:45]ProductNumber:1:="xxx"
	SAVE RECORD:C53([xShell_ApplicationData:45])
	KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])
End if 

If (SYS_IsWindows )
	$l_error:=sys_GetNetworkInfo ($t_informacionesRed)
	AT_Text2Array (->$at_informacionesRed;$t_informacionesRed;",")
	If (Size of array:C274($at_informacionesRed)>=2)  //Para evitar errores en windows 98 No segunda edicion
		$t_nombreDominio:=$at_informacionesRed{2}
	Else 
		$t_nombreDominio:=""
	End if 
Else 
	$t_nombreDominio:=""
End if 
$t_nombreUsuario_OS:=Current system user:C484
$t_nombreMaquina_OS:=Current machine:C483

If (($t_nombreUsuario_OS#"aBachler") & ($t_nombreUsuario_OS#"Alberto Bachler") & ($t_nombreMaquina_OS#"Colegium-@") & ($t_nombreDominio#"lester.colegium.com") & ($t_nombreMaquina_OS#"U2"))
	If ((<>lUSR_CurrentUserID>0) | (Application type:C494=4D Server:K5:6))
		If (<>b_CheckActivationKey)
			TRACE:C157
			If (Application type:C494#4D Server:K5:6)
				$l_resultadoVerificacionLicencia:=LICENCIA_Verifica (False:C215)
				Case of 
					: ($l_resultadoVerificacionLicencia<=0)
						LICENCIA_Registro 
						
				End case 
				
			Else 
				$t_mensajeError:=LICENCIA_Descarga 
				If ($t_mensajeError="")
					$l_resultadoVerificacionLicencia:=LICENCIA_Verifica (False:C215)
				Else 
					ALERT:C41($t_mensajeError)
				End if 
			End if 
		End if 
	End if 
End if 

READ ONLY:C145([xShell_ApplicationData:45])
QUERY:C277([xShell_ApplicationData:45];[xShell_ApplicationData:45]ProductName:16="Main")
FIRST RECORD:C50([xShell_ApplicationData:45])
<>vtXS_CountryCode:=[xShell_ApplicationData:45]Código_Pais:26
<>LDL_RegisterKey:=[xShell_ApplicationData:45]BitRecord:19
KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])

If (<>vtXS_CountryCode="")
	<>vtXS_CountryCode:="cl"
End if 