//%attributes = {}
  //CD_THERMOMETREXSEC

If (False:C215)
	  //Method: CD_THERMOMETREXSEC
	  //Written by  Roberto Catalán
End if 
C_LONGINT:C283($1;$mode;tiempo1;tiempo2)
C_REAL:C285($2)
_O_C_STRING:C293(255;$3)
$mode:=$1
Case of 
	: ($mode=1)
		CD_THERMOMETRE ($1;$2;$3)
		tiempo1:=Milliseconds:C459
	: ($mode=0)
		tiempo2:=Milliseconds:C459
		If (tiempo2-tiempo1>=1000)
			If (Count parameters:C259=3)
				CD_THERMOMETRE ($1;$2;$3)
			Else 
				CD_THERMOMETRE ($1;$2)
			End if 
			tiempo1:=Milliseconds:C459
		End if 
	: ($mode=-1)
		CD_THERMOMETRE ($1)
		tiempo1:=0
		tiempo2:=0
End case 