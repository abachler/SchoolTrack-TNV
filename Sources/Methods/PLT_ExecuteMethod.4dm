//%attributes = {}
  //PLT_ExecuteMethod
C_POINTER:C301($1)

C_LONGINT:C283($l_indiceBoton;$l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_objeto)
C_TEXT:C284($t_nombreVariable)

If (False:C215)
	C_POINTER:C301(PLT_ExecuteMethod ;$1)
End if 

$y_objeto:=$1
RESOLVE POINTER:C394($y_objeto;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
$l_indiceBoton:=Num:C11($t_nombreVariable)
Case of 
	: (Form event:C388=On Clicked:K2:4)
		BWR_ExecuteMethod (atPLT_ServicesMethods{$l_indiceBoton})
		
	: (Form event:C388=On Mouse Enter:K2:33)
		IT_MuestraTip (atPLT_ServicesTips{$l_indiceBoton})
End case 