$dec:=Self:C308->
$l:=Length:C16(String:C10(rGradesTo))
$maxDec:=4-$l
If ($dec>$maxDec)
	CD_Dlog (0;Replace string:C233(Replace string:C233(__ ("El número de decimales no puede ser superior a ^0 si la nota máxima se compone de ^1 cifra(s).");__ ("^0");String:C10($maxDec));__ ("^1");String:C10($l));__ ("");__ ("OK"))
	Self:C308->:=$maxDec
	GOTO OBJECT:C206(Self:C308->)
Else 
	
	$decimales:=iGradesDec
	$intervalo:=rGradesInterval
	
	If ($decimales>0)
		$int:=Int:C8($intervalo)
		$decString:=Substring:C12(String:C10(Dec:C9($intervalo));3)
		If (Length:C16($decString)>$decimales)
			$intervalo:=Num:C11(String:C10($int)+<>tXS_RS_DecimalSeparator+Substring:C12($decString;1;$decimales))
			BEEP:C151
		End if 
	Else 
		If ($intervalo<1)
			$intervalo:=1
			BEEP:C151
		End if 
	End if 
	rGradesInterval:=$intervalo
	EVS_SetFormats 
	EVS_SetModified 
End if 