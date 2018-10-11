//%attributes = {}
  // MÉTODO: EV2_Real_a_Nota
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 06:29:07
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Real_a_Nota()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_REAL:C285($1;$nValue;$r_resultado;$minimum;$r_resultado)
C_LONGINT:C283($truncate;$roundTo;$3)
C_BOOLEAN:C305($4;$set2Minimum)
$minimum:=vrNTA_MinimoEscalaReferencia
$nValue:=$1
$set2Minimum:=True:C214

Case of 
	: (Count parameters:C259=5)
		$truncate:=$2
		$roundTo:=$3
		$set2Minimum:=$4
		$minimum:=$5
	: (Count parameters:C259=4)
		$truncate:=$2
		$roundTo:=$3
		$set2Minimum:=$4
	: (Count parameters:C259=3)
		$truncate:=$2
		$roundTo:=$3
	: (Count parameters:C259=2)
		$truncate:=$2
	Else 
		$truncate:=0
End case 


If ($roundTo=0)
	MATH_Max (iGradesDec;iGradesDecPP;iGradesDecPF;iGradesDecNF;iGradesDecNO)
End if 

  // CODIGO PRINCIPAL

Case of 
	: ($nValue=-10)
		$r_resultado:=$nValue
		
	: ($nValue=-5)
		$r_resultado:=$nValue
		
	: ($nValue=-4)
		$r_resultado:=$nValue
		
	: ($nValue=-2)
		$r_resultado:=$nValue
		
	: ($nValue=-3)
		$r_resultado:=$nValue
		
	: ($nValue=0)
		$r_resultado:=$nValue
		
	: ($nValue<$minimum)
		  //$nvalue:=$minimum
		$r_resultado:=NTA_ConvertNumValue ($nValue;rGradesFrom/rGradesTo*100;rPctMinimum;100;rGradesMinimum;rGradesTo;$roundTo;rGradesFrom;$truncate;$set2Minimum)
		If (iConversionTable=1)
			$r_resultado:=Num:C11(NTA_GetValueFromPctConvTable ($nValue;Notas))
		Else 
			If ($roundTo#0)
				$r_resultado:=NTA_ConvertNumValue ($nValue;rGradesFrom/rGradesTo*100;rPctMinimum;100;rGradesMinimum;rGradesTo;$roundTo;rGradesFrom;$truncate;$set2Minimum)
			Else 
				$r_resultado:=NTA_ConvertNumValue ($nValue;rGradesFrom/rGradesTo*100;rPctMinimum;100;rGradesMinimum;rGradesTo;$roundTo;rGradesFrom;$truncate;$set2Minimum)
			End if 
		End if 
		
	: ($nValue>=$minimum)
		If (iConversionTable=1)
			$r_resultado:=Num:C11(NTA_GetValueFromPctConvTable ($nValue;Notas))
		Else 
			If ($roundTo#0)
				$r_resultado:=NTA_ConvertNumValue ($nValue;rGradesFrom/rGradesTo*100;rPctMinimum;100;rGradesMinimum;rGradesTo;$roundTo;rGradesFrom;$truncate;$set2Minimum)
			Else 
				$r_resultado:=NTA_ConvertNumValue ($nValue;rGradesFrom/rGradesTo*100;rPctMinimum;100;rGradesMinimum;rGradesTo;$roundTo;rGradesFrom;$truncate;$set2Minimum)
			End if 
		End if 
		$r_resultado:=$r_resultado
		
	Else 
		$r_resultado:=-10
		
End case 


$0:=$r_resultado
