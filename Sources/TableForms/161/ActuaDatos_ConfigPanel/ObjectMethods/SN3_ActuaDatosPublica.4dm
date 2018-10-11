  //IT_SetButtonState ((SN3_ActuaDatosPublica=1);->SN3_ActuaDatosReqVerif;->SN3_ActuaDatosNoMailApo)
OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))
ab_NivelModificado{aiADT_NivNo}:=True:C214

$msg:=ST_Boolean2Str (SN3_ActuaDatosPublica=1;"Activada";"Desactivada")+", actualizacion de datos de alumnos para nivel "+at_IDNivel{aiADT_NivNo}
LOG_RegisterEvt ($msg;0;0;<>lUSR_CurrentUserID;"ActuaDatos")