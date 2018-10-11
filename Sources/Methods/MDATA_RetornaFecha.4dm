//%attributes = {}
  // Método: MDATA_RetornaFecha
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/10/09, 10:35:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_POINTER:C301($1;$fieldPointer)
C_TEXT:C284($2;$fieldName)
C_LONGINT:C283($year;$3;$tableNum)
C_DATE:C307($0)

  // Código principal
$fieldPointer:=$1
$fieldName:=$2
$year:=<>gYear
If (Count parameters:C259=3)
	$year:=$3
End if 

$tableNum:=Table:C252($fieldPointer)
QUERY:C277([xxSTR_MetadatosLocales:141];[xxSTR_MetadatosLocales:141]Tabla:2=$tableNum;*)
QUERY:C277([xxSTR_MetadatosLocales:141]; & ;[xxSTR_MetadatosLocales:141]Etiqueta:3=$fieldName)

If (Records in selection:C76([xxSTR_MetadatosLocales:141])=1)
	$key:=KRL_MakeStringAccesKey (->[xxSTR_MetadatosLocales:141]UUID:10;$fieldPointer;->$year)
	$0:=KRL_GetDateFieldData (->[MDATA_RegistrosDatosLocales:145]Llave:5;->$key;->[MDATA_RegistrosDatosLocales:145]Valor_Fecha:8)
End if 






