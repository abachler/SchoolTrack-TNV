//%attributes = {}
  //AL_SetNotasClr

C_LONGINT:C283($k;$1;$2)
C_BOOLEAN:C305($esfuerzoVisible;$controlVisible)
ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBleu;2;0)
ARRAY INTEGER:C220(aSetBleu{1};0)
ARRAY INTEGER:C220(aSetBleu{2};0)
ARRAY INTEGER:C220(aSetGreen;2;0)
ARRAY INTEGER:C220(aSetGreen{1};0)
ARRAY INTEGER:C220(aSetGreen{2};0)
ARRAY INTEGER:C220(aSetViol;2;0)
ARRAY INTEGER:C220(aSetViol{1};0)
ARRAY INTEGER:C220(aSetViol{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)



$l_modo:=$1

$el:=Find in array:C230(aNtaEsfuerzo;"@")
If ($el>0)
	$esfuerzoVisible:=True:C214
End if 
$el:=Find in array:C230(aNtaEXP;"@")
If ($el>0)
	$controlVisible:=True:C214
End if 

ARRAY TEXT:C222($aArrayNames;0)
ARRAY TEXT:C222($aHeaders;0)
$err:=AL_GetHeaders (xALP_Notas;$aHeaders;1)
$err:=AL_GetArrayNames (xALP_Notas;$aArrayNames;1)



$primeraColumnaNotas:=Find in array:C230($aArrayNames;"aNta1")
For ($k;1;Size of array:C274(aNtaF))
	EVS_ReadStyleData (aNtaEvStyleID{$k})
	$l_idAsignatura:=Num:C11(ST_GetWord (at_KeyEvaluacionPrincipal{$k};4;"."))
	$l_numeroNivel:=Num:C11(ST_GetWord (at_KeyEvaluacionPrincipal{$k};3;"."))
	$b_convertir_a_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_numeroNivel;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)\
		 | KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]NotaOficial_conEstiloAsignatura:95)
	
	Case of 
		: ($l_modo=Notas)
			$r_minimoEscala:=rGradesFrom
			$r_minimoAprobatorio:=rGradesMinimum
		: ($l_modo=Puntos)
			$r_minimoEscala:=rPointsFrom
			$r_minimoAprobatorio:=rPointsMinimum
		Else 
			$r_minimoEscala:=vrNTA_MinimoEscalaReferencia
			$r_minimoAprobatorio:=Round:C94(rPctMinimum;11)
	End case 
	
	NTA_SetCellClr (aRealNta1{$k};$primeraColumnaNotas;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta2{$k};$primeraColumnaNotas+1;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta3{$k};$primeraColumnaNotas+2;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta4{$k};$primeraColumnaNotas+3;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta5{$k};$primeraColumnaNotas+4;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta6{$k};$primeraColumnaNotas+5;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta7{$k};$primeraColumnaNotas+6;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta8{$k};$primeraColumnaNotas+7;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta9{$k};$primeraColumnaNotas+8;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta10{$k};$primeraColumnaNotas+9;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta11{$k};$primeraColumnaNotas+10;$k;$r_minimoAprobatorio)
	NTA_SetCellClr (aRealNta12{$k};$primeraColumnaNotas+11;$k;$r_minimoAprobatorio)
	
	$el:=Find in array:C230($aArrayNames;"aNtaP1")
	If ($el>0)
		NTA_SetCellClr (aRealNtaP1{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaP2")
	If ($el>0)
		NTA_SetCellClr (aRealNtaP2{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaP3")
	If ($el>0)
		NTA_SetCellClr (aRealNtaP3{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaP4")
	If ($el>0)
		NTA_SetCellClr (aRealNtaP4{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaP5")
	If ($el>0)
		NTA_SetCellClr (aRealNtaP5{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaPF")
	If ($el>0)
		NTA_SetCellClr (aRealNtaPF{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaEX")
	If ($el>0)
		NTA_SetCellClr (aRealNtaEX{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaEXX")
	If ($el>0)
		NTA_SetCellClr (aRealNtaEXX{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaF")
	If ($el>0)
		NTA_SetCellClr (aRealNtaF{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aStrAsgAverage")
	If ($el>0)
		NTA_SetCellClr (aRealAsgAverage{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaEXP")
	If ($el>0)
		NTA_SetCellClr (aRealNtaEXP{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaBX")
	If ($el>0)
		NTA_SetCellClr (aRealNtaBX{$k};$el;$k;$r_minimoAprobatorio)
	End if 
	
	$el:=Find in array:C230($aArrayNames;"aNtaOf")
	If ($el>0)
		$l_visualizacionActual:=vi_lastGradeView
		vi_lastGradeView:=$l_modo
		If ($b_convertir_a_EstiloOficial)
			$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			EVS_ReadStyleData ($idEstiloOficial)
			NTA_SetCellClr (aRealNtaOficial{$k};$el;$k;rPctminimum)  //;vrEVLG_Requerido;vrEVLG_Evaluacion_Maximo)
			EVS_ReadStyleData (aNtaEvStyleID{$k})
		Else 
			NTA_SetCellClr (aRealNtaOficial{$k};$el;$k)
		End if 
		vi_lastGradeView:=$l_visualizacionActual
	End if 
	
	If ((aNtaReprobada{$k}) & (aIncide{$k}))
		INSERT IN ARRAY:C227(aSetRed{1};Size of array:C274(aSetRed{1})+1)
		INSERT IN ARRAY:C227(aSetRed{2};Size of array:C274(aSetRed{2})+1)
		aSetRed{1}{Size of array:C274(aSetRed{1})}:=1
		aSetRed{2}{Size of array:C274(aSetRed{2})}:=$k
		INSERT IN ARRAY:C227(aSetRed{1};Size of array:C274(aSetRed{1})+1)
		INSERT IN ARRAY:C227(aSetRed{2};Size of array:C274(aSetRed{2})+1)
		aSetRed{1}{Size of array:C274(aSetRed{1})}:=2
		aSetRed{2}{Size of array:C274(aSetRed{2})}:=$k
		
	Else 
		INSERT IN ARRAY:C227(aSetBlack{1};Size of array:C274(aSetBlack{1})+1)
		INSERT IN ARRAY:C227(aSetBlack{2};Size of array:C274(aSetBlack{2})+1)
		aSetBlack{1}{Size of array:C274(aSetBlack{1})}:=1
		aSetBlack{2}{Size of array:C274(aSetBlack{2})}:=$k
		INSERT IN ARRAY:C227(aSetBlack{1};Size of array:C274(aSetBlack{1})+1)
		INSERT IN ARRAY:C227(aSetBlack{2};Size of array:C274(aSetBlack{2})+1)
		aSetBlack{1}{Size of array:C274(aSetBlack{1})}:=2
		aSetBlack{2}{Size of array:C274(aSetBlack{2})}:=$k
		
	End if 
End for 

AL_SetCellColor (xALP_Notas;0;0;0;0;aSetBlack;"";16)
AL_SetCellColor (xALP_Notas;0;0;0;0;aSetRed;"";4)
AL_SetCellColor (xALP_Notas;0;0;0;0;aSetBleu;"";7)
AL_SetCellColor (xALP_Notas;0;0;0;0;aSetGreen;"";10)
AL_SetCellColor (xALP_Notas;0;0;0;0;aSetViol;"";240)
ARRAY INTEGER:C220(aSetRed;0;0)
ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBleu;0;0)
ARRAY INTEGER:C220(aSetBleu;2;0)
ARRAY INTEGER:C220(aSetBleu{1};0)
ARRAY INTEGER:C220(aSetBleu{2};0)
ARRAY INTEGER:C220(aSetGreen;2;0)
ARRAY INTEGER:C220(aSetGreen{1};0)
ARRAY INTEGER:C220(aSetGreen{2};0)
ARRAY INTEGER:C220(aSetViol;2;0)
ARRAY INTEGER:C220(aSetViol{1};0)
ARRAY INTEGER:C220(aSetViol{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)


