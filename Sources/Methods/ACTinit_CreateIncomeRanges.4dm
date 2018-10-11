//%attributes = {}
  //ACTinit_CreateIncomeRanges

C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)

  //tramos ingreso
LOC_LoadList2Blob ("ACT_TramosIngreso";->xBlob)
PREF_SetBlob (0;"ACT_TramosIngreso";xBlob)
SET BLOB SIZE:C606(xBlob;0)