//%attributes = {}
  // KRL_CuentaTablasYCampos()
  // Por: Alberto Bachler: 08/03/13, 11:35:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)

C_LONGINT:C283($i;$j)
C_POINTER:C301($y_campos_L;$y_tablas_L)

If (False:C215)
	C_POINTER:C301(KRL_CuentaTablasYCampos ;$1)
	C_POINTER:C301(KRL_CuentaTablasYCampos ;$2)
End if 

$y_tablas_L:=$1
$y_campos_L:=$2

$y_tablas_L->:=0
$y_campos_L->:=0
For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		$y_tablas_L->:=$y_tablas_L->+1
		For ($j;1;Get last field number:C255($i))
			If (Is field number valid:C1000($i;$j))
				$y_campos_L->:=$y_campos_L->+1
			End if 
		End for 
	End if 
End for 

