//%attributes = {}
  //SRcust_SetParentsVariables

_O_ARRAY STRING:C218(255;asSRVariables;18)

AT_Inc (0)

asSRVariables{AT_Inc }:="1;Variables sistema"
asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
asSRVariables{AT_Inc }:="2;Datos del colegio"
asSRVariables{AT_Inc }:="2;Nombre del colegio;◊gCustom;1"
asSRVariables{AT_Inc }:="2;Director;◊gRector;1"
asSRVariables{AT_Inc }:="2;Dirección;◊gDireccion;1"
asSRVariables{AT_Inc }:="2;Comuna;◊gComuna;1"
asSRVariables{AT_Inc }:="2;Ciudad;◊gCiudad;1"
asSRVariables{AT_Inc }:="2;Provincia;◊gProvincia;1"
asSRVariables{AT_Inc }:="2;Región;◊gRegion;1"
asSRVariables{AT_Inc }:="2;RUT del colegio;◊gRut;1"
asSRVariables{AT_Inc }:="2;Rol de base de datos;◊gRolBD;1"
asSRVariables{AT_Inc }:="2;Año escolar;◊gYear;1"
asSRVariables{AT_Inc }:="2;Representante legal;<>gRepLegalNombre;1"
asSRVariables{AT_Inc }:="2;RUT representante legal;<>gRepLegalRUT;1"
asSRVariables{AT_Inc }:="2;Giro;<>gGiro;1"

$err:=SR Variables (xReportData;"asSRVariables")