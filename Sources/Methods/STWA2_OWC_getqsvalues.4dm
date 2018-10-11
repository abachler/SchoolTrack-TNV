//%attributes = {}
  // Método: STWA2_OWC_getqsvalues
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:49:52
  // ----------------------------------------------------
  // Modificado por: Alberto Bachler Klein: 21-11-15, 13:27:57
  // Uso de Objeto 4D para generar json en reemplazo de plugin OAuth o componente JSON
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BOOLEAN:C305($b_continuar)
C_LONGINT:C283($i;$l_campos)
C_POINTER:C301($y_lista;$y_ParameterNames;$y_ParameterValues;$y_tabla)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_cultura;$t_json;$t_tipo;$t_uuid)


If (False:C215)
	C_TEXT:C284(STWA2_OWC_getqsvalues ;$0)
	C_TEXT:C284(STWA2_OWC_getqsvalues ;$1)
	C_POINTER:C301(STWA2_OWC_getqsvalues ;$2)
	C_POINTER:C301(STWA2_OWC_getqsvalues ;$3)
End if 

$t_uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$t_tipo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tipo")
$t_cultura:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"cultura")
$t_codigoPais:=ST_GetWord ($t_cultura;2;"-")
$t_codigoLenguaje:=ST_GetWord ($t_cultura;1;"-")
$b_continuar:=True:C214
Case of 
	: ($t_tipo="asignaturas")
		$y_tabla:=->[Asignaturas:18]
		BWR_GetPanelSettings (SchoolTrack;Table:C252($y_tabla);$t_codigoPais;$t_codigoLenguaje)
	Else 
		$b_continuar:=False:C215
End case 
If ($b_continuar)
	ARRAY TEXT:C222(atVS_QFAssociatedList;0)
	$l_campos:=Size of array:C274(alVS_QFSourceTableNumber)
	If ($l_campos>0)
		ARRAY TEXT:C222(atVS_QFAssociatedList;$l_campos)
		For ($i;1;$l_campos)
			QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=alVS_QFSourceTableNumber{$i};*)
			QUERY:C277([xShell_Fields:52]; & [xShell_Fields:52]NumeroCampo:2=alVS_QFSourceFieldNumber{$i})
			atVS_QFAssociatedList{$i}:=[xShell_Fields:52]ListaDeValoresAsociados:11
		End for 
	End if 
	QRY_LoadOperatorsArray 
	
	C_OBJECT:C1216($ob_json;$ob_listas)
	$ob_json:=OB_Create 
	$ob_listas:=OB_Create 
	OB_SET ($ob_json;->atVS_QFSourceFieldAlias;"campos")
	OB_SET ($ob_json;->atVS_QFAssociatedList;"listas")
	OB_SET ($ob_json;->aDelims;"delims")
	
	For ($i;1;Size of array:C274(atVS_QFAssociatedList))
		If (atVS_QFAssociatedList{$i}#"")
			$y_lista:=Get pointer:C304(atVS_QFAssociatedList{$i})
			OB_SET ($ob_listas;$y_lista;atVS_QFAssociatedList{$i})
		End if 
	End for 
	OB_SET ($ob_json;->$ob_listas;"listasDEF")
	$t_json:=OB_Object2Json ($ob_json)
End if 

$0:=$t_json

