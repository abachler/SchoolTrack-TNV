//%attributes = {}
  //CU_FrecuenciaCalificaciones

C_TEXT:C284(vs_string1;vs_string2;vs_string3;vs_string4;vs_string5;vs_string6;vs_string7;vs_string8;vs_string9;vs_string10;vs_string11;vs_string12)
ARRAY INTEGER:C220(aInt1;0)
ARRAY INTEGER:C220(aInt2;0)
ARRAY INTEGER:C220(aInt3;0)
ARRAY INTEGER:C220(aInt4;0)
ARRAY INTEGER:C220(aInt5;0)
ARRAY INTEGER:C220(aInt6;0)
ARRAY INTEGER:C220(aInt7;0)
ARRAY INTEGER:C220(aInt8;0)
ARRAY INTEGER:C220(aInt9;0)
ARRAY INTEGER:C220(aInt10;0)
ARRAY INTEGER:C220(aInt11;0)
ARRAY INTEGER:C220(aInt12;0)
ARRAY LONGINT:C221(aLong1;0)



QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
  //EVS_LoadStyles 
EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
Case of 
	: (iEvaluationMode=Notas)
		$startNumber:=rGradesTo
		$endNumber:=rGradesFrom
		$interval:=rGradesInterval
	: (iEvaluationMode=Notas)
		$startNumber:=rPointsTo
		$endNumber:=rPointsFrom
		$interval:=rGradesInterval
End case 

$periodo:=$1
$parciales:=$2

EV2_InitArrays 
Case of 
	: ($periodo=5)
		$pointerPromedio:=->aRealNtaP5
	: ($periodo=4)
		$pointerPromedio:=->aRealNtaP4
	: ($periodo=3)
		$pointerPromedio:=->aRealNtaP3
	: ($periodo=2)
		$pointerPromedio:=->aRealNtaP2
	: ($periodo=1)
		$pointerPromedio:=->aRealNtaP1
	: ($periodo=0)
		$pointerPromedio:=->aRealNtaF
End case 

ARRAY REAL:C219(ar_Real1;1)
ARRAY REAL:C219(ar_Real2;1)
$nota:=$startNumber
ar_Real1{1}:=$nota
ar_Real2{1}:=NTA_StringValue2Percent (String:C10($nota))
Repeat 
	AT_Insert (Size of array:C274(ar_Real1)+1;1;->ar_Real1;->ar_Real2)
	$nota:=$nota-$interval
	ar_Real1{Size of array:C274(ar_Real1)}:=$nota
	ar_Real2{Size of array:C274(ar_Real1)}:=NTA_StringValue2Percent (String:C10($nota))
Until ($nota=$endNumber)

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
  //MONO TICKET 155405
If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
End if 
EV2_Calificaciones_SeleccionAL 
CREATE SET:C116([Alumnos_Calificaciones:208];"notas")
AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->aLong1)

QRY_QueryWithArray (->[Asignaturas:18]Numero:1;->aLong1)
QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas:18]ordenGeneral:105;$aPosition;[Asignaturas:18]Numero:1;$idSubject;[Asignaturas:18]Asignatura:3;$aSubject;[Asignaturas:18]Abreviación:26;$aAbreviacion;[Profesores:4]Nombre_comun:21;$aProfesores;[Profesores:4]Iniciales:29;$aIniciales)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
SORT ARRAY:C229($aPosition;$aSubject;$idSubject;$aAbreviacion;$aProfesores;$aIniciales;>)

If (vPageNumber>1)
	DELETE FROM ARRAY:C228($aPosition;1;(vPageNumber-1)*12)
	DELETE FROM ARRAY:C228($aSubject;1;(vPageNumber-1)*12)
	DELETE FROM ARRAY:C228($idSubject;1;(vPageNumber-1)*12)
	DELETE FROM ARRAY:C228($aAbreviacion;1;(vPageNumber-1)*12)
	DELETE FROM ARRAY:C228($aProfesores;1;(vPageNumber-1)*12)
	DELETE FROM ARRAY:C228($aIniciales;1;(vPageNumber-1)*12)
End if 

