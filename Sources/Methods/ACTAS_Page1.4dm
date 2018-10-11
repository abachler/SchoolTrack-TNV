//%attributes = {}
  //ACTAS_Page1

C_LONGINT:C283($i;$k;$j;iAbs;iBad;iRet;iOk)
C_TEXT:C284(txtObs;sMencion;$sNoAvg)

ARRAY TEXT:C222(aSign;0)
ARRAY TEXT:C222(aSignAut;0)
ARRAY TEXT:C222(aSignAsg;0)
ARRAY TEXT:C222(aSignProf;0)
ARRAY TEXT:C222(aSign;30)
ARRAY TEXT:C222(aSignAut;30)
ARRAY TEXT:C222(aSignAsg;30)
ARRAY TEXT:C222(aSignProf;30)
iAbs:=0
iBad:=0
iPending:=0
iOK:=0
$evStyleRecNum:=Record number:C243([xxSTR_EstilosEvaluacion:44])
MESSAGES OFF:C175


ARRAY TEXT:C222(aCSex;0)
ARRAY TEXT:C222(aCLocality;0)
ARRAY TEXT:C222(aC0;0)

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42>vdSTR_Periodos_InicioEjercicio;*)
QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]Fecha_de_retiro:42=!00-00-00!)

SELECTION TO ARRAY:C260([Alumnos:2]Nombre_oficial:48;aC0;[Alumnos:2]RUT:5;aCRUN;[Alumnos:2]numero:1;$id;[Alumnos:2]Fecha_de_retiro:42;$dateOut;[Alumnos:2]Situacion_final:33;$statPromo;[Alumnos:2]Nacionalidad:8;$nation;[Alumnos:2]Promedio_General_Oficial:32;$FAverage;[Alumnos:2]Porcentaje_asistencia:56;$pctAttendance;[Alumnos:2]Observaciones_en_Acta:58;$obs;[Alumnos:2]Comentario_Situacion_Final:31;$comment;[Alumnos:2]Status:50;$aStatus;[Alumnos:2]Sexo:49;aCSex;[Alumnos:2]Fecha_de_nacimiento:7;$aCBirthDate;[Alumnos:2]Comuna:14;aCLocality;[Alumnos:2]nivel_numero:29;$aNivel)
If (vi_UppercaseNames=1)
	SELECTION TO ARRAY:C260([Alumnos:2]Apellido_paterno:3;$apat;[Alumnos:2]Apellido_materno:4;$amat;[Alumnos:2]Nombres:2;$aNames)
	For ($i;1;Size of array:C274($apat))
		aC0{$i}:=ST_Uppercase ($apat{$i})+" "+ST_Uppercase ($amat{$i})+" "+$aNames{$i}
		$FAverage{$i}:=Replace string:C233($FAverage{$i};Char:C90(0);"")
	End for 
End if 
ARRAY INTEGER:C220(alActas_ColumnNumber;Size of array:C274(alActas_ColumnNumber))
If (SYS_IsWindows )
	COPY ARRAY:C226(aC0;$names)
	For ($i;1;Size of array:C274($names))
		$names{$i}:=ST_nTilde2Special ($names{$i})
	End for 
	SORT ARRAY:C229($names;aC0;aCRUN;$ID;$dateOut;$statPromo;$nation;$obs;$pctAttendance;$FAverage;$comment;$aStatus;aCSex;$aCBirthDate;aCLocality;$aNivel;>)
Else 
	SORT ARRAY:C229(aC0;aCRUN;$ID;$dateOut;$statPromo;$nation;$obs;$pctAttendance;$FAverage;$comment;$aStatus;aCSex;$aCBirthDate;aCLocality;$aNivel;>)
End if 
EV2_Calificaciones_SeleccionAL 
KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")

QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Es_Optativa:70=True:C214)
SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aAsgOptativas)

INSERT IN ARRAY:C227($aAsgOptativas;1;1)
$aAsgOptativas{1}:="Religión"



Case of 
	: (iTotalAlumnos<30)
		$lines:=30
		$heigth:=14
	: (iTotalAlumnos>45)
		$lines:=iTotalAlumnos
		$heigth:=10
	Else 
		$heigth:=12
		$lines:=iTotalAlumnos
End case 
ARRAY TEXT:C222(aCBirthDate;Size of array:C274($aCBirthDate))

