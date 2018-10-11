//%attributes = {}
  //STRpp_OnExplorerLoad
C_LONGINT:C283($i_registro;$l_registros)
C_POINTER:C301($y_arreglo)

ARRAY DATE:C224($ad_FechaNac;0)
ARRAY LONGINT:C221($al_idApdo;0)
ARRAY LONGINT:C221($al_idCta;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY TEXT:C222($at_Nacionalidad;0)
ARRAY TEXT:C222($at_NoPasaporte;0)
ARRAY TEXT:C222($at_pasaporte;0)
ARRAY TEXT:C222($at_Rut;0)

$l_registros:=Size of array:C274(alBWR_recordNumber)
READ ONLY:C145([Personas:7])

For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Personas:7])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Personas:7]RUT:6)))
			CREATE SELECTION FROM ARRAY:C640([Personas:7];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([Personas:7]RUT:6;$at_Rut;[Personas:7]IDNacional_2:37;$at_IdNac2;[Personas:7]IDNacional_3:38;$at_IdNac3;[Personas:7]Pasaporte:59;$at_NoPasaporte;[Personas:7]Nacionalidad:7;$at_Nacionalidad;[Personas:7]Fecha_de_nacimiento:5;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
			End for 
			REDUCE SELECTION:C351([Personas:7];0)
			AL_SetFormat (xALP_Browser;$i;"")
	End case 
End for 
