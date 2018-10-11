//%attributes = {}
  //NTA_SetCellClr

C_REAL:C285($1;$4;$eval;$minimum)
  //$1: Nota
  //$2: Col
  //$3: Row
Case of 
	: (Count parameters:C259=4)
		  //$minimum:=$4
		$minimum:=Round:C94($4;11)
		$eval:=Round:C94($1;11)
	Else 
		$eval:=Round:C94($1;11)
		$minimum:=Round:C94(rPctMinimum;11)
End case 
Case of 
	: ((iEvaluationMode=4) & ($eval<$minimum))
		INSERT IN ARRAY:C227(aSetRed{1};Size of array:C274(aSetRed{1})+1)
		INSERT IN ARRAY:C227(aSetRed{2};Size of array:C274(aSetRed{2})+1)
		aSetRed{1}{Size of array:C274(aSetRed{1})}:=$2
		aSetRed{2}{Size of array:C274(aSetRed{2})}:=$3
	: ($eval=-2)
		INSERT IN ARRAY:C227(aSetGreen{1};Size of array:C274(aSetGreen{1})+1)
		INSERT IN ARRAY:C227(aSetGreen{2};Size of array:C274(aSetGreen{2})+1)
		aSetGreen{1}{Size of array:C274(aSetGreen{1})}:=$2
		aSetGreen{2}{Size of array:C274(aSetGreen{2})}:=$3
	: ($eval=-1)
		INSERT IN ARRAY:C227(aSetViol{1};Size of array:C274(aSetViol{1})+1)
		INSERT IN ARRAY:C227(aSetViol{2};Size of array:C274(aSetViol{2})+1)
		aSetViol{1}{Size of array:C274(aSetViol{1})}:=$2
		aSetViol{2}{Size of array:C274(aSetViol{2})}:=$3
	: (($eval>=vrNTA_MinimoEscalaReferencia) & ($eval<$minimum))
		INSERT IN ARRAY:C227(aSetRed{1};Size of array:C274(aSetRed{1})+1)
		INSERT IN ARRAY:C227(aSetRed{2};Size of array:C274(aSetRed{2})+1)
		aSetRed{1}{Size of array:C274(aSetRed{1})}:=$2
		aSetRed{2}{Size of array:C274(aSetRed{2})}:=$3
	: (($eval>=vrNTA_MinimoEscalaReferencia) & ($eval>=$minimum))
		INSERT IN ARRAY:C227(aSetBleu{1};Size of array:C274(aSetBleu{1})+1)
		INSERT IN ARRAY:C227(aSetBleu{2};Size of array:C274(aSetBleu{2})+1)
		aSetBleu{1}{Size of array:C274(aSetBleu{1})}:=$2
		aSetBleu{2}{Size of array:C274(aSetBleu{2})}:=$3
End case 