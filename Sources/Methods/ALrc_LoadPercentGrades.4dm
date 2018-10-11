//%attributes = {}
  //ALrc_LoadPercentGrades

  // 20180126 Patricio Aliaga, cambio variable vi_PrintMode por iViewMode por cambio en metodo EVS_ReadStyleData

C_LONGINT:C283($periodo;$rubOfst;$2;$convertTo)
  //If (Undefined(vi_PrintMode))  //20150626 RCH para evitar error en compilado... NO quise arreglarlo antes en el codigo porque en el blob podría estar indefinida la variable y al pasar a definida podría aparecer un erroral leer las variables desde el blob...
  //C_REAL(vi_PrintMode)
  //End if 
C_LONGINT:C283(iViewMode;$vlNTA_DecimalesParciales)
EV2_InitArrays 
vlEVS_CurrentEvStyleID:=0

$periodo:=$1
$styleID:=0
$convertTo:=0
Case of 
	: (Count parameters:C259=4)
		$convertTo:=$2
		$styleID:=$3
	: (Count parameters:C259=3)
		$convertTo:=$2
		$styleID:=$3
	: (Count parameters:C259>=2)
		$convertTo:=$2
End case 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]En_InformesInternos:14=True:C214)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;aRealNtaP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealNtaP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealNtaP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealNtaP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealNtaP5;[Alumnos_Calificaciones:208]Anual_Real:11;aRealNtaPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealNtaEx;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]Reprobada:9;aNtaReprobada;[Asignaturas:18]Asignatura:3;aNtaAsignatura;[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;aRealAsgAverage;[Asignaturas:18]posicion_en_informes_de_notas:36;aNtaOrden;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID;[Asignaturas:18]denominacion_interna:16;aNtaInternalName;[Asignaturas:18]Incide_en_promedio:27;aIncide;[Asignaturas:18]Sector:9;aSector;[Asignaturas:18]Electiva:11;aElectiva;[Asignaturas:18]Numero:1;aNtaIdAsignatura;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Alumnos_Calificaciones:208]ExamenExtra_Real:21;aRealNtaEXX)
  //agrego Bonificacion Real al arreglo aRealNtaBX 
  //JVP 20160706 164731
