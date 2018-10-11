  // [Asignaturas].Sub_evaluaciones.bPopupControles()
  // Por: Alberto Bachler K.: 22-02-14, 17:42:22
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($bitToSet;$i;$oldMOde;$pos;$result)
C_TEXT:C284($popupContent;$t_ponderacionglobal;$t_ponderacionInferior;$t_ponderacionSuperior;$t_valorInferior;$t_valorSuperior)


If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
	$t_ponderacionglobal:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlInferior:8)+"%"
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 11)
	$t_ponderacionInferior:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlInferior:8)+"%"
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 21)
	$t_ponderacionSuperior:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)+"%"
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 14)
	$t_valorInferior:=EV2_Real_a_Literal ([xxSTR_Subasignaturas:83]ValorControlSiInferior:9)
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 24)
	$t_valorSuperior:=EV2_Real_a_Literal ([xxSTR_Subasignaturas:83]ValorControlSiSuperior:10)
End if 

$popupContent:=__ ("01Ponderado en: $t_ponderacionglobal;(-;(Si es inferior al Promedio;  11se pondera en: $t_ponderacionInferior;  12la Calificación Final será igual al Promedio;  13la Calificación Final será igual al Control;  14la Calificación Final será"+" igu"+"alorIn"+"ferior;(Si es superior a Promedio;  21se pondera en: $t_ponderacionSuperior;  "+"22la Calificación Final será igual al Promedio;  23la Calificación Final será igual al Control;  24la Calificación Final será igual a: $t_valorSuperior;(-;Sin Controles Periódicos")
$popupContent:=Replace string:C233($popupContent;"$t_ponderacionglobal";$t_ponderacionglobal)
$popupContent:=Replace string:C233($popupContent;"$t_ponderacionInferior";$t_ponderacionInferior)
$popupContent:=Replace string:C233($popupContent;"$t_ponderacionSuperior";$t_ponderacionSuperior)
$popupContent:=Replace string:C233($popupContent;"$t_valorInferior";$t_valorInferior)
$popupContent:=Replace string:C233($popupContent;"$t_valorSuperior";$t_valorSuperior)


If ([xxSTR_Subasignaturas:83]ModoControles:5=0)
	$popupContent:=Replace string:C233($popupContent;"00";"<B!"+Char:C90(18);1)
Else 
	$popupContent:=Replace string:C233($popupContent;"00";"";1)
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
	$popupContent:=Replace string:C233($popupContent;"01";"<B!"+Char:C90(18);1)
Else 
	$popupContent:=Replace string:C233($popupContent;"01";"";1)
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 11)
	$popupContent:=Replace string:C233($popupContent;"11";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"11";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 12)
	$popupContent:=Replace string:C233($popupContent;"12";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"12";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 13)
	$popupContent:=Replace string:C233($popupContent;"13";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"13";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 14)
	$popupContent:=Replace string:C233($popupContent;"14";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"14";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 21)
	$popupContent:=Replace string:C233($popupContent;"21";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"21";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 22)
	$popupContent:=Replace string:C233($popupContent;"22";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"22";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 23)
	$popupContent:=Replace string:C233($popupContent;"23";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"23";"")
End if 
If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 24)
	$popupContent:=Replace string:C233($popupContent;"24";"<B!"+Char:C90(18))
Else 
	$popupContent:=Replace string:C233($popupContent;"24";"")
End if 

$result:=Pop up menu:C542($popupContent)
If ($result>0)
	Case of 
		: ($result=14)
			[xxSTR_Subasignaturas:83]ModoControles:5:=0
		: ($result=1)
			$bitToSet:=1
			[xxSTR_Subasignaturas:83]ModoControles:5:=0
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?+ $bitToSet
		: (($result>=4) & ($result<=7))
			$bitToSet:=$result-3+10
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 1
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 11  // ponderado
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 12  // igual a promedio final
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 13  // igual a examen
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 14  // igual a:
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?+ $bitToSet
			
			
		: ($result>8)
			$bitToSet:=$result-8+20
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 1
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 21
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 22
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 23
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?- 24
			[xxSTR_Subasignaturas:83]ModoControles:5:=[xxSTR_Subasignaturas:83]ModoControles:5 ?+ $bitToSet
	End case 
	
	
	$oldMOde:=Old:C35([xxSTR_Subasignaturas:83]ModoControles:5)
	SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	
	If (([xxSTR_Subasignaturas:83]ModoControles:5=0) & ($oldMode>0))
		AL_RemoveArrays (xALP_SubEvals;1;35)
		$pos:=Find in array:C230(aSubEvalControles;"@")
		If ($pos>0)
			OK:=CD_Dlog (0;__ ("Los controles registrados serán eliminados definitivamente. ¿Desea usted continuar?");__ ("");__ ("No");__ ("Si"))
			If (ok=2)
				_O_ARRAY STRING:C218(5;aSubEvalControles;0)
				_O_ARRAY STRING:C218(5;aSubEvalControles;Size of array:C274(aRealSubEvalP1))
				ARRAY REAL:C219(aRealSubEvalControles;0)
				ARRAY REAL:C219(aRealSubEvalControles;Size of array:C274(aRealSubEvalP1))
				ARRAY REAL:C219(aRealSubEvalPresentacion;0)
				ARRAY REAL:C219(aRealSubEvalPresentacion;Size of array:C274(aRealSubEvalP1))
				ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
			Else 
				[xxSTR_Subasignaturas:83]ModoControles:5:=$oldMode
			End if 
		End if 
	End if 
	ASsev_LeePropiedadesControles ($result)
	If ([xxSTR_Subasignaturas:83]ModoControles:5#$oldMode)
		For ($i;1;Size of array:C274(aSubEvalP1))
			ASsev_Average ($i)
		End for 
		COPY ARRAY:C226(aSubEvalID;aIdAlumnos_a_Recalcular)
		AS_ALP_ConfigAreaSubEvals 
		AL_UpdateArrays (xALP_SubEvals;-2)
	Else 
	End if 
End if 

