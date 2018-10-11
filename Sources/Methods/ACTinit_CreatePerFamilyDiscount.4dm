//%attributes = {}
  //ACTinit_CreatePerFamilyDiscount

C_BLOB:C604(xBlob)

  //preferencias descuentos por familia
SET BLOB SIZE:C606(xBlob;0)
gGroupByFamily:=1
gGroupByGardian:=0
oOrderbyBirthDate:=1
oOrderByClass:=0
nOrdenAscendiente:=0
nOrdenDescendiente:=1
cbUsarDescuentosFamilia:=0
cbUsarDescuentosIngresos:=0
cbUsarDescuentosIndividual:=0
cbUsarDescuentosCargas:=0
cbIncluirAdmision:=0

C_REAL:C285(cbUsarDescuentosXSeparado;cbConsiderarDctoMaximo;vr_descuentoMaximo;cbCrearDctosEnLineasSeparadas)
cbUsarDescuentosXSeparado:=0
cbConsiderarDctoMaximo:=0
vr_descuentoMaximo:=0
cbCrearDctosEnLineasSeparadas:=0

  //BLOB_Variables2Blob (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas)
BLOB_Variables2Blob (->xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas;->cbUsarDescuentosXSeparado;->cbConsiderarDctoMaximo;->vr_descuentoMaximo;->cbCrearDctosEnLineasSeparadas)
PREF_SetBlob (0;"ACT_DescuentosFamilia";xBlob)
SET BLOB SIZE:C606(xBlob;0)