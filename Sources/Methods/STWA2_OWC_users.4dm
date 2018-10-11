//%attributes = {}
  // Método: STWA2_OWC_users
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:09:44
  // ----------------------------------------------------
  // Modificado por: Alberto Bachler Klein: 21-11-15, 12:46:52
  // Uso de Objeto 4D para generar json en reemplzo de plugin OAuth
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_tecleoPredictivoDesactivado)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_json)
C_OBJECT:C1216($ob_json)
C_BOOLEAN:C305($b_habReemplazo)

ARRAY TEXT:C222($at_usuarios;0)
$l_tecleoPredictivoDesactivado:=Num:C11(PREF_fGet (0;"DeshabillitarPredictivo";"0"))
If ($l_tecleoPredictivoDesactivado=0)
	COPY ARRAY:C226(<>atUSR_UserNames;$at_usuarios)
End if 

  //envio json con idiomas disponibles y el idioma por defecto de la BD
ARRAY TEXT:C222($at_lenguajeMenu;0)
ARRAY TEXT:C222($at_lenguajeAbrev;0)
APPEND TO ARRAY:C911($at_lenguajeMenu;"Español")
APPEND TO ARRAY:C911($at_lenguajeMenu;"English")
APPEND TO ARRAY:C911($at_lenguajeMenu;"Portugues")

Case of 
	: (<>gCountryCode="ar")
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es-AR")
		$t_countryCode:="es-AR"
	: (<>gCountryCode="cl")
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es-CL")
		$t_countryCode:="es-CL"
	: (<>gCountryCode="uy")
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es-UY")
		$t_countryCode:="es-UY"
	: (<>gCountryCode="mx")
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es-MX")
		$t_countryCode:="es-MX"
	: (<>gCountryCode="co")
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es-CO")
		$t_countryCode:="es-CO"
	Else 
		APPEND TO ARRAY:C911($at_lenguajeAbrev;"es")
		$t_countryCode:="es"
End case 

APPEND TO ARRAY:C911($at_lenguajeAbrev;"en")
APPEND TO ARRAY:C911($at_lenguajeAbrev;"pt-BR")


$ob_json:=OB_Create 
OB_SET ($ob_json;->$at_usuarios;"users")
OB_SET ($ob_json;->$at_lenguajeMenu;"lenguajeMenu")
OB_SET ($ob_json;->$at_lenguajeAbrev;"lenguajeAbrev")
OB_SET ($ob_json;->$t_countryCode;"countryCode")

$t_json:=OB_Object2Json ($ob_json)

TEXT TO BLOB:C554($t_json;$x_blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($x_blob;*)

$0:=$t_json


