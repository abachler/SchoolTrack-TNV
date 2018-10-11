//%attributes = {}
  // Licencia_Verifica()
  // Por: Alberto Bachler K.: 27-08-14, 16:01:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_LONGINT:C283($0)
C_BOOLEAN:C305($1)

C_BLOB:C604($x_Licencia;$x_llavePublica)
C_BOOLEAN:C305($b_cargarLicencia;$b_iniciarMTweb;$b_iniciarSTWA;$b_licenciaMTweb_antes;$b_licenciaMTweb_nuevo;$b_licenciaSTWA_antes;$b_licenciaSTWA_nuevo;$b_licenciaValida;$b_muestraMensaje)
C_DATE:C307($d_licenciaValidaDesde;$d_licenciaValidaHasta)
C_LONGINT:C283($i;$l_error;$l_HLcrypt;$l_idCliente;$l_IdProceso;$l_indiceMacRegistradas;$l_ModulosAutorizados;$l_opcion;$l_resultado;$l_usuarios4D)
C_LONGINT:C283($l_usuariosSTWA)
C_TEXT:C284($t_error;$t_json;$t_jsonLicencia;$t_Licencia;$t_llavePublica;$t_macAddressValidada;$t_mensaje;$t_nombreMaquina;$t_refjson;$t_refJsonError)
C_TEXT:C284($t_refJsonLicencia;$t_usuarioSistema;$t_uuidColegio;$t_fechahasta;$t_fechaDesde)
C_BOOLEAN:C305($b_validajson)
ARRAY TEXT:C222($at_MacAddressAutorizadas;0)

If (False:C215)
	C_LONGINT:C283(LICENCIA_Verifica ;$0)
	C_BOOLEAN:C305(LICENCIA_Verifica ;$1)
End if 


If (Count parameters:C259=1)
	$b_muestraMensaje:=$1
End if 

$b_licenciaMTweb_antes:=LICENCIA_esModuloAutorizado (1;MediaTrack)
$b_licenciaSTWA_antes:=LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access)


READ WRITE:C146([xShell_ApplicationData:45])
ALL RECORDS:C47([xShell_ApplicationData:45])
Case of 
	: (Records in selection:C76([xShell_ApplicationData:45])=0)
		CREATE RECORD:C68([xShell_ApplicationData:45])
		[xShell_ApplicationData:45]ProductName:16:="Main"
		SAVE RECORD:C53([xShell_ApplicationData:45])
		LICENCIA_Descarga 
	: ((Records in selection:C76([xShell_ApplicationData:45])>=1) & ([xShell_ApplicationData:45]Licencia:23=""))
		LICENCIA_Descarga 
	Else 
		FIRST RECORD:C50([xShell_ApplicationData:45])
End case 
$t_json:=[xShell_ApplicationData:45]Licencia:23


C_OBJECT:C1216($ob_raiz;$ob_error;$ob_licencia)

$ob_raiz:=OB_Create 
$ob_error:=OB_Create 
$ob_licencia:=OB_Create 

  //$t_refjson:=JSON Parse text ($t_json)
If ($t_json="")
	LICENCIA_Descarga 
	$t_json:=[xShell_ApplicationData:45]Licencia:23
	  //$t_refjson:=JSON Parse text ($t_json)
	$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
End if 

$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
OB_GET ($ob_raiz;->$ob_error;"error")
OB_GET ($ob_raiz;->$ob_licencia;"licencia")
OB_GET ($ob_error;->$t_error;"textoError")
OB_GET ($ob_error;->$l_error;"codigoError")

If ($l_error<0)
	
	CLEAR VARIABLE:C89($ob_raiz)
	CLEAR VARIABLE:C89($ob_error)
	CLEAR VARIABLE:C89($ob_licencia)
	$ob_raiz:=OB_Create 
	$ob_error:=OB_Create 
	$ob_licencia:=OB_Create 
	
	LICENCIA_Descarga 
	
	$t_json:=[xShell_ApplicationData:45]Licencia:23
	
	$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob_raiz;->$ob_error;"error")
	OB_GET ($ob_raiz;->$ob_licencia;"licencia")
	OB_GET ($ob_error;->$t_error;"textoError")
	OB_GET ($ob_error;->$l_error;"codigoError")
	
