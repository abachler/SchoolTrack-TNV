//%attributes = {}
  // AS_SetNotasClr()
  // 
  //
  // creado por: Alberto Bachler Klein: 24-06-16, 17:43:33
  // -----------------------------------------------------------




  //asigno las constantes a variables debido a un bug de 4D v11 con las constantes en compilado
C_LONGINT:C283($5bimestres;$4Bimestres;$3Trimestres;$2semestres;$anual)
C_LONGINT:C283($i;$k)
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
ARRAY INTEGER:C220(aSetUnderline;2;0)
ARRAY INTEGER:C220(aSetUnderline{1};0)
ARRAY INTEGER:C220(aSetUnderline{2};0)
ARRAY INTEGER:C220(aSetPlain;2;0)
ARRAY INTEGER:C220(aSetPlain{1};0)
ARRAY INTEGER:C220(aSetPlain{2};0)

If ((Not:C34([Asignaturas:18]Seleccion:17)) & (Not:C34([Asignaturas:18]Electiva:11)))
	$startAt:=3
Else 
	$startAt:=4
End if 

  //verifico si hay columna para el registro de la inasistencia
ARRAY TEXT:C222($aArrayNames;0)
$err:=AL_GetArrayNames (xALP_ASNotas;$aArrayNames)
If (Find in array:C230($aArrayNames;"alSTR_InasistenciasPeriodo")>0)
	$startAt:=$startAt+1
End if 

