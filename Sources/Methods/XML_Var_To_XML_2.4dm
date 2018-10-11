//%attributes = {}
  //XML_Var_To_XML_2

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 28/05/07, 14:12:34
  // ----------------------------------------------------
  // Método: XML_Var_To_XML_2
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_POINTER:C301($1;$vy_Data)
C_TEXT:C284($2;$vt_Tag_Name)
C_TEXT:C284($0)

$vy_Data:=$1
$vt_Tag_Name:=$2

C_TEXT:C284($vt_Tag_Open)
C_TEXT:C284($vt_Tag_Close)

$vt_Tag_Open:="<+>"
$vt_Tag_Close:="</+>"

C_TEXT:C284($vt_Data)

C_LONGINT:C283($vl_Type)
$vl_Type:=Type:C295($vy_Data->)

  //Is Alpha Field	Long Integer	 0
  //Is String Var	Long Integer	24
  //Is Text	Long Integer	2
Case of 
	: (($vl_Type#0) & ($vl_Type#24) & ($vl_Type#2))
		$vt_Data:=String:C10($vy_Data->)
	Else 
		$vt_Data:=$vy_Data->
End case 

C_TEXT:C284($vt_XML_End)
$vt_XML_End:=Replace string:C233($vt_Tag_Open;"+";$vt_Tag_Name)+$vt_Data+Replace string:C233($vt_Tag_Close;"+";$vt_Tag_Name)

$0:=$vt_XML_End