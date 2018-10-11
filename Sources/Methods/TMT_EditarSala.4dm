//%attributes = {}
  // TMT_EditarSala()
  // Por: Alberto Bachler: 30/05/13, 15:04:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_IdSala)

If (False:C215)
	C_LONGINT:C283(TMT_EditarSala ;$1)
End if 

$l_IdSala:=$1

QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=$l_IdSala)
WDW_OpenFormWindow (->[TMT_Salas:167];"Input";-1;8)
KRL_ModifyRecord (->[TMT_Salas:167];"Input")
CLOSE WINDOW:C154
If (ok=1)
	TMT_CargaSalas 
End if 

