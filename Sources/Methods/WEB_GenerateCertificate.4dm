//%attributes = {"executedOnServer":true}
  // WEB_GenerateCertificate()
  //
  //
  // creado por: ??
  // -----------------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($b_ejecutado)
C_LONGINT:C283($l_days;$l_proceso;$ok)
C_TEXT:C284($t_dominio;$t_localidad;$t_mensajeError;$t_organizacion;$t_pais;$t_provincia;$t_retorno;$t_rutaCertificado;$t_rutaLlave;$t_rutaScript)
C_TEXT:C284($t_unidadOrganizacional)


If (False:C215)
	C_TEXT:C284(WEB_GenerateCertificate ;$1)
End if 

$t_rutaScript:=Get 4D folder:C485(Current resources folder:K5:16)+"Php_lib"+Folder separator:K24:12+"certGen.php"

$l_days:=5475  //15 años!!!
$t_rutaCertificado:=Convert path system to POSIX:C1106(Get 4D folder:C485(Database folder:K5:14)+"cert.pem")
$t_rutaLlave:=Convert path system to POSIX:C1106(Get 4D folder:C485(Database folder:K5:14)+"key.pem")
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
$t_pais:=[Colegio:31]Codigo_Pais:31
$t_provincia:=[Colegio:31]Provincia:5
$t_localidad:=[Colegio:31]Ciudad:6
$t_organizacion:=Substring:C12([Colegio:31]Nombre_Colegio:1;1;63)
$t_unidadOrganizacional:="Colegio"

$t_dominio:=$1

  //realizo validación de campos
$t_mensajeError:=""
If ($t_pais="")
	$t_mensajeError:=$t_mensajeError+"• "+__ ("País.")+"\r"
End if 
If ($t_provincia="")
	$t_mensajeError:=$t_mensajeError+"• "+__ ("Provincia.")+"\r"
	$ok:=0
End if 
If ($t_localidad="")
	$t_mensajeError:=$t_mensajeError+"• "+__ ("Ciudad.")+"\r"
	$ok:=0
End if 
If ($t_organizacion="")
	$t_mensajeError:=$t_mensajeError+"• "+__ ("Nombre del colegio.")+"\r"
	$ok:=0
End if 


If ($t_mensajeError="")
	$l_proceso:=IT_UThermometer (1;0;__ ("Generado archivos de certificado y llave privada…");-1)
	$b_ejecutado:=PHP Execute:C1058($t_rutaScript;"creaCert";$t_retorno;$l_days;$t_rutaCertificado;$t_rutaLlave;$t_pais;$t_provincia;$t_localidad;$t_organizacion;$t_unidadOrganizacional;$t_dominio)
	IT_UThermometer (-2;$l_proceso)
	If (Not:C34($b_ejecutado))
		CD_Dlog (0;__ ("Se produjo un problema en la creación de los certificados.")+"\r"+__ ("Inténtelo nuevamente o contacte a nuestra Mesa de Ayuda."))
	End if 
Else 
	$t_mensajeError:=__ ("Para poder generar los certificados correctamente se deben completar los siguientes campos en la configuración: ")+"\r\r"+$t_mensajeError+"\r\r"+__ ("Los certificados no se han creado.")
	CD_Dlog (0;$t_mensajeError)
End if 