//%attributes = {}
  // EV2_Puntos_a_Real()
  //
  //
  // creado por: Alberto Bachler Klein: 13-09-16, 19:48:29
  // -----------------------------------------------------------

C_REAL:C285($0)
C_REAL:C285($1)

C_REAL:C285($r_puntos;$r_real)


If (False:C215)
	C_REAL:C285(EV2_Puntos_a_Real ;$0)
	C_REAL:C285(EV2_Puntos_a_Real ;$1)
End if 

$r_puntos:=$1

Case of 
	: (($r_puntos=-2) | ($r_puntos=-3) | ($r_puntos=-4))
		$r_real:=$r_puntos
		
	: ($r_puntos<0)  // cualquier otro valor  negativo equivale una evaluación nula (vacia)
		$r_real:=-10
		
	Else 
		  // $r_puntos es igual o superior al valor mínimo en la escala para el registro de evaluaciones
		If (iConversionTable=1)
			$r_real:=NTA_GetPctValueFromConvTable ($r_puntos;Puntos)
		Else 
			$r_real:=NTA_ConvertNumValue ($r_puntos;rPointsFrom;rPointsMinimum;rPointsTo;rPctMinimum;100;11)
		End if 
		
End case 


$0:=$r_real