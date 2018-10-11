//%attributes = {}
  //EV2_MuestraInfoCalificacion

C_LONGINT:C283($row;$1;$column;$2)
C_POINTER:C301($pointer)
$row:=$1
$column:=$2
vi_Parcial:=Abs:C99($column-vi_PrimeraColumnaParciales)+1
$periodo:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}


ARRAY TEXT:C222($aArrayNames;0)
ARRAY TEXT:C222($aHeaders;0)
$err:=AL_GetArrayNames (xALP_ASNotas;$aArrayNames)
$err:=AL_GetHeaders (xALP_ASNotas;$aHeaders)


Case of 
	: ($aArrayNames{$column}="aNtaP1")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P01_Final_Literal:116)
	: ($aArrayNames{$column}="aNtaP2")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191)
	: ($aArrayNames{$column}="aNtaP3")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266)
	: ($aArrayNames{$column}="aNtaP4")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Literal:341)
	: ($aArrayNames{$column}="aNtaP5")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Literal:416)
	: ($aArrayNames{$column}="aNtaEXP")
		Case of 
			: ($periodo=1)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P01_Control_Literal:111)
			: ($periodo=2)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P02_Control_Literal:186)
			: ($periodo=3)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P03_Control_Literal:261)
			: ($periodo=4)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P04_Control_Literal:336)
			: ($periodo=5)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P05_Control_Literal:411)
		End case 
		
	: ($aArrayNames{$column}="aNtaBX")
		Case of 
			: ($periodo=1)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514)
			: ($periodo=2)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519)
			: ($periodo=3)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524)
			: ($periodo=4)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529)
			: ($periodo=5)
				$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534)
		End case 
		
	: ($aArrayNames{$column}="aNtaPF")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]Anual_Literal:15)
		
	: ($aArrayNames{$column}="aNtaEX")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20)
		
	: ($aArrayNames{$column}="aNtaEXX")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25)
		
	: ($aArrayNames{$column}="aNtaF")
		$fieldNum:=Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
		
	Else 
		
		Case of 
			: ($periodo=1)
				$fieldNum:=42+((vi_Parcial-1)*5)+4
			: ($periodo=2)
				$fieldNum:=117+((vi_Parcial-1)*5)+4
			: ($periodo=3)
				$fieldNum:=192+((vi_Parcial-1)*5)+4
			: ($periodo=4)
				$fieldNum:=267+((vi_Parcial-1)*5)+4
			: ($periodo=5)
				$fieldNum:=342+((vi_Parcial-1)*5)+4
		End case 
		
End case 


$recNum:=aNtaRecNum{$row}
KRL_GotoRecord (->[Alumnos_Calificaciones:208];$recNum)
vs_Key:=[Alumnos_Calificaciones:208]Llave_principal:1+"."+String:C10($fieldNum)

$pointer:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$fieldNum)

$title:=Substring:C12(aNtaStdNme{$row};1;40)+__ (", nota ")+$aHeaders{$column}+", "+vt_periodo
$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->vs_Key;True:C214)

If ($recNum<0)
	BEEP:C151
Else 
	WDW_OpenFormWindow (->[xxSTR_InfoCalificaciones:142];"InfoCalificacion";7;Palette form window:K39:9;$title)
	KRL_ModifyRecord (->[xxSTR_InfoCalificaciones:142];"InfoCalificacion")
End if 
CLOSE WINDOW:C154