For ($k;1;Size of array:C274(aRealNtaF))
	Case of 
		: (vlSTR_Periodos_Tipo=Anual)
			NTA_SetCellClr (aRealNtaP1{$k};$startAt;$k)  //P1
			If (vi_UsarExamenes=1)
				NTA_SetCellClr (aRealNtaPF{$k};$startAt+1;$k)  //PF
				NTA_SetCellClr (aRealNtaEX{$k};$startAt+2;$k)  //EX
				If (vi_UsarExamenExtra=1)
					NTA_SetCellClr (aRealNtaEXX{$k};$startAt+3;$k)  //EX
					NTA_SetCellClr (aRealNtaF{$k};$startAt+4;$k)  //NF
					$colOffset:=$startAt+4
				Else 
					NTA_SetCellClr (aRealNtaF{$k};$startAt+3;$k)  //NF
					$colOffset:=$startAt+3
				End if 
			Else 
				NTA_SetCellClr (aRealNtaF{$k};$startAt+1;$k)  //NF
				$colOffset:=$startAt+1
			End if 
			
		: (vlSTR_Periodos_Tipo=5 Bimestres)
			NTA_SetCellClr (aRealNtaP1{$k};$startAt;$k)
			NTA_SetCellClr (aRealNtaP2{$k};$startAt+1;$k)
			NTA_SetCellClr (aRealNtaP3{$k};$startAt+2;$k)
			NTA_SetCellClr (aRealNtaP4{$k};$startAt+3;$k)
			NTA_SetCellClr (aRealNtaP5{$k};$startAt+4;$k)
			If (vi_UsarExamenes=1)
				NTA_SetCellClr (aRealNtaPF{$k};$startAt+5;$k)  //PF
				NTA_SetCellClr (aRealNtaEX{$k};$startAt+6;$k)  //EX
				If (vi_UsarExamenExtra=1)
					NTA_SetCellClr (aRealNtaEXX{$k};$startAt+7;$k)  //EX
					NTA_SetCellClr (aRealNtaF{$k};$startAt+8;$k)  //NF
					$colOffset:=$startAt+8
				Else 
					NTA_SetCellClr (aRealNtaF{$k};$startAt+7;$k)  //NF
					$colOffset:=$startAt+7
				End if 
			Else 
				NTA_SetCellClr (aRealNtaF{$k};$startAt+5;$k)  //NF
				$colOffset:=$startAt+5
			End if 
			
			
		: (vlSTR_Periodos_Tipo=2 Semestres)
			NTA_SetCellClr (aRealNtaP1{$k};$startAt;$k)  //P1
			NTA_SetCellClr (aRealNtaP2{$k};$startAt+1;$k)  //P2
			If (vi_UsarExamenes=1)
				NTA_SetCellClr (aRealNtaPF{$k};$startAt+2;$k)  //PF
				NTA_SetCellClr (aRealNtaEX{$k};$startAt+3;$k)  //EX
				If (vi_UsarExamenExtra=1)
					NTA_SetCellClr (aRealNtaEXX{$k};$startAt+4;$k)  //EX
					NTA_SetCellClr (aRealNtaF{$k};$startAt+5;$k)  //NF
					$colOffset:=$startAt+5
				Else 
					NTA_SetCellClr (aRealNtaF{$k};$startAt+4;$k)  //NF
					$colOffset:=$startAt+4
				End if 
			Else 
				NTA_SetCellClr (aRealNtaF{$k};$startAt+2;$k)  //NF
				$colOffset:=$startAt+2
			End if 
			
			
		: (vlSTR_Periodos_Tipo=3 Trimestres)
			NTA_SetCellClr (aRealNtaP1{$k};$startAt;$k)  //P1
			NTA_SetCellClr (aRealNtaP2{$k};$startAt+1;$k)  //P2
			NTA_SetCellClr (aRealNtaP3{$k};$startAt+2;$k)  //P3
			If (vi_UsarExamenes=1)
				NTA_SetCellClr (aRealNtaPF{$k};$startAt+3;$k)  //PF
				NTA_SetCellClr (aRealNtaEX{$k};$startAt+4;$k)  //EX
				If (vi_UsarExamenExtra=1)
					NTA_SetCellClr (aRealNtaEXX{$k};$startAt+5;$k)  //EX
					NTA_SetCellClr (aRealNtaF{$k};$startAt+6;$k)  //NF
					$colOffset:=$startAt+6
				Else 
					NTA_SetCellClr (aRealNtaF{$k};$startAt+5;$k)  //NF
					$colOffset:=$startAt+5
				End if 
			Else 
				NTA_SetCellClr (aRealNtaF{$k};$startAt+3;$k)  //NF
				$colOffset:=$startAt+3
			End if 
			
		: (vlSTR_Periodos_Tipo=4 Bimestres)
			NTA_SetCellClr (aRealNtaP1{$k};$startAt;$k)  //P1
			NTA_SetCellClr (aRealNtaP2{$k};$startAt+1;$k)  //P2
			NTA_SetCellClr (aRealNtaP3{$k};$startAt+2;$k)  //P3
			NTA_SetCellClr (aRealNtaP4{$k};$startAt+3;$k)  //P4
			If (vi_UsarExamenes=1)
				NTA_SetCellClr (aRealNtaPF{$k};$startAt+4;$k)  //PF
				NTA_SetCellClr (aRealNtaEX{$k};$startAt+5;$k)  //EX
				If (vi_UsarExamenExtra=1)
					NTA_SetCellClr (aRealNtaEXX{$k};$startAt+6;$k)  //EX
					NTA_SetCellClr (aRealNtaF{$k};$startAt+7;$k)  //NF
					$colOffset:=$startAt+7
				Else 
					NTA_SetCellClr (aRealNtaF{$k};$startAt+6;$k)  //NF
					$colOffset:=$startAt+6
				End if 
			Else 
				NTA_SetCellClr (aRealNtaF{$k};$startAt+4;$k)  //NF
				$colOffset:=$startAt+4
			End if 
			
	End case 
	
	If (vb_NotaOficialVisible)
		$idEstiloOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		EVS_ReadStyleData ($idEstiloOficial)
		NTA_SetCellClr (aRealNtaOficial{$k};$colOffset+1;$k)  //NO
		EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
		$colOffset:=$colOffset+1
		If ([Asignaturas:18]Ingresa_Esfuerzo:40)
			NTA_SetCellClr (aRealNtaEsfuerzo{$k};$colOffset+1;$k)  //ESF
			$colOffset:=$colOffset+1
		End if 
		If (vi_UsarBonificacion#0)
			NTA_SetCellClr (aRealNtaBX{$k};$colOffset+1;$k)  //BX
			$colOffset:=$colOffset+1
		End if 
		If (vi_UsarControlesFinPeriodo#0)
			NTA_SetCellClr (aRealNtaEXP{$k};$colOffset+1;$k)  //EXP
			$colOffset:=$colOffset+1
		End if 
	Else 
		If ([Asignaturas:18]Ingresa_Esfuerzo:40)
			NTA_SetCellClr (aRealNtaEsfuerzo{$k};$colOffset+1;$k)  //ESF
			$colOffset:=$colOffset+1
		End if 
		If (vi_UsarBonificacion#0)
			NTA_SetCellClr (aRealNtaBX{$k};$colOffset+1;$k)  //BX
			$colOffset:=$colOffset+1
		End if 
		If (vi_UsarControlesFinPeriodo>0)
			NTA_SetCellClr (aRealNtaEXP{$k};$colOffset+1;$k)  //EXP
			$colOffset:=$colOffset+1
		End if 
	End if 
	
	For ($i;1;12)
		NTA_SetCellClr (aNtaRealArrPointers{$i}->{$k};$i+$colOffset;$k)
		$el:=Find in array:C230(aiAS_EvalPropColumnIndex;$i)
		If ($el>0)
			$coefficient:=arAS_EvalPropCoefficient{$el}
			If ($coefficient#1)
				INSERT IN ARRAY:C227(aSetUnderline{1};Size of array:C274(aSetUnderline{1})+1)
				INSERT IN ARRAY:C227(aSetUnderline{2};Size of array:C274(aSetUnderline{2})+1)
				aSetUnderline{1}{Size of array:C274(aSetUnderline{1})}:=$i+$colOffset
				aSetUnderline{2}{Size of array:C274(aSetUnderline{2})}:=$k
			Else 
				INSERT IN ARRAY:C227(aSetPlain{1};Size of array:C274(aSetPlain{1})+1)
				INSERT IN ARRAY:C227(aSetPlain{2};Size of array:C274(aSetPlain{2})+1)
				aSetPlain{1}{Size of array:C274(aSetPlain{1})}:=$i+$colOffset
				aSetPlain{2}{Size of array:C274(aSetPlain{2})}:=$k
			End if 
		End if 
	End for 
End for 

AL_SetCellStyle (xALP_ASNotas;0;0;0;0;aSetPlain;0;"Tahoma")
AL_SetCellStyle (xALP_ASNotas;0;0;0;0;aSetUnderline;4;"Tahoma")
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetRed;"";4)
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetBleu;"";7)
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetGreen;"";10)
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetViol;"";240)



ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)
ARRAY INTEGER:C220(aSetBlack{2};0)


