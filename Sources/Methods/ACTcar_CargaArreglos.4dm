//%attributes = {}
  //ACTcar_CargaArreglos

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})

$vt_accion:=$1

Case of 
	: ($vt_accion="DesdeArray")
		CUT NAMED SELECTION:C334([ACT_Cargos:173];"nameSelCargos")
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$2->;"")
		For ($i;3;Count parameters:C259;2)
			SELECTION TO ARRAY:C260(${$i}->;${$i+1}->)
		End for 
		USE NAMED SELECTION:C332("nameSelCargos")
		  //CLEAR NAMED SELECTION("nameSelCargos")
End case 
