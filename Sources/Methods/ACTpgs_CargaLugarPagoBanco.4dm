//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): asepulveda
  // Fecha y hora: 23-10-14, 09:33:36
  // ----------------------------------------------------
  // Método: ACTpgs_CargaLugarPagoBanco
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($0)
C_LONGINT:C283($choice;$i)
ARRAY TEXT:C222(atACT_LugaresBancos;0)

ACTcfg_LoadBancos 

APPEND TO ARRAY:C911(atACT_LugaresBancos;"Ninguno")
APPEND TO ARRAY:C911(atACT_LugaresBancos;"-")
For ($i;1;Size of array:C274(<>atACT_LugaresPago))
	APPEND TO ARRAY:C911(atACT_LugaresBancos;<>atACT_LugaresPago{$i})
End for 
APPEND TO ARRAY:C911(atACT_LugaresBancos;"-")
For ($i;1;Size of array:C274(atACT_BankName))
	APPEND TO ARRAY:C911(atACT_LugaresBancos;atACT_BankName{$i})
End for 
$choice:=ACTKRL_PopUp (->atACT_LugaresBancos;"Seleccione el lugar de pago...")
If ($choice#0)
	If ($choice=1)
		$0:=""
	Else 
		$0:=atACT_LugaresBancos{$choice}
	End if 
End if 
ARRAY TEXT:C222(atACT_LugaresBancos;0)

