//%attributes = {}
  // ACTter_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 11:12:10
  // -----------------------------------------------------------
C_LONGINT:C283($i_columna;$i_registro;$l_registros)

ARRAY DATE:C224($ad_FechaNac;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY TEXT:C222($at_Nacionalidad;0)
ARRAY TEXT:C222($at_NoPasaporte;0)
ARRAY TEXT:C222($at_Rut;0)

$l_registros:=Size of array:C274(alBWR_recordNumber)
READ ONLY:C145([ACT_Terceros:138])

For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[ACT_Terceros:138])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[ACT_Terceros:138]RUT:4)))
			CREATE SELECTION FROM ARRAY:C640([ACT_Terceros:138];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([ACT_Terceros:138]RUT:4;$at_Rut;[ACT_Terceros:138]Identificador_Nacional2:20;$at_IdNac2;[ACT_Terceros:138]Identificador_Nacional3:21;$at_IdNac3;[ACT_Terceros:138]Pasaporte:25;$at_NoPasaporte;[ACT_Terceros:138]Nacionalidad:27;$at_Nacionalidad;[ACT_Terceros:138]Fecha_de_Nacimiento:28;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
			End for 
			REDUCE SELECTION:C351([Personas:7];0)
			AL_SetFormat (xALP_Browser;$i_columna;"")
			  //
	End case 
End for 