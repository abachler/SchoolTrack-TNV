//%attributes = {}
  // STRal_OnExplorerLoad()
  // 
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 11:53:42
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
READ ONLY:C145([Alumnos:2])


For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
	Case of 
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Alumnos:2])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Alumnos:2]RUT:5)))
			CREATE SELECTION FROM ARRAY:C640([Alumnos:2];alBWR_recordNumber)
			SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;$at_Rut;[Alumnos:2]IDNacional_2:71;$at_IdNac2;[Alumnos:2]IDNacional_3:70;$at_IdNac3;[Alumnos:2]NoPasaporte:87;$at_NoPasaporte;[Alumnos:2]Nacionalidad:8;$at_Nacionalidad;[Alumnos:2]Fecha_de_nacimiento:7;$ad_FechaNac)
			For ($i_registro;1;$l_registros)
				ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
			End for 
			AL_SetFormat (xALP_Browser;$i_columna;"")
			REDUCE SELECTION:C351([Alumnos:2];0)
			
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Alumnos_SintesisAnual:210])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)) & (<>vtXS_CountryCode="ar"))
			  //en Argentina, si el promedio FINAL interno está vacío se utiliza asigna el promedio ANUAL interno ya que el FINAL sólo se calcula cuando se cumplen ciertas condiciones
			$y_arreglo:=ayBWR_ArrayPointers{$i_columna}
			CREATE SELECTION FROM ARRAY:C640([Alumnos:2];alBWR_recordNumber)
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Automatic:K51:4;Automatic:K51:4)  //20180410 ASM Ticket 202636
			SELECTION TO ARRAY:C260([Alumnos:2];$al_RecNums;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;$at_promedioAnual)
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Structure configuration:K51:2;Structure configuration:K51:2)
			For ($i_registro;1;$l_registros)
				$l_posicion:=Find in array:C230($al_RecNums;alBWR_recordNumber{$i_registro})
				If (($l_posicion>0) & (ayBWR_ArrayPointers{$i_columna}->{$i_registro}=""))  //MONO 209553
					ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=$at_promedioAnual{$l_posicion}
				End if 
			End for 
			REDUCE SELECTION:C351([Alumnos:2];0)
			
		: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Alumnos_SintesisAnual:210])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33)) & (<>vtXS_CountryCode="ar"))
			  //en argentina se  muestra el número de inasistencias y no el porcentaje
			CREATE SELECTION FROM ARRAY:C640([Alumnos:2];alBWR_recordNumber)
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Automatic:K51:4;Automatic:K51:4)  //20180410 ASM Ticket 202636
			SELECTION TO ARRAY:C260([Alumnos:2];$al_RecNums;[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;$ai_diasInasistencia;[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45;$ar_FaltasJornada;[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46;$ar_FaltasSesiones)
			SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Structure configuration:K51:2;Structure configuration:K51:2)
			For ($i_registro;1;$l_registros)
				$l_posicion:=Find in array:C230($al_RecNums;alBWR_recordNumber{$i_registro})
				If ($l_posicion>0)
					ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=$ai_diasInasistencia{$l_posicion}+$ar_FaltasJornada{$l_posicion}+$ar_FaltasSesiones{$l_posicion}
				End if 
			End for 
			AL_SetFormat (xALP_Browser;$i_columna;"|Real_2Dec")
			
	End case 
End for 

