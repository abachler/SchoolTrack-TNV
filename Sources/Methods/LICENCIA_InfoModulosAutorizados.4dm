//%attributes = {}
  // LICENCIA_InfoModulosAutorizados()
  // Por: Alberto Bachler K.: 10-10-14, 15:57:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($1;$2;$3)

C_POINTER:C301($y_modulosNombre)
C_POINTER:C301($y_modulosId)
C_POINTER:C301($y_modulosAutorizado)

$y_modulosNombre:=$1
$y_modulosId:=$2
$y_modulosAutorizado:=$3


AT_Initialize ($y_modulosNombre;$y_modulosId;$y_modulosAutorizado)

APPEND TO ARRAY:C911($y_modulosNombre->;"SchoolTrack")
APPEND TO ARRAY:C911($y_modulosId->;SchoolTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (SchoolTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"MediaTrack")
APPEND TO ARRAY:C911($y_modulosId->;MediaTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (MediaTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"AccountTrack")
APPEND TO ARRAY:C911($y_modulosId->;AccountTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (AccountTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"AdmissionTrack")
APPEND TO ARRAY:C911($y_modulosId->;AdmissionTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (AdmissionTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"TransportTrack")
APPEND TO ARRAY:C911($y_modulosId->;TransportTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (TransportTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"SchoolNet")
APPEND TO ARRAY:C911($y_modulosId->;SchoolNet)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (SchoolNet))

APPEND TO ARRAY:C911($y_modulosNombre->;"SchoolCenter")
APPEND TO ARRAY:C911($y_modulosId->;SchoolCenter)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (SchoolCenter))

APPEND TO ARRAY:C911($y_modulosNombre->;"SchoolTrack Web Access")
APPEND TO ARRAY:C911($y_modulosId->;SchoolTrack Web Access)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (SchoolTrack Web Access))

APPEND TO ARRAY:C911($y_modulosNombre->;"CommTrack")
APPEND TO ARRAY:C911($y_modulosId->;CommTrack)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (CommTrack))

APPEND TO ARRAY:C911($y_modulosNombre->;"AdmissionNet")
APPEND TO ARRAY:C911($y_modulosId->;AdmissionNet)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (AdmissionNet))

APPEND TO ARRAY:C911($y_modulosNombre->;"CommTrack Light")
APPEND TO ARRAY:C911($y_modulosId->;CommTrack Light)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (CommTrack Light))

APPEND TO ARRAY:C911($y_modulosNombre->;"Edunet Matematica")
APPEND TO ARRAY:C911($y_modulosId->;Edunet Matematica)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (Edunet Matematica))

APPEND TO ARRAY:C911($y_modulosNombre->;"Edunet Lenguaje")
APPEND TO ARRAY:C911($y_modulosId->;Edunet Lenguaje)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (Edunet Lenguaje))

APPEND TO ARRAY:C911($y_modulosNombre->;"Google Apps")
APPEND TO ARRAY:C911($y_modulosId->;Google Apps)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (Google Apps))

APPEND TO ARRAY:C911($y_modulosNombre->;"DTE")
APPEND TO ARRAY:C911($y_modulosId->;DTE)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (DTE))

APPEND TO ARRAY:C911($y_modulosNombre->;"Webpay")
APPEND TO ARRAY:C911($y_modulosId->;Webpay)
APPEND TO ARRAY:C911($y_modulosAutorizado->;LICENCIA_esModuloAutorizado (Webpay))