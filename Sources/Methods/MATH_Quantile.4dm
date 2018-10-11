//%attributes = {}
  // MATH_Quantile()
  // Por: Alberto Bachler: 03/10/2008, 13:35:25
  //  ---------------------------------------------
  // Retorna el valor del límite superior del cuantil (tercil, cuartil, quintil, nonil, decil, duodecil,...percentil) pasado en $2 sobre el arreglo de valores pasados en $1
  // el quantil debe ser inferior o igual a 1 como se muestra en los ejemplos siguientes
  // 1/3: primer tercil
  // 3/5: tercer quintil
  // 7/10: séptimo decil
  //
  //  ---------------------------------------------

C_POINTER:C301($arrayPointer;$1)
C_REAL:C285($quantile;$2;$r;$0)
$arrayPointer:=$1
$quantile:=$2

  //CUERPO
If (Size of array:C274($arrayPointer->)>0)
	ARRAY REAL:C219($aValues;Size of array:C274($arrayPointer->))
	AT_CopyArrayElements ($arrayPointer;->$aValues)
	AT_DistinctsArrayValues (->$aValues)
	SORT ARRAY:C229($aValues;>)
	
	$n:=$quantile*(Size of array:C274($aValues)-1)+1
	
	Case of 
		: ($n=0)
			$r:=$aValues{1}
		: ($n=Size of array:C274($aValues))
			$r:=$aValues{Size of array:C274($aValues)}
		Else 
			If (Dec:C9($n)>0)
				$value1:=Round:C94($aValues{Int:C8($n)};10)
				$value2:=Round:C94($aValues{Int:C8($n)+1};10)
				$r:=Round:C94($aValues{Int:C8($n)}+(($value2-$value1)*$quantile);10)
			Else 
				$r:=$aValues{$n}
			End if 
	End case 
	
	$0:=$r
Else 
	$0:=-1
End if 


  //LIMPIEZA








