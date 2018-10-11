//%attributes = {}
  //SN3_LoadActivationSettings

C_BLOB:C604($activationSettings)

  //==========  CREAMOS UNA CONFIGURACION GENERICA PARA LA PRIMERA VEZ  ==========

SN3_InitActivationSettings 

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

  //==========  FIN CONFIG. GENERICA  ==========

$activationSettings:=PREF_fGetBlob (0;"SN3ActivationSettings";$activationSettings)

$OT_Object:=OT BLOBToObject ($activationSettings)

C_op1:=OT GetLong ($OT_Object;"identificadorPrincipal")
C_op2:=OT GetLong ($OT_Object;"identificador2")
C_op3:=OT GetLong ($OT_Object;"identificador3")
C_op4:=OT GetLong ($OT_Object;"pasaporte")
C_op5:=OT GetLong ($OT_Object;"codigoInterno")

cb_TieneEncabezado:=OT GetLong ($OT_Object;"tieneEncabezados")
cb_AutoParser:=OT GetLong ($OT_Object;"autoParser")
cb_Listar:=OT GetLong ($OT_Object;"listardespues")

OT Clear ($OT_Object)

