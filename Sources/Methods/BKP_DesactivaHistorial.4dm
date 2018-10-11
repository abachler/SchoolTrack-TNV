//%attributes = {"executedOnServer":true}
  // BKP_DesactivaHistorial()
  // Por: Alberto Bachler K.: 01-09-14, 18:28:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_rutaArchivoHistorial)

SELECT LOG FILE:C345(*)
$t_rutaArchivoHistorial:=SYS_GetServerProperty (XS_LogFilePath)


