  // CIM_Indices.Botón()
  // Por: Alberto Bachler K.: 08-04-15, 13:12:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_idProgreso:=Progress New 
Progress SET TITLE ($l_idProgreso;__ ("Reconstruyendo indexes...");-1;"";True:C214)
CIM_RespaldaIndex 
CIM_ReconstruyeIndex 
Progress QUIT ($l_idProgreso)
USR_RegisterUserEvent (UE_SIM_IndexRebuild;0;__ ("Reconstrucción completa"))

