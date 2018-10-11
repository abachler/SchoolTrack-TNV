//%attributes = {}
  // ACTcc_OnExplorerLoad()
  //
  //
  // creado por: Alberto Bachler Klein: 14-03-16, 15:37:08
  // basado en codigo anterior de Roberto Catalan (?)
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_mostrarProgreso)
C_LONGINT:C283($i_columna;$i_registro;$l_año;$l_mes;$l_registros)
C_POINTER:C301($y_columnaProyectado)

C_LONGINT:C283($l_indice)  // Modificado por: Saúl Ponce (17-02-2017) - Ticket Nº 175333 declaración

  // Modificado por: Saúl Ponce (21-02-2017) - Ticket Nº 174878 Declara variables
C_BOOLEAN:C305($b_mostrarProgreso)
C_LONGINT:C283($l_ProgressProcID)

ARRAY DATE:C224($ad_FechaNac;0)
ARRAY DATE:C224($ad_per_FechaNac;0)
ARRAY LONGINT:C221($al_idApdo;0)
ARRAY LONGINT:C221($al_idCta;0)
ARRAY LONGINT:C221($al_per_no;0)
ARRAY TEXT:C222($at_IdNac2;0)
ARRAY TEXT:C222($at_IdNac3;0)
ARRAY TEXT:C222($at_Nacionalidad;0)
ARRAY TEXT:C222($at_NoPasaporte;0)
ARRAY TEXT:C222($at_per_IdNac2;0)
ARRAY TEXT:C222($at_per_IdNac3;0)
ARRAY TEXT:C222($at_per_Nacionalidad;0)
ARRAY TEXT:C222($at_per_NoPasaporte;0)
ARRAY TEXT:C222($at_per_Rut;0)
ARRAY TEXT:C222($at_Rut;0)