For ($i;1;Size of array:C274(aCSex))
	Case of 
		: (vs_birthDateFormat="000000")
			aCBirthDate{$i}:=String:C10(Day of:C23($aCBirthDate{$i});"00")+String:C10(Month of:C24($aCBirthDate{$i});"00")+Substring:C12(String:C10(Year of:C25($aCBirthDate{$i});"0000");3;2)
		: (vs_birthDateFormat="00/00/00")
			aCBirthDate{$i}:=String:C10(Day of:C23($aCBirthDate{$i});"00")+"/"+String:C10(Month of:C24($aCBirthDate{$i});"00")+"/"+Substring:C12(String:C10(Year of:C25($aCBirthDate{$i});"0000");3;2)
		: (vs_birthDateFormat="00000000")
			aCBirthDate{$i}:=String:C10(Day of:C23($aCBirthDate{$i});"00")+String:C10(Month of:C24($aCBirthDate{$i});"00")+String:C10(Year of:C25($aCBirthDate{$i});"0000")
		: (vs_birthDateFormat="00/00/0000")
			aCBirthDate{$i}:=String:C10(Day of:C23($aCBirthDate{$i});"00")+"/"+String:C10(Month of:C24($aCBirthDate{$i});"00")+"/"+String:C10(Year of:C25($aCBirthDate{$i});"0000")
	End case 
End for 

ACTAS_InitVars ($lines)
For ($i;1;31)
	$ptr:=Get pointer:C304("aC"+String:C10($i))
	ARRAY TEXT:C222($ptr->;$lines)
End for 
$PFCol:=Find in array:C230(atActas_Subsectores;"Promedio final")
$PACol:=Find in array:C230(atActas_Subsectores;"Porcentaje de asistencia")
$SFCol:=Find in array:C230(atActas_Subsectores;"Situación final")
$sNoAvg:=""


$columns:=Size of array:C274(atActas_Subsectores)
For ($k;1;$columns)
	If ($k<=$columns)
		$ptr:=Get pointer:C304("aC"+String:C10($k))
		If (Find in array:C230($aAsgOptativas;atActas_Subsectores{$k})>0)
			For ($i;1;Size of array:C274($id))
				$fechaTope:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
				If (($dateOut{$i}<$fechaTope) & ($aStatus{$i}="Retirado@"))
					$ptr->{$i}:="-"
				Else 
					$ptr->{$i}:=vs_AbrNoReligion
				End if 
			End for 
		Else 
			For ($i;1;Size of array:C274($id))
				$ptr->{$i}:="-"
			End for 
		End if 
	End if 
End for 

iAbs:=0
iBad:=0
iOK:=0



$repRendimiento:=__ ("Reprobado por rendimiento")
$repAsistencia:=__ ("Reprobado por asistencia insuficiente")


