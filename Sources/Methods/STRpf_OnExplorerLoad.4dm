//%attributes = {}
  // STRpf_OnExplorerLoad()
  // 
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 14:47:59
  // -----------------------------------------------------------



ARRAY LONGINT:C221($al_idCta;0)
ARRAY LONGINT:C221($al_idApdo;0)
ARRAY TEXT:C222($at_Rut;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY DATE:C224($ad_FechaNac;0)
ARRAY TEXT:C222($at_Nacionalidad;0)
ARRAY TEXT:C222($at_pasaporte;0)

$l_registros:=Size of array:C274(alBWR_recordNumber)
READ ONLY:C145([Profesores:4])


For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Profesores:4])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Profesores:4]RUT:27)))
			CREATE SELECTION FROM ARRAY:C640([Profesores:4];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([Profesores:4]RUT:27;$at_Rut;[Profesores:4]IDNacional_2:42;$at_IdNac2;[Profesores:4]IDNacional_3:43;$at_IdNac3;[Profesores:4]Pasaporte:60;$at_NoPasaporte;[Profesores:4]Nacionalidad:7;$at_Nacionalidad;[Profesores:4]Fecha_de_nacimiento:6;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
			End for 
			REDUCE SELECTION:C351([Profesores:4];0)
			AL_SetFormat (xALP_Browser;$i;"")
			  //
			
	End case 
	
	
End for 
