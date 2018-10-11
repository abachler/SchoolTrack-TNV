//%attributes = {}
  //CUpr_PlanillaPeriodo`

C_LONGINT:C283($i;$k;$j;$periodo)
C_POINTER:C301($nil)

$periodo:=$1
vPeriodo:=$periodo

$pId:=IT_UThermometer (1;0;__ ("Preparando impresión de la planilla de notas..."))

MESSAGES OFF:C175
EV2_InitArrays 

Case of 
	: (aEvStyleType=3)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_oficial:23
		vi_EvStyleToUse:=$evStyleID
		EVS_ReadStyleData ($evStyleID)
		$modoPromedioPeriodo:=iPrintMode
	: (aEvStyleType=4)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		$evStyleID:=[xxSTR_Niveles:6]EvStyle_interno:33
		vi_EvStyleToUse:=$evStyleID
		EVS_ReadStyleData ($evStyleID)
		$modoPromedioPeriodo:=iPrintMode
	: (aEvStyleType=1)
		vlEVS_CurrentEvStyleID:=0
		$evStyleID:=0
		$modoPromedioPeriodo:=0
End case 

If (n1NotaFinalOficial=1)
	$notaFinalArrPointer:=->aNtaOf
Else 
	$notaFinalArrPointer:=->aNtaF
End if 

PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
  ///20151105 JVP ticket 152215 validacion para no mostrar los alumnos que se encuentren ocultos en nominas, esto es para todos excepto CL
  //MONO TICKET 155405
If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
End if 

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

SET FIELD RELATION:C919([Alumnos_SintesisAnual:210]LlavePrincipal:5;Automatic:K51:4;Automatic:K51:4)
SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;Automatic:K51:4;Automatic:K51:4)

ARRAY TEXT:C222(aC0;0)
SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Sexo:49;$aSexo;[Alumnos:2]apellidos_y_nombres:40;$aNames;[Alumnos:2]Apellido_paterno:3;$apat;[Alumnos:2]Apellido_materno:4;$amat;[Alumnos:2]Nombres:2;$names;[Alumnos:2]numero:1;al_IDAlumnos;[Alumnos:2]no_de_lista:53;aOrder;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;aPctAsistencia)

If (n1NotaFinalOficial=1)
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Sexo:49;$aSexo;[Alumnos:2]Status:50;$aStatus;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;$ar_PromedioPercent_F)
Else 
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Sexo:49;$aSexo;[Alumnos:2]Status:50;$aStatus;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;$ar_PromedioPercent_F)
End if 

Case of 
	: ($periodo=0)
		If (n1NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;$ar_PromedioPercent_P)
		End if 
	: ($periodo=1)
		If (vl_NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Status:50;$aStatus;[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Status:50;$aStatus;[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92;$ar_PromedioPercent_P)
		End if 
	: ($periodo=2)
		If (vl_NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121;$ar_PromedioPercent_P)
		End if 
	: ($periodo=3)
		If (vl_NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150;$ar_PromedioPercent_P)
		End if 
	: ($periodo=4)
		If (vl_NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179;$ar_PromedioPercent_P)
		End if 
	: ($periodo=5)
		If (vl_NotaFinalOficial=1)
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257;$ar_PromedioPercent_P)
		Else 
			SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208;$ar_PromedioPercent_P)
		End if 
End case 

  //SET AUTOMATIC RELATIONS(False;False)
SET FIELD RELATION:C919([Alumnos_SintesisAnual:210]LlavePrincipal:5;No relation:K51:5;No relation:K51:5)
SET FIELD RELATION:C919([Alumnos:2]LlaveRegistroCicloActual:76;No relation:K51:5;No relation:K51:5)



If (vi_EvStyleToUse=0)
	$evStyleInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]EvStyle_interno:33)
	$evStyleOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]EvStyle_oficial:23)
	EVS_ReadStyleData ($evStyleInterno)
	$modoPromedioPeriodo:=iPrintMode
End if 


