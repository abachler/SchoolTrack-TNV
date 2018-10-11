//%attributes = {}
  // UD_v20130320_DiaEnSesiones()
  // Por: Alberto Bachler: 20/03/13, 09:58:37
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

<>vb_ImportHistoricos_STX:=True:C214
$l_procesoAvance:=IT_UThermometer (1;0;__ ("Actualizando tabla Sesiones de clases"))
ALL RECORDS:C47([Asignaturas_RegistroSesiones:168])
APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]NumeroDia:15:=DT_GetDayNumber_ISO8601 ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3))
$l_procesoAvance:=IT_UThermometer (-2;$l_procesoAvance)
<>vb_ImportHistoricos_STX:=False:C215