For ($k;1;Size of array:C274(aNtaIdAlumno))
	If (aNtaReprobada{$k})
		INSERT IN ARRAY:C227(aSetRed{1};Size of array:C274(aSetRed{1})+1)
		INSERT IN ARRAY:C227(aSetRed{2};Size of array:C274(aSetRed{2})+1)
		aSetRed{1}{Size of array:C274(aSetRed{1})}:=1
		aSetRed{2}{Size of array:C274(aSetRed{2})}:=$k
	Else 
		INSERT IN ARRAY:C227(aSetBlack{1};Size of array:C274(aSetBlack{1})+1)
		INSERT IN ARRAY:C227(aSetBlack{2};Size of array:C274(aSetBlack{2})+1)
		aSetBlack{1}{Size of array:C274(aSetBlack{1})}:=1
		aSetBlack{2}{Size of array:C274(aSetBlack{2})}:=$k
	End if 
End for 
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetRed;"Red";0;"";0)
AL_SetCellColor (xALP_ASNotas;0;0;0;0;aSetBlack;"Black";0;"";0)


ARRAY INTEGER:C220(aSetRed;2;0)
ARRAY INTEGER:C220(aSetRed{1};0)
ARRAY INTEGER:C220(aSetRed{2};0)
ARRAY INTEGER:C220(aSetBlack;2;0)
ARRAY INTEGER:C220(aSetBlack{1};0)
ARRAY INTEGER:C220(aSetBlack{2};0)

AL_UpdateArrays (xALP_ASNotas;Size of array:C274(aNtaIdAlumno))



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
ARRAY INTEGER:C220(aSetUnderline;2;0)
ARRAY INTEGER:C220(aSetUnderline{1};0)
ARRAY INTEGER:C220(aSetUnderline{2};0)
ARRAY INTEGER:C220(aSetPlain;2;0)
ARRAY INTEGER:C220(aSetPlain{1};0)
ARRAY INTEGER:C220(aSetPlain{2};0)