If ((vi_ConvertGradesTo#$modoPromedioPeriodo) & (vi_ConvertGradesTo>0))
	$modoPromedioPeriodo:=vi_ConvertGradesTo
End if 
ARRAY TEXT:C222($aStudenAverageP;0)
ARRAY TEXT:C222($aStudenAverageP;Size of array:C274($aRecNums))
ARRAY TEXT:C222($aStudenAverage;0)
ARRAY TEXT:C222($aStudenAverage;Size of array:C274($aRecNums))
  //PS 20110905 se agregan los 2 ultimos parametros para que considere la cantidad de desimales a aproximar y/o truncar
For ($i;1;Size of array:C274($aStudenAverage))
	$aStudenAverageP{$i}:=NTA_PercentValue2StringValue ($ar_PromedioPercent_P{$i};$modoPromedioPeriodo;0;$nil;iGradesDecPP;vi_gTrPAvg)
	$aStudenAverage{$i}:=NTA_PercentValue2StringValue ($ar_PromedioPercent_F{$i};$modoPromedioPeriodo;0;$nil;iGradesDecNF;vi_gTrFAvg)
End for 

  //If (o1Ordenamiento=1)
  //SORT ARRAY($aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;aOrder;$aRecNums;aPctAsistencia;$aStatus;>)
  //Else 
  //SORT ARRAY(aOrder;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;$aRecNums;aPctAsistencia;$aStatus;>)
  //End if 

Case of 
	: (o1Ordenamiento=1)
		SORT ARRAY:C229($aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;aOrder;$aRecNums;aPctAsistencia;$aStatus;>)
	: (o2Ordenamiento=1)
		SORT ARRAY:C229(aOrder;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;$aRecNums;aPctAsistencia;$aStatus;>)
	: (o3Ordenamiento=1)
		  //SORT ARRAY($aSexo;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;$aRecNums;aPctAsistencia;$aStatus;<)
		  //PS 04-07-2012: Se cambia el ordenamiento para que luego de ordenar por sexo lo haga por nombres ya que quedaba desordenado
		AT_MultiLevelSort ("<>";->$aSexo;->$aNames;->$apat;->$aMat;->$names;->al_IDAlumnos;->$aStudenAverage;->$aRecNums;->aPctAsistencia;->$aStatus)
End case 


EV2_Calificaciones_SeleccionAL 
  // PS 04-04-2012 se agrega linea para filtrar las asignaturas actuales del curso ya que en mexico que tienen niveles por año salen las de niveles anteriores
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NIvel_Numero:4=[Cursos:3]Nivel_Numero:7)
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5)



If (p1_Internas=1)
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]En_InformesInternos:14=True:C214;*)
	If (cb_PrintConsolidantes=0)
		QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Consolidacion_Madre_Id:7=0)
	Else 
		QUERY SELECTION:C341([Asignaturas:18]; | [Asignaturas:18]Consolidacion_Madre_Id:7>0)
	End if 
Else 
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
	QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Consolidacion_Madre_Id:7=0;*)
	QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Asignatura_No_Oficial:71=False:C215)
End if 
QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Numero:1>0)
CREATE SET:C116([Asignaturas:18];"Incluidas")
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Asignatura:3)


SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;aAsgAbrev;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Asignaturas:18]Asignatura:3;aAsgName;[Asignaturas:18]Numero:1;aLong1;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID)
SORT ARRAY:C229(aAsgAbrev;at_OrdenAsignaturas;aAsgName;aLong1;aNtaEvStyleID;>)
For ($k;Size of array:C274(aAsgName);1;-1)
	If ((aAsgAbrev{$k-1}=aAsgAbrev{$k}) & ($k>1))
		DELETE FROM ARRAY:C228(aAsgName;$k)
		DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$k)
		DELETE FROM ARRAY:C228(aAsgAbrev;$k)
		DELETE FROM ARRAY:C228(aNtaEvStyleID;$k)
	End if 
