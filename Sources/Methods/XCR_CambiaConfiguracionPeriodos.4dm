//%attributes = {}
  // XCR_CambiaConfiguracionPeriodos()
  // Por: Alberto Bachler K.: 03-07-14, 09:16:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_abortar)
C_LONGINT:C283($i_Periodos;$i_registros)
C_LONGINT:C283($i;$l_accionUsuario;$l_idActividad;$l_idConfiguracionAnterior;$l_idConfiguracionNueva;$l_idTermometro;$l_inscripcionesInvalidas;$l_numeroPeriodosInscrito;$l_PeriodosConfigAnterior)
C_LONGINT:C283($l_resultado)
C_TEXT:C284($t_mensaje)

ARRAY LONGINT:C221($al_RecNums;0)
If (False:C215)
	C_LONGINT:C283(XCR_CambiaConfiguracionPeriodos ;$0)
	C_LONGINT:C283(XCR_CambiaConfiguracionPeriodos ;$1)
	C_LONGINT:C283(XCR_CambiaConfiguracionPeriodos ;$2)
	C_LONGINT:C283(XCR_CambiaConfiguracionPeriodos ;$3)
End if 
$l_idActividad:=$1
$l_idConfiguracionAnterior:=$2
$l_idConfiguracionNueva:=$3

If ($l_idConfiguracionAnterior#$l_idConfiguracionNueva)
	$l_PeriodosConfigAnterior:=viSTR_Periodos_NumeroPeriodos
	PERIODOS_LoadData (0;$l_idConfiguracionNueva)
	Case of 
		: ($l_PeriodosConfigAnterior<viSTR_Periodos_NumeroPeriodos)
			  // el número de períodos de la nueva configuración es superior al número de períodos de la configuración anterior
			  // no hay cambios que hacer en las inscripciones de los alumnos:
			  //  - si estaba inscrito en todos los períodos (bit0 del campo [Alumnos_Actividades]Periodos_Inscritos) se mantiene tal cual
			  //  - si estaba inscrito solo en algunos de los períodos, permanece inscrito en ellos
			SAVE RECORD:C53([Actividades:29])
			
		: ($l_PeriodosConfigAnterior=viSTR_Periodos_NumeroPeriodos)
			  // el número de períodos de la nueva configuración es igual número de períodos de la configuración anterior
			  // no hacemos nada
			SAVE RECORD:C53([Actividades:29])
			
		: ($l_PeriodosConfigAnterior>viSTR_Periodos_NumeroPeriodos)
			  // si la configuracion de períodos anterior tiene más períodos que la configuración actual
			  // actualizamos los registros de la tabla [Alumnos_Actividades]
			QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=$l_idActividad)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Actividades:28];$al_RecNums;"")
			
			  // verifico que los alumnos no estén inscritos en períodos que no existen en la nueva configuración
			$l_inscripcionesInvalidas:=0
			For ($i_registros;1;Size of array:C274($al_RecNums))
				READ WRITE:C146([Alumnos_Actividades:28])
				KRL_GotoRecord (->[Alumnos_Actividades:28];$al_RecNums{$i_registros})
				For ($i_Periodos;viSTR_Periodos_NumeroPeriodos+1;$l_PeriodosConfigAnterior)
					Case of 
						: ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i_Periodos)
							$l_inscripcionesInvalidas:=$l_inscripcionesInvalidas+Num:C11([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i_Periodos)
							$i_Periodos:=$l_PeriodosConfigAnterior+1
							$i_registros:=Size of array:C274($al_RecNums)+1
						: ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0)
							$l_inscripcionesInvalidas:=$l_inscripcionesInvalidas+1
							$i_Periodos:=$l_PeriodosConfigAnterior+1
							$i_registros:=Size of array:C274($al_RecNums)+1
					End case 
				End for 
			End for 
			
			If ($l_inscripcionesInvalidas>0)
				  //si hay alumnos inscritos en períodos que no existen en la nueva configuración solicito confirmacion al usuario
				$t_mensaje:=__ ("La configuración de períodos anterior comprende mas períodos que la anterior.")+"\r"+\
					__ ("La información registrada en esos períodos será eliminada.")+"\r"+\
					__ ("Confirma usted el cambio de configuración de períodos")
				$l_accionUsuario:=ModernUI_Notificacion (__ ("Cambio de configuración de períodos");$t_mensaje;"Cancelar";"Confirmo")
				$b_abortar:=($l_accionUsuario=1)
			End if 
			
			If (Not:C34($b_abortar))
				OK:=1
				START TRANSACTION:C239
				$l_idTermometro:=IT_Progress (1;0;0;"...")
				For ($i_registros;1;Size of array:C274($al_RecNums))
					READ WRITE:C146([Alumnos_Actividades:28])
					KRL_GotoRecord (->[Alumnos_Actividades:28];$al_RecNums{$i_registros})
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_Actividades:28]Alumno_Numero:1)
					For ($i_Periodos;viSTR_Periodos_NumeroPeriodos+1;$l_PeriodosConfigAnterior)
						  // retiramos la inscripción en los periodos que no existen en la nueva configuracion de períodos
						[Alumnos_Actividades:28]Periodos_Inscritos:44:=[Alumnos_Actividades:28]Periodos_Inscritos:44 ?- $i_Periodos
						  // eliminamos la información que pudiese existir en los períodos que no existen en la nueva configuración de períodos
						OK:=XCR_EliminaInformacionPeriodo ([Alumnos_Actividades:28]Actividad_numero:2;[Alumnos_Actividades:28]Alumno_Numero:1;$i_Periodos)
						If (OK=0)
							$b_abortar:=True:C214
							$i_Periodos:=$l_PeriodosConfigAnterior+1
							$i_registros:=Size of array:C274($al_RecNums)+1
						End if 
					End for 
					
					If (Not:C34($b_abortar))
						$l_numeroPeriodosInscrito:=0
						For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
							$l_numeroPeriodosInscrito:=$l_numeroPeriodosInscrito+Num:C11([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i)
						End for 
						If ($l_numeroPeriodosInscrito=viSTR_Periodos_NumeroPeriodos)
							[Alumnos_Actividades:28]Periodos_Inscritos:44:=1
						End if 
						SAVE RECORD:C53([Alumnos_Actividades:28])
					End if 
					$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
				End for 
				$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
				
				If (Not:C34($b_abortar))
					SAVE RECORD:C53([Actividades:29])
					VALIDATE TRANSACTION:C240
					$l_resultado:=1
					LOG_RegisterEvt (__ ("Cambio de configuración de períodos por otra con menos períodos. El usuario aceptó la eliminación de información en períodos inválidos."))
				Else 
					$l_accionUsuario:=ModernUI_Notificacion (__ ("Cambio de configuración de períodos");__ ("No es posible cambiar la configuración de períodos en este momento.\rPor favor intente nuevamente más tarde."))
					CANCEL TRANSACTION:C241
					[Actividades:29]ID_ConfiguracionPeriodos:13:=$l_idConfiguracionAnterior
					SAVE RECORD:C53([Actividades:29])
				End if 
				KRL_UnloadReadOnly (->[Alumnos_Actividades:28])
				
			Else 
				[Actividades:29]ID_ConfiguracionPeriodos:13:=$l_idConfiguracionAnterior
				SAVE RECORD:C53([Actividades:29])
			End if 
			
	End case 
End if 

$0:=$l_resultado
