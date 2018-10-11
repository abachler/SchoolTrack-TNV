//%attributes = {}
  //ACTbank_RetornaConvenio
C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_TEXT:C284($vt_paramentroBusqueda;$2)
READ ONLY:C145([xxACT_Bancos:129])

$vt_accion:=$1
$vt_paramentroBusqueda:=$2

Case of 
	: ($vt_accion="ObtieneConvenioDesdeCodigo")
		QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Codigo:2=$vt_paramentroBusqueda;*)
		QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Pais:3=<>gCountryCode)
		$vt_retorno:=[xxACT_Bancos:129]mx_NumeroConvenio:5
		
End case 
$0:=$vt_retorno