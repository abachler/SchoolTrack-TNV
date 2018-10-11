//%attributes = {}
C_TEXT:C284($json;$0)
C_OBJECT:C1216($ob_objetoRaiz)


PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
EV2_Examenes_LeeConfigExamenes ($periodo)
$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)

ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aEje;0)
ARRAY LONGINT:C221($aTableNumbers;0)
ARRAY LONGINT:C221($aFieldNumbers;0)

$ob_objetoRaiz:=OB_Create 
APPEND TO ARRAY:C911($aNombres;"P1")
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P01_Final_Real:112))
APPEND TO ARRAY:C911($aEje;"porcentaje")
Case of 
	: (vlSTR_Periodos_Tipo=2 Semestres)
		APPEND TO ARRAY:C911($aNombres;"P2")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Real:187))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
	: (vlSTR_Periodos_Tipo=3 Trimestres)
		APPEND TO ARRAY:C911($aNombres;"P2")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Real:187))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
		APPEND TO ARRAY:C911($aNombres;"P3")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Real:262))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
	: (vlSTR_Periodos_Tipo=4 Bimestres)
		APPEND TO ARRAY:C911($aNombres;"P2")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Real:187))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
		APPEND TO ARRAY:C911($aNombres;"P3")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Real:262))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
		APPEND TO ARRAY:C911($aNombres;"P4")
		APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Real:337))
		APPEND TO ARRAY:C911($aEje;"porcentaje")
	Else 
		If (vlSTR_Periodos_Tipo#Anual)
			APPEND TO ARRAY:C911($aNombres;"P2")
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Real:187))
			APPEND TO ARRAY:C911($aEje;"porcentaje")
			APPEND TO ARRAY:C911($aNombres;"P3")
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Real:262))
			APPEND TO ARRAY:C911($aEje;"porcentaje")
			APPEND TO ARRAY:C911($aNombres;"P4")
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Real:337))
			APPEND TO ARRAY:C911($aEje;"porcentaje")
			APPEND TO ARRAY:C911($aNombres;"P5")
			APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
			APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Real:412))
			APPEND TO ARRAY:C911($aEje;"porcentaje")
		End if 
End case 
If (vi_UsarExamenes#0)
	APPEND TO ARRAY:C911($aNombres;"PA")
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]Anual_Real:11))
	APPEND TO ARRAY:C911($aEje;"porcentaje")
	APPEND TO ARRAY:C911($aNombres;"EX")
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]ExamenAnual_Real:16))
	APPEND TO ARRAY:C911($aEje;"porcentaje")
End if 
If (vi_UsarExamenExtra#0)
	APPEND TO ARRAY:C911($aNombres;"EXX")
	APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
	APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]ExamenExtra_Real:21))
	APPEND TO ARRAY:C911($aEje;"porcentaje")
End if 
APPEND TO ARRAY:C911($aNombres;"NF")
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26))
APPEND TO ARRAY:C911($aEje;"porcentaje")
APPEND TO ARRAY:C911($aNombres;"NO")
APPEND TO ARRAY:C911($aTableNumbers;Table:C252(->[Alumnos_Calificaciones:208]))
APPEND TO ARRAY:C911($aFieldNumbers;Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32))
APPEND TO ARRAY:C911($aEje;"porcentaje")

  //Periodicas
  //$t_nodoPeriodicas:=JSON Append node ($t_raizJson;"periodicas")
ARRAY OBJECT:C1221($aob_listaperiodos;0)
C_OBJECT:C1216($ob_nodoperiodicas)
$ob_nodoperiodicas:=OB_Create 

