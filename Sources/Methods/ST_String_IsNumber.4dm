//%attributes = {}
  // ST_String_Is_Numeric()
  // Por: Alberto Bachler: 16/11/13, 19:22:05
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_REAL:C285($0)
C_TEXT:C284($1)
$t_texto:=$1

If ((Num:C11($t_texto)#0) & (Length:C16(String:C10(Num:C11($t_texto)))=Length:C16($t_texto)))
	$0:=Num:C11($t_texto)
End if 



