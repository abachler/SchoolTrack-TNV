//%attributes = {}
  // XLS_unitTest()
  //
  //
  // creado por: Alberto Bachler Klein: 18-01-16, 18:06:16
  // -----------------------------------------------------------
C_LONGINT:C283($l_bookRef;$l_error;$l_sheetRef)
C_TEXT:C284($t_rutaDocumento)

ARRAY BOOLEAN:C223($ab_columna4;0)
ARRAY DATE:C224($ad_columna3;0)
ARRAY POINTER:C280($ay_columnas;0)
ARRAY REAL:C219($ar_columna2;0)
ARRAY TEXT:C222($at_columna1;0)
ARRAY TEXT:C222($at_encabezados;0)

APPEND TO ARRAY:C911($at_columna1;"fila 1")
APPEND TO ARRAY:C911($at_columna1;"fila 2")
APPEND TO ARRAY:C911($at_columna1;"fila 3")

APPEND TO ARRAY:C911($ar_columna2;1000)
APPEND TO ARRAY:C911($ar_columna2;3.1416)
APPEND TO ARRAY:C911($ar_columna2;MAXLONG:K35:2)

APPEND TO ARRAY:C911($ad_columna3;Current date:C33)
APPEND TO ARRAY:C911($ad_columna3;Current date:C33-100)

APPEND TO ARRAY:C911($ab_columna4;True:C214)
APPEND TO ARRAY:C911($ab_columna4;False:C215)
APPEND TO ARRAY:C911($ab_columna4;True:C214)
APPEND TO ARRAY:C911($ab_columna4;False:C215)
APPEND TO ARRAY:C911($ab_columna4;True:C214)

APPEND TO ARRAY:C911($at_encabezados;"Texto")
APPEND TO ARRAY:C911($at_encabezados;"Numérico")
APPEND TO ARRAY:C911($at_encabezados;"Fecha")
APPEND TO ARRAY:C911($at_encabezados;"Booleano")

APPEND TO ARRAY:C911($ay_columnas;->$at_columna1)
APPEND TO ARRAY:C911($ay_columnas;->$ar_columna2)
APPEND TO ARRAY:C911($ay_columnas;->$ad_columna3)
APPEND TO ARRAY:C911($ay_columnas;->$ab_columna4)

$l_bookRef:=XLS_CreateBook 
$l_sheetRef:=XLS_CreateSheet ($l_bookRef;"Test 4D to XLS")
XLS_SetColumns ($l_sheetRef;->$ay_columnas;->$at_encabezados)

$t_rutaDocumento:=Temporary folder:C486+Generate UUID:C1066+".xls"
$l_error:=XLS_SaveDocument ($l_bookRef;$t_rutaDocumento)
XLS_ClearSheet ($l_sheetRef)
XLS_ClearBook ($l_bookRef)

SHOW ON DISK:C922($t_rutaDocumento)
OPEN URL:C673($t_rutaDocumento)