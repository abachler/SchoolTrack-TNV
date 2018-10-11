//%attributes = {}
  //UD_v20171213_FixEVSBonificacion 
  //MONO: Verifico y corrijo los decimales en las bonificaciones, debido a se podía ingresar mas decimales de los configurados
  //Luego al aplicar la bonificación y tener calculo por tabla de conversión la nota queda fuera de la escala por tener distinta cantidad de decimales y no obtenemos el real correspondiente.

C_LONGINT:C283($i;$n;$l_idTermometro)
C_BOOLEAN:C305($b_save)
C_REAL:C285($r_newValue)
ARRAY LONGINT:C221($al_recnumEVS;0)
ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_EstilosEvaluacion:44];$al_recnumEVS;"")
$l_idTermometro:=IT_Progress (1;0;0;"Revisando Estilos de Evaluación ...")
For ($i;1;Size of array:C274($al_recnumEVS))
	GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];$al_recnumEVS{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnumEVS);"Revisando Bonificación ...")
	EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
	$b_save:=False:C215
	For ($n;1;Size of array:C274(arEVS_ConvGradesOfficial))
		$r_newValue:=Trunc:C95(arEVS_ConvGradesOfficial{$n};iGradesDecNO)
		If (arEVS_ConvGradesOfficial{$n}#$r_newValue)
			arEVS_ConvGradesOfficial{$n}:=$r_newValue
			$b_save:=True:C214
		End if 
	End for 
	If ($b_save)
		EVS_WriteStyleData 
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)