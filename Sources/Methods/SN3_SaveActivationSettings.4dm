//%attributes = {}
  //SN3_SaveActivationSettings

C_BLOB:C604($activationSettings)

$OT_Object:=OT New 

OT PutLong ($OT_Object;"identificadorPrincipal";C_op1)
OT PutLong ($OT_Object;"identificador2";C_op2)
OT PutLong ($OT_Object;"identificador3";C_op3)
OT PutLong ($OT_Object;"pasaporte";C_op4)
OT PutLong ($OT_Object;"codigoInterno";C_op5)

OT PutLong ($OT_Object;"tieneEncabezados";cb_TieneEncabezado)
OT PutLong ($OT_Object;"autoParser";cb_AutoParser)
OT PutLong ($OT_Object;"listardespues";cb_Listar)

$activationSettings:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

PREF_SetBlob (0;"SN3ActivationSettings";$activationSettings)

