//%attributes = {}
  //CUpr_PlanillaOnePage


C_LONGINT:C283($i;$k;$j)
C_TEXT:C284($1;$printDestination)

$pId:=IT_UThermometer (1;0;__ ("Preparando impresión de la planilla de notas..."))
If (Count parameters:C259=1)
	$printDestination:=$1
Else 
	$printDestination:="printer"
End if 

PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

If (n1NotaFinalOficial=1)
	$notaFinalArrPointer:=->aNtaOf
Else 
	$notaFinalArrPointer:=->aNtaF
End if 

vs_pages:=""
vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
  ///20151105 JVP ticket 152215 validacion para no mostrar los alumnos que se encuentren ocultos en nominas, esto es para todos excepto CL
  //MONO TICKET 155405
If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
End if 

CREATE SET:C116([Alumnos:2];"alumnos")
ARRAY TEXT:C222(aC0;0)
  //SET AUTOMATIC RELATIONS(True;False)

EV2_Calificaciones_SeleccionAL 
If (n1NotaFinalOficial=1)
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Sexo:49;$aSexo;[Alumnos:2]apellidos_y_nombres:40;$aNames;[Alumnos:2]Apellido_paterno:3;$apat;[Alumnos:2]Apellido_materno:4;$amat;[Alumnos:2]Nombres:2;$names;[Alumnos:2]numero:1;al_IDAlumnos;[Alumnos:2]no_de_lista:53;aOrder;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;aPctAsistencia;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;$aStudenAverage;[Alumnos:2]Status:50;$aStatus)
Else 
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums;[Alumnos:2]Sexo:49;$aSexo;[Alumnos:2]apellidos_y_nombres:40;$aNames;[Alumnos:2]Apellido_paterno:3;$apat;[Alumnos:2]Apellido_materno:4;$amat;[Alumnos:2]Nombres:2;$names;[Alumnos:2]numero:1;al_IDAlumnos;[Alumnos:2]no_de_lista:53;aOrder;[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;aPctAsistencia;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;$aStudenAverage;[Alumnos:2]Status:50;$aStatus)
End if 


  //If (o1Ordenamiento=1)
  //SORT ARRAY($aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;aOrder;$aRecNums;aPctAsistencia;$aStatus;>)
  //Else 
  //SORT ARRAY(aOrder;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aRecNums;aPctAsistencia;$aStatus;>)
  //End if 

Case of 
	: (o1Ordenamiento=1)
		SORT ARRAY:C229($aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;aOrder;$aRecNums;aPctAsistencia;$aStatus;>)
	: (o2Ordenamiento=1)
		SORT ARRAY:C229(aOrder;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aRecNums;aPctAsistencia;$aStatus;>)
	: (o3Ordenamiento=1)
		  //SORT ARRAY($aSexo;$aNames;$apat;$aMat;$names;al_IDAlumnos;$aStudenAverage;$aStudenAverageP;$aRecNums;aPctAsistencia;$aStatus;<)
		  //PS 04-07-2012: Se cambia el ordenamiento para que luego de ordenar por sexo lo haga por nombres ya que quedaba desordenado
		AT_MultiLevelSort ("<>";->$aSexo;->$aNames;->$apat;->$aMat;->$names;->al_IDAlumnos;->$aStudenAverage;->$aRecNums;->aPctAsistencia;->$aStatus)
End case 

USE SET:C118("alumnos")
EV2_Calificaciones_SeleccionAL 
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

QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Asignatura_No_Oficial:71=False:C215;*)
QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Numero:1>0)
CREATE SET:C116([Asignaturas:18];"Incluidas")
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>;[Asignaturas:18]Asignatura:3)

SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;aAsgAbrev;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Asignaturas:18]Asignatura:3;aAsgName;[Asignaturas:18]Numero:1;aLong1;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;aNtaEvStyleID;[Asignaturas:18]PorcentajeAprobados:103;$aPctAprobados)
SORT ARRAY:C229(aAsgAbrev;at_OrdenAsignaturas;aAsgName;aLong1;aNtaEvStyleID;$aPctAprobados;>)
For ($k;Size of array:C274(aAsgName);1;-1)
	If ((aAsgAbrev{$k-1}=aAsgAbrev{$k}) & ($k>1))
		DELETE FROM ARRAY:C228(aAsgName;$k)
		DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$k)
		DELETE FROM ARRAY:C228(aAsgAbrev;$k)
		DELETE FROM ARRAY:C228(aNtaEvStyleID;$k)
	End if 
