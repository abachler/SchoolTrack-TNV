//%attributes = {}
  // ZIP_UnitTest()
  //
  //
  // creado por: Alberto Bachler Klein: 21-01-16, 10:28:13
  // -----------------------------------------------------------
C_TEXT:C284($t_ruta)

ARRAY TEXT:C222($at_docs;0)

$t_ruta:=Select folder:C670
$t_ruta:=ZIP_Zip (Client;$t_ruta)

$t_ruta:=Select document:C905("";".zip";"seleccionar…";0;$at_docs)
$t_ruta:=ZIP_Unzip (Client;$at_docs{1})

$t_ruta:=Select document:C905("";"*";"seleccionar…";0;$at_docs)
$t_ruta:=ZIP_Zip (Client;$at_docs{1})
$t_ruta:=ZIP_Unzip (Client;$t_ruta)


