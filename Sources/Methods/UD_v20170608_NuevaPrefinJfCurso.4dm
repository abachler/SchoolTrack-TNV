//%attributes = {}
  // Patricio Aliaga 
  // Ticket N° 182255: Se agrega preferencia tipo longint llamada vl_sinprofesor, para controlar nueva funcion de formulario.
C_BLOB:C604(xBlob)
C_LONGINT:C283(vl_sinprofesor)
vl_sinprofesor:=0
xBlob:=PREF_fGetBlob (0;"DispersionNotasEnInformeJefatura";xBlob)
BLOB_Blob2Vars (->xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres)
BLOB_Variables2Blob (->xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
PREF_SetBlob (0;"DispersionNotasEnInformeJefatura";xBlob)
SET BLOB SIZE:C606(xBlob;0)