If (Size of array:C274($aPosition)>12)
	$elementosAEliminar:=Size of array:C274($aPosition)
	DELETE FROM ARRAY:C228($aPosition;13;$elementosAEliminar)
	DELETE FROM ARRAY:C228($aSubject;13;$elementosAEliminar)
	DELETE FROM ARRAY:C228($idSubject;13;$elementosAEliminar)
	DELETE FROM ARRAY:C228($aAbreviacion;13;$elementosAEliminar)
	DELETE FROM ARRAY:C228($aProfesores;13;$elementosAEliminar)
	DELETE FROM ARRAY:C228($aIniciales;13;$elementosAEliminar)
End if 



For ($i;1;12)
	$stringpointer:=Get pointer:C304("vs_string"+String:C10($i))
	$arrayPointer:=Get pointer:C304("aInt"+String:C10($i))
	$stringpointer->:=""
	AT_DimArrays (0;$arrayPointer)
End for 


$totalEvaluaciones:=0
$totalasignado:=0
vt_text1:=""



ARRAY LONGINT:C221(aLong1;Size of array:C274($aAbreviacion))
For ($i;1;Size of array:C274($aAbreviacion))
	$stringpointer:=Get pointer:C304("vs_string"+String:C10($i))
	$arrayPointer:=Get pointer:C304("aInt"+String:C10($i))
	AT_DimArrays (Size of array:C274(ar_Real1);$arrayPointer)
	$stringPointer->:=$aAbreviacion{$i}+"\r"+$aIniciales{$i}
	vt_text1:=vt_text1+$aAbreviacion{$i}+": "+$aSubject{$i}+" ("+$aProfesores{$i}+"); "
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$idSubject{$i})
	EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$periodo)
	
	aLong1{$i}:=Size of array:C274(aNtaRealArrPointers{1}->)
	$totalEvaluaciones:=0
	If ($parciales=1)
		For ($indexparciales;1;12)
			For ($indexEvaluaciones;1;Size of array:C274(aNtaRealArrPointers{$indexparciales}->))
				$percent:=aNtaRealArrPointers{$indexparciales}->{$indexEvaluaciones}
				If ($percent>0)
					$totalEvaluaciones:=$totalEvaluaciones+1
					$position:=Find in array:C230(ar_Real2;$percent)
					If ($Position>0)
						$arrayPointer->{$position}:=$arrayPointer->{$position}+1
						$totalasignado:=$totalasignado+1
					Else 
						For ($iLoop;1;Size of array:C274(ar_Real2))
							If ($iLoop<Size of array:C274(ar_Real2))
								If (($percent>=ar_Real2{$iLoop}) & ($percent<ar_Real2{$iLoop+1}))
									$arrayPointer->{$iLoop}:=$arrayPointer->{$iLoop}+1
									$totalasignado:=$totalasignado+1
									$iLoop:=Size of array:C274(ar_Real2)+1
								End if 
							End if 
						End for 
					End if 
				End if 
			End for 
		End for 
		aLong1{$i}:=$totalEvaluaciones
	Else 
		For ($indexEvaluaciones;1;Size of array:C274($pointerPromedio->))
			$percent:=$pointerPromedio->{$indexEvaluaciones}
			If ($percent>0)
				$totalEvaluaciones:=$totalEvaluaciones+1
				$position:=Find in array:C230(ar_Real2;$percent)
				If ($Position>0)
					$arrayPointer->{$position}:=$arrayPointer->{$position}+1
					$totalasignado:=$totalasignado+1
				Else 
					For ($iLoop;1;Size of array:C274(ar_Real2))
						If ($iLoop<Size of array:C274(ar_Real2))
							If (($percent>=ar_Real2{$iLoop}) & ($percent<ar_Real2{$iLoop+1}))
								$arrayPointer->{$iLoop}:=$arrayPointer->{$iLoop}+1
								$totalasignado:=$totalasignado+1
								$iLoop:=Size of array:C274(ar_Real2)+1
							End if 
						End if 
					End for 
				End if 
			End if 
		End for 
		aLong1{$i}:=$totalEvaluaciones
	End if 
End for 
vt_text1:=Substring:C12(vt_text1;1;Length:C16(vt_text1)-2)

$0:=Size of array:C274($aAbreviacion)