End for 
SORT ARRAY:C229(at_OrdenAsignaturas;aAsgAbrev;aAsgName;aLong1;aNtaEvStyleID;>)
$dim:=Size of array:C274(al_IDAlumnos)
C_TEXT:C284(tExplain)
If (Size of array:C274(aAsgName)>0)
	tExplain:=aAsgAbrev{1}+": "+aAsgName{1}
End if 
For ($i;2;Size of array:C274(aAsgAbrev))
	tExplain:=tExplain+",  "+aAsgAbrev{$i}+": "+aAsgName{$i}
End for 
tExplain:=tExplain+", PP: Promedio del Período, PF: Promedio Final"
vi_Columns:=Size of array:C274(aAsgname)


ACTAS_InitVars (0)
ACTAS_InitVars (Size of array:C274($aPat))
ARRAY TEXT:C222(aC0;Size of array:C274($aPat))
ARRAY TEXT:C222(aCAvg;Size of array:C274(al_IDAlumnos))
ARRAY TEXT:C222(aCAvgP;Size of array:C274(al_IDAlumnos))
vPageNumber:=0


For ($i;1;Size of array:C274(al_IDAlumnos))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	  //aC0{$i}:=$apat{$i}+" "+$amat{$i}+". "+ST_Uppercase (Substring($names{$i};1;1))+"."+ST_Uppercase (Substring($names{$i};Position(" ";$names{$i})+1;1))
	$comp1:=$apat{$i}+" "
	$comp2:=Substring:C12($amat{$i};1;1)+"., "
	$comp3:=ST_GetWord ($names{$i};1;" ")
	$tcomp4:=ST_Uppercase (Substring:C12(ST_GetWord ($names{$i};2;" ");1;1))
	$comp4:=ST_Boolean2Str (($tcomp4#"");" "+ST_Uppercase (Substring:C12(ST_GetWord ($names{$i};2;" ");1;1))+".")
	  //aC0{$i}:=$comp1+$comp2+$comp3+$comp4 
	aC0{$i}:=[Alumnos:2]apellidos_y_nombres:40
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	ARRAY TEXT:C222(aText1;0)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	If (p1_Internas=1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]En_InformesInternos:14=True:C214;*)
		If (cb_PrintConsolidantes=0)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]Consolidacion_Madre_Id:7=0)
		Else 
			QUERY SELECTION:C341([Alumnos_Calificaciones:208]; | [Asignaturas:18]Consolidacion_Madre_Id:7>0)
		End if 
	Else 
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]Consolidacion_Madre_Id:7=0;*)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]Asignatura_No_Oficial:71=False:C215)
	End if 
	
	Case of 
		: ($periodo=0)
			If (n1NotaFinalOficial=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			Else 
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			End if 
			vs_Periodo:="Promedios Generales"+" "+<>gNombreAgnoEscolar
		: ($periodo=1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			vs_Periodo:=aPeriodos{$periodo}+" "+<>gNombreAgnoEscolar
		: ($periodo=2)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Real:187;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			vs_Periodo:=aPeriodos{$periodo}+" "+<>gNombreAgnoEscolar
		: ($periodo=3)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Final_Real:262;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			vs_Periodo:=aPeriodos{$periodo}+" "+<>gNombreAgnoEscolar
		: ($periodo=4)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Real:337;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			vs_Periodo:=aPeriodos{$periodo}+" "+<>gNombreAgnoEscolar
		: ($periodo=5)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Real:412;$aReal;[Asignaturas:18]Abreviación:26;aNtaAsgAbrev;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID)
			vs_Periodo:=aPeriodos{$periodo}+" "+<>gNombreAgnoEscolar
	End case 
	
	
	aCavg{$i}:=$aStudenAverage{$i}
	aCavgP{$i}:=$aStudenAverageP{$i}
	$sum:=0
	$div:=0
	$Insuf:=0
	$eximido:=False:C215
	$strExim:=""
	
	Case of 
		: (aEvStyleType=3)
			READ ONLY:C145([xxSTR_Niveles:6])
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
			$evStyleID:=[xxSTR_Niveles:6]EvStyle_oficial:23
			vi_EvStyleToUse:=$evStyleID
			EVS_ReadStyleData ($evStyleID)
			$modoPromedioPeriodo:=iPrintMode
		: (aEvStyleType=4)
			READ ONLY:C145([xxSTR_Niveles:6])
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
			$evStyleID:=[xxSTR_Niveles:6]EvStyle_interno:33
			vi_EvStyleToUse:=$evStyleID
			EVS_ReadStyleData ($evStyleID)
			$modoPromedioPeriodo:=iPrintMode
		: (aEvStyleType=1)
			vlEVS_CurrentEvStyleID:=0
			$evStyleID:=0
			$modoPromedioPeriodo:=0
	End case 
	If (vi_ConvertGradesTo>0)
		$modePointer:=->vi_ConvertGradesTo
	Else 
		$modePointer:=->iPrintMode
	End if 
	
	For ($k;1;Size of array:C274($aReal))
		  //If (aNtaOrden{$k}>0)
		$ColPos:=Find in array:C230(aAsgAbrev;aNtaAsgAbrev{$k})
		If ($colPos=-1)
		Else 
			$ptr:=Get pointer:C304("aC"+String:C10($colPos))
			If (aEvStyleType=1)
				$Ptr->{$i}:=NTA_PercentValue2StringValue ($aReal{$k};0;$aEvStyleID{$k};$modePointer)
			Else 
				$Ptr->{$i}:=NTA_PercentValue2StringValue ($aReal{$k};0;0;$modePointer)
			End if 
		End if 
	End for 
End for 


  // ARRAY TEXT(aCAvgP;Size of array(aC0))
$sumP:=0
$sumF:=0
$sumAsistencia:=0
$dividerP:=0
$dividerF:=0
$dividerAsistencia:=0
For ($i;1;Size of array:C274(aCavg))
	If ($aStatus{$i}#"Retirado@")
		$sumP:=$sumP+Num:C11(aCavgP{$i})
		$dividerP:=$dividerP+Num:C11(Num:C11(aCavgP{$i})>0)
		$sumF:=$sumF+Num:C11(aCavg{$i})
		$dividerF:=$dividerF+Num:C11(Num:C11(aCavg{$i})>0)
		$sumAsistencia:=$sumAsistencia+aPctAsistencia{$i}
		$dividerAsistencia:=$dividerAsistencia+Num:C11(aPctAsistencia{$i}>0)
	End if 
End for 

If ($periodo>0)
	AT_Insert (Size of array:C274(aOrder)+1;3;->aC0;->aOrder;->aCAvg;->aCAvgP;->aPctAsistencia)
	aC0{Size of array:C274(aOrder)-2}:="Promedio "+aPeriodos{aPeriodos}
	aC0{Size of array:C274(aOrder)-1}:="Promedio final"
	aC0{Size of array:C274(aOrder)}:="Aprobados"
Else 
	AT_Insert (Size of array:C274(aOrder)+1;2;->aC0;->aOrder;->aCAvg;->aCAvgP;->aPctAsistencia)
	aC0{Size of array:C274(aOrder)-1}:="Promedio final"
	aC0{Size of array:C274(aOrder)}:="Aprobados"
End if 

For ($i;1;vi_Columns)
	  //busqueda de las asignaturs y notas de la columna para el cálculo de promedio    
	USE SET:C118("incluidas")
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Abreviación:26=aAsgAbrev{$i})
	$evStyle:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39  //estilo leido de la primera asignatura (se usa para todas las que tienen la misma
	EVS_ReadStyleData ($evStyle)  //abreviacion)
	EV2_Calificaciones_SeleccionAS 
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->al_IdAlumnos;True:C214)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Ret@")
	
	
	If (n1NotaFinalOficial=1)
		Case of 
			: ($periodo=0)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Real:187;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Final_Real:262;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Real:337;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Real:412;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
		End case 
	Else 
		Case of 
			: ($periodo=0)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=1)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=2)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P02_Final_Real:187;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=3)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P03_Final_Real:262;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=4)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P04_Final_Real:337;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
			: ($periodo=5)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P05_Final_Real:412;aRealP1;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aReal1;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
		End case 
	End if 
	
	
	  //calculo del promedio del periodo    
	$arrPointer:=Get pointer:C304("aC"+String:C10($i))
	If ($periodo>0)
		INSERT IN ARRAY:C227($arrPointer->;Size of array:C274($arrPointer->)+1;2)
		$line:=Size of array:C274($arrPointer->)
		$percentValue:=MATH_ArrayAverage (->aRealP1)
		  //RBM y ASM 20121228 se elimina el parametro de truncar porque no corresponde truncar spbre promedios ya truncados.
		$arrPointer->{$line-1}:=NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode;iGradesDecPP)
	Else 
		INSERT IN ARRAY:C227($arrPointer->;Size of array:C274($arrPointer->)+1;1)
		$line:=Size of array:C274($arrPointer->)
	End if 
	
	QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]ID_Asignatura:2=[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3=<>gyear)
	
	  //calculo del promedio final
	If (n1NotaFinalOficial=1)
		$percentValue:=MATH_ArrayAverage (->aReal1)
		  //RBM y ASM 20121228 se elimina el parametro de truncar porque no corresponde truncar spbre promedios ya truncados.
		$arrPointer->{$line}:=NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa;iGradesDecNO)
		
	Else 
		$percentValue:=MATH_ArrayAverage (->aReal1)
		  //RBM y ASM 20121228 se elimina el parametro de truncar porque no corresponde truncar spbre promedios ya truncados.
		$arrPointer->{$line}:=NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode;iGradesDecNF)
		
	End if 
	
	If ($periodo=0)
		
		$aprobados:=Size of array:C274($aReprobada)
		For ($i_alumnos;1;Size of array:C274($aReprobada))
			If ($aReprobada{$i_alumnos})
				$aprobados:=$aprobados-1
			End if 
		End for 
		
	Else 
		
		$aprobados:=Size of array:C274(aRealP1)
		For ($i_alumnos;1;Size of array:C274(aRealP1))
			If ((aRealP1{$i_alumnos}<rPctMinimum) & (aRealP1{$i_alumnos}>0))
				$aprobados:=$aprobados-1
			End if 
		End for 
		
	End if 
	
	  //Codigo Anterior
	  //If (AT_GetSumArray (->aRealP1)=0)
	  //$porcentajeAprobados:=0
	  //Else 
	  //$porcentajeAprobados:=Round($aprobados/Size of array($aReprobada)*100;2)
	  //End if 
	  //INSERT IN ARRAY($arrPointer->;Size of array($arrPointer->)+1;1)
	  //$arrPointer->{Size of array($arrPointer->)}:=String($porcentajeAprobados;"##0"+<>txs_rs_decimalseparator+"00%")
	
	
	  //Cambio el Parámetro de redondeo a 1 decimal y ademas se cambia la concatenación del valor pasado al arreglo a mostrar
	  //ya que si es 100 quedaba (100,00%) por lo que en la planilla se visualizaba de forma erronea.
	  //AB - JV ( 30/07/2015)- ticket 146411 
	
	If (AT_GetSumArray (->aRealP1)=0)
		$porcentajeAprobados:=0
	Else 
		  //$porcentajeAprobados:=Round($aprobados/Size of array($aReprobada)*100;2)
		$porcentajeAprobados:=Round:C94($aprobados/Size of array:C274($aReprobada)*100;1)
	End if 
	INSERT IN ARRAY:C227($arrPointer->;Size of array:C274($arrPointer->)+1;1)
	  //$arrPointer->{Size of array($arrPointer->)}:=String($porcentajeAprobados;"##0"+<>txs_rs_decimalseparator+"00%")
	$arrPointer->{Size of array:C274($arrPointer->)}:=String:C10($porcentajeAprobados)+"%"
	
