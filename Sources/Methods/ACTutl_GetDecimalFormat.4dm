//%attributes = {}
  // ACTutl_GetDecimalFormat()
  // Por: Alberto Bachler K.: 24-07-15, 13:01:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_decimales)
C_TEXT:C284($t_formato;$t_key)

  // Modificado por: Saúl Ponce (16/08/2017) Ticket 186708, asegurar que <>gCountryCode tenga un valor
If (<>gCountryCode="")
	STR_ReadGlobals 
End if 
If (<>gCountryCode="")
	$l_decimales:=0
Else 
	ACTcfg_LeeDecimalMonedaPais 
	$l_decimales:=<>vlACT_decimalesMonedaPais
End if 

<>vlACT_Decimales:=$l_decimales
If (Count parameters:C259=1)
	$t_formato:=$1
Else 
	$t_formato:=""
End if 
Case of 
	: ($t_formato="Despliegue_ACT")
		Case of 
			: ($l_decimales=0)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"
			: ($l_decimales=1)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0"
			: ($l_decimales=2)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00"
			: ($l_decimales=3)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"000"
			: ($l_decimales=4)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0000"
		End case 
	: ($t_formato="Despliegue_ACT_SinZeros")
		Case of 
			: ($l_decimales=0)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"
			: ($l_decimales=1)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"#"
			: ($l_decimales=2)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"##"
			: ($l_decimales=3)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"###"
			: ($l_decimales=4)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_DecimalSeparator+"###"
		End case 
	: ($t_formato="Despliegue_ACT_Pagos")
		Case of 
			: ($l_decimales=0)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"
			: ($l_decimales=1)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0"
			: ($l_decimales=2)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"00"
			: ($l_decimales=3)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"000"
			: ($l_decimales=4)
				$0:="###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"###"+<>tXS_RS_ThousandsSeparator+"##0"+<>tXS_RS_DecimalSeparator+"0000"
		End case 
End case 