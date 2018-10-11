//%attributes = {}
  //NTA_convertNum2value


  //$result:=Nta_calculs ($evaluacion;$origen_MINIMO;$origen_REQUERIDO;$origen_MAXIMO;$destino_REQUERIDO;$destino_MAXIMO;$decimales)
C_BOOLEAN:C305($10;$set2Minimum)
C_LONGINT:C283($7;$decimales)
C_REAL:C285($1;$2;$3;$4;$5;$6;$0;$Result;$evaluacion;$origen_REQUERIDO;$destino_MINIMO;$destino_REQUERIDO;$destino_MAXIMO;$origen_MINIMO;$origen_MAXIMO;$x1;$x2;$x3;$x4;$y1;$y2;$y3;$y4;$r1)
$evaluacion:=$1  //source to convert
$origen_MINIMO:=$2  //source  minimum
$origen_REQUERIDO:=$3  //source required
$origen_MAXIMO:=$4  //source max

  //$destino_MINIMO:=$origen_MINIMO/$origen_MAXIMO*100  `destination minimum
If (Count parameters:C259>=8)
	$destino_MINIMO:=$8
Else 
	$destino_MINIMO:=MATH_Divide ($origen_MINIMO;$origen_MAXIMO)*100  //destination minimum
End if 
If (Count parameters:C259>=9)
	$truncate:=$9
Else 
	$truncate:=0
End if 
If (Count parameters:C259=10)
	$set2Minimum:=$10
Else 
	$set2Minimum:=False:C215  // por defecto en Falso para que ST no suba notas ponderadas al mínimo de la escala (ABK 23/02/2006)
End if 

$destino_REQUERIDO:=$5  //destination required
$destino_MAXIMO:=$6  //destination maximum
$decimales:=$7
If ($decimales>11)
	$decimales:=11
End if 


If (($origen_MINIMO=$origen_REQUERIDO) & ($evaluacion=$origen_MINIMO))
	If ($truncate>0)
		$result:=Trunc:C95($destino_REQUERIDO;$truncate)
	Else 
		$result:=Round:C94($destino_REQUERIDO;$decimales)
	End if 
Else 
	If ($evaluacion<=$origen_REQUERIDO)
		$x1:=$destino_REQUERIDO-$destino_MINIMO
		
		If ($x1=0)
			$x1:=MATH_Divide (1;$destino_MAXIMO)
		End if 
		$x2:=$origen_REQUERIDO-$origen_MINIMO
		If ($x2=0)
			$x2:=MATH_Divide (1;$origen_MAXIMO)
		End if 
		If (($x1>=1) & ($x2>=1))
			$x3:=MATH_Divide ($x1;$x2)
		Else 
			$x3:=MATH_Divide ($x2;$x1)
		End if 
		$x4:=$x3*$evaluacion
		$y1:=$destino_REQUERIDO-$destino_MINIMO
		If ($y1>0)
			$y2:=$origen_REQUERIDO-$origen_MINIMO
			$y3:=MATH_Divide ($y1;$y2)
			$y4:=$y3*$origen_REQUERIDO
			$r1:=$x4-$y4+$destino_REQUERIDO
		Else 
			$r1:=$x4
		End if 
		If ($truncate>0)
			  //$result:=Trunc($r1;$truncate)
			$result:=Trunc:C95($r1;$decimales)
		Else 
			$result:=Round:C94($r1;$decimales)
		End if 
		
		
	Else 
		$x1:=$destino_MAXIMO-$destino_REQUERIDO
		$x2:=$origen_MAXIMO-$origen_REQUERIDO
		$x3:=MATH_Divide ($x1;$x2)
		$x4:=$x3*$evaluacion
		$y1:=$destino_MAXIMO-$destino_REQUERIDO
		$y2:=$origen_MAXIMO-$origen_REQUERIDO
		$y3:=MATH_Divide ($y1;$y2)
		$y4:=$y3*$origen_MAXIMO
		$r1:=$x4-$y4+$destino_MAXIMO
		If ($truncate>0)
			  //$result:=Trunc($r1;$truncate)
			$result:=Trunc:C95($r1;$decimales)
		Else 
			$result:=Round:C94($r1;$decimales)
		End if 
	End if 
End if 

If (($result<$destino_MINIMO) & ($set2Minimum))
	$result:=Round:C94($destino_MINIMO;$decimales)
End if 

If ((Not:C34($result<0)) & (Not:C34($result>0)) & ($result<$origen_MINIMO))
	  //es un NAN
	$result:=-10
End if 

$0:=$result