For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
	ARRAY TEXT:C222($aNombresPER;0)
	ARRAY TEXT:C222($aEjePER;0)
	ARRAY LONGINT:C221($aTableNumbersPER;0)
	ARRAY LONGINT:C221($aFieldNumbersPER;0)
	AS_PropEval_Lectura ("";aiSTR_Periodos_Numero{$i})
	If ($modoRegistroAsistencia=4)
		APPEND TO ARRAY:C911($aNombresPER;"AUS")
		APPEND TO ARRAY:C911($aTableNumbersPER;Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		APPEND TO ARRAY:C911($aFieldNumbersPER;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10(aiSTR_Periodos_Numero{$i})+"_Inasistencias")))
		APPEND TO ARRAY:C911($aEjePER;"auto")
	End if 
	If (vi_UsarControlesFinPeriodo#0)
		APPEND TO ARRAY:C911($aNombresPER;"CP")
		APPEND TO ARRAY:C911($aTableNumbersPER;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbersPER;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10(aiSTR_Periodos_Numero{$i})+"_Control_Real")))
		APPEND TO ARRAY:C911($aEjePER;"porcentaje")
	End if 
	If ([Asignaturas:18]Ingresa_Esfuerzo:40)
		APPEND TO ARRAY:C911($aNombresPER;"ESF")
		APPEND TO ARRAY:C911($aTableNumbersPER;Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
		APPEND TO ARRAY:C911($aFieldNumbersPER;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10(aiSTR_Periodos_Numero{$i})+"_Esfuerzo")))
		APPEND TO ARRAY:C911($aEjePER;"custom")
	End if 
	  //
	For ($j;1;12)
		If (atAS_EvalPropPrintName{$j}#"")
			APPEND TO ARRAY:C911($aNombresPER;String:C10($j)+" ("+atAS_EvalPropPrintName{$j}+")")
		Else 
			APPEND TO ARRAY:C911($aNombresPER;String:C10($j))
		End if 
		APPEND TO ARRAY:C911($aTableNumbersPER;Table:C252(->[Alumnos_Calificaciones:208]))
		APPEND TO ARRAY:C911($aFieldNumbersPER;Field:C253(KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10(aiSTR_Periodos_Numero{$i})+"_Eval"+String:C10($j;"0#")+"_Real")))
		APPEND TO ARRAY:C911($aEjePER;"porcentaje")
	End for 
	  //$t_nodoPeriodo:=JSON Append node ($t_nodoPeriodicas;"periodo"+String(aiSTR_Periodos_Numero{$i}))
	C_OBJECT:C1216($ob_nodoperiodo)
	$ob_nodoperiodo:=OB_Create 
	OB_SET ($ob_nodoperiodo;->$aNombresPER;"nombres";"")
	OB_SET ($ob_nodoperiodo;->$aTableNumbersPER;"tablas";"")
	OB_SET ($ob_nodoperiodo;->$aFieldNumbersPER;"campos";"")
	OB_SET ($ob_nodoperiodo;->$aEjePER;"ejes";"")
	APPEND TO ARRAY:C911($aob_listaperiodos;$ob_nodoperiodo)
End for 

C_OBJECT:C1216($ob_nodoNoPeriodicas)
$ob_nodoNoPeriodicas:=OB_Create 
OB_SET ($ob_nodoNoPeriodicas;->$aNombres;"nombres";"")
OB_SET ($ob_nodoNoPeriodicas;->$aTableNumbers;"tablas";"")
OB_SET ($ob_nodoNoPeriodicas;->$aFieldNumbers;"campos";"")
OB_SET ($ob_nodoNoPeriodicas;->$aEje;"ejes";"")

  //$t_nodoNoPeriodicas:=JSON Append node ($t_raizJson;"noperiodicas")
  //STWA2_Arreglo_a_json ($t_nodoNoPeriodicas;->$aNombres;"nombres";"")
  //STWA2_Arreglo_a_json ($t_nodoNoPeriodicas;->$aTableNumbers;"tablas";"")
  //STWA2_Arreglo_a_json ($t_nodoNoPeriodicas;->$aFieldNumbers;"campos";"")
  //STWA2_Arreglo_a_json ($t_nodoNoPeriodicas;->$aEje;"ejes";"")

C_POINTER:C301($y_pointer)
C_OBJECT:C1216($ob_nodoListaPeriodos)
$ob_nodoListaPeriodos:=OB_Create 
OB_SET ($ob_nodoListaPeriodos;->atSTR_Periodos_Nombre;"nombres";"")
OB_SET ($ob_nodoListaPeriodos;->aiSTR_Periodos_Numero;"numeros";"###0")
OB_SET_Text ($ob_nodoListaPeriodos;String:C10($periodo);"actual")


  //$t_nodoListaPeriodos:=JSON Append node ($t_raizJson;"periodos")
  //STWA2_Arreglo_a_json ($t_nodoListaPeriodos;->atSTR_Periodos_Nombre;"nombres";"")
  //STWA2_Arreglo_a_json ($t_nodoListaPeriodos;->aiSTR_Periodos_Numero;"numeros";"###0")
  //JSON_AgregaTexto ($t_nodoListaPeriodos;ST_Qte (String($periodo));ST_Qte ("actual"))


C_OBJECT:C1216($ob_periodicas)
ARRAY OBJECT:C1221($aob_periodos;0)
$ob_periodicas:=OB_Create 
For ($i;1;Size of array:C274($aob_listaperiodos))
	OB_SET ($ob_periodicas;->$aob_listaperiodos{$i};"periodo"+String:C10($i))
	  //APPEND TO ARRAY($aob_periodos;$ob_periodicas)
End for 
OB_SET ($ob_objetoRaiz;->$ob_periodicas;"periodicas")
OB_SET ($ob_objetoRaiz;->$ob_nodoNoPeriodicas;"noperiodicas")
OB_SET ($ob_objetoRaiz;->$ob_nodoListaPeriodos;"periodos")


  //$0:=JSON Export to text ($t_raizJson;JSON_WITH_WHITE_SPACE)
  //JSON CLOSE ($t_raizJson)
$0:=OB_Object2Json ($ob_objetoRaiz)
$t_text:=OB_Object2Json ($ob_objetoRaiz)
SET TEXT TO PASTEBOARD:C523($t_text)
