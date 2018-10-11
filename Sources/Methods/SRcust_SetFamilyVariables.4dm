//%attributes = {}
  //SRcust_SetFamilyVariables

_O_ARRAY STRING:C218(255;asSRVariables;18)

AT_Inc (0)

asSRVariables{AT_Inc }:="1;Variables sistema"
asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
asSRVariables{AT_Inc }:="2;Datos del colegio"
asSRVariables{AT_Inc }:="2;Nombre del colegio;<>gCustom;1"
asSRVariables{AT_Inc }:="2;Director;<>gRector;1"
asSRVariables{AT_Inc }:="2;Dirección;<>gDireccion;1"
asSRVariables{AT_Inc }:="2;Comuna;<>gComuna;1"
asSRVariables{AT_Inc }:="2;Ciudad;<>gCiudad;1"
asSRVariables{AT_Inc }:="2;Provincia;<>gProvincia;1"
asSRVariables{AT_Inc }:="2;Región;<>gRegion;1"
asSRVariables{AT_Inc }:="2;RUT del colegio;<>gRut;1"
asSRVariables{AT_Inc }:="2;Rol de base de datos;<>gRolBD;1"
asSRVariables{AT_Inc }:="2;Año escolar;<>gYear;1"
asSRVariables{AT_Inc }:="2;Representante legal;<>gRepLegalNombre;1"
asSRVariables{AT_Inc }:="2;RUT representante legal;<>gRepLegalRUT;1"
asSRVariables{AT_Inc }:="2;Giro;<>gGiro;1"

$nextItem:=Size of array:C274(asSRVariables)+1
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=(Table:C252(->[Personas:7])))
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$aFieldNums;[xShell_Fields:52]ID:24;$aFieldIDs)
ARRAY TEXT:C222($aFieldNames;Size of array:C274($aFieldIDs))
For ($h;1;Size of array:C274($aFieldIDs))
	$aFieldNames{$h}:=XSvs_nombreCampoLocal_Numero (Table:C252(->[Personas:7]);$aFieldIDs{$h};<>vtXS_CountryCode;<>vtXS_Langage)
End for 
SORT ARRAY:C229($aFieldNames;$aFieldNums;>)
$index:=Size of array:C274(asSRVariables)+1
AT_ResizeArrays (->asSRVariables;Size of array:C274(asSRVariables)+Size of array:C274($aFieldNums)+1)
asSRVariables{$index}:="3;Datos de la Madre"
$index:=$index+1
For ($i;1;Size of array:C274($aFieldNums))
	$varName:=Substring:C12("vMadre_"+Field name:C257(7;$aFieldNums{$i});1;30)
	asSRVariables{$index}:="3;"+$aFieldNames{$i}+";"+$varName+";1"
	$index:=$index+1
End for 

ARRAY TEXT:C222($aMenuItems;Size of array:C274($aFieldNums))
$index:=Size of array:C274(asSRVariables)+1
AT_ResizeArrays (->asSRVariables;Size of array:C274(asSRVariables)+Size of array:C274($aFieldNums)+1)
asSRVariables{$index}:="4;Datos del Padre"
$index:=$index+1
For ($i;1;Size of array:C274($aFieldNums))
	$varName:=Substring:C12("vPadre_"+Field name:C257(7;$aFieldNums{$i});1;30)
	asSRVariables{$index}:="4;"+$aFieldNames{$i}+";"+$varName+";1"
	$index:=$index+1
End for 



$err:=SR Variables (xReportData;"asSRVariables")