End for 

  // Modificado por: Saúl Ponce (01-09-2016)
  // Ticket Nº 165574 - Cambié la query para poder utilizar los promedios por período y no calcular en la planilla
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1;*)
QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=<>gyear)

  //READ ONLY([xxSTR_Niveles])
  //QUERY([xxSTR_Niveles];[xxSTR_Niveles]NoNivel=[Cursos]Nivel_Numero)
  //EVS_ReadStyleData ([xxSTR_Niveles]EvStyle_interno)
  //$averageP:=NTA_StringValue2Percent (String($sumP/$dividerP))
  //aCAvgP{Size of array(aOrder)-2}:=NTA_PercentValue2StringValue ($averageP;vi_ConvertGradesTo;[xxSTR_Niveles]EvStyle_oficial;->iPrintMode;iGradesDecPP;vi_gTrPAvg)

Case of 
	: ($periodo=0)
		  // no se requiere período para imprimir los PF
	: ($periodo=1)
		aCAvgP{Size of array:C274(aOrder)-2}:=[Cursos_SintesisAnual:63]P01_Promedio_Literal:31
	: ($periodo=2)
		aCAvgP{Size of array:C274(aOrder)-2}:=[Cursos_SintesisAnual:63]P02_Promedio_Literal:36
	: ($periodo=3)
		aCAvgP{Size of array:C274(aOrder)-2}:=[Cursos_SintesisAnual:63]P03_Promedio_Literal:41
	: ($periodo=4)
		aCAvgP{Size of array:C274(aOrder)-2}:=[Cursos_SintesisAnual:63]P04_Promedio_Literal:46
	: ($periodo=5)
		aCAvgP{Size of array:C274(aOrder)-2}:=[Cursos_SintesisAnual:63]P05_Promedio_Literal:51
