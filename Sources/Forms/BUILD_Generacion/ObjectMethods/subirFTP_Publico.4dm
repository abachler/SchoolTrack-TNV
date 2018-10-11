  // GeneracionAplicacion.subirFTP_Publico()
  // 
  //
  // creado por: Alberto Bachler Klein: 15-08-16, 13:19:17
  // -----------------------------------------------------------

OBJECT SET VISIBLE:C603(*;"ftpUploadAppsPublic_thermo";OBJECT Get pointer:C1124->=1)
OBJECT SET TITLE:C194(*;"ftpUploadAppsPublic_text";Choose:C955(OBJECT Get pointer:C1124->=1;"7. Carga de applicaciones en FTP Publico (en espera)";"7. Carga de aplicaciones en FTP Publico (inactiva)"))
OBJECT SET RGB COLORS:C628(*;"ftpUploadAppsPublic_text";Choose:C955(OBJECT Get pointer:C1124->=0;color RGB silver;color RGB black);color RGB white)
