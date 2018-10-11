//%attributes = {}
  // UD_v20130625_SN3RegXEnviar()
  // Por: Alberto Bachler: 25/06/13, 12:57:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
READ WRITE:C146([xxSN3_RegistrosXEnviar:143])
QUERY:C277([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]tipoDato:1=SN3_Inasistencias;*)
QUERY:C277([xxSN3_RegistrosXEnviar:143]; & ;[xxSN3_RegistrosXEnviar:143]accion:3=SNT_Accion_Eliminar)
DELETE SELECTION:C66([xxSN3_RegistrosXEnviar:143])




