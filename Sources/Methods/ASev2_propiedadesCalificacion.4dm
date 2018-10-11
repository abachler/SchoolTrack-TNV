//%attributes = {}
  // MÉTODO: ASev2_propiedadesCalificacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 02/04/12, 15:32:45
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // ASev2_propiedadesCalificacion()
  // ----------------------------------------------------
C_LONGINT:C283($l_errorALP;$l_parcial;$l_periodo)
C_TEXT:C284($t_arrayName;$t_Coeficiente_o_ponderacion;vtAS_NombreEvaluacion)

ARRAY TEXT:C222($at_ArrayNames;0)

  // CODIGO PRINCIPAL
$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
$l_columna:=AL_GetColumn (xALP_ASNotas)
$l_row:=AL_GetClickedRow (xALP_ASNotas)

$t_arrayName:=$at_ArrayNames{$l_columna}
$l_periodo:=atSTR_Periodos_Nombre
vtAS_NombreEvaluacion:=""

Case of 
	: ($t_arrayName="aNtaP1")
		vtAS_NombreEvaluacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{1}
		
	: ($t_arrayName="aNtaP2")
		vtAS_NombreEvaluacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{2}
		
	: ($t_arrayName="aNtaP3")
		vtAS_NombreEvaluacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{3}
		
	: ($t_arrayName="aNtaP4")
		vtAS_NombreEvaluacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{4}
		
	: ($t_arrayName="aNtaP5")
		vtAS_NombreEvaluacion:=__ ("Promedio ")+atSTR_Periodos_Nombre{5}
		
		
	: ($t_arrayName="aNtaEXP")
		vtAS_NombreEvaluacion:=__ ("Control final ")+atSTR_Periodos_Nombre{$l_periodo}
		
	: ($t_arrayName="aNtaPF")
		vtAS_NombreEvaluacion:=__ ("Promedio anual (antes examen)")
		
	: ($t_arrayName="aNtaEX")
		vtAS_NombreEvaluacion:=__ ("Examen anual")
		
	: ($t_arrayName="aNtaEXX")
		vtAS_NombreEvaluacion:=__ ("Examen extraordinario")
		
	: ($t_arrayName="aNtaF")
		vtAS_NombreEvaluacion:=__ ("Calificación final")
		
	: ($t_arrayName="aNtaEsfuerzo")
		vtAS_NombreEvaluacion:=__ ("Esfuerzo")
		
	: ($t_arrayName="aNtaOF")
		vtAS_NombreEvaluacion:=__ ("Nota Oficial")
		
	: ($t_Arrayname="alSTR_InasistenciasPeriodo")
		vtAS_NombreEvaluacion:=__ ("Inasistencias ")+atSTR_Periodos_Nombre{$l_periodo}
		
		
	Else 
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		If ($l_parcial>0)
			Case of 
				: (alAS_EvalPropSourceID{$l_parcial}<0)
					vtAS_NombreEvaluacion:="Recibe evaluaciones de Subasignatura \""+atAS_EvalPropSourceName{$l_parcial}+"\""
					  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-2)
				: (alAS_EvalPropSourceID{$l_parcial}>0)
					vtAS_NombreEvaluacion:="Recibe evaluaciones de Asignatura consolidante \""+atAS_EvalPropSourceName{$l_parcial}+"\""
					  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-2)
				: (aiAS_EvalPropEnterable{$l_parcial}=0)
					vtAS_NombreEvaluacion:="Ingreso de notas bloqueado en esta columna"
					  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-3)
				Else 
					If (atAS_EvalPropPrintName{$l_parcial}#"")
						vtAS_NombreEvaluacion:="Evaluación para: "+atAS_EvalPropPrintName{$l_parcial}
					Else 
						vtAS_NombreEvaluacion:="Evaluación para parcial Nº "+String:C10($l_parcial)
					End if 
					  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-9)
			End case 
			
			Case of 
				: ([Asignaturas:18]Consolidacion_TipoPonderacion:50=1)
					$t_Coeficiente_o_ponderacion:=String:C10(arAS_EvalPropCoefficient{$l_parcial})
					If ($t_Coeficiente_o_ponderacion#"0")
						vtAS_NombreEvaluacion:=vtAS_NombreEvaluacion+" - Coeficiente: "+String:C10(arAS_EvalPropCoefficient{$l_parcial})
					End if 
				: ([Asignaturas:18]Consolidacion_TipoPonderacion:50=2)
					$t_Coeficiente_o_ponderacion:=String:C10(arAS_EvalPropPercent{$l_parcial})
					If ($t_Coeficiente_o_ponderacion#"0")
						vtAS_NombreEvaluacion:=vtAS_NombreEvaluacion+" - Ponderación:  "+String:C10(arAS_EvalPropPercent{$l_parcial})
					End if 
			End case 
			
			If ($l_row>0)
				Case of 
					: (aNtaRegEximicion{$l_row}#0)
						  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-3)
						vtAS_NombreEvaluacion:=vtAS_NombreEvaluacion+__ (" (Alumno eximido)")
					: (aNtaStatus{vRow}="Retirado@")
						OBJECT SET COLOR:C271(vtAS_NombreEvaluacion;-3)
						  //vtAS_NombreEvaluacion:=vtAS_NombreEvaluacion+__ (" (Alumno retirado)")
					: (aNtaStatus{$l_row}="Promovido@")
						OBJECT SET COLOR:C271(vtAS_NombreEvaluacion;-3)
						vtAS_NombreEvaluacion:=vtAS_NombreEvaluacion+__ (" (Alumno retirado)")
					: (Not:C34(vb_calificacionesEditables))
						  //OBJECT SET COLOR(vtAS_NombreEvaluacion;-3)
				End case 
			End if 
		End if 
End case 



POST OUTSIDE CALL:C329(Current process:C322)