//%attributes = {}
  //SN3_SendAsignaturasXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_REAL:C285($real_value)

$todos:=True:C214
$useArrays:=False:C215

Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (SN3_DTi_Asignaturas;$todos;$useArrays)
If (Records in selection:C76([Asignaturas:18])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Asignaturas:18];$recNums;[Asignaturas:18]Numero:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Asignaturas;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Asignaturas;"asignaturas";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de asignaturas..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Asignaturas:18];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"asignatura")
		SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Asignaturas:18]Numero:1))
		SAX_CreateNode ($refXMLDoc;"nombreoficial";True:C214;[Asignaturas:18]Asignatura:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"nombreinterno";True:C214;[Asignaturas:18]denominacion_interna:16;True:C214)
		SAX_CreateNode ($refXMLDoc;"abreviacion";True:C214;[Asignaturas:18]Abreviación:26;True:C214)
		SAX_CreateNode ($refXMLDoc;"codigointerno";True:C214;[Asignaturas:18]Codigo_interno:48;True:C214)
		SAX_CreateNode ($refXMLDoc;"idprofesor";True:C214;String:C10([Asignaturas:18]profesor_numero:4))
		SAX_CreateNode ($refXMLDoc;"idfirmante";True:C214;String:C10([Asignaturas:18]profesor_firmante_numero:33))
		SAX_CreateNode ($refXMLDoc;"nivelnumero";True:C214;String:C10([Asignaturas:18]Numero_del_Nivel:6))
		SAX_CreateNode ($refXMLDoc;"curso";True:C214;[Asignaturas:18]Curso:5;True:C214)
		SAX_CreateNode ($refXMLDoc;"incidepromediointerno";True:C214;String:C10(Num:C11([Asignaturas:18]IncideEnPromedioInterno:64)))
		SAX_CreateNode ($refXMLDoc;"incidepromediooficial";True:C214;String:C10(Num:C11([Asignaturas:18]Incide_en_promedio:27)))
		SAX_CreateNode ($refXMLDoc;"ordengeneral";True:C214;[Asignaturas:18]ordenGeneral:105;True:C214)
		SAX_CreateNode ($refXMLDoc;"esmadre";True:C214;String:C10(Num:C11([Asignaturas:18]Consolidacion_EsConsolidante:35)))
		SAX_CreateNode ($refXMLDoc;"idmatrizaprendizajes";True:C214;String:C10([Asignaturas:18]EVAPR_IdMatriz:91))
		SAX_CreateNode ($refXMLDoc;"horassemanales";True:C214;String:C10([Asignaturas:18]Horas_Semanales:51))
		SAX_CreateNode ($refXMLDoc;"horasefectivas";True:C214;String:C10([Asignaturas:18]Horas_de_clases_efectivas:52))
		SAX_CreateNode ($refXMLDoc;"incideasistencia";True:C214;String:C10(Num:C11([Asignaturas:18]Incide_en_Asistencia:45)))
		SAX_CreateNode ($refXMLDoc;"eninformesinternos";True:C214;String:C10(Num:C11([Asignaturas:18]En_InformesInternos:14)))
		SAX_CreateNode ($refXMLDoc;"publicarenschoolnet";True:C214;String:C10([Asignaturas:18]Publicar_en_SchoolNet:60))
		SAX_CreateNode ($refXMLDoc;"desplegaresfuerzo";True:C214;String:C10(Num:C11([Asignaturas:18]Ingresa_Esfuerzo:40)))
		EV2_Examenes_LeeConfigExamenes 
		SAX_CreateNode ($refXMLDoc;"desplegarexpa";True:C214;String:C10(vi_UsarExamenes))
		SAX_CreateNode ($refXMLDoc;"desplegarexx";True:C214;String:C10(vi_UsarExamenExtra))
		SAX_CreateNode ($refXMLDoc;"desplegarcp";True:C214;String:C10(vi_UsarControlesFinPeriodo))
		
		
		  //20161004 JVP
		  // agrego tag de bonificacion
		SAX_CreateNode ($refXMLDoc;"desplegarbx";True:C214;String:C10(vi_UsarBonificacion))
		
		
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		SAX_CreateNode ($refXMLDoc;"estadisticas")
		For ($x;1;Size of array:C274(aiSTR_Periodos_Numero))
			Case of 
				: ($x=1)
					$fieldMax:=->[Asignaturas_SintesisAnual:202]P01_Maximo_Literal:105
					$fieldMax_R:=->[Asignaturas_SintesisAnual:202]P01_Maximo_Real:85
					$fieldMax_N:=->[Asignaturas_SintesisAnual:202]P01_Maximo_Nota:90
					$fieldMax_P:=->[Asignaturas_SintesisAnual:202]P01_Maximo_Puntos:95
					$fieldMax_S:=->[Asignaturas_SintesisAnual:202]P01_Maximo_Simbolo:100
					
					$fieldProm:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29
					$fieldProm_R:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25
					$fieldProm_N:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Nota:26
					$fieldProm_P:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Puntos:27
					$fieldProm_S:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Simbolo:28
					
					$fieldMin:=->[Asignaturas_SintesisAnual:202]P01_Minimo_Literal:65
					$fieldMin_R:=->[Asignaturas_SintesisAnual:202]P01_Minimo_Real:50
					$fieldMin_N:=->[Asignaturas_SintesisAnual:202]P01_Minimo_Nota:55
					$fieldMin_P:=->[Asignaturas_SintesisAnual:202]P01_Minimo_Puntos:60
					$fieldMin_S:=->[Asignaturas_SintesisAnual:202]P01_Minimo_Simbolo:70
					
				: ($x=2)
					$fieldMax:=->[Asignaturas_SintesisAnual:202]P02_Maximo_Literal:106
					$fieldMax_R:=->[Asignaturas_SintesisAnual:202]P02_Maximo_Real:86
					$fieldMax_N:=->[Asignaturas_SintesisAnual:202]P02_Maximo_Nota:91
					$fieldMax_P:=->[Asignaturas_SintesisAnual:202]P02_Maximo_Puntos:96
					$fieldMax_S:=->[Asignaturas_SintesisAnual:202]P02_Maximo_Simbolo:101
					
					$fieldProm:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34
					$fieldProm_R:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30
					$fieldProm_N:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Nota:31
					$fieldProm_P:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Puntos:32
					$fieldProm_S:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Simbolo:33
					
					$fieldMin:=->[Asignaturas_SintesisAnual:202]P02_Minimo_Literal:66
					$fieldMin_R:=->[Asignaturas_SintesisAnual:202]P02_Minimo_Real:51
					$fieldMin_N:=->[Asignaturas_SintesisAnual:202]P02_Minimo_Nota:56
					$fieldMin_P:=->[Asignaturas_SintesisAnual:202]P02_Minimo_Puntos:61
					$fieldMin_S:=->[Asignaturas_SintesisAnual:202]P02_Minimo_Simbolo:71
					
				: ($x=3)
					$fieldMax:=->[Asignaturas_SintesisAnual:202]P03_Maximo_Literal:107
					$fieldMax_R:=->[Asignaturas_SintesisAnual:202]P03_Maximo_Real:87
					$fieldMax_N:=->[Asignaturas_SintesisAnual:202]P03_Maximo_Nota:92
					$fieldMax_P:=->[Asignaturas_SintesisAnual:202]P03_Maximo_Puntos:97
					$fieldMax_S:=->[Asignaturas_SintesisAnual:202]P03_Maximo_Simbolo:102
					
					$fieldProm:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39
					$fieldProm_R:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35
					$fieldProm_N:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Nota:36
					$fieldProm_P:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Puntos:37
					$fieldProm_S:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Simbolo:38
					
					$fieldMin:=->[Asignaturas_SintesisAnual:202]P03_Minimo_Literal:67
					$fieldMin_R:=->[Asignaturas_SintesisAnual:202]P03_Minimo_Real:52
					$fieldMin_N:=->[Asignaturas_SintesisAnual:202]P03_Minimo_Nota:57
					$fieldMin_P:=->[Asignaturas_SintesisAnual:202]P03_Minimo_Puntos:62
					$fieldMin_S:=->[Asignaturas_SintesisAnual:202]P03_Minimo_Simbolo:72
					
				: ($x=4)
					$fieldMax:=->[Asignaturas_SintesisAnual:202]P04_Maximo_Literal:108
					$fieldMax_R:=->[Asignaturas_SintesisAnual:202]P04_Maximo_Real:88
					$fieldMax_N:=->[Asignaturas_SintesisAnual:202]P04_Maximo_Nota:93
					$fieldMax_P:=->[Asignaturas_SintesisAnual:202]P04_Maximo_Puntos:98
					$fieldMax_S:=->[Asignaturas_SintesisAnual:202]P04_Maximo_Simbolo:103
					
					$fieldProm:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44
					$fieldProm_R:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40
					$fieldProm_N:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Nota:41
					$fieldProm_P:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Puntos:42
					$fieldProm_S:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Simbolo:43
					
					$fieldMin:=->[Asignaturas_SintesisAnual:202]P04_Minimo_Literal:68
					$fieldMin_R:=->[Asignaturas_SintesisAnual:202]P04_Minimo_Real:53
					$fieldMin_N:=->[Asignaturas_SintesisAnual:202]P04_Minimo_Nota:58
					$fieldMin_P:=->[Asignaturas_SintesisAnual:202]P04_Minimo_Puntos:63
					$fieldMin_S:=->[Asignaturas_SintesisAnual:202]P04_Minimo_Simbolo:73
					
				: ($x=5)
					$fieldMax:=->[Asignaturas_SintesisAnual:202]P05_Maximo_Literal:109
					$fieldMax_R:=->[Asignaturas_SintesisAnual:202]P05_Maximo_Real:89
					$fieldMax_N:=->[Asignaturas_SintesisAnual:202]P05_Maximo_Nota:94
					$fieldMax_P:=->[Asignaturas_SintesisAnual:202]P05_Maximo_Puntos:99
					$fieldMax_S:=->[Asignaturas_SintesisAnual:202]P05_Maximo_Simbolo:104
					
					$fieldProm:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49
					$fieldProm_R:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45
					$fieldProm_N:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Nota:46
					$fieldProm_P:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Puntos:47
					$fieldProm_S:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Simbolo:48
					
					$fieldMin:=->[Asignaturas_SintesisAnual:202]P05_Minimo_Literal:69
					$fieldMin_R:=->[Asignaturas_SintesisAnual:202]P05_Minimo_Real:54
					$fieldMin_N:=->[Asignaturas_SintesisAnual:202]P05_Minimo_Nota:59
					$fieldMin_P:=->[Asignaturas_SintesisAnual:202]P05_Minimo_Puntos:64
					$fieldMin_S:=->[Asignaturas_SintesisAnual:202]P05_Minimo_Simbolo:74
					
			End case 
			$key:=String:C10(0)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
			$max:=""
			$min:=""
			$med:=""
			$real_value:=0
			
			SAX_CreateNode ($refXMLDoc;"maximo")
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($x))
			AS_LeeSintesisAnual ($key;$fieldMax;->$max)
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;$max)
			
			AS_LeeSintesisAnual ($key;$fieldMax_R;->$real_value)
			If ($real_value>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
				AS_LeeSintesisAnual ($key;$fieldMax_N;->$real_value)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldMax_P;->$real_value)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldMax_S;->$max)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$max)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$max)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$max)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$max)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$max)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			SAX_CreateNode ($refXMLDoc;"promedio")
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($x))
			AS_LeeSintesisAnual ($key;$fieldProm;->$med)
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;$med)
			
			AS_LeeSintesisAnual ($key;$fieldProm_R;->$real_value)
			If ($real_value>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
				AS_LeeSintesisAnual ($key;$fieldProm_N;->$real_value)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldProm_P;->$real_value)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldProm_S;->$med)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$med)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$med)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$med)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$med)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$med)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			SAX_CreateNode ($refXMLDoc;"minimo")
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($x))
			AS_LeeSintesisAnual ($key;$fieldMin;->$min)
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;$min)
			
			AS_LeeSintesisAnual ($key;$fieldMin_R;->$real_value)
			If ($real_value>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
				AS_LeeSintesisAnual ($key;$fieldMin_N;->$real_value)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldMin_P;->$real_value)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
				AS_LeeSintesisAnual ($key;$fieldMin_S;->$min)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$min)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$min)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$min)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$min)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$min)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
		End for 
		
		$key:=String:C10(0)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero:1)
		$max:=""
		$min:=""
		$med:=""
		$real_value:=0
		
		SAX_CreateNode ($refXMLDoc;"maximo")
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Maximo_Literal:119;->$max)
		SAX_CreateNode ($refXMLDoc;"valor";True:C214;$max)
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Maximo_Real:115;->$real_value)
		If ($real_value>=0)
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Maximo_Nota:116;->$real_value)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Maximo_Puntos:117;->$real_value)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Maximo_Simbolo:118;->$max)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$max)
		Else 
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$max)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$max)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$max)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$max)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		
		SAX_CreateNode ($refXMLDoc;"promedio")
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;->$med)
		SAX_CreateNode ($refXMLDoc;"valor";True:C214;$med)
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;->$real_value)
		If ($real_value>=0)
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]PromedioFinal_Nota:16;->$real_value)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]PromedioFinal_Puntos:17;->$real_value)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]PromedioFinal_Simbolo:18;->$med)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$med)
		Else 
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$med)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$med)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$med)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$med)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		
		SAX_CreateNode ($refXMLDoc;"minimo")
		SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"-1")
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Minimo_Literal:83;->$min)
		SAX_CreateNode ($refXMLDoc;"valor";True:C214;$min)
		AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Minimo_Real:80;->$real_value)
		If ($real_value>=0)
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($real_value;Porcentaje))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Minimo_Nota:81;->$real_value)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Minimo_Puntos:82;->$real_value)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($real_value)))
			AS_LeeSintesisAnual ($key;->[Asignaturas_SintesisAnual:202]Final_Minimo_Simbolo:84;->$min)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$min)
		Else 
			SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$min)
			SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$min)
			SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$min)
			SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$min)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		
		SAX_CreateNode ($refXMLDoc;"propiedades")
		$colPond:="0"
		For ($x;1;Size of array:C274(aiSTR_Periodos_Numero))
			AS_ReadEvalProperties ("";aiSTR_Periodos_Numero{$x})
			SN3_RecopilaPropsEvaluacion ($refXMLDoc;String:C10($x))
			arAS_EvalPropPonderacion{0}:=0
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->arAS_EvalPropPonderacion;">";->$DA_Return)
			If (($colPond="0") & (Size of array:C274($DA_Return)>0))
				$colPond:="1"
			End if 
		End for 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		SAX_CreateNode ($refXMLDoc;"desplegarpond";True:C214;$colPond)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Asignaturas;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de asignaturas.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de asignaturas no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)