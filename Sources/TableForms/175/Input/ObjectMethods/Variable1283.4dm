  //ARRAY LONGINT(alACT_SubFieldIDs;0)
  //ALL SUBRECORDS([ACT_CuentasCorrientes]Observaciones)
  //SF_Subtable2Array (->[ACT_CuentasCorrientes]Observaciones;->[ACT_CuentasCorrientes]Observaciones'ID;->alACT_SubFieldIDs)
  //SORT ARRAY(alACT_SubFieldIDs;>)
  //$nextID:=alACT_SubFieldIDs{Size of array(alACT_SubFieldIDs)}+1
  //AT_Initialize (->alACT_SubFieldIDs)
  //CREATE SUBRECORD([ACT_CuentasCorrientes]Observaciones)
  //[ACT_CuentasCorrientes]Observaciones'Fecha:=Current date(*)
  //[ACT_CuentasCorrientes]Observaciones'Observacion:=""
  //[ACT_CuentasCorrientes]Observaciones'ID:=$nextID
  //AL_UpdateArrays (xALP_Observaciones;0)
  //ACTcc_LoadObs 
  //AL_UpdateArrays (xALP_Observaciones;-2)
  //$line:=Find in array(alACT_IDObs;$nextID)
  //AL_GotoCell (xALP_Observaciones;2;$line)
$id:=ACTcc_CreateObs ([ACT_CuentasCorrientes:175]ID:1;"";Current date:C33(*);Table:C252(->[ACT_CuentasCorrientes:175]))
AL_ExitCell (xALP_Observaciones)
AL_UpdateArrays (xALP_Observaciones;0)
ACTcc_LoadObs 
AL_UpdateArrays (xALP_Observaciones;-2)
$line:=Find in array:C230(alACT_IDObs;$id)
AL_GotoCell (xALP_Observaciones;2;$line)