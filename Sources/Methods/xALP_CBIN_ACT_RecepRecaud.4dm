//%attributes = {}
  //xALP_CBIN_ACT_RecepRecaud

C_BOOLEAN:C305($0)
C_LONGINT:C283($ALArea;$entryMethod;$1;$2;$3)

$ALArea:=$1
$entryMethod:=$2
modificado:=True:C214
_O_ENABLE BUTTON:C192(bSave)

AL_GetCurrCell (xALP_RecepRecaud;vCol;vRow)

TempCol1:=alACT_Campo{vRow}
TempCol2:=atACT_Descripcion{vRow}
TempCol3:=alACT_Largo{vRow}
TempCol4:=atACT_Tipo{vRow}
TempCol5:=atACT_Posicion{vRow}
TempCol6:=atACT_Correspondencia{vRow}
TempCol7:=alACT_PosIni{vRow}
TempCol8:=alACT_PosFinal{vRow}

Case of 
		
	: ($entryMethod=2)
		If (vRow#vLastRow)
			AL_GotoCell (xALP_RecepRecaud;2;vLastRow)
		End if 
	: ($entryMethod=3)
		If (vRow#vLastRow)
			AL_GotoCell (xALP_RecepRecaud;3;vLastRow)
		End if 
	: ($entryMethod=4)
		If (vCol#vLastCol)
			AL_GotoCell (xALP_RecepRecaud;vLastCol;1)
		End if 
	: ($entryMethod=5)
		If (vCol#vLastCol)
			AL_GotoCell (xALP_RecepRecaud;vLastCol;1)
		End if 
End case 

If (NewFiller)
	POST KEY:C465(Character code:C91("F");0)
	POST KEY:C465(Character code:C91("i");0)
	POST KEY:C465(Character code:C91("l");0)
	POST KEY:C465(Character code:C91("l");0)
	POST KEY:C465(Character code:C91("e");0)
	POST KEY:C465(Character code:C91("r");0)
	POST KEY:C465(9;0)
	NewFiller:=False:C215
End if 