End for 
SORT ARRAY:C229(at_OrdenAsignaturas;aAsgAbrev;aAsgName;aLong1;aNtaEvStyleID;>)
vi_Columns:=Size of array:C274(aAsgName)


$dim:=Size of array:C274(al_IDAlumnos)
tExplain:=aAsgAbrev{1}+": "+aAsgName{1}
For ($i;2;Size of array:C274(aAsgAbrev))
	tExplain:=tExplain+",  "+aAsgAbrev{$i}+": "+aAsgName{$i}
End for 
ACTAS_InitVars (0)
ACTAS_InitVars ($dim)
vi_Columns:=Size of array:C274(aAsgName)
ARRAY TEXT:C222(aC0;Size of array:C274($aPat))

ARRAY TEXT:C222(aCAvg;Size of array:C274(al_IDAlumnos))
For ($i;1;Size of array:C274(al_IDAlumnos))
	GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
	  //aC0{$i}:=$apat{$i}+" "+$amat{$i}+" "+ST_Uppercase (Substring($names{$i};1;1))+"."+ST_Uppercase (Substring($names{$i};Position(" ";$names{$i})+1;1))
	$comp1:=$apat{$i}+" "
	$comp2:=Substring:C12($amat{$i};1;1)+"., "
	$comp3:=ST_GetWord ($names{$i};1;" ")
	$tcomp4:=ST_Uppercase (Substring:C12(ST_GetWord ($names{$i};2;" ");1;1))
	$comp4:=ST_Boolean2Str (($tcomp4#"");" "+ST_Uppercase (Substring:C12(ST_GetWord ($names{$i};2;" ");1;1))+".")
	aC0{$i}:=$comp1+$comp2+$comp3+$comp4
	aC0{$i}:=[Alumnos:2]apellidos_y_nombres:40
	$idAlumno:=al_IDAlumnos{$i}
	KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno)
	EV2_LeeCalificacionesAlumno (0)
	
	
	If (vi_ConvertGradesTo>0)
		For ($j;1;Size of array:C274(aNtaRecNum))
			Case of 
					  //PS 13-07-2012 se agregan lineas para el caso de periodo unico que no estaba considerado
				: (viSTR_Periodos_NumeroPeriodos=1)
					aNtaP1{$j}:=NTA_PercentValue2StringValue (aRealNtaP1{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
				: (viSTR_Periodos_NumeroPeriodos=2)
					aNtaP1{$j}:=NTA_PercentValue2StringValue (aRealNtaP1{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP2{$j}:=NTA_PercentValue2StringValue (aRealNtaP2{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
				: (viSTR_Periodos_NumeroPeriodos=3)
					aNtaP1{$j}:=NTA_PercentValue2StringValue (aRealNtaP1{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP2{$j}:=NTA_PercentValue2StringValue (aRealNtaP2{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP3{$j}:=NTA_PercentValue2StringValue (aRealNtaP3{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
				: (viSTR_Periodos_NumeroPeriodos=4)
					aNtaP1{$j}:=NTA_PercentValue2StringValue (aRealNtaP1{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP2{$j}:=NTA_PercentValue2StringValue (aRealNtaP2{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP3{$j}:=NTA_PercentValue2StringValue (aRealNtaP3{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP4{$j}:=NTA_PercentValue2StringValue (aRealNtaP4{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
				: (viSTR_Periodos_NumeroPeriodos=5)
					aNtaP1{$j}:=NTA_PercentValue2StringValue (aRealNtaP1{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP2{$j}:=NTA_PercentValue2StringValue (aRealNtaP2{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP3{$j}:=NTA_PercentValue2StringValue (aRealNtaP3{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP4{$j}:=NTA_PercentValue2StringValue (aRealNtaP4{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
					aNtaP5{$j}:=NTA_PercentValue2StringValue (aRealNtaP5{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
			End case 
			aNtaPF{$j}:=NTA_PercentValue2StringValue (aRealNtaPF{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
			aNtaEX{$j}:=NTA_PercentValue2StringValue (aRealNtaEX{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
			aNtaF{$j}:=NTA_PercentValue2StringValue (aRealNtaF{$j};vi_ConvertGradesTo;aNtaEvStyleID{$j})
		End for 
	End if 
	
	
	  //aCAvg{$i}:=String(rfMedia (->[Notas]Promedio Final))
	aCavg{$i}:=$aStudenAverage{$i}
	$sum:=0
	$div:=0
	$Insuf:=0
	$eximido:=False:C215
	$strExim:=""
	Case of 
		: ($printDestination="printer")
			For ($k;1;Size of array:C274(aNtaP1))
				$ColPos:=Find in array:C230(aAsgAbrev;aNtaAsgAbrev{$k})
				If ($colPos=-1)
				Else 
					$ptr:=Get pointer:C304("aC"+String:C10($colPos))
					$padd:=" "*4
					$l:=Length:C16($padd)
					Case of 
							  //PS 13-07-2012 se agregan lineas para el caso de periodo unico que no estaba considerado
						: (viSTR_Periodos_NumeroPeriodos=1)
							$Ptr->{$i}:=Substring:C12(aNtaP1{$k}+$padd;1;$l)+Substring:C12(aNtaPF{$k}+$padd;1;$l)+Substring:C12(aNtaEX{$k}+$padd;1;$l)+$notaFinalArrPointer->{$k}
						: (viSTR_Periodos_NumeroPeriodos=2)
							$Ptr->{$i}:=Substring:C12(aNtaP1{$k}+$padd;1;$l)+Substring:C12(aNtaP2{$k}+$padd;1;$l)+Substring:C12(aNtaPF{$k}+$padd;1;$l)+Substring:C12(aNtaEX{$k}+$padd;1;$l)+$notaFinalArrPointer->{$k}
						: (viSTR_Periodos_NumeroPeriodos=3)
							$Ptr->{$i}:=Substring:C12(aNtaP1{$k}+$padd;1;$l)+Substring:C12(aNtaP2{$k}+$padd;1;$l)+Substring:C12(aNtaP3{$k}+$padd;1;$l)+Substring:C12(aNtaPF{$k}+$padd;1;$l)+Substring:C12(aNtaEX{$k}+$padd;1;$l)+$notaFinalArrPointer->{$k}
						: (viSTR_Periodos_NumeroPeriodos=4)
							$Ptr->{$i}:=Substring:C12(aNtaP1{$k}+$padd;1;$l)+Substring:C12(aNtaP2{$k}+$padd;1;$l)+Substring:C12(aNtaP3{$k}+$padd;1;$l)+Substring:C12(aNtaP4{$k}+$padd;1;$l)+Substring:C12(aNtaPF{$k}+$padd;1;$l)+Substring:C12(aNtaEX{$k}+$padd;1;$l)+$notaFinalArrPointer->{$k}
						: (viSTR_Periodos_NumeroPeriodos=5)
							$Ptr->{$i}:=Substring:C12(aNtaP1{$k}+$padd;1;$l)+Substring:C12(aNtaP2{$k}+$padd;1;$l)+Substring:C12(aNtaP3{$k}+$padd;1;$l)+Substring:C12(aNtaP4{$k}+$padd;1;$l)+Substring:C12(aNtaP5{$k}+$padd;1;$l)+Substring:C12(aNtaPF{$k}+$padd;1;$l)+Substring:C12(aNtaEX{$k}+$padd;1;$l)+$notaFinalArrPointer->{$k}
					End case 
				End if 
			End for 
		: ($printDestination="file")
			
	End case 
End for 

$t:="\t"
Case of 
	: ($printDestination="printer")
		$padd:=" "*2
		Case of 
				  //PS 13-07-2012 se agregan lineas para el caso de periodo unico que no estaba considerado
			: (viSTR_Periodos_NumeroPeriodos=1)
				$title:="1S"+$padd+"PF"+$padd+"EX"+$padd+"NF"
			: (viSTR_Periodos_NumeroPeriodos=2)
				$title:="1S"+$padd+"2S"+$padd+"PF"+$padd+"EX"+$padd+"NF"
			: (viSTR_Periodos_NumeroPeriodos=3)
				$title:="1T"+$padd+"2T"+$padd+"3T"+$padd+"PF"+$padd+"EX"+$padd+"NF"
			: (viSTR_Periodos_NumeroPeriodos=4)
				$title:="1B"+$padd+"2B"+$padd+"3B"+$padd+"4B"+$padd+"PF"+$padd+"EX"+$padd+"NF"
			: (viSTR_Periodos_NumeroPeriodos=5)
				$title:="1P"+$padd+"2P"+$padd+"3P"+$padd+"4P"+$padd+"5P"+$padd+"PF"+$padd+"EX"+$padd+"NF"
		End case 
	: ($printDestination="file")
End case 

$sumP:=0
$sumF:=0
$sumAsistencia:=0
$dividerP:=0
$dividerF:=0
$dividerAsistencia:=0
For ($i;1;Size of array:C274(aCavg))
	  //$sumP:=$sumP+Num(aCavgP{$i})
	  //$dividerP:=$dividerP+Num(Num(aCavgP{$i})>0)
	If ($aStatus{$i}#"Retirado@")
		$sumF:=$sumF+Num:C11(aCavg{$i})
		$dividerF:=$dividerF+Num:C11(Num:C11(aCavg{$i})>0)
		$sumAsistencia:=$sumAsistencia+aPctAsistencia{$i}
		$dividerAsistencia:=$dividerAsistencia+Num:C11(aPctAsistencia{$i}>0)
	End if 
End for 


INSERT IN ARRAY:C227(aOrder;1;1)
INSERT IN ARRAY:C227(aC0;1;1)
INSERT IN ARRAY:C227(aCAvg;1;1)
INSERT IN ARRAY:C227(aPctAsistencia;1;1)
For ($i;1;31)
	$arrPointer:=Get pointer:C304("aC"+String:C10($i))
	INSERT IN ARRAY:C227($arrPointer->;1;1)
	$arrPointer->{1}:=$title
End for 

ARRAY REAL:C219($aSumsP;vi_columns)
ARRAY REAL:C219($aDividersP;vi_columns)
ARRAY REAL:C219($aSumsF;vi_columns)
ARRAY REAL:C219($aDividersF;vi_columns)
ARRAY TEXT:C222(aText2;vi_columns)  // promedios periodicos
ARRAY TEXT:C222(aText3;vi_columns)  // promedios finales
ARRAY LONGINT:C221($aEvStyle;vi_columns)
QRY_QueryWithArray (->[Asignaturas:18]Numero:1;->aLong1)

AT_Insert (Size of array:C274(aOrder)+1;2;->aC0;->aOrder;->aCAvg;->aPctAsistencia)
aC0{Size of array:C274(aOrder)-1}:="Promedios"
aC0{Size of array:C274(aOrder)}:="Aprobados"

$line:=Size of array:C274(aC0)-1
$padd:=" "*4
$l:=Length:C16($padd)
For ($i;1;vi_Columns)
	$arrPointer:=Get pointer:C304("aC"+String:C10($i))
	USE SET:C118("incluidas")
	QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Abreviación:26=aAsgAbrev{$i})
	$evStyle:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39  //estilo leido de la primera asignatura (se usa para todas las que tienen la misma
	EV2_Calificaciones_SeleccionAS 
	QRY_QueryWithArray (->[Alumnos_Calificaciones:208]ID_Alumno:6;->al_IdAlumnos;True:C214)
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;aRealP1;[Alumnos_Calificaciones:208]P02_Final_Real:187;aRealP2;[Alumnos_Calificaciones:208]P03_Final_Real:262;aRealP3;[Alumnos_Calificaciones:208]P04_Final_Real:337;aRealP4;[Alumnos_Calificaciones:208]P05_Final_Real:412;aRealP5;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;aRealNtaOficial;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;aRealNtaF;[Alumnos_Calificaciones:208]Anual_Real:11;aREalPF;[Alumnos_Calificaciones:208]ExamenAnual_Real:16;aRealEX;[Alumnos_Calificaciones:208]Reprobada:9;$aReprobada)
	
	
	$aprobados:=Size of array:C274($aReprobada)
	For ($i_alumnos;1;Size of array:C274($aReprobada))
		If ($aReprobada{$i_alumnos})
			$aprobados:=$aprobados-1
		End if 
	End for 
	If (AT_GetSumArray (->aRealNtaF)=0)
		$porcentajeAprobados:=0
	Else 
		$porcentajeAprobados:=Round:C94($aprobados/Size of array:C274($aReprobada)*100;2)
	End if 
	INSERT IN ARRAY:C227($arrPointer->;Size of array:C274($arrPointer->)+1;2)
	$arrPointer->{Size of array:C274($arrPointer->)}:=String:C10($porcentajeAprobados;"##0,00%")
	
	
	If (vrNTA_MinimoEscalaReferencia=0)
		$modo_calculo:=3
	Else 
		$modo_calculo:=1
	End if 
	
	Case of 
			  //PS 13-07-2012 se agregan lineas para el caso de periodo unico que no estaba considerado
		: (viSTR_Periodos_NumeroPeriodos=1)
			$percentValue:=MATH_ArrayAverage (->aRealP1)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealPF)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=AT_Mean (->aRealEX;$modo_calculo)
			If (($percentValue=0) & (vrNTA_MinimoEscalaReferencia>0))
				$percentValue:=-10
			End if 
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			If (n1NotaFinalOficial=1)
				$percentValue:=MATH_ArrayAverage (->aRealNtaOficial)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa)
			Else 
				$percentValue:=MATH_ArrayAverage (->aRealNtaF)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)
			End if 
			
		: (viSTR_Periodos_NumeroPeriodos=2)
			$percentValue:=MATH_ArrayAverage (->aRealP1)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP2)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealPF)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			
			$percentValue:=AT_Mean (->aRealEX;$modo_calculo)
			If (($percentValue=0) & (vrNTA_MinimoEscalaReferencia>0))
				$percentValue:=-10
			End if 
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			
			If (n1NotaFinalOficial=1)
				$percentValue:=MATH_ArrayAverage (->aRealNtaOficial)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa)
			Else 
				$percentValue:=MATH_ArrayAverage (->aRealNtaF)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)
			End if 
			
		: (viSTR_Periodos_NumeroPeriodos=3)
			$percentValue:=MATH_ArrayAverage (->aRealP1)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP2)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP3)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealPF)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=AT_Mean (->aRealEX;$modo_calculo)
			If (($percentValue=0) & (vrNTA_MinimoEscalaReferencia>0))
				$percentValue:=-10
			End if 
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			If (n1NotaFinalOficial=1)
				$percentValue:=MATH_ArrayAverage (->aRealNtaOficial)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa)
			Else 
				$percentValue:=MATH_ArrayAverage (->aRealNtaF)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)
			End if 
			
		: (viSTR_Periodos_NumeroPeriodos=4)
			$percentValue:=MATH_ArrayAverage (->aRealP1)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP2)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP3)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP4)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealPF)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=AT_Mean (->aRealEX;$modo_calculo)
			If (($percentValue=0) & (vrNTA_MinimoEscalaReferencia>0))
				$percentValue:=-10
			End if 
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			If (n1NotaFinalOficial=1)
				$percentValue:=MATH_ArrayAverage (->aRealNtaOficial)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa)
			Else 
				$percentValue:=MATH_ArrayAverage (->aRealNtaF)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)
			End if 
			
		: (viSTR_Periodos_NumeroPeriodos=5)
			$percentValue:=MATH_ArrayAverage (->aRealP1)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP2)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP3)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP4)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealP5)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=MATH_ArrayAverage (->aRealPF)
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			$percentValue:=AT_Mean (->aRealEX;$modo_calculo)
			If (($percentValue=0) & (vrNTA_MinimoEscalaReferencia>0))
				$percentValue:=-10
			End if 
			$arrPointer->{$line}:=$arrPointer->{$line}+Substring:C12(NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)+$padd;1;$l)
			If (n1NotaFinalOficial=1)
				$percentValue:=MATH_ArrayAverage (->aRealNtaOficial)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintActa)
			Else 
				$percentValue:=MATH_ArrayAverage (->aRealNtaF)
				$arrPointer->{$line}:=$arrPointer->{$line}+NTA_PercentValue2StringValue ($percentValue;vi_ConvertGradesTo;$evStyle;->iPrintMode)
			End if 
			
	End case 
	
	
End for 


  //20130806 ASM y SP se toma el promedio directo de cursos_sintesisAnual, porque se estaba produciendo un descuadre en los promedio.
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1;*)
QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=<>gyear)
If (n1NotaFinalOficial=1)
	  //READ ONLY([xxSTR_Niveles])
	  //QUERY([xxSTR_Niveles];[xxSTR_Niveles]NoNivel=[Cursos]Nivel_Numero)
	  //EVS_ReadStyleData ([xxSTR_Niveles]EvStyle_oficial)
	  //$averageF:=NTA_StringValue2Percent (String($sumF/$dividerF))
	  //aCAvg{Size of array(aOrder)-1}:=NTA_PercentValue2StringValue ($averageF;vi_ConvertGradesTo;[xxSTR_Niveles]EvStyle_oficial;->iPrintActa)
	aCAvg{Size of array:C274(aOrder)-1}:=[Cursos_SintesisAnual:63]PromedioOficial_Literal:26
	
Else 
	  //READ ONLY([xxSTR_Niveles])
	  //QUERY([xxSTR_Niveles];[xxSTR_Niveles]NoNivel=[Cursos]Nivel_Numero)
	  //EVS_ReadStyleData ([xxSTR_Niveles]EvStyle_interno)
	  //$averageF:=NTA_StringValue2Percent (String($sumF/$dividerF))
	  //aCAvg{Size of array(aOrder)-1}:=NTA_PercentValue2StringValue ($averageF;vi_ConvertGradesTo;[xxSTR_Niveles]EvStyle_interno;->iPrintMode)
	aCAvg{Size of array:C274(aOrder)-1}:=[Cursos_SintesisAnual:63]PromedioFinal_Literal:21
End if 
aPctAsistencia{Size of array:C274(aOrder)}:=$sumAsistencia/$dividerAsistencia
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
