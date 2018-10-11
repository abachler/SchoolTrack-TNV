//%attributes = {}
  // UD_v20140315_LimiteRegAnotacion()
  // Por: Alberto Bachler K.: 15-03-14, 10:46:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BOOLEAN:C305(<>vb_bloqueo_ingreso_anotacion)
_O_C_INTEGER:C282(<>vi_nd_reg_anotacion)
C_BLOB:C604($vx_block_anotacion)
SET BLOB SIZE:C606($vx_block_anotacion;0)
$vx_block_anotacion:=PREF_fGetBlob (0;"ST_BloqueoAnotacionDias";$vx_block_anotacion)
BLOB_Blob2Vars (->$vx_block_anotacion;0;-><>vb_bloqueo_ingreso_anotacion;-><>vi_nd_reg_anotacion)
SET BLOB SIZE:C606($vx_block_anotacion;0)
PREF_SetBlob (0;"ST_BloqueoAnotacionDias";$vx_block_anotacion)
PREF_Set (0;"ST_BloqueoAnotacionDias";String:C10(<>vi_nd_reg_anotacion))





