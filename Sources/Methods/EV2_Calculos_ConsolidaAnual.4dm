//%attributes = {}
  // MÉTODO: EV2_Calculos_ConsolidaAnual
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 21:02:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Calculos_ConsolidaAnual()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($IdInstitucion;$año;$periodo;$IdAsignaturaConsolidante;$idAlumno;$method)
C_BOOLEAN:C305($conPonderaciones;$conCoeficientes)
C_REAL:C285($sumaCoeficientes;$ponderacionesAcumuladas;$promedioRealBruto;$0)
ARRAY LONGINT:C221($alAS_EvalPropSourceID;0)
ARRAY REAL:C219($arAS_EvalPropPercent;0)
ARRAY REAL:C219($arAS_EvalPropCoefficient;0)


If (Count parameters:C259=1)
	$recNum:=$1
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNum;True:C214)
End if 
$conEximiciones:=False:C215
$evaluaciones:=0

  // CODIGO PRINCIPAL
OK:=1
  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
  //MONO CAMBIO AS_PropEval_Lectura
AS_PropEval_Lectura ("Anual")

  // // si el estilo de evaluación non esta cargado se lee el numero de estilo en la Asignatura y se carga
$estiloEvaluacion:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
EVS_ReadStyleData ($estiloEvaluacion)


  // //