For ($i;1;Size of array:C274($id))
	Case of 
		: ($statPromo{$i}="Y")
			
		: ($statPromo{$i}="R")
			If ((Position:C15($repAsistencia;$comment{$i})>0) | ($comment{$i}="Asistencia inferior@"))
				iAbs:=iabs+1
			Else 
				iBad:=iBad+1
			End if 
		Else 
			iOK:=iOK+1
	End case 
	aCRUN{$i}:=ST_ClearSpaces (aCRUN{$i})
	alActas_ColumnNumber{$i}:=$i
	If (Num:C11(Substring:C12(aCRun{$i};1;1))>0)
		$d:=aCRun{$i}[[Length:C16(aCRun{$i})]]
		$run:=Substring:C12(aCRun{$i};1;Length:C16(aCRun{$i})-1)
		$len:=Length:C16($run)
		Case of 
			: ($len=7)
				$run:=Substring:C12($run;1;1)+"."+Substring:C12($run;2;3)+"."+Substring:C12($run;5;3)
			: ($len=8)
				$run:=Substring:C12($run;1;2)+"."+Substring:C12($run;3;3)+"."+Substring:C12($run;6;3)
			: ($len=9)
				$run:=Substring:C12($run;1;3)+"."+Substring:C12($run;4;3)+"."+Substring:C12($run;7;3)
		End case 
		aCRun{$i}:=$run+"-"+$d
	Else 
		If ($nation{$i}#"Chilen@")
			aCRUN{$i}:="E/T"
		End if 
	End if 
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	EV2_RegistrosDelAlumno ($id{$i};$aNivel{$i})
	SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$pctGrade;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$aGrade;[Asignaturas:18]Asignatura:3;$Asig;[Asignaturas:18]Incide_en_promedio:27;$inAv;[Asignaturas:18]Incluida_en_Actas:44;$enActas;[Alumnos_Calificaciones:208]ID_Asignatura:5;$asgID;[Alumnos_ComplementoEvaluacion:209]Eximicion_NoRegistro:8;$aEximicion;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;$dateEximicion;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$aEvStyleID;[Asignaturas:18]Es_Optativa:70;$aOptativa)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	$sum:=0
	$div:=0
	$Insuf:=0
	$eximido:=False:C215
	$strExim:=""
	$repRI:=False:C215
	$pendiente:=False:C215
	
	
	For ($k;1;Size of array:C274($pctGrade))
		$aGrade{$k}:=Replace string:C233($aGrade{$k};Char:C90(0);"")
		$ColPos:=Find in array:C230(atActas_Subsectores;$asig{$k})
		If ($enActas{$k})
			If (($inAv{$k}=False:C215) & (Position:C15($asig{$k};$sNoAvg)=0))
				If ($sNoAvg#"")
					$sNoAvg:=$sNoAvg+", "+$asig{$k}
				Else 
					$sNoAvg:=$asig{$k}
				End if 
			End if 
			If ($colPos=-1)
				If ($inAv{$k})
					$r:=CD_Dlog (2;__ ("La asignatura ")+$asig{$k}+__ (" no tiene posición definida en el modelo de acta.\rEl acta no puede ser impresa correctamente."))
					$k:=Size of array:C274($pctGrade)
					$i:=Size of array:C274($id)
				End if 
			Else 
				$ptr:=Get pointer:C304("aC"+String:C10($colPos))
				$fechaTope:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
				If (($dateOut{$i}<$fechaTope) & ($aStatus{$i}="Retirado@"))
					$ptr->{$i}:="-"
				Else 
					If ($aOptativa{$k})
						$ptr->{$i}:=vs_AbrNoReligion
					End if 
					Case of 
						: ((($pctGrade{$k}=0) | ($pctGrade{$k}=-10) | ($pctGrade{$k}=-1)) & ($aOptativa{$k}))
							$ptr->{$i}:=vs_AbrNoReligion
						: (($pctGrade{$k}=0) & (($dateEximicion{$k}>!00-00-00!) | ($pctGrade{$k}=-3)))
							$ptr->{$i}:="EX"
						: (($dateEximicion{$k}>!00-00-00!) | ($pctGrade{$k}=-3))
							$ptr->{$i}:="EX"
						: ($pctGrade{$k}=-2)
							$ptr->{$i}:="P"
						: (($pctGrade{$k}=0) | ($pctGrade{$k}=-10) | ($pctGrade{$k}=-1))
							$ptr->{$i}:="-"
						Else 
							$ptr->{$i}:=$aGrade{$k}
					End case 
				End if 
			End if 
		End if 
	End for 
	
	$fAverage{$i}:=Replace string:C233($fAverage{$i};Char:C90(0);"")
	Case of 
		: ($PFCol=-1)
			$r:=CD_Dlog (2;__ ("La columna Promedio Final no fue definida en el modelo de acta.\rEl acta no puede ser impresa correctamente."))
			$i:=Size of array:C274($id)
		: ($PACol=-1)
			$r:=CD_Dlog (2;__ ("La columna Porcentaje de asistencia no fue definida en el modelo de acta.\rEl acta no puede ser impresa correctamente."))
			$i:=Size of array:C274($id)
		: ($SFCol=-1)
			$r:=CD_Dlog (2;__ ("La columna Situación final no fue definida en el modelo de acta.\rEl acta no puede ser impresa correctamente."))
			$i:=Size of array:C274($id)
		Else 
			If (vi_noCalculations=0)
				$ptr:=Get pointer:C304("aC"+String:C10($PFCol))
				$ptr->{$i}:=$fAverage{$i}
			Else 
				$ptr:=Get pointer:C304("aC"+String:C10($PFCol))
				$ptr->{$i}:="-"
			End if 
			$d2:=DT_GetDateFromDayMonthYear (30;11;<>gYear)
			If (($dateOut{$i}<=$d2) & ($aStatus{$i}="Retirado@"))
				$PFCol:=Find in array:C230(atActas_Subsectores;"Promedio final")
				$ptr:=Get pointer:C304("aC"+String:C10($PFCol))
				$ptr->{$i}:="-"
				$PACol:=Find in array:C230(atActas_Subsectores;"Porcentaje de asistencia")
				$ptr:=Get pointer:C304("aC"+String:C10($PACol))
				$ptr->{$i}:="-"
			Else 
				$ptr:=Get pointer:C304("aC"+String:C10($PACol))
				Case of 
					: ($pctAttendance{$i}=100)
						$ptr->{$i}:="100"
					: ($pctAttendance{$i}>0)
						Case of 
							: ([xxSTR_Niveles:6]Decimales_asistencia:42=0)
								$pctAttendance{$i}:=Round:C94($pctAttendance{$i};0)
								$ptr->{$i}:=String:C10($pctAttendance{$i};"##0")
							: ([xxSTR_Niveles:6]Decimales_asistencia:42=1)
								$pctAttendance{$i}:=Round:C94($pctAttendance{$i};1)
								$ptr->{$i}:=String:C10($pctAttendance{$i};"##0"+<>tXS_RS_DecimalSeparator+"0")
							: ([xxSTR_Niveles:6]Decimales_asistencia:42=2)
								$pctAttendance{$i}:=Round:C94($pctAttendance{$i};2)
								$ptr->{$i}:=String:C10($pctAttendance{$i};"##0"+<>tXS_RS_DecimalSeparator+"00")
						End case 
					Else 
						$ptr->{$i}:="100"
				End case 
			End if 
			$ptr:=Get pointer:C304("aC"+String:C10($SFCol))
			$ptr->{$i}:=$statPromo{$i}
			aC37{$i}:=Replace string:C233(Replace string:C233($obs{$i};"[";"");"]";"")
	End case 
	
End for 
iReprobados:=iBad+iAbs

sMencion:=""
If ($sNoAvg#"")
	If (Position:C15(", ";$sNoAvg)#0)
		sMencion:="NOTA: Las asignaturas de "+$sNoAvg+" no inciden en el promedio general de calificaciones ni en la situación final "+"del alumno."
	Else 
		sMencion:="NOTA: La asignatura de "+$sNoAvg+" no incide en el promedio general de calificaciones ni en la situación final "+"del alumno."
	End if 
End if 

Case of 
	: ((([Cursos:3]Nivel_Numero:7=6) | ([Cursos:3]Nivel_Numero:7=10)) & (<>gYear=1999))
		$fixReforma:=True:C214
	: ((([Cursos:3]Nivel_Numero:7=7) | ([Cursos:3]Nivel_Numero:7=11)) & (<>gYear=2000) & (Current date:C33(*)<!2001-03-01!))
		$fixReforma:=True:C214
	: ((([Cursos:3]Nivel_Numero:7=8)) & (<>gYear=2002) & (Current date:C33(*)<!2002-03-01!))
		$fixReforma:=True:C214
	Else 
		$fixReforma:=False:C215
End case 


If ($fixReforma)
	
	ipending:=0
	$PFCol:=Find in array:C230(atActas_Subsectores;"Promedio final")
	$ptrPF:=Get pointer:C304("aC"+String:C10($PFCol))
	$ptrSF:=Get pointer:C304("aC"+String:C10($SFCol))
	For ($i;1;Size of array:C274($ptr->))
		$promedio:=Num:C11($ptrPF->{$i})
		If ($ptrSF->{$i}="R")
			$positionRepitente:=$i
			$pendingCounted:=False:C215
			$reprobadas:=0
			For ($j;1;Size of array:C274(atActas_Subsectores))
				$ptr:=Get pointer:C304("aC"+String:C10($j))
				$notaNumerica:=Num:C11($ptr->{$positionRepitente})
				If (($notaNumerica<4) & ($notaNumerica>0))
					$reprobadas:=$reprobadas+1
					If ($pendingCounted=False:C215)
						$pendingCounted:=True:C214
						ipending:=ipending+1
					End if 
				End if 
			End for 
			If ((($reprobadas=1) & ($promedio<4.5)) | ($reprobadas>1))
				If ($obs{$positionRepitente}#"")
					aC37{$i}:="Sit. Esc. Pend. (Dec. Sup. Ex. Nº 1113/98); "+$obs{$i}
				Else 
					aC37{$i}:="Sit. Esc. Pend. (Dec. Sup. Ex. Nº 1113/98)"
				End if 
			End if 
		End if 
	End for 
End if 