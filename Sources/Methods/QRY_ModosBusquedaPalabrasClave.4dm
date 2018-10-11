//%attributes = {}
  // QRY_ModosBusquedaPalabrasClave()
  // Por: Alberto Bachler: 10/10/13, 16:38:14
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_POINTER:C301($y_modoComparacion_at;$y_refModoComparacion_al)
$y_modoComparacion_at:=$1
$y_refModoComparacion_al:=$2


ARRAY TEXT:C222($y_modoComparacion_at->;0)
ARRAY LONGINT:C221($y_refModoComparacion_al->;0)


ARRAY TEXT:C222($y_modoComparacion_at->;0)
ARRAY LONGINT:C221($y_refModoComparacion_al->;0)

APPEND TO ARRAY:C911($y_modoComparacion_at->;__ ("Contiene todas las palabras"))
APPEND TO ARRAY:C911($y_refModoComparacion_al->;Contiene todas las palabras)

APPEND TO ARRAY:C911($y_modoComparacion_at->;__ ("Contiene alguna de las palabras"))
APPEND TO ARRAY:C911($y_refModoComparacion_al->;Contiene alguna de las palabras)

APPEND TO ARRAY:C911($y_modoComparacion_at->;__ ("Comienza con"))
APPEND TO ARRAY:C911($y_refModoComparacion_al->;Comienza con)

APPEND TO ARRAY:C911($y_modoComparacion_at->;__ ("Es exactamente"))
APPEND TO ARRAY:C911($y_refModoComparacion_al->;Es exactamente)


