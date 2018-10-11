//%attributes = {}
  //ACTter_OnUnLoad

ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
AL_UpdateArrays (xAL_ACT_Terc_UF_P;0)
  //AL_UpdateArrays (xAL_ACT_Terc_UF_E;0)
C_LONGINT:C283(hlTab_STR_Terceros;xAL_ACT_Terc_UF)
HL_ClearList (xAL_ACT_Terc_UF)
ACTter_InitVariablesForm 
ACTter_Datos_ALP ("DeclaraArraysAreaInscAlumnos")