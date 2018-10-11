//%attributes = {}
  // MÉTODO: SOPORTE_CreaNotas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/12, 17:27:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Crea o reemplaza notas aleatorias en X columnas en las asignaturas listadas en el explorador y calcula sus promedios
  // Este método debe ser utilizado solo en soporte.
  //
  // PARÁMETROS
  // SOPORTE_CreaNotas()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_BLOB:C604($x_recNumArray)
C_LONGINT:C283($i_calificaciones;$j;$l_cantidadDeColumnas;$l_numeroCampo;$l_numeroTabla;$l_primerCampoP1;$l_primerCampoP2;$l_primerCampoP3;$l_primerCampoP4;$l_primerCampoP5)
C_LONGINT:C283($i_asignaturas)
C_POINTER:C301($y_campoLiteral;$y_campoNota;$y_campoPuntos;$y_campoReal;$y_campoSimbolos)
C_REAL:C285($r_notaReal)
C_TEXT:C284($t_nombreSet)

ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY LONGINT:C221($al_RecNumCalificaciones;0)
If (False:C215)
	C_LONGINT:C283(SOPORTE_CreaNotas ;$1)
End if 




  // CODIGO PRINCIPAL
If (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
	$t_nombreSet:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
	USE SET:C118($t_nombreSet)
	If (Records in selection:C76([Asignaturas:18])>0)
		If (Count parameters:C259=1)
			$l_cantidadDeColumnas:=$1
		Else 
			$l_cantidadDeColumnas:=2
		End if 
		STR_SeleccionaPeriodo 
		If (ok=1)
			$l_numeroTabla:=Table:C252(->[Alumnos_Calificaciones:208])
			$l_primerCampoP1:=Field:C253(->[Alumnos_Calificaciones:208]P01_Eval01_Real:42)-5
			$l_primerCampoP2:=Field:C253(->[Alumnos_Calificaciones:208]P02_Eval01_Real:117)-5
			$l_primerCampoP3:=Field:C253(->[Alumnos_Calificaciones:208]P03_Eval01_Real:192)-5
			$l_primerCampoP4:=Field:C253(->[Alumnos_Calificaciones:208]P04_Eval01_Real:267)-5
			$l_primerCampoP5:=Field:C253(->[Alumnos_Calificaciones:208]P05_Eval01_Real:342)-5
			READ ONLY:C145([Asignaturas:18])
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando notas para el "+atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}+", para "+String:C10($l_cantidadDeColumnas)+" columnas.")
			For ($i_asignaturas;1;Size of array:C274($al_RecNumAsignaturas))
				GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$i_asignaturas})
				EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
				EV2_Calificaciones_SeleccionAS 
				
				LONGINT ARRAY FROM SELECTION:C647([Alumnos_Calificaciones:208];$al_RecNumCalificaciones;"")
				For ($i_calificaciones;1;Size of array:C274($al_RecNumCalificaciones))
					READ WRITE:C146([Alumnos_Calificaciones:208])
					GOTO RECORD:C242([Alumnos_Calificaciones:208];$al_RecNumCalificaciones{$i_calificaciones})
					For ($j;1;$l_cantidadDeColumnas)
						$r_notaReal:=MATH_RandomLongint (50;100)
						Case of 
							: (vPeriodo=1)
								$y_campoReal:=Field:C253($l_numeroTabla;$l_primerCampoP1+(5*$j))
								$y_campoReal->:=$r_notaReal
							: (vPeriodo=2)
								$y_campoReal:=Field:C253($l_numeroTabla;$l_primerCampoP2+(5*$j))
								$y_campoReal->:=$r_notaReal
							: (vPeriodo=3)
								$y_campoReal:=Field:C253($l_numeroTabla;$l_primerCampoP3+(5*$j))
								$y_campoReal->:=$r_notaReal
							: (vPeriodo=4)
								$y_campoReal:=Field:C253($l_numeroTabla;$l_primerCampoP4+(5*$j))
								$y_campoReal->:=$r_notaReal
							: (vPeriodo=5)
								$y_campoReal:=Field:C253($l_numeroTabla;$l_primerCampoP5+(5*$j))
								$y_campoReal->:=$r_notaReal
						End case 
						$l_numeroCampo:=Field:C253($y_campoReal)
						$y_campoNota:=Field:C253($l_numeroTabla;$l_numeroCampo+1)
						$y_campoNota->:=EV2_Real_a_Nota ($y_campoReal->;0;iGradesDec)
						$y_campoPuntos:=Field:C253($l_numeroTabla;$l_numeroCampo+2)
						$y_campoPuntos->:=EV2_Real_a_Puntos ($y_campoReal->;0;iPointsDec)
						$y_campoSimbolos:=Field:C253($l_numeroTabla;$l_numeroCampo+3)
						$y_campoSimbolos->:=EV2_Real_a_Simbolo ($y_campoReal->)
						$y_campoLiteral:=Field:C253($l_numeroTabla;$l_numeroCampo+4)
						$y_campoLiteral->:=EV2_Real_a_Literal ($y_campoReal->;iPrintMode;vlNTA_DecimalesParciales)
						
					End for 
					SAVE RECORD:C53([Alumnos_Calificaciones:208])
					KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
				End for 
				$l_ProgressProcID:=IT_Progress (1;$i_asignaturas/Size of array:C274($al_RecNumAsignaturas)*100;$l_ProgressProcID;"Generando notas para el "+atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}+", para "+String:C10($l_cantidadDeColumnas)+" columnas.")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			BLOB_Variables2Blob (->$x_recNumArray;0;->$al_RecNumAsignaturas)
			EV2dbu_Recalculos ($x_recNumArray;False:C215)
			
		End if 
	Else 
		CD_Dlog (0;"Deben existir asignaturas listadas.")
	End if 
Else 
	CD_Dlog (0;"Ejecutar desde asignaturas.")
End if 