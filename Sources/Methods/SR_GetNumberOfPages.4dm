//%attributes = {}
  //SR_GetNumberOfPages


$Process:=IT_UThermometer (1;0;__ ("Calculando numero de páginas..."))
vi_Pages:=SR Get Number Of Pages (xSR_ReportBlob;7;0)
IT_UThermometer (-2;$Process)
$0:=vi_Pages