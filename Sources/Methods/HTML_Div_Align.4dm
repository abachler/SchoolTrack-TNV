//%attributes = {}
  //HTML_Div_Align

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 12/06/06, 15:13:39
  // ----------------------------------------------------
  // Método: HTML_Div_Align
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$vt_Aligment)  //left, center, right, justify
C_TEXT:C284($2;$vt_DataInside)
C_TEXT:C284($3;$vt_MoreSettings)
C_TEXT:C284($0;$vt_Result)

$vt_Aligment:=$1
$vt_DataInside:=$2
If (Count parameters:C259=3)
	$vt_MoreSettings:=$3
End if 

  //Case of 
  //: (Count parameters=2)
  //$vt_DivOpen:="<div align="+"+"+">"
  //$vt_DivClose:="</div>"
  //
  //$vt_DivOpen:=Replace string($vt_DivOpen;"+";ST_Qte ($vt_Aligment))
  //
  //$vt_DivAligment:=$vt_DivOpen+$vt_DataInside+$vt_DivClose
  //
  //$vt_Result:=$vt_DivAligment
  //: (Count parameters=3)
  //$vt_DivOpen:="<div align="+"+"+">"
  //$vt_DivClose:="</div>"
  //
  //$vt_DivOpen:=Replace string($vt_DivOpen;"+";ST_Qte ($vt_Aligment)+$vt_MoreSettings)
  //$vt_DivAligment:=$vt_DivOpen+$vt_DataInside+$vt_DivClose
  //$vt_Result:=$vt_DivAligment
  //End case 

$vt_DivOpen:="<div align="+"+"+">"
$vt_DivClose:="</div>"

$vt_DivOpen:=Replace string:C233($vt_DivOpen;"+";ST_Qte ($vt_Aligment))

$vt_DivAligment:=$vt_DivOpen+$vt_DataInside+$vt_DivClose

$vt_Result:=$vt_DivAligment

$0:=$vt_Result