If (OK=1)
	$recNumRegistroConsolidante:=Record number:C243([Alumnos_Calificaciones:208])
	
	[Alumnos_Calificaciones:208]Anual_Real:11:=-10
	[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
	[Alumnos_Calificaciones:208]Anual_Literal:15:=""
	[Alumnos_Calificaciones:208]Anual_Nota:12:=-10
	[Alumnos_Calificaciones:208]Anual_Puntos:13:=-10
	[Alumnos_Calificaciones:208]Anual_Simbolo:14:=""
	
	  // // Copio arreglos y variables de las propiedades de evaluación de la asignatura madre que son necesarios para los calculos, 
	  //conservando sus valores cuando se necesario leer las propiedades de asignaturas hijas
	COPY ARRAY:C226(alAS_EvalPropSourceID;$alAS_EvalPropSourceID)
	COPY ARRAY:C226(arAS_EvalPropPercent;$arAS_EvalPropPercent)
	COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficient)
	$sumPonderaciones:=AT_GetSumArray (->arAS_EvalPropPercent)
	$conPonderaciones:=($sumPonderaciones>0)
	$sumaCoeficientes:=AT_GetSumArray (->arAS_EvalPropCoefficient)
	If (($sumaCoeficientes#12) & ($sumaCoeficientes>0))
		$conCoeficientes:=True:C214
	End if 
	  // //
	
	
	$sum:=0
	$div:=0
	$ponderacionesAcumuladas:=0
	
	
	For ($iParciales;1;Size of array:C274($alAS_EvalPropSourceID))
		$evaluacion:=-10
		Case of 
			: ($conPonderaciones)
				$ponderacion:=$arAS_EvalPropPercent{$iParciales}
			: ($conCoeficientes)
				$coeficiente:=$arAS_EvalPropCoefficient{$iParciales}
			Else 
				$ponderacion:=0
				$coeficiente:=0
		End case 
		
		Case of 
			: ($alAS_EvalPropSourceID{$iParciales}>0)  //asignaturas hijas
				$vsIdInstitucion:=String:C10([Alumnos_Calificaciones:208]ID_institucion:2)
				$vsAño:=String:C10([Alumnos_Calificaciones:208]Año:3)
				$vsIdAsignatura:=String:C10($alAS_EvalPropSourceID{$iParciales})
				$vsIdAlumno:=String:C10([Alumnos_Calificaciones:208]ID_Alumno:6)
				$vsNivel:=String:C10([Alumnos_Calificaciones:208]NIvel_Numero:4)
				$key:=$vsIdInstitucion+"."+$vsAño+"."+$vsNivel+"."+$vsIdAsignatura+"."+$vsIdAlumno
				$recNumComponente:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$key)
				KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNumComponente)
				If (OK=1)
					$evaluacion:=[Alumnos_Calificaciones:208]Anual_Real:11
					Case of 
						: ($evaluacion=-3)
							$sum:=-3
							$iParciales:=Size of array:C274($alAS_EvalPropSourceID)
							
						: ($evaluacion=-2)
							$sum:=-2
							$iParciales:=Size of array:C274($alAS_EvalPropSourceID)
							
						: ($evaluacion>=vrNTA_MinimoEscalaReferencia)
							$evaluaciones:=$evaluaciones+1
							Case of 
								: ($conPonderaciones)
									$evaluacionPonderada:=EV2_PonderaEvaluacion ($evaluacion;$ponderacion)
									If ($evaluacionPonderada>=0)
										$sum:=$sum+$evaluacionPonderada
									End if 
									$ponderacionesAcumuladas:=$ponderacionesAcumuladas+$ponderacion
									
								: ($conCoeficientes)
									$sum:=$sum+Round:C94($evaluacion*$coeficiente;11)
									$div:=$div+$coeficiente
								Else 
									$sum:=Round:C94($sum+$evaluacion;11)
									$div:=$div+1
							End case 
							
						Else 
							  //si no hay calificaciones o el alumno está eximido de la asignatura se ignoran los valores
					End case 
				End if 
				
		End case 
	End for 
	
	KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNumRegistroConsolidante;True:C214)
	
	Case of 
		: (($conEximiciones) & ($evaluaciones=0))
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-2
			
		: ($evaluaciones=0)
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=-10
			
		: (($sum=-2) | ($sum=-3))
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=$sum
			
		: (($conPonderaciones) & ($evaluaciones>0))
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=Round:C94($sum/$ponderacionesAcumuladas*100;11)
			
		: (($conCoeficientes) & ($evaluaciones>0))
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=Round:C94($sum/$div;11)
			
		: (($sum>0) & ($div>0))
			[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501:=Round:C94($sum/$div;11)
	End case 
	
	  //If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones]Anual_RealNoAproximado<rPctMinimum))
	  //$r_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones]Anual_RealNoAproximado;vi_TruncarInferiorRequerido)
	  //[Alumnos_Calificaciones]Anual_RealNoAproximado:=EV2_Nota_a_Real ($r_Nota)
	  //End if 
	
	
	[Alumnos_Calificaciones:208]Anual_Real:11:=[Alumnos_Calificaciones:208]Anual_RealNoAproximado:501
	
	  // si el promedio es inferior al mínimo requerido y no debe ser truncado
	If ((vi_TruncarInferiorRequerido=1) & ([Alumnos_Calificaciones:208]Anual_Real:11<rPctMinimum))
		Case of 
			: (iEvaluationMode=Notas)
				$r_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_TruncarInferiorRequerido)
				[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Nota_a_Real ($r_Nota)
				
			: (iEvaluationMode=Puntos)
				$r_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_TruncarInferiorRequerido)
				[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ($r_Puntos)
				
			: (iEvaluationMode=Porcentaje)
				[Alumnos_Calificaciones:208]Anual_Real:11:=Trunc:C95([Alumnos_Calificaciones:208]Anual_Real:11;1)
				
		End case 
	End if 
	
	Case of 
		: (iEvaluationMode=Notas)
			$r_Nota:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
			[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Nota_a_Real ($r_Nota)
			
		: (iEvaluationMode=Puntos)
			$r_Puntos:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
			[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Puntos_a_Real ($r_Puntos)
			
		: (iEvaluationMode=Simbolos)
			$t_Simbolo:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
			[Alumnos_Calificaciones:208]Anual_Real:11:=EV2_Simbolo_a_Real ($t_Simbolo)
	End case 
	[Alumnos_Calificaciones:208]Anual_Literal:15:=EV2_Real_a_Literal ([Alumnos_Calificaciones:208]Anual_Real:11;iPrintMode;vlNTA_DecimalesPF)
	[Alumnos_Calificaciones:208]Anual_Nota:12:=EV2_Real_a_Nota ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iGradesDecPF)
	[Alumnos_Calificaciones:208]Anual_Puntos:13:=EV2_Real_a_Puntos ([Alumnos_Calificaciones:208]Anual_Real:11;vi_gTrFAvg;iPointsDecPF)
	[Alumnos_Calificaciones:208]Anual_Simbolo:14:=EV2_Real_a_Simbolo ([Alumnos_Calificaciones:208]Anual_Real:11)
	
	
	EV2loc_Ajustes_Anual 
	
	SAVE RECORD:C53([Alumnos_Calificaciones:208])
End if 


  //LIMPIEZA

