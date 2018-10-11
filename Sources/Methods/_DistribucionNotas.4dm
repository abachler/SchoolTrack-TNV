//%attributes = {}
  //_DistribucionNotas


C_POINTER:C301($1)

If (Not:C34(Is nil pointer:C315($1)))
	
	$estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
	EVS_ReadStyleData ($estiloEvaluacionOficial)
	
	$r0:=0
	If (Count parameters:C259=7)
		C_TEXT:C284($rango1;$rango2;$rango3;$rango4;$rango5;$rango6;$2;$3;$4;$5;$6;$7)
		$rango1:=Replace string:C233(Replace string:C233($2;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$rango2:=Replace string:C233(Replace string:C233($3;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$rango3:=Replace string:C233(Replace string:C233($4;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$rango4:=Replace string:C233(Replace string:C233($5;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$rango5:=Replace string:C233(Replace string:C233($6;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$rango6:=Replace string:C233(Replace string:C233($7;".";<>tXS_RS_DecimalSeparator);",";<>tXS_RS_DecimalSeparator)
		$r1:=NTA_StringValue2Percent ($rango1)
		$r2:=NTA_StringValue2Percent ($rango2)
		$r3:=NTA_StringValue2Percent ($rango3)
		$r4:=NTA_StringValue2Percent ($rango4)
		$r5:=NTA_StringValue2Percent ($rango5)
		$r6:=NTA_StringValue2Percent ($rango6)
	Else 
		$r1:=NTA_StringValue2Percent ("2")
		$r2:=NTA_StringValue2Percent ("3")
		$r3:=NTA_StringValue2Percent ("4")
		$r4:=NTA_StringValue2Percent ("5")
		$r5:=NTA_StringValue2Percent ("6")
		$r6:=NTA_StringValue2Percent ("7")
	End if 
	
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	ARRAY TEXT:C222($nf;0)
	ARRAY INTEGER:C220(aDistNotas;0)
	ARRAY INTEGER:C220(aDistNotas;7)
	SELECTION TO ARRAY:C260($1->;aRealNtaF)
	For ($i;1;Size of array:C274(aRealNtaF))
		$n:=aRealNtaF{$i}
		Case of 
			: (($n>0) & ($n<=$r1))
				aDistNotas{1}:=aDistNotas{1}+1
			: (($n>$r1) & ($n<=$r2))
				aDistNotas{2}:=aDistNotas{2}+1
			: (($n>$r2) & ($n<=$r3))
				aDistNotas{3}:=aDistNotas{3}+1
			: (($n>$r3) & ($n<=$r4))
				aDistNotas{4}:=aDistNotas{4}+1
			: (($n>$r4) & ($n<=$r5))
				aDistNotas{5}:=aDistNotas{5}+1
			: (($n>$r5) & ($n<=$r6))
				aDistNotas{6}:=aDistNotas{6}+1
		End case 
	End for 
	aDistNotas{7}:=Size of array:C274(aRealNtaF)
Else 
	TRACE:C157
End if 
