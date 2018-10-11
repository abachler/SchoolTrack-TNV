//%attributes = {}
  //SNTps_DataHandled_Transmision

C_TEXT:C284($1;$vt_4DFTP)
C_TEXT:C284($2;$vt_Use_All)

$vt_4DFTP:=$1
$vt_Use_All:=$2

C_LONGINT:C283(<>vl_SNT_Send_DataHandled_Trans)
<>vl_SNT_Send_DataHandled_Trans:=0
If (<>vl_SNT_Send_DataHandled_Trans=0)
	<>vl_SNT_Send_DataHandled_Trans:=New process:C317("SNT_DataHandled_Transmision";Pila_256K;"SNT_DataHandled_Transmision";$vt_4DFTP;$vt_Use_All)
End if 