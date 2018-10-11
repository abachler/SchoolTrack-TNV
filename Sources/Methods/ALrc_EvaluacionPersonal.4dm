//%attributes = {}
  //ALrc_EvaluacionPersonal

<>ST_v461:=False:C215  //10/8/98 at 04:50:27 by: Alberto Bachler
  // implementación  de bimestres
C_LONGINT:C283($i;$startrow;$endrow)
ARRAY TEXT:C222(aEValInfo1;0)
ARRAY TEXT:C222(aEValInfo2;0)
ARRAY TEXT:C222(aEValInfo3;0)
ARRAY TEXT:C222(aEValInfo4;0)
ARRAY TEXT:C222(aEvalFinal;0)
ARRAY INTEGER:C220(aEvalSort;0)
ARRAY INTEGER:C220(aEvalPos;0)
If (bEvVal=1)
	COPY ARRAY:C226(<>aValores;aValores)  //Impresion de la evaluacion valórica
	For ($i;Size of array:C274(aValores);1;-1)
		If (aValores{$i}="")
			AT_Delete ($i;1;->aValores)
		Else 
			aValores{$i}:="   "+aValores{$i}
		End if 
	End for 
Else 
	_O_ARRAY STRING:C218(60;aValores;0)
End if 
$s:=Size of array:C274(aValores)

If ($s>0)
	$startRow:=1
	$endRow:=$s
	ARRAY TEXT:C222(aEValInfo1;$s)
	ARRAY TEXT:C222(aEValInfo2;$s)
	ARRAY TEXT:C222(aEValInfo3;$s)
	ARRAY TEXT:C222(aEValInfo4;$s)
	ARRAY TEXT:C222(aEvalFinal;$s)
	ARRAY INTEGER:C220(aEvalSort;$s)
	ARRAY INTEGER:C220(aEvalPos;$s)
	QUERY:C277([Alumnos_EvaluacionValorica:23];[Alumnos_EvaluacionValorica:23]Alumno_Numero:1=[Alumnos:2]numero:1)
	For ($i;1;$s)
		aEvalSort{$i}:=0
		aEvalPos{$i}:=$i
		aEValInfo1{$i}:=Field:C253(Table:C252(->[Alumnos_EvaluacionValorica:23]);$i+1)->
		If ((vPeriodo=2) | (vPeriodo=3))
			aEValInfo2{$i}:=Field:C253(Table:C252(->[Alumnos_EvaluacionValorica:23]);$i+7)->
		Else 
			aEValInfo2{$i}:=""
		End if 
		If ((viSTR_Periodos_NumeroPeriodos>=3) & (vPeriodo=3))
			aEValInfo3{$i}:=Field:C253(Table:C252(->[Alumnos_EvaluacionValorica:23]);$i+13)->
		Else 
			aEValInfo3{$i}:=""
		End if 
		If ((viSTR_Periodos_NumeroPeriodos=4) & (vPeriodo=4))
			aEValInfo4{$i}:=Field:C253(Table:C252(->[Alumnos_EvaluacionValorica:23]);$i+20)->
		Else 
			aEValInfo4{$i}:=""
		End if 
	End for 
	$hdr:=aText1{22}
	$0:=$s+1
Else 
	$hdr:=aText1{49}
	$0:=0
End if 