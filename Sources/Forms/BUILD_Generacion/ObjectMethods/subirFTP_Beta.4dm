  // GeneracionAplicacion.subirFTP_Beta()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-08-16, 13:18:11
  // -----------------------------------------------------------

OBJECT SET VISIBLE:C603(*;"ftpUploadAppsBeta_thermo";OBJECT Get pointer:C1124->=1)
OBJECT SET TITLE:C194(*;"ftpUploadAppsBeta_text";Choose:C955(OBJECT Get pointer:C1124->=1;"6. Carga de applicaciones en FTP Beta (en espera)";"6. Carga de aplicaciones en FTP Beta (inactiva)"))
OBJECT SET RGB COLORS:C628(*;"ftpUploadAppsBeta_text";Choose:C955(OBJECT Get pointer:C1124->=0;color RGB silver;color RGB black);color RGB white)