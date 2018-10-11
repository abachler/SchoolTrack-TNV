//%attributes = {}
  // INET_Conectado()
  // Por: Alberto Bachler: 06/08/13, 09:07:07
  //  ---------------------------------------------
  // En MacOS X, si no se pasan parametros en se testea contra los servidor locales de Google para el país correspondiente al país usuario
  // o contra google.com (los servidores de google fueron los que me dieron respuestas más rápidas)
  // Bajo Windows se utiliza un comando de Win32
  // Si se recibe una URL en $1 se verifica la conexión a esa URL
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($l_error;$l_Idconexion)
C_TEXT:C284($t_url)



If (False:C215)
	C_BOOLEAN:C305(INET_Conectado ;$0)
End if 
C_BOOLEAN:C305(<>bXS_esServidorOficial)


If (Count parameters:C259=1)
	$t_url:=$1
	$0:=INET_IsHostAvailable ($t_url)
	
	
Else 
	Case of 
		: (Not:C34(<>bXS_esServidorOficial))
			$t_url:="google.cl"
		: (<>gCountryCode="cl")
			$t_url:="google.cl"
		: (<>gCountryCode="ar")
			$t_url:="google.com.ar"
		: (<>gCountryCode="mx")
			$t_url:="google.mx"
		: (<>gCountryCode="pe")
			$t_url:="google.com.pe"
		: (<>gCountryCode="co")
			$t_url:="google.com.co"
		: (<>gCountryCode="br")
			$t_url:="google.com.br"
		Else 
			$t_url:="google.com"
	End case 
	$0:=INET_IsHostAvailable ($t_url;80)
End if 


