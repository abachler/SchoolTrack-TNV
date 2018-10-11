//%attributes = {}
  // ADTcdd_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 16:51:55
  // -----------------------------------------------------------
C_LONGINT:C283($i_Columna;$i_registro;$l_registros)

ARRAY DATE:C224($ad_FechaNac;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY TEXT:C222($at_Nacionalidad;0)
ARRAY TEXT:C222($at_NoPasaporte;0)
ARRAY TEXT:C222($at_Rut;0)

READ ONLY:C145([ADT_Candidatos:49])
CREATE SELECTION FROM ARRAY:C640([ADT_Candidatos:49];alBWR_recordNumber)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([ADT_Candidatos:49];$al_recNums;[Alumnos:2]RUT:5;$at_Rut;[Alumnos:2]IDNacional_2:71;$at_IdNac2;[Alumnos:2]IDNacional_3:70;$at_IdNac3;[Alumnos:2]NoPasaporte:87;$at_NoPasaporte;[Alumnos:2]Nacionalidad:8;$at_Nacionalidad;[Alumnos:2]Fecha_de_nacimiento:7;$ad_FechaNac)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

$l_registros:=Size of array:C274(alBWR_recordNumber)

For ($i_Columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Alumnos:2])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Alumnos:2]RUT:5)))
			READ ONLY:C145([Alumnos:2])
			  //TICKET_184390 
			  //
			  // Modificado por: Alexis Bustamante (03-07-2017)
			
			
			  //se estaba creando una seleccion en base al rec num del candidado
			  //CREATE SELECTION FROM ARRAY([Alumnos];alBWR_recordNumber)
			  //SELECTION TO ARRAY([Alumnos]RUT;$at_Rut;[Alumnos]IDNacional_2;$at_IdNac2;[Alumnos]IDNacional_3;$at_IdNac3;[Alumnos]NoPasaporte;$at_NoPasaporte;[Alumnos]Nacionalidad;$at_Nacionalidad;[Alumnos]Fecha_de_nacimiento;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
			End for 
			AL_SetFormat (xALP_Browser;$i_columna;"")
			REDUCE SELECTION:C351([Alumnos:2];0)
			
			
		: ((Table:C252(ayBWR_FieldPointers{$i_Columna})=Table:C252(->[ADT_Candidatos:49])) & (Field:C253(ayBWR_FieldPointers{$i_Columna})=Field:C253(->[ADT_Candidatos:49]Postulante:43)))
			For ($i_registro;1;$l_registros)
				If (Not:C34(ayBWR_ArrayPointers{$i_columna}->{$i_registro}))
					AL_SetRowColor (xALP_Browser;$i_registro;"";15*16+8)
					AL_SetRowStyle (xALP_Browser;$i_registro;2)
				Else 
					AL_SetRowColor (xALP_Browser;$i_registro;"";16)
					AL_SetRowStyle (xALP_Browser;$i_registro;0)
				End if 
			End for 
			
	End case 
End for 
AL_UpdateArrays (xALP_Browser;-1)