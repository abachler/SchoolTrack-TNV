//%attributes = {}
  // Método: ACT_num2Text
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 01-03-10, 14:23:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_REAL:C285($vrACT_num;$1;$vrACT_ParteEntera;$vrACT_ParteDecimal)
C_TEXT:C284($vtACT_Idioma;$0;$vtACT_Moneda;$vt_numeroEnLetras;$vtACT_ParteDecimal)
C_LONGINT:C283($vlACT_Decimales)

$vrACT_num:=$1
If (Count parameters:C259>=2)
	$vtACT_Idioma:=$2
End if 
If (Count parameters:C259>=3)
	$vtACT_Moneda:=$3
End if 

If ($vtACT_Idioma="")
	$vtACT_Idioma:="spanish"
End if 
If ($vtACT_Moneda="")
	$vtACT_Moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
End if 

  // Código principal

READ ONLY:C145([xxACT_Monedas:146])
QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Nombre_Moneda:2=$vtACT_Moneda)
If (Records in selection:C76([xxACT_Monedas:146])>1)
	QUERY SELECTION:C341([xxACT_Monedas:146];[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode)
End if 
$vlACT_Decimales:=[xxACT_Monedas:146]Numero_Decimales:8

$vrACT_ParteEntera:=Int:C8($vrACT_num)
$vrACT_ParteDecimal:=Round:C94(Dec:C9($vrACT_num);$vlACT_Decimales)
If ($vlACT_Decimales=0)
	$vt_numeroEnLetras:=ST_Num2Text2 ($vrACT_ParteEntera;$vtACT_Idioma)
Else 
	$vt_numeroEnLetras:=ST_Num2Text2 ($vrACT_ParteEntera;$vtACT_Idioma)
	$vtACT_ParteDecimal:=Substring:C12(String:C10($vrACT_ParteDecimal);3)
	$vtACT_ParteDecimal:=ST_RigthChars (("0"*$vlACT_Decimales)+$vtACT_ParteDecimal;$vlACT_Decimales)
	$vt_numeroEnLetras:=$vt_numeroEnLetras+" con "+$vtACT_ParteDecimal+"/"+"1"+("0"*$vlACT_Decimales)
End if 
$0:=$vt_numeroEnLetras


