//%attributes = {}
  //xALP_CBIN_ACT_Documentar

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
AL_GetCurrCell (xALP_Documentar;vCol;vRow)

OldMonto_Cheque:=arACT_MontoCheque{vRow}
OldNoSerie:=atACT_Serie{vRow}
OldBancoNombre:=atACT_BancoNombre{vRow}
OldBancoCodigo:=atACT_BancoCodigo{vRow}
OldFecha:=adACT_Fecha{vRow}
OldCuenta:=atACT_Cuenta{vRow}

COPY ARRAY:C226(arACT_MontoCheque;arACT_TempMontos)
COPY ARRAY:C226(abACT_Modificados;abACT_TempModificados)