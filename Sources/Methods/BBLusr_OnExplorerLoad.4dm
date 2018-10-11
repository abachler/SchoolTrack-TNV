//%attributes = {}
  // BBLusr_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 11:52:41
  // -----------------------------------------------------------
C_LONGINT:C283($i_columna;$i_registro;$l_registros)

ARRAY DATE:C224($ad_FechaNac;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY TEXT:C222($at_Rut;0)

$l_registros:=Size of array:C274(alBWR_recordNumber)
READ ONLY:C145([Alumnos:2])



For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[BBL_Lectores:72])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[BBL_Lectores:72]RUT:7)))
			CREATE SELECTION FROM ARRAY:C640([BBL_Lectores:72];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([BBL_Lectores:72]RUT:7;$at_Rut;[BBL_Lectores:72]IDNacional_2:33;$at_IdNac2;[BBL_Lectores:72]IDNacional_3:34;$at_IdNac3;[Alumnos:2]Fecha_de_nacimiento:7;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_FieldPointers{$i_columna}->:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro})
			End for 
			AL_SetFormat (xALP_Browser;$i_columna;"")
	End case 
End for 


REDUCE SELECTION:C351([BBL_Lectores:72];0)


