//%attributes = {}
  //ADTcfg_SaveEstados

C_BLOB:C604($blob)
LIST TO BLOB:C556(hl_Estados;$blob)
PREF_SetBlob (0;"estadosADT";$blob)
HL_ClearList (hl_Estados)

ADTcdd_LoadEstados2Arrays 