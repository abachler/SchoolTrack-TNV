//%attributes = {}
  // XSvs_nombreCampoLocal_Numero()
  // Por: Alberto Bachler: 14/03/13, 08:08:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($fieldNum;$tableNum)
C_TEXT:C284($countryCode;$fieldRef;$languageCode)
C_BOOLEAN:C305($b_leerNombreVirtual)


If (False:C215)
	C_TEXT:C284(XSvs_nombreCampoLocal_Numero ;$0)
	C_LONGINT:C283(XSvs_nombreCampoLocal_Numero ;$1)
	C_LONGINT:C283(XSvs_nombreCampoLocal_Numero ;$2)
	C_TEXT:C284(XSvs_nombreCampoLocal_Numero ;$3)
	C_TEXT:C284(XSvs_nombreCampoLocal_Numero ;$4)
	C_BOOLEAN:C305(XSvs_nombreCampoLocal_Numero ;$5)
End if 

$tableNum:=$1
$fieldNum:=$2
$countryCode:=<>vtXS_CountryCode
$languageCode:=<>vtXS_langage
$b_leerNombreVirtual:=True:C214
Case of 
	: (Count parameters:C259=5)
		$t_codigoPais:=$3
		$t_codigoLenguaje:=$4
		$b_leerNombreVirtual:=$5
	: (Count parameters:C259=4)
		$countryCode:=$3
		$languageCode:=$4
	: (Count parameters:C259=3)
		$countryCode:=$3
End case 


If (Is field number valid:C1000($tableNum;$fieldNum))
	$0:=XSvs_nombreCampoLocal_puntero (Field:C253($tableNum;$fieldNum);$countryCode;$languageCode;$b_leerNombreVirtual)
End if 
