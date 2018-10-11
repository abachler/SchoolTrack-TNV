//%attributes = {}
  // AS_xALP_PropiedadesCalificación()
  // Por: Alberto Bachler K.: 01-02-14, 16:36:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_error;$l_fila;$l_parcial;$l_periodo)
C_TEXT:C284($t_arrayName;$t_fechaCierre;$t_infoAlumno;$t_InfoCalificacion;$t_Ponderacion)
C_POINTER:C301($y_array_bloq)
ARRAY TEXT:C222($at_ArrayNames;0)

$l_columna:=$1
$l_fila:=$2

$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_ArrayNames)


$t_arrayName:=$at_ArrayNames{$l_columna}
$l_periodo:=atSTR_Periodos_Nombre
$t_InfoCalificacion:=""

$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
If ($b_calculosSobreCompetencias)
	OBJECT SET VISIBLE:C603(*;"InfoCalificacion@";False:C215)
	$t_InfoCalificacion:=__ ("Resultados calculados sobre la base de evaluación de competencias")
	OBJECT SET TITLE:C194(*;"InfoCalificacion_Detalle";$t_InfoCalificacion)
	OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Detalle";True:C214)
	
	If ($l_fila>0)
		Case of 
			: (aNtaRegEximicion{$l_fila}#0)
				$t_infoAlumno:=__ ("Eximido")
			: (aNtaStatus{$l_fila}="Retirado@")
				$t_infoAlumno:=__ ("Retirado")
			: (aNtaStatus{$l_fila}="Promovido@")
				$t_infoAlumno:=__ ("Promovido anticipadamente")
			: (aRealNtaF{$l_fila}=-2)
				$t_infoAlumno:=__ ("Calificaciones pendientes")
			: (aNtaReprobada{$l_fila})
				$t_infoAlumno:=__ ("Asignatura reprobada")
			: ((Not:C34(aNtaReprobada{$l_fila})) & (aRealNtaF{$l_fila}>vrNTA_MinimoEscalaReferencia))
				$t_infoAlumno:=__ ("Asignatura aprobada")
			Else 
				$t_infoAlumno:=""
		End case 
	Else 
		$t_infoAlumno:=""
	End if 
	OBJECT SET TITLE:C194(*;"InfoCalificacion_Alumno";$t_infoAlumno)
	OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Alumno";$t_infoAlumno#"")
	
	
Else 
	If ($l_columna>0)
		Case of 
			: ($t_arrayName="aNtaP1")
				$t_InfoCalificacion:=__ ("Resultado ")+atSTR_Periodos_Nombre{1}
				
			: ($t_arrayName="aNtaP2")
				$t_InfoCalificacion:=__ ("Resultado ")+atSTR_Periodos_Nombre{2}
				
			: ($t_arrayName="aNtaP3")
				$t_InfoCalificacion:=__ ("Resultado ")+atSTR_Periodos_Nombre{3}
				
			: ($t_arrayName="aNtaP4")
				$t_InfoCalificacion:=__ ("Resultado ")+atSTR_Periodos_Nombre{4}
				
			: ($t_arrayName="aNtaP5")
				$t_InfoCalificacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{5}
				
				
			: ($t_arrayName="aNtaEXP")
				$t_InfoCalificacion:=__ ("Control de período ")  //+atSTR_Periodos_Nombre{$l_periodo}
				
			: ($t_arrayName="aNtaPF")
				$t_InfoCalificacion:=__ ("Promedio anual")
				
			: ($t_arrayName="aNtaEX")
				$t_InfoCalificacion:=__ ("Examen anual")
				
			: ($t_arrayName="aNtaEXX")
				$t_InfoCalificacion:=__ ("Examen extraordinario")
				
			: ($t_arrayName="aNtaF")
				$t_InfoCalificacion:=__ ("Calificación final")
				
			: ($t_arrayName="aNtaEsfuerzo")
				$t_InfoCalificacion:=__ ("Esfuerzo")
				
			: ($t_arrayName="aNtaOF")
				$t_InfoCalificacion:=__ ("Nota Oficial")
				
			: ($t_arrayName="aNtaPTC_Literal")
				$t_InfoCalificacion:=__ ("Promedio de todas las evaluaciones parciales del año")
				
			: ($t_Arrayname="alSTR_InasistenciasPeriodo")
				$t_InfoCalificacion:=__ ("Inasistencias ")+atSTR_Periodos_Nombre{$l_periodo}
				
			: (($l_columna<4) & ($l_fila>0))
				$t_InfoCalificacion:=aNtaStdNme{$l_fila}
				
			Else 
				AS_ReadEvalProperties 
				$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
				If ($l_parcial>0)
					Case of 
						: (adAS_EvalPropDueDate{$l_parcial}#!00-00-00!)
							$t_fechaCierre:=__ ("Cierre: ")+String:C10(adAS_EvalPropDueDate{$l_parcial};System date abbreviated:K1:2)
						: (adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado}#!00-00-00!)
							$t_fechaCierre:=__ ("Cierre: ")+String:C10(adSTR_Periodos_Cierre{vlSTR_PeriodoSeleccionado};System date abbreviated:K1:2)
						Else 
							$t_fechaCierre:=__ ("Cierre: ")+String:C10(adSTR_Periodos_Hasta{vlSTR_PeriodoSeleccionado};System date abbreviated:K1:2)
					End case 
					
					Case of 
						: (alAS_EvalPropSourceID{$l_parcial}<0)
							$t_InfoCalificacion:=__ ("Subasignatura: ")+atAS_EvalPropSourceName{$l_parcial}
						: (alAS_EvalPropSourceID{$l_parcial}>0)
							$t_InfoCalificacion:=__ ("Asignatura consolidante: ")+atAS_EvalPropSourceName{$l_parcial}
						: (aiAS_EvalPropEnterable{$l_parcial}=0)
							$t_InfoCalificacion:=__ ("Edición inhabilitada")
						Else 
							If (atAS_EvalPropPrintName{$l_parcial}#"")
								$t_InfoCalificacion:=atAS_EvalPropPrintName{$l_parcial}
							Else 
								$t_InfoCalificacion:="Parcial Nº "+String:C10($l_parcial)
							End if 
					End case 
					
					  //MONO BLOQUEO DE PARCIALES
					$y_array_bloq:=Get pointer:C304("ad_BloqueoParcial_P"+String:C10(vlSTR_PeriodoSeleccionado))
					If ($y_array_bloq->{$l_parcial}>!00-00-00!)
						$t_InfoCalificacion:=$t_InfoCalificacion+", "+__ ("Ingreso hasta: ")+String:C10($y_array_bloq->{$l_parcial})
					End if 
					
					Case of 
						: ([Asignaturas:18]Consolidacion_TipoPonderacion:50=1)
							If (arAS_EvalPropCoefficient{$l_parcial}#0)
								$t_Ponderacion:=$t_Ponderacion+" - Coef.: "+String:C10(arAS_EvalPropCoefficient{$l_parcial})
							End if 
						: ([Asignaturas:18]Consolidacion_TipoPonderacion:50=2)
							If (arAS_EvalPropPercent{$l_parcial}#0)
								$t_Ponderacion:=String:C10(arAS_EvalPropPercent{$l_parcial};"##0,00%")
							End if 
						Else 
							$t_Ponderacion:=""
					End case 
				Else 
					$t_Ponderacion:=""
					$t_fechaCierre:=""
				End if 
		End case 
		
		If ($l_fila>0)
			Case of 
				: (aNtaRegEximicion{$l_fila}#0)
					$t_infoAlumno:=__ ("Eximido")
				: (aNtaStatus{$l_fila}="Retirado@")
					$t_infoAlumno:=__ ("Retirado")
				: (aNtaStatus{$l_fila}="Promovido@")
					$t_infoAlumno:=__ ("Promovido anticipadamente")
				: (aRealNtaF{$l_fila}=-2)
					$t_infoAlumno:=__ ("Calificaciones pendientes")
				: (aNtaReprobada{$l_fila})
					$t_infoAlumno:=__ ("Asignatura reprobada")
				: ((Not:C34(aNtaReprobada{$l_fila})) & (aRealNtaF{$l_fila}>vrNTA_MinimoEscalaReferencia))
					$t_infoAlumno:=__ ("Asignatura aprobada")
				Else 
					$t_infoAlumno:=""
			End case 
		Else 
			$t_infoAlumno:=""
		End if 
		$t_restriccion:=AS_xALP_ManejoExcepciones ($l_columna;$l_fila)
		If ($t_restriccion#"")
			$t_InfoCalificacion:=$t_InfoCalificacion+" - "+$t_restriccion
		End if 
	End if 
End if 


OBJECT SET TITLE:C194(*;"InfoCalificacion_Detalle";$t_InfoCalificacion)
OBJECT SET TITLE:C194(*;"InfoCalificacion_Ponderacion";$t_Ponderacion)
OBJECT SET TITLE:C194(*;"InfoCalificacion_FechaCierre";$t_fechaCierre)
OBJECT SET TITLE:C194(*;"InfoCalificacion_Alumno";$t_infoAlumno)
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Ponderacion@";([Asignaturas:18]Consolidacion_TipoPonderacion:50>0))
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Detalle";$t_InfoCalificacion#"")
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Ponderacion";$t_Ponderacion#"")
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_FechaCierre";$t_fechaCierre#"")
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Alumno";$t_infoAlumno#"")

OBJECT SET VISIBLE:C603(*;"InfoCalificacion@";$t_InfoCalificacion#"")
OBJECT SET VISIBLE:C603(*;"InfoCalificacion_Ponderacion@";$t_Ponderacion#"")