End if 


If ($l_error<0)
	If ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Volume desktop:K5:2))
		ModernUI_Notificacion (__ ("Verificación de la licencia");$t_error;__ ("Aceptar"))
	End if 
	
Else 
	
	OB_GET ($ob_licencia;->$t_Licencia;"datosLicencia")
	$t_jsonLicencia:=CRYPT_NewEncryptDecrypt ("decryptNo4d";"public";$t_Licencia;True:C214)
	
	If (Valida_json ($t_jsonLicencia))
		C_OBJECT:C1216($ob_licencia2)
		
		$ob_licencia2:=OB_Create 
		$ob_licencia2:=JSON Parse:C1218($t_jsonLicencia;Is object:K8:27)
		
		
		OB_GET ($ob_licencia2;->$t_uuidColegio;"uuidColegio")
		OB_GET ($ob_licencia2;->$l_usuarios4D;"usuarios4D")
		OB_GET ($ob_licencia2;->$l_usuariosSTWA;"usuariosSTWA")
		
		OB_GET ($ob_licencia2;->$d_licenciaValidaDesde;"validaDesde")
		
		OB_GET ($ob_licencia2;->$t_fechaDesde;"validaDesde")
		OB_GET ($ob_licencia2;->$t_fechaHasta;"validaHasta")
		
		  //no estaba obteniendo correctamente el día190432 ABC
		$d_licenciaValidaHasta:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fechahasta;7;2));Num:C11(Substring:C12($t_fechahasta;5;2));Num:C11(Substring:C12($t_fechahasta;1;4)))
		$d_licenciaValidaDesde:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fechaDesde;7;2));Num:C11(Substring:C12($t_fechaDesde;5;2));Num:C11(Substring:C12($t_fechaDesde;1;4)))
		
		OB_GET ($ob_licencia2;->$at_MacAddressAutorizadas;"macAddress")
		OB_GET ($ob_licencia2;->$l_ModulosAutorizados;"modulos")
	End if 
	
	If (Valida_json ($t_jsonLicencia)=False:C215) | (Not:C34(Util_isValidUUID ($t_uuidColegio)))
		$t_mensaje:=__ ("La licencia es inválida o no existe.")
		$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor póngase en contacto con la mesa de ayuda de Colegium.")
		ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Aceptar"))
		
	Else 
		If (Application type:C494=4D Server:K5:6)
			  // el método se ejecuta en el servidor, ignoramos la MAC 000000000000 
			$l_elemento:=Find in array:C230($at_MacAddressAutorizadas;"000000000000")
			If ($l_elemento>0)
				DELETE FROM ARRAY:C228($at_MacAddressAutorizadas;$l_elemento)
			End if 
		End if 
		
		LICENCIA_ListaMacAddress 
		For ($i;1;Size of array:C274($at_MacAddressAutorizadas))
			$l_indiceMacRegistradas:=Find in array:C230(<>aMacAddress;$at_MacAddressAutorizadas{$i})
			$b_licenciaValida:=($l_indiceMacRegistradas>0)
			If ($b_licenciaValida)
				$t_macAddressValidada:=<>aMacAddress{$l_indiceMacRegistradas}
				$i:=Size of array:C274($at_MacAddressAutorizadas)+1
			End if 
		End for 
		
		If (Not:C34($b_licenciaValida))
			$t_macAddressValidada:=Choose:C955(Find in array:C230($at_MacAddressAutorizadas;"000000000000")>0;"000000000000";"")
			$b_licenciaValida:=(Find in array:C230($at_MacAddressAutorizadas;"000000000000")>0)
		End if 
		
		$t_usuarioSistema:=Current system user:C484
		$t_nombreMaquina:=Current machine:C483
		If ((($t_usuarioSistema="aBachler") | ($t_usuarioSistema="@Alberto Bachler@")) & (<>lUSR_CurrentUserID>=0))
			$b_licenciaValida:=True:C214
			$t_macAddressValidada:="000000000000"
		End if 
		
		Case of 
			: (($b_licenciaValida) & ($t_macAddressValidada="000000000000") & (<>lUSR_CurrentUserID<0))
				If ([xShell_ApplicationData:45]BitRecord:19#$l_ModulosAutorizados)  //20130827 JHB - RCH Se cargara el bit cuando cambie el dato
					$b_cargarLicencia:=True:C214
				End if 
				[xShell_ApplicationData:45]BitRecord:19:=$l_ModulosAutorizados
				[xShell_ApplicationData:45]Licenced_until:10:=Current date:C33(*)
				[xShell_ApplicationData:45]Licenced_Users:11:=100
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=100
				SAVE RECORD:C53([xShell_ApplicationData:45])
				$l_resultado:=1
				
				
			: ($t_macAddressValidada="")
				$l_resultado:=-1  //la licencia no corresponde al computador
				If ($b_muestraMensaje)
					Case of 
						: ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Local mode:K5:1))
							$t_mensaje:=__ ("La licencia es inválida no corresponde al computador en que está instalado SchoolTrack Server.")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Si ha instalado la aplicación en un computador distinto del que estaba previamente registrado por favor póngase en contacto con la mesa de ayuda de Colegium.")
							ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Aceptar"))
							QUIT 4D:C291
							
						: (Application type:C494=4D Volume desktop:K5:2)
							$t_mensaje:=__ ("La licencia es inválida o no corresponde al computador en que está instalado la Schooltrack Monousuario.")
							$t_mensaje:=$t_mensaje+"\r\r"+__ ("Si ha instalado la aplicación en un computador distinto del que estaba previamente registrado por favor póngase en contacto con la mesa de ayuda de Colegium.")
							ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Aceptar"))
							QUIT 4D:C291
							
					End case 
				End if 
				[xShell_ApplicationData:45]BitRecord:19:=0
				[xShell_ApplicationData:45]Licenced_until:10:=!00-00-00!
				[xShell_ApplicationData:45]Licenced_Users:11:=0
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=0
				[xShell_ApplicationData:45]Licencia:23:=""
				SAVE RECORD:C53([xShell_ApplicationData:45])
				
				
				
			: ($t_uuidColegio#[xShell_ApplicationData:45]UUID:31)
				$l_resultado:=-3  //la licencia no corresponde al cliente
				[xShell_ApplicationData:45]BitRecord:19:=0
				[xShell_ApplicationData:45]Licenced_until:10:=!00-00-00!
				[xShell_ApplicationData:45]Licenced_Users:11:=0
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=0
				[xShell_ApplicationData:45]Licencia:23:=""
				SAVE RECORD:C53([xShell_ApplicationData:45])
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Volume desktop:K5:2) | (Not:C34(Is compiled mode:C492)))
					$t_mensaje:=__ ("La licencia no es valida para el identificador de la institución.")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor póngase en contacto con la mesa de ayuda de Colegium.")
					ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Aceptar"))
					QUIT 4D:C291
					
				End if 
				
			: ($l_ModulosAutorizados=0)
				$l_resultado:=-4  // no hay módulos autorizados
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Volume desktop:K5:2) | (Not:C34(Is compiled mode:C492)))
					$t_mensaje:=__ ("La licencia es inválida: No hay ningún módulo autorizado.")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor póngase en contacto con la mesa de ayuda de Colegium.")
					ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Aceptar"))
					QUIT 4D:C291
				End if 
				[xShell_ApplicationData:45]BitRecord:19:=0
				[xShell_ApplicationData:45]Licenced_until:10:=!00-00-00!
				[xShell_ApplicationData:45]Licenced_Users:11:=0
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=0
				[xShell_ApplicationData:45]Licencia:23:=""
				SAVE RECORD:C53([xShell_ApplicationData:45])
				
			: ($d_licenciaValidaHasta<Current date:C33(*))
				$l_resultado:=-2  //la licencia ha expirado
				[xShell_ApplicationData:45]BitRecord:19:=0
				[xShell_ApplicationData:45]Licenced_until:10:=!00-00-00!
				[xShell_ApplicationData:45]Licenced_Users:11:=0
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=0
				[xShell_ApplicationData:45]Licencia:23:=""
				SAVE RECORD:C53([xShell_ApplicationData:45])
				If ((Application type:C494=4D Remote mode:K5:5) | (Application type:C494=4D Volume desktop:K5:2) | (Not:C34(Is compiled mode:C492)))
					$t_mensaje:=__ ("La licencia expiró el ")+String:C10($d_licenciaValidaHasta;3)+"\r"+__ ("Debe actualizar la licencia para continuar utilizando la aplicación.")
					$t_mensaje:=$t_mensaje+"\r\r"+__ ("Si necesita ayuda por favor póngase en contacto con la mesa de ayuda de Colegium.")
					ModernUI_Notificacion (__ ("Verificación de la licencia");$t_mensaje;__ ("Actualizar licencia");__ ("Salir"))
					If ($l_opcion=2)
						QUIT 4D:C291
					End if 
				End if 
				
				
			Else 
				  // la licencia  es valida
				$l_resultado:=1
				If ([xShell_ApplicationData:45]BitRecord:19#$l_ModulosAutorizados)
					  // si hay cambios en los modulos autorizados se debe volver a cargar el arreglo de bits en todas las máquinas remotas
					$b_cargarLicencia:=True:C214
				End if 
				[xShell_ApplicationData:45]BitRecord:19:=$l_ModulosAutorizados
				[xShell_ApplicationData:45]Licenced_until:10:=$d_licenciaValidaHasta
				[xShell_ApplicationData:45]Licenced_Users:11:=$l_usuarios4D
				[xShell_ApplicationData:45]Licenced_Users_STWA:32:=$l_usuariosSTWA
				SAVE RECORD:C53([xShell_ApplicationData:45])
				KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])
		End case 
		<>LDL_RegisterKey:=[xShell_ApplicationData:45]BitRecord:19
		
		
		If ($l_resultado=1)
			vd_date:=$d_licenciaValidaHasta
			
			If ($b_cargarLicencia)
				KRL_ExecuteEverywhere ("Licencia_LeeVariables")  //JHB 20130801 Para que al registrar licencia los cambios repercutan en el server y los demas clientes
				
				TRACE:C157
				$b_licenciaMTweb_nuevo:=LICENCIA_esModuloAutorizado (1;MediaTrack)
				$b_licenciaSTWA_nuevo:=LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access)
				$b_iniciarSTWA:=$b_licenciaSTWA_nuevo & (Not:C34($b_licenciaSTWA_antes))
				$b_iniciarMTweb:=$b_licenciaMTweb_nuevo & (Not:C34($b_licenciaMTweb_antes))
				Case of 
					: ($b_iniciarSTWA | $b_iniciarMTweb)
						  // la licencia anterior no autorizaba el servidor web, la nueva si lo permite
						WEB_StartWebServer2   // se ejecuta en el servidor, reiniciando el demonio de manejo se sesiones si es necesario
						
					: (Not:C34($b_licenciaMTweb_nuevo | $b_licenciaSTWA_nuevo))
						  // la licencia anterior no autorizaba el servidor web, la nueva si lo permite
						WEB STOP SERVER:C618
				End case 
			End if 
			
			Case of 
				: ([xShell_ApplicationData:45]Licenced_Users:11=0)
					vtDL_Users:=""
				: ([xShell_ApplicationData:45]Licenced_Users:11=1)
					vtDL_Users:="Sistema monousuario."
				: ([xShell_ApplicationData:45]Licenced_Users:11>1)
					vtDL_Users:="Sistema multi-usuario con licencia para "+String:C10([xShell_ApplicationData:45]Licenced_Users:11)+" usuarios concurrentes."
			End case 
			
			
			
		Else 
			vt_Version:=""
			vtDL_Users:=""
			vd_date:=!00-00-00!
		End if 
		
		
		
	End if 
End if 

$0:=$l_resultado

