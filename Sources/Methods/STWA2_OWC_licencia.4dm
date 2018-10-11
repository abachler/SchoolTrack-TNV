//%attributes = {}
  // Método: STWA2_OWC_licencia
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:10:11
  // ----------------------------------------------------
  // Modificado por: Alberto Bachler Klein: 21-11-15, 12:52:12
  // Uso de Objeto 4D para generar json en reemplazo de plugin OAuth o componente JSON
  //  ---------------------------------------------  
C_TEXT:C284($0)
C_BLOB:C604($blob)
C_OBJECT:C1216($ob_json)
$t_version:="v"+SYS_LeeVersionEstructura 
$b_conLicenciaMediatrack:=LICENCIA_esModuloAutorizado (1;MediaTrack)
$b_conLicenciaSTWA:=LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access)

$ob_json:=OB_Create 
OB_SET ($ob_json;->$b_conLicenciaMediatrack;"licenciaMT")
OB_SET ($ob_json;->$b_conLicenciaSTWA;"licenciaSTWA")
OB_SET ($ob_json;->$t_version;"version")
$t_json:=OB_Object2Json ($ob_json)

TEXT TO BLOB:C554($t_json;$blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($blob;*)
$0:=$t_json