If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
	$b_mostrarProgreso:=False:C215
	$l_registros:=Size of array:C274(alBWR_recordNumber)
	$y_columnaProyectado:=Get pointer:C304(atBWR_ArrayNames{10})
	ARRAY TEXT:C222(aMeses;12)
	COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
	$l_mes:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_MesProyectado";String:C10(Month of:C24(Current date:C33(*)))))
	$l_año:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"ACTcc_AñoProyectado";String:C10(Year of:C25(Current date:C33(*)))))
	$l_registros:=Size of array:C274(alBWR_recordNumber)
	
	For ($i_columna;1;Size of array:C274(ayBWR_FieldPointers))
		Case of 
			: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Personas:7])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Personas:7]RUT:6)))
				READ ONLY:C145([Personas:7])
				QUERY WITH ARRAY:C644([Personas:7]No:1;$al_idApdo)
				SELECTION TO ARRAY:C260([Personas:7]No:1;$al_per_no;[Personas:7]RUT:6;$at_per_Rut;[Personas:7]IDNacional_2:37;$at_per_IdNac2;[Personas:7]IDNacional_3:38;$at_per_IdNac3;[Personas:7]Fecha_de_nacimiento:5;$ad_per_FechaNac;[Personas:7]Nacionalidad:7;$at_per_Nacionalidad;[Personas:7]Pasaporte:59;$at_per_NoPasaporte)
				$l_registros:=Size of array:C274($al_per_no)
				  // Modificado por: Saúl Ponce (17-02-2017) - Ticket Nº 175333, para que el formato se asigne a todos los elementos del array. Cuando el apoderado era el mismo, por ejemplo en dos cuentas, se asignaba formato sólo al primer elemento.
				  // For ($i_registro;1;$l_registros)
				For ($i_registro;1;Size of array:C274($al_idApdo))
					  //ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_per_FechaNac{$i_registro};$at_per_Rut{$i_registro};$at_per_IdNac2{$i_registro};$at_per_IdNac3{$i_registro};$at_per_NoPasaporte{$i_registro})
					$l_indice:=Find in array:C230($al_per_no;$al_idApdo{$i_registro})  //20170704 RCH Se agrega linea porque formato no se asignaba correctamente.
					If ($l_indice>0)
						ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_per_FechaNac{$l_indice};$at_per_Rut{$l_indice};$at_per_IdNac2{$l_indice};$at_per_IdNac3{$l_indice};$at_per_NoPasaporte{$l_indice})
					End if 
				End for 
				REDUCE SELECTION:C351([Personas:7];0)
				AL_SetFormat (xALP_Browser;$i_columna;"")
				
			: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[Alumnos:2])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[Alumnos:2]RUT:5)))
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Alumnos:2])
				CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];alBWR_recordNumber)
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_idCta;[ACT_CuentasCorrientes:175]ID_Apoderado:9;$al_idApdo;[Alumnos:2]RUT:5;$at_Rut;[Alumnos:2]IDNacional_2:71;$at_IdNac2;[Alumnos:2]IDNacional_3:70;$at_IdNac3;[Alumnos:2]Fecha_de_nacimiento:7;$ad_FechaNac;[Alumnos:2]Nacionalidad:8;$at_Nacionalidad;[Alumnos:2]NoPasaporte:87;$at_NoPasaporte)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				$l_registros:=Size of array:C274($al_idCta)
				For ($i_registro;1;$l_registros)
					ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=dhBWR_FormatoIDNacional ($ad_FechaNac{$i_registro};$at_Rut{$i_registro};$at_IdNac2{$i_registro};$at_IdNac3{$i_registro};$at_NoPasaporte{$i_registro})
				End for 
				REDUCE SELECTION:C351([Alumnos:2];0)
				AL_SetFormat (xALP_Browser;$i_columna;"")
				  //
				
			: ((Table:C252(ayBWR_FieldPointers{$i_columna})=Table:C252(->[ACT_CuentasCorrientes:175])) & (Field:C253(ayBWR_FieldPointers{$i_columna})=Field:C253(->[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17)))
				If (($l_mes#0) & ($l_año#0))
					If (($l_mes=Month of:C24(Current date:C33(*))) & ($l_año=Year of:C25(Current date:C33(*))))
						AL_SetHeaders (xALP_Browser;10;1;__ ("Proyectado\rMes en Curso"))
					Else 
						AL_SetHeaders (xALP_Browser;10;1;__ ("Proyectado\r")+<>atXS_MonthNames{$l_mes}+" "+String:C10($l_año))
					End if 
					If ($l_registros>100)
						$b_mostrarProgreso:=True:C214
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando proyectado para el mes de ")+aMeses{$l_mes}+__ (" de ")+String:C10($l_año)+__ ("..."))
					End if 
					
				Else 
					If (($l_mes=0) & ($l_año#0))
						AL_SetHeaders (xALP_Browser;10;1;__ ("Proyectado\rAño ")+String:C10($l_año))
						If ($l_registros>100)
							$b_mostrarProgreso:=True:C214
							$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando proyectado para el año ")+String:C10($l_año)+__ ("..."))
						End if 
					Else 
						AL_SetHeaders (xALP_Browser;10;1;__ ("Proyectado\rPara Período..."))
					End if 
				End if 
				
				
				For ($i_registro;1;$l_registros)
					READ ONLY:C145([ACT_CuentasCorrientes:175])
					READ ONLY:C145([ACT_Cargos:173])
					Case of 
						: (($l_mes#0) & ($l_año#0))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$al_idCta{$i_registro};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$l_mes;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$l_año)
							ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							  // Modificado por: Saúl Ponce (21-02-2017) - Ticket Nº 174878 Sólo si se está mostrando la barra, se actualiza
							If ($b_mostrarProgreso)
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registro/$l_registros;__ ("Calculando proyectado para el mes de ")+aMeses{$l_mes}+__ (" de ")+String:C10($l_año)+__ ("..."))
							End if 
						: (($l_mes=0) & ($l_año#0))
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$al_idCta{$i_registro};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$l_año)
							ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							  // Modificado por: Saúl Ponce (21-02-2017) - Ticket Nº 174878 Sólo si se está mostrando la barra, se actualiza
							If ($b_mostrarProgreso)
								$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registro/$l_registros;__ ("Calculando proyectado para el año ")+String:C10($l_año)+__ ("..."))
							End if 
						Else 
							ayBWR_ArrayPointers{$i_columna}->{$i_registro}:=0
					End case 
				End for 
		End case 
		If ($b_mostrarProgreso)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		  //
	End for 
	
End if 
REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
AL_UpdateArrays (xALP_Browser;-1)


