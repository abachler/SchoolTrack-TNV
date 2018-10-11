//%attributes = {}
  //SR_GetAreaBottom

$area:=$1


$l_altoPagina:=SR_GetLongProperty ($area;1;SRP_Report_PageHeight)
$l_margenInferior:=SR_GetLongProperty ($area;1;SRP_Report_MarginBottom)
$l_margenSuperior:=SR_GetLongProperty ($area;1;SRP_Report_MarginTop)
$l_altoPagina:=$l_altoPagina-$l_margenInferior-$l_margenSuperior

$0:=$l_altoPagina


  //$err:=SR Get Section Properties ($area;SR Section Footer;$useSectioni;$printi;$Positioni;$optionsi;$throwPagei;$minSpacei;$breakTypei;$breakTablei;$breakFieldi;$breakVarNamei)
  //$posIni:=$Positioni
  //While ($err=0)
  //$err:=SR Get Section Properties ($area;SR Section Footer;$useSection;$print;$Position;$options;$throwPage;$minSpace;$breakType;$breakTable;$breakField;$breakVarName)
  //$err:=SR Set Section Properties ($area;SR Section Footer;$useSection;$print;$posIni;$options;$throwPage;$minSpace;$breakType;$breakTable;$breakField;$breakVarName)
  //$posIni:=$posIni+10
  //End while 
  //While ($err<0)
  //$err:=SR Get Section Properties ($area;SR Section Footer;$useSection;$print;$Position;$options;$throwPage;$minSpace;$breakType;$breakTable;$breakField;$breakVarName)
  //$err:=SR Set Section Properties ($area;SR Section Footer;$useSection;$print;$posIni;$options;$throwPage;$minSpace;$breakType;$breakTable;$breakField;$breakVarName)
  //$posIni:=$posIni-1
  //End while 
  //$posIni:=$posIni+1
  //$err:=SR Set Section Properties ($area;SR Section Footer;$useSectioni;$printi;$Positioni;$optionsi;$throwPagei;$minSpacei;$breakTypei;$breakTablei;$breakFieldi;$breakVarNamei)
  //$0:=$posIni