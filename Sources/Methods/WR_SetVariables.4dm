//%attributes = {}
  //WR_SetVariables

$trapped:=False:C215
$trapped:=dhWR_SetVariables 
If (Not:C34($trapped))
	Case of 
		: ((vsBWR_CurrentModule="SchoolTrack") | (vsBWR_CurrentModule="AdmissionTrack") | (vsBWR_CurrentModule="MediaTrack"))
			_O_ARRAY STRING:C218(255;asWRVariables;14)
			AT_Inc (0)
			asWRVariables{AT_Inc }:="Datos del colegio"
			asWRVariables{AT_Inc }:="Nombre del colegio;◊gCustom"
			asWRVariables{AT_Inc }:="Director;◊gRector"
			asWRVariables{AT_Inc }:="Dirección;◊gDireccion"
			asWRVariables{AT_Inc }:="Comuna;◊gComuna"
			asWRVariables{AT_Inc }:="Ciudad;◊gCiudad"
			asWRVariables{AT_Inc }:="Provincia;◊gProvincia"
			asWRVariables{AT_Inc }:="Región;◊gRegion"
			asWRVariables{AT_Inc }:="RUT del colegio;◊gRut"
			asWRVariables{AT_Inc }:="Rol de base de datos;◊gRolBD"
			asWRVariables{AT_Inc }:="Año escolar;◊gYear"
			asWRVariables{AT_Inc }:="Representante legal;<>gRepLegalNombre"
			asWRVariables{AT_Inc }:="RUT representante legal;<>gRepLegalRUT"
			asWRVariables{AT_Inc }:="Giro;<>gGiro"
		: (vsBWR_CurrentModule="AccountTrack")
			_O_ARRAY STRING:C218(255;asWRVariables;14)
			AT_Inc (0)
			asWRVariables{AT_Inc }:="Datos del colegio"
			asWRVariables{AT_Inc }:="Nombre del colegio;<>vsACT_RazonSocial"
			asWRVariables{AT_Inc }:="Director;◊gRector"
			asWRVariables{AT_Inc }:="Dirección;<>vsACT_Direccion"
			asWRVariables{AT_Inc }:="Comuna;<>vsACT_Comuna"
			asWRVariables{AT_Inc }:="Ciudad;<>vsACT_Ciudad"
			asWRVariables{AT_Inc }:="Provincia;◊gProvincia"
			asWRVariables{AT_Inc }:="Región;◊gRegion"
			asWRVariables{AT_Inc }:="RUT del colegio;<>vsACT_RUT"
			asWRVariables{AT_Inc }:="Rol de base de datos;◊gRolBD"
			asWRVariables{AT_Inc }:="Año escolar;◊gYear"
			asWRVariables{AT_Inc }:="Representante legal;<>vsACT_RepLegal"
			asWRVariables{AT_Inc }:="RUT representante legal;<>vsACT_RUTRepLegal"
			asWRVariables{AT_Inc }:="Giro;<>vsACT_Giro"
	End case 
	For ($i;1;Size of array:C274(asWRVariables))
		asWRVariables{$i}:=Replace string:C233(asWRVariables{$i};Char:C90(215);"<>")
		$words:=ST_CountWords (asWRVariables{$i};0;";")
		If ($words=1)
			If ($i=1)
				$posParent:=$i
				$subList:=New list:C375
			Else 
				APPEND TO LIST:C376(hl_Variables;asWRVariables{$posParent};$posParent;$subList;False:C215)
				$posParent:=$i
				$subList:=New list:C375
			End if 
		Else 
			APPEND TO LIST:C376($subList;ST_GetWord (asWRVariables{$i};1;";");$i)
		End if 
	End for 
	APPEND TO LIST:C376(hl_Variables;asWRVariables{$posParent};$posParent;$subList;False:C215)
End if 