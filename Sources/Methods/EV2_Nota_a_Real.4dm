//%attributes = {}
  // EV2_Nota_a_Real()
  //
  //
  // creado por: Alberto Bachler Klein: 13-09-16, 19:49:37
  // -----------------------------------------------------------

C_REAL:C285($0)
C_REAL:C285($1)

C_REAL:C285($r_nota;$r_real)


If (False:C215)
	C_REAL:C285(EV2_Nota_a_Real ;$0)
	C_REAL:C285(EV2_Nota_a_Real ;$1)
End if 

$r_nota:=$1

Case of 
	: (($r_nota=-2) | ($r_nota=-3) | ($r_nota=-4))
		$r_real:=$r_nota
		
	: ($r_nota<0)  // cualquier otro valor  negativo equivale una evaluación nula (vacia)
		$r_real:=-10
		
	Else 
		If (iConversionTable=1)
			$r_real:=NTA_GetPctValueFromConvTable ($r_nota;Notas)
		Else 
			$r_real:=NTA_ConvertNumValue ($r_nota;rGradesFrom;rGradesMinimum;rGradesTo;rPctMinimum;100;11)
		End if 
End case 


$0:=$r_real


