  // GeneracionAplicacion.subirFTP_Privado()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-08-16, 13:17:05
  // -----------------------------------------------------------

OBJECT SET VISIBLE:C603(*;"ftpUploadAppsPrivate_thermo";OBJECT Get pointer:C1124->=1)
OBJECT SET TITLE:C194(*;"ftpUploadAppsPrivate_text";Choose:C955(OBJECT Get pointer:C1124->=1;"5. Carga de applicaciones en FTP Privado (en espera)";"5. Carga de aplicaciones en FTP privado (inactiva)"))
OBJECT SET RGB COLORS:C628(*;"ftpUploadAppsPrivate_text";Choose:C955(OBJECT Get pointer:C1124->=0;color RGB silver;color RGB black);color RGB white)