//%attributes = {}
  //xALP_CBIN_ACT_DocumentarLC

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
AL_GetCurrCell (xALP_DocumentarLC;vCol;vRow)
ARRAY BOOLEAN:C223(abACT_LCTempModificados;0)
ARRAY REAL:C219(arACT_LCFolioTemp;0)
ARRAY REAL:C219(arACT_LCMontosTemp;0)
OldFolio:=arACT_LCFolio{vRow}
OldFVencimiento:=adACT_LCVencimiento{vRow}
OldMonto:=arACT_LCMonto{vRow}
adACT_LCVencimiento{0}:=adACT_LCVencimiento{1}

COPY ARRAY:C226(arACT_LCFolio;arACT_LCFolioTemp)
COPY ARRAY:C226(abACT_LCModificados;abACT_LCTempModificados)
COPY ARRAY:C226(arACT_LCMonto;arACT_LCMontosTemp)