Case of 
	: ($periodo=1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Eval01_Real:42;aRealNta1;[Alumnos_Calificaciones:208]P01_Eval02_Real:47;aRealNta2;[Alumnos_Calificaciones:208]P01_Eval03_Real:52;aRealNta3;[Alumnos_Calificaciones:208]P01_Eval04_Real:57;aRealNta4;[Alumnos_Calificaciones:208]P01_Eval05_Real:62;aRealNta5;[Alumnos_Calificaciones:208]P01_Eval06_Real:67;aRealNta6;[Alumnos_Calificaciones:208]P01_Eval07_Real:72;aRealNta7;[Alumnos_Calificaciones:208]P01_Eval08_Real:77;aRealNta8;[Alumnos_Calificaciones:208]P01_Eval09_Real:82;aRealNta9;[Alumnos_Calificaciones:208]P01_Eval10_Real:87;aRealNta10;[Alumnos_Calificaciones:208]P01_Eval11_Real:92;aRealNta11;[Alumnos_Calificaciones:208]P01_Eval12_Real:97;aRealNta12;[Alumnos_Calificaciones:208]P01_Control_Real:107;aRealNtaEXP;[Alumnos_Calificaciones:208]P01_Presentacion_Real:102;aRealNtaPresentP;[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510;aRealNtaBX)
	: ($periodo=2)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Eval01_Real:117;aRealNta1;[Alumnos_Calificaciones:208]P02_Eval02_Real:122;aRealNta2;[Alumnos_Calificaciones:208]P02_Eval03_Real:127;aRealNta3;[Alumnos_Calificaciones:208]P02_Eval04_Real:132;aRealNta4;[Alumnos_Calificaciones:208]P02_Eval05_Real:137;aRealNta5;[Alumnos_Calificaciones:208]P02_Eval06_Real:142;aRealNta6;[Alumnos_Calificaciones:208]P02_Eval07_Real:147;aRealNta7;[Alumnos_Calificaciones:208]P02_Eval08_Real:152;aRealNta8;[Alumnos_Calificaciones:208]P02_Eval09_Real:157;aRealNta9;[Alumnos_Calificaciones:208]P02_Eval10_Real:162;aRealNta10;[Alumnos_Calificaciones:208]P02_Eval11_Real:167;aRealNta11;[Alumnos_Calificaciones:208]P02_Eval12_Real:172;aRealNta12;[Alumnos_Calificaciones:208]P02_Control_Real:182;aRealNtaEXP;[Alumnos_Calificaciones:208]P02_Presentacion_Real:177;aRealNtaPresentP;[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515;aRealNtaBX)
	: ($periodo=3)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Eval01_Real:192;aRealNta1;[Alumnos_Calificaciones:208]P03_Eval02_Real:197;aRealNta2;[Alumnos_Calificaciones:208]P03_Eval03_Real:202;aRealNta3;[Alumnos_Calificaciones:208]P03_Eval04_Real:207;aRealNta4;[Alumnos_Calificaciones:208]P03_Eval05_Real:212;aRealNta5;[Alumnos_Calificaciones:208]P03_Eval06_Real:217;aRealNta6;[Alumnos_Calificaciones:208]P03_Eval07_Real:222;aRealNta7;[Alumnos_Calificaciones:208]P03_Eval08_Real:227;aRealNta8;[Alumnos_Calificaciones:208]P03_Eval09_Real:232;aRealNta9;[Alumnos_Calificaciones:208]P03_Eval10_Real:237;aRealNta10;[Alumnos_Calificaciones:208]P03_Eval11_Real:242;aRealNta11;[Alumnos_Calificaciones:208]P03_Eval12_Real:247;aRealNta12;[Alumnos_Calificaciones:208]P03_Control_Real:257;aRealNtaEXP;[Alumnos_Calificaciones:208]P03_Presentacion_Real:252;aRealNtaPresentP;[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520;aRealNtaBX)
	: ($periodo=4)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Eval01_Real:267;aRealNta1;[Alumnos_Calificaciones:208]P04_Eval02_Real:272;aRealNta2;[Alumnos_Calificaciones:208]P04_Eval03_Real:277;aRealNta3;[Alumnos_Calificaciones:208]P04_Eval04_Real:282;aRealNta4;[Alumnos_Calificaciones:208]P04_Eval05_Real:287;aRealNta5;[Alumnos_Calificaciones:208]P04_Eval06_Real:292;aRealNta6;[Alumnos_Calificaciones:208]P04_Eval07_Real:297;aRealNta7;[Alumnos_Calificaciones:208]P04_Eval08_Real:302;aRealNta8;[Alumnos_Calificaciones:208]P04_Eval09_Real:307;aRealNta9;[Alumnos_Calificaciones:208]P04_Eval10_Real:312;aRealNta10;[Alumnos_Calificaciones:208]P04_Eval11_Real:317;aRealNta11;[Alumnos_Calificaciones:208]P04_Eval12_Real:322;aRealNta12;[Alumnos_Calificaciones:208]P04_Control_Real:332;aRealNtaEXP;[Alumnos_Calificaciones:208]P04_Presentacion_Real:327;aRealNtaPresentP;[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525;aRealNtaBX)
	: ($periodo=5)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Eval01_Real:342;aRealNta1;[Alumnos_Calificaciones:208]P05_Eval02_Real:347;aRealNta2;[Alumnos_Calificaciones:208]P05_Eval03_Real:352;aRealNta3;[Alumnos_Calificaciones:208]P05_Eval05_Real:362;aRealNta4;[Alumnos_Calificaciones:208]P05_Eval05_Real:362;aRealNta5;[Alumnos_Calificaciones:208]P05_Eval06_Real:367;aRealNta6;[Alumnos_Calificaciones:208]P05_Eval07_Real:372;aRealNta7;[Alumnos_Calificaciones:208]P05_Eval08_Real:377;aRealNta8;[Alumnos_Calificaciones:208]P05_Eval09_Real:382;aRealNta9;[Alumnos_Calificaciones:208]P05_Eval10_Real:387;aRealNta10;[Alumnos_Calificaciones:208]P05_Eval11_Real:392;aRealNta11;[Alumnos_Calificaciones:208]P05_Eval12_Real:397;aRealNta12;[Alumnos_Calificaciones:208]P05_Control_Real:407;aRealNtaEXP;[Alumnos_Calificaciones:208]P05_Presentacion_Real:402;aRealNtaPresentP;[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530;aRealNtaBX)
End case 

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

For ($i;1;Size of array:C274(aNtaStrArrPointers))
	AT_DimArrays (Size of array:C274(aRealNtaF);aNtaStrArrPointers{$i})
End for 

If ($periodo=0)
	$startConversionAt:=14
Else 
	$startConversionAt:=1
End if 


ARRAY REAL:C219(aRealPctMinimum;0)
ARRAY REAL:C219(aRealPctMinimum;Size of array:C274(aRealNtaF))
If ($styleID=0)
	If ((p2=1) & (iViewMode>0))
		  //20121016 RCH Defecto 114724. Se carga el estilo de eval para poder pasar la variable $vlNTA_DecimalesParciales con el valor correcto.
		  //For ($i;1;Size of array(aRealNtaP1))
		  //aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		  //For ($k;$startConversionAt;Size of array(aNtaStrArrPointers)-1)
		  //aNtaStrArrPointers{$k}->{$i}:=NTA_PercentValue2StringValue (aNtaRealArrPointers{$k}->{$i};0;aNtaEvStyleID{$i};->vi_PrintMode)
		  //End for 
		  //End for 
		For ($i;1;Size of array:C274(aRealNtaP1))
			aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
			EVS_ReadStyleData (aNtaEvStyleID{$i})
			Case of 
				: (iViewMode=Notas)
					$vlNTA_DecimalesParciales:=iGradesDec
				: (iViewMode=Puntos)
					$vlNTA_DecimalesParciales:=iPointsDec
				: (iViewMode=Simbolos)
					$vlNTA_DecimalesParciales:=0
				: (iViewMode=Porcentaje)
					$vlNTA_DecimalesParciales:=1
			End case 
			For ($k;$startConversionAt;Size of array:C274(aNtaStrArrPointers)-1)
				aNtaStrArrPointers{$k}->{$i}:=EV2_Real_a_Literal (aNtaRealArrPointers{$k}->{$i};iViewMode;$vlNTA_DecimalesParciales)
			End for 
		End for 
		
	Else 
		  //20121016 RCH Defecto 114724. Se carga el estilo de eval para poder pasar la variable $vlNTA_DecimalesParciales con el valor correcto.
		  //For ($i;1;Size of array(aRealNtaP1))
		  //aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
		  //For ($k;$startConversionAt;Size of array(aNtaStrArrPointers)-1)
		  //aNtaStrArrPointers{$k}->{$i}:=NTA_PercentValue2StringValue (aNtaRealArrPointers{$k}->{$i};0;aNtaEvStyleID{$i};->iPrintMode)
		  //End for 
		  //End for 
		For ($i;1;Size of array:C274(aRealNtaP1))
			aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue (aNtaEvStyleID{$i};"rPctMinimum")
			EVS_ReadStyleData (aNtaEvStyleID{$i})
			Case of 
				: (iViewMode=Notas)
					$vlNTA_DecimalesParciales:=iGradesDec
				: (iViewMode=Puntos)
					$vlNTA_DecimalesParciales:=iPointsDec
				: (iViewMode=Simbolos)
					$vlNTA_DecimalesParciales:=0
				: (iViewMode=Porcentaje)
					$vlNTA_DecimalesParciales:=1
			End case 
			For ($k;$startConversionAt;Size of array:C274(aNtaStrArrPointers)-1)
				aNtaStrArrPointers{$k}->{$i}:=EV2_Real_a_Literal (aNtaRealArrPointers{$k}->{$i};iPrintMode;$vlNTA_DecimalesParciales)
			End for 
		End for 
		
	End if 
Else 
	If ((p2=1) & (iViewMode>0))
		  //20121016 RCH Defecto 114724. Se carga el estilo de eval para poder pasar la variable $vlNTA_DecimalesParciales con el valor correcto.
		  //For ($i;1;Size of array(aRealNtaP1))
		  //aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue ($styleID;"rPctMinimum")
		  //For ($k;$startConversionAt;Size of array(aNtaStrArrPointers))
		  //aNtaStrArrPointers{$k}->{$i}:=NTA_PercentValue2StringValue (aNtaRealArrPointers{$k}->{$i};0;$styleID;->vi_PrintMode)
		  //End for 
		  //End for 
		For ($i;1;Size of array:C274(aRealNtaP1))
			aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue ($styleID;"rPctMinimum")
			EVS_ReadStyleData (aNtaEvStyleID{$i})
			Case of 
				: (iViewMode=Notas)
					$vlNTA_DecimalesParciales:=iGradesDec
				: (iViewMode=Puntos)
					$vlNTA_DecimalesParciales:=iPointsDec
				: (iViewMode=Simbolos)
					$vlNTA_DecimalesParciales:=0
				: (iViewMode=Porcentaje)
					$vlNTA_DecimalesParciales:=1
			End case 
			For ($k;$startConversionAt;Size of array:C274(aNtaStrArrPointers))
				aNtaStrArrPointers{$k}->{$i}:=EV2_Real_a_Literal (aNtaRealArrPointers{$k}->{$i};iViewMode;$vlNTA_DecimalesParciales)
			End for 
		End for 
	Else 
		  //20121016 RCH Defecto 114724. Se carga el estilo de eval para poder pasar la variable $vlNTA_DecimalesParciales con el valor correcto.
		  //For ($i;1;Size of array(aRealNtaP1))
		  //aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue ($styleID;"rPctMinimum")
		  //For ($k;$startConversionAt;Size of array(aNtaStrArrPointers))
		  //aNtaStrArrPointers{$k}->{$i}:=NTA_PercentValue2StringValue (aNtaRealArrPointers{$k}->{$i};0;$styleID;->iPrintMode)
		  //End for 
		  //End for 
		For ($i;1;Size of array:C274(aRealNtaP1))
			aRealPctMinimum{$i}:=EVS_GetEvStyleREALValue ($styleID;"rPctMinimum")
			EVS_ReadStyleData (aNtaEvStyleID{$i})
			Case of 
				: (iViewMode=Notas)
					$vlNTA_DecimalesParciales:=iGradesDec
				: (iViewMode=Puntos)
					$vlNTA_DecimalesParciales:=iPointsDec
				: (iViewMode=Simbolos)
					$vlNTA_DecimalesParciales:=0
				: (iViewMode=Porcentaje)
					$vlNTA_DecimalesParciales:=1
			End case 
			For ($k;$startConversionAt;Size of array:C274(aNtaStrArrPointers))
				aNtaStrArrPointers{$k}->{$i}:=EV2_Real_a_Literal (aNtaRealArrPointers{$k}->{$i};iPrintMode;$vlNTA_DecimalesParciales)
			End for 
		End for 
	End if 
End if 