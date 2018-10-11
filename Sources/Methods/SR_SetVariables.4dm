//%attributes = {}
  //SR_SetVariables

C_DATE:C307(SRDate)
C_TIME:C306(SRTime)
C_LONGINT:C283(SRPage;SRRecord)
C_LONGINT:C283(SRArea;SRObjectPrintRef)
$trapped:=False:C215
$trapped:=dhSR_SetVariables 
If (Not:C34($trapped))
	Case of 
		: (vsBWR_CurrentModule="SchoolTrack")
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
		: (vsBWR_CurrentModule="AccountTrack")
			_O_ARRAY STRING:C218(255;asSRVariables;18)
			AT_Inc (0)
			asSRVariables{AT_Inc }:="1;Variables sistema"
			asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
			asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
			asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
			asSRVariables{AT_Inc }:="2;Datos del colegio"
			asSRVariables{AT_Inc }:="2;Nombre del colegio;<>vsACT_RazonSocial;1"
			asSRVariables{AT_Inc }:="2;Director;◊gRector;1"
			asSRVariables{AT_Inc }:="2;Dirección;<>vsACT_Direccion;1"
			asSRVariables{AT_Inc }:="2;Comuna;<>vsACT_Comuna;1"
			asSRVariables{AT_Inc }:="2;Ciudad;<>vsACT_Ciudad;1"
			asSRVariables{AT_Inc }:="2;Provincia;◊gProvincia;1"
			asSRVariables{AT_Inc }:="2;Región;◊gRegion;1"
			asSRVariables{AT_Inc }:="2;RUT del colegio;<>vsACT_RUT;1"
			asSRVariables{AT_Inc }:="2;Rol de base de datos;◊gRolBD;1"
			asSRVariables{AT_Inc }:="2;Año escolar;◊gYear;1"
			asSRVariables{AT_Inc }:="2;Representante legal;<>vsACT_RepLegal;1"
			asSRVariables{AT_Inc }:="2;RUT representante legal;<>vsACT_RUTRepLegal;1"
			asSRVariables{AT_Inc }:="2;Giro;<>vsACT_Giro;1"
		: (vsBWR_CurrentModule="AdmissionTrack")
			_O_ARRAY STRING:C218(255;asSRVariables;18)
			AT_Inc (0)
			asSRVariables{AT_Inc }:="1;Variables sistema"
			asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
			asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
			asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
			asSRVariables{AT_Inc }:="2;Datos del colegio"
			asSRVariables{AT_Inc }:="2;Nombre del colegio;<>vsACT_RazonSocial;1"
			asSRVariables{AT_Inc }:="2;Director;◊gRector;1"
			asSRVariables{AT_Inc }:="2;Dirección;<>vsACT_Direccion;1"
			asSRVariables{AT_Inc }:="2;Comuna;<>vsACT_Comuna;1"
			asSRVariables{AT_Inc }:="2;Ciudad;<>vsACT_Ciudad;1"
			asSRVariables{AT_Inc }:="2;Provincia;◊gProvincia;1"
			asSRVariables{AT_Inc }:="2;Región;◊gRegion;1"
			asSRVariables{AT_Inc }:="2;RUT del colegio;<>vsACT_RUT;1"
			asSRVariables{AT_Inc }:="2;Rol de base de datos;◊gRolBD;1"
			asSRVariables{AT_Inc }:="2;Año escolar;◊gYear;1"
			asSRVariables{AT_Inc }:="2;Representante legal;<>vsACT_RepLegal;1"
			asSRVariables{AT_Inc }:="2;RUT representante legal;<>vsACT_RUTRepLegal;1"
			asSRVariables{AT_Inc }:="2;Giro;<>vsACT_Giro;1"
		: (vsBWR_CurrentModule="MediaTrack")
			_O_ARRAY STRING:C218(255;asSRVariables;18)
			AT_Inc (0)
			asSRVariables{AT_Inc }:="1;Variables sistema"
			asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
			asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
			asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
			asSRVariables{AT_Inc }:="2;Datos del colegio"
			asSRVariables{AT_Inc }:="2;Nombre del colegio;<>vsACT_RazonSocial;1"
			asSRVariables{AT_Inc }:="2;Director;◊gRector;1"
			asSRVariables{AT_Inc }:="2;Dirección;<>vsACT_Direccion;1"
			asSRVariables{AT_Inc }:="2;Comuna;<>vsACT_Comuna;1"
			asSRVariables{AT_Inc }:="2;Ciudad;<>vsACT_Ciudad;1"
			asSRVariables{AT_Inc }:="2;Provincia;◊gProvincia;1"
			asSRVariables{AT_Inc }:="2;Región;◊gRegion;1"
			asSRVariables{AT_Inc }:="2;RUT del colegio;<>vsACT_RUT;1"
			asSRVariables{AT_Inc }:="2;Rol de base de datos;◊gRolBD;1"
			asSRVariables{AT_Inc }:="2;Año escolar;◊gYear;1"
			asSRVariables{AT_Inc }:="2;Representante legal;<>vsACT_RepLegal;1"
			asSRVariables{AT_Inc }:="2;RUT representante legal;<>vsACT_RUTRepLegal;1"
			asSRVariables{AT_Inc }:="2;Giro;<>vsACT_Giro;1"
	End case 
	$err:=SR Variables (xReportData;"asSRVariables")
End if 