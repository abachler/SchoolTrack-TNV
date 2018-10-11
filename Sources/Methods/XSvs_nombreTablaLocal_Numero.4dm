//%attributes = {}
  // XSvs_nombreTablaLocal_Numero(numeroTabla:L {;codigoPais:T {;codigoLenguaje:T}}) -> nombreTablaLocalizado:L
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
  // Por: Alberto Bachler: 11/03/13, 16:32:14
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_BOOLEAN:C305($4)

C_BOOLEAN:C305($b_leerNombreVirtual)
C_LONGINT:C283($l_numeroTabla)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais)

If (False:C215)
	C_TEXT:C284(XSvs_nombreTablaLocal_Numero ;$0)
	C_LONGINT:C283(XSvs_nombreTablaLocal_Numero ;$1)
	C_TEXT:C284(XSvs_nombreTablaLocal_Numero ;$2)
	C_TEXT:C284(XSvs_nombreTablaLocal_Numero ;$3)
	C_BOOLEAN:C305(XSvs_nombreTablaLocal_Numero ;$4)
End if 

$l_numeroTabla:=$1
$t_codigoPais:=<>vtXS_CountryCode
$t_codigoLenguaje:=<>vtXS_langage
$b_leerNombreVirtual:=True:C214
Case of 
	: (Count parameters:C259=4)
		$t_codigoPais:=$2
		$t_codigoLenguaje:=$3
		$b_leerNombreVirtual:=$4
	: (Count parameters:C259=3)
		$t_codigoPais:=$2
		$t_codigoLenguaje:=$3
	: (Count parameters:C259=2)
		$t_codigoPais:=$2
End case 

If (Is table number valid:C999($l_numeroTabla))
	$0:=XSvs_nombreTablaLocal_puntero (Table:C252($l_numeroTabla);$t_codigoPais;$t_codigoLenguaje;$b_leerNombreVirtual)
End if 
