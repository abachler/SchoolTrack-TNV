SN3_CreaRegistroLog (Self:C308)

SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
SN3_SendDataReceptionConfigs (0)

SN3_SendDataReceptionConfigs (1;vlSN3_CurrConfigLevel)
SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)

OBJECT SET SCROLL POSITION:C906(lb_CamposAlumno;1;*)
OBJECT SET SCROLL POSITION:C906(lb_CamposRelaciones;1;*)
OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))