End case 

  //20130806 ASM y SP se toma el promedio directo de cursos_sintesisAnual, porque se estaba produciendo un descuadre en los promedio.
  //QUERY([Cursos_SintesisAnual];[Cursos_SintesisAnual]Curso=[Cursos]Curso;*)
  //QUERY([Cursos_SintesisAnual]; & ;[Cursos_SintesisAnual]Año=<>gyear)
If (n1NotaFinalOficial=1)
	  //EVS_ReadStyleData ([xxSTR_Niveles]EvStyle_oficial)
	  //$averageF:=NTA_StringValue2Percent (String($sumF/$dividerF))
	  //aCAvg{Size of array(aOrder)-1}:=NTA_PercentValue2StringValue ($averageF;vi_ConvertGradesTo;[xxSTR_Niveles]EvStyle_oficial;->iPrintActa;iGradesDecNO;vi_gTroncarNotaFinal)
	aCAvg{Size of array:C274(aOrder)-1}:=[Cursos_SintesisAnual:63]PromedioOficial_Literal:26
Else 
	  //$averageF:=NTA_StringValue2Percent (String($sumF/$dividerF))
	  //aCAvg{Size of array(aOrder)-1}:=NTA_PercentValue2StringValue ($averageF;vi_ConvertGradesTo;[xxSTR_Niveles]EvStyle_interno;->iPrintMode;iGradesDecNO;vi_gTroncarNotaFinal)
	aCAvg{Size of array:C274(aOrder)-1}:=[Cursos_SintesisAnual:63]PromedioFinal_Literal:21
End if 
aPctAsistencia{Size of array:C274(aOrder)-1}:=$sumAsistencia/$dividerAsistencia
ARRAY TEXT:C222(atPctAsistencia;0)
For ($i;1;Size of array:C274(aPctAsistencia))
	If (aPctAsistencia{$i}=0)
		APPEND TO ARRAY:C911(atPctAsistencia;"")
	Else 
		  // MOD Ticket N° 198166, no se respeta formato aplicado al porcentaje de asistencia.
		  //APPEND TO ARRAY(atPctAsistencia;String(aPctAsistencia{$i};"##0"+<>txs_rs_decimalseparator+"0%"))
		APPEND TO ARRAY:C911(atPctAsistencia;String:C10(aPctAsistencia{$i};"|Pct_1DecIfNec"))
	End if 
End for 


$pId:=IT_UThermometer (-2;$pId)
