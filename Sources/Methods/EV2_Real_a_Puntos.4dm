//%attributes = {}
  // MÉTODO: EV2_Real_a_Puntos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/03/11, 06:35:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Real_a_Puntos()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_REAL:C285($1;$nValue;$Result;$minimum;$0)
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
	MATH_Max (iPointsDec;iPointsDecPP;iPointsDecPF;iPointsDecNF;iPointsDecNO)
End if 

  // CODIGO PRINCIPAL
Case of 
	: ($nValue=-10)
		$0:=$nValue
		
	: ($nValue=-5)
		$0:=$nValue
		
	: ($nValue=-4)
		$0:=$nValue
		
	: ($nValue=-2)
		$0:=$nValue
		
	: ($nValue=-3)
		$0:=$nValue
		
	: ($nValue=0)
		$0:=$nValue
		
	: ($nValue<$minimum)  //20141107 ASM para evitar problemas en los calculos de ponderación.
		
		$nValue:=$minimum
		
		If (iConversionTable=1)
			$result:=Num:C11(NTA_GetValueFromPctConvTable ($nValue;Puntos))
		Else 
			If ($roundTo#0)
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;rPointsTO;$roundTo;rPointsFrom;$truncate;$set2Minimum)
			Else 
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;rPointsTo;iPointsDec;rPointsFrom;$truncate;$set2Minimum)
			End if 
		End if 
		$0:=$result
		
	: ($nValue>=$minimum)
		If (iConversionTable=1)
			$result:=Num:C11(NTA_GetValueFromPctConvTable ($nValue;Puntos))
		Else 
			If ($roundTo#0)
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;rPointsTO;$roundTo;rPointsFrom;$truncate;$set2Minimum)
			Else 
				$result:=NTA_ConvertNumValue ($nValue;rPointsFrom/rPointsTo*100;rPctMinimum;100;rPointsMinimum;rPointsTo;iPointsDec;rPointsFrom;$truncate;$set2Minimum)
			End if 
		End if 
		$0:=$result
		
	Else 
		$0:=-10
		
End case 