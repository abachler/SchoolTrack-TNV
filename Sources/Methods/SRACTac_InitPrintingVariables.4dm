//%attributes = {}
  //SRACTac_InitPrintingVariables

C_LONGINT:C283(vlSR_RegXPagina)

ARRAY TEXT:C222(atACT_CGlosaImpresion1;0)
ARRAY REAL:C219(arACT_CMontoNeto1;0)
ARRAY TEXT:C222(atACT_CAlumno1;0)
_O_ARRAY STRING:C218(2;asACT_Afecto1;0)
ARRAY TEXT:C222(atACT_CAlumnoCurso1;0)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre1;0)
ARRAY REAL:C219(arACT_MontoCategoria1;0)
ARRAY LONGINT:C221(alACT_Cantidad1;0)  //RCH
  //20130626 RCH NF CANTIDAD
ARRAY REAL:C219(arACT_Cantidad1;0)
ARRAY TEXT:C222(atACT_MonedaSimbolo1;0)


ARRAY TEXT:C222(atACT_CGlosaImpresion2;0)
ARRAY REAL:C219(arACT_CMontoNeto2;0)
ARRAY TEXT:C222(atACT_CAlumno2;0)
_O_ARRAY STRING:C218(2;asACT_Afecto2;0)
ARRAY TEXT:C222(atACT_CAlumnoCurso2;0)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre2;0)
ARRAY REAL:C219(arACT_MontoCategoria2;0)
ARRAY LONGINT:C221(alACT_Cantidad2;0)  //RCH
ARRAY REAL:C219(arACT_Cantidad2;0)  //RCH
ARRAY TEXT:C222(atACT_MonedaSimbolo2;0)

ARRAY TEXT:C222(atACT_CGlosaImpresion3;0)
ARRAY REAL:C219(arACT_CMontoNeto3;0)
ARRAY TEXT:C222(atACT_CAlumno3;0)
_O_ARRAY STRING:C218(2;asACT_Afecto3;0)
ARRAY TEXT:C222(atACT_CAlumnoCurso3;0)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre3;0)
ARRAY REAL:C219(arACT_MontoCategoria3;0)
ARRAY LONGINT:C221(alACT_Cantidad3;0)  //RCH
ARRAY REAL:C219(arACT_Cantidad3;0)  //RCH
ARRAY TEXT:C222(atACT_MonedaSimbolo3;0)

ARRAY TEXT:C222(atACT_CGlosaImpresion4;0)
ARRAY REAL:C219(arACT_CMontoNeto4;0)
ARRAY TEXT:C222(atACT_CAlumno4;0)
_O_ARRAY STRING:C218(2;asACT_Afecto4;0)
ARRAY TEXT:C222(atACT_CAlumnoCurso4;0)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre4;0)
ARRAY REAL:C219(arACT_MontoCategoria4;0)
ARRAY LONGINT:C221(alACT_Cantidad4;0)  //RCH
ARRAY REAL:C219(arACT_Cantidad4;0)  //RCH
ARRAY TEXT:C222(atACT_MonedaSimbolo4;0)

C_TEXT:C284(vEtiquetaColGlosa;vEtiquetaColCta;vEtiquetaColCurso;vEtiquetaColNivel;vEtiquetaColMonto;vEtiquetaColAfecto)

SRACTacmx_LoadVarsPagosRef ("DeclaraVars")
C_LONGINT:C283(vlACT_SRac_IDAviso1;vlACT_SRac_MesNum1;vlACT_SRac_AñoAviso1)
C_DATE:C307(vdACT_SRac_FechaAviso1;vdACT_SRac_FechaVencimiento1;vdACT_SRac_2FechaPago1;vdACT_SRac_3FechaPago1;vdACT_SRac_4FechaPago1)
C_TEXT:C284(vtACT_SRac_MesText1;vtACT_SRac_Observaciones1;vtACT_SRac_ApdoNombre1;vtACT_SRac_IDNac3Apdo1;vtACT_SRac_IDNac2Apdo1;vtACT_SRac_IDNacApdo1;vtACT_SRac_DirEC1;vtACT_SRac_DirPersonal1;vtACT_SRac_DirProfesional1;vtACT_SRac_CodigoFamilias1;vtACT_SRac_NombreFamilias1;vtACT_SRac_MododePago1;vtACT_SRac_NombreCta1;vtACT_SRac_IDNacCta1;vtACT_SRac_CursoCta1;vtACT_SRac_CodigoCta1;vtACT_SRac_NivelCta1)
C_TEXT:C284(vtACT_SRac_TotalText1;vtACT_SRac_MontoAPagarText1)
C_REAL:C285(vrACT_SRac_MontoExento1;vrACT_SRac_MontoAfecto1;vrACT_SRac_MontoIVA1;vrACT_SRac_Total1;vrACT_SRac_SaldoAnterior1;vrACT_SRac_Tot2Fecha1;vrACT_SRac_Tot3Fecha1;vrACT_SRac_Tot4Fecha1;vrACT_SRac_SaldoApdo1;vrACT_SRac_SaldoCta1;vrACT_SRac_MontoAPagar1)
C_REAL:C285(vrACT_SRac_InteresesAnteriores1;vrACT_SRac_CargosAnteriores1)
C_REAL:C285(vrACT_SRac_MontoNeto1;vrACT_SRac_Intereses1;vrACT_SRac_MontoPagado1)
C_TEXT:C284(vtACT_SRac_ComunaEC1;vtACT_SRac_CiudadEC1;vtACT_SRac_CodPostalEC1;vtACT_SRac_EmailPersonal1)

C_TEXT:C284(vtACT_SRac_IDDT1;vtACT_SRac_EstadoDT1;vtACT_SRac_EmitidoPor1;vtACT_SRac_TotalTextDT1)
C_TEXT:C284(vtACT_SRac_FechaEmisionDT1)
C_TEXT:C284(vtACT_SRac_Afecto1;vtACT_SRac_IVA1;vtACT_SRac_TotalDT1)

C_LONGINT:C283(vlACT_SRac_IDAviso2;vlACT_SRac_MesNum2;vlACT_SRac_AñoAviso2)
C_DATE:C307(vdACT_SRac_FechaAviso2;vdACT_SRac_FechaVencimiento2;vdACT_SRac_2FechaPago2;vdACT_SRac_3FechaPago2;vdACT_SRac_4FechaPago2)
C_TEXT:C284(vtACT_SRac_MesText2;vtACT_SRac_Observaciones2;vtACT_SRac_ApdoNombre2;vtACT_SRac_IDNac3Apdo2;vtACT_SRac_IDNac2Apdo2;vtACT_SRac_IDNacApdo2;vtACT_SRac_DirEC2;vtACT_SRac_DirPersonal2;vtACT_SRac_DirProfesional2;vtACT_SRac_CodigoFamilias2;vtACT_SRac_NombreFamilias2;vtACT_SRac_MododePago2;vtACT_SRac_NombreCta2;vtACT_SRac_IDNacCta2;vtACT_SRac_CursoCta2;vtACT_SRac_CodigoCta2;vtACT_SRac_NivelCta2)
C_TEXT:C284(vtACT_SRac_TotalText2;vtACT_SRac_MontoAPagarText2)
C_REAL:C285(vrACT_SRac_MontoExento2;vrACT_SRac_MontoAfecto2;vrACT_SRac_MontoIVA2;vrACT_SRac_Total2;vrACT_SRac_SaldoAnterior2;vrACT_SRac_Tot2Fecha2;vrACT_SRac_Tot3Fecha2;vrACT_SRac_Tot4Fecha2;vrACT_SRac_SaldoApdo2;vrACT_SRac_SaldoCta2;vrACT_SRac_MontoAPagar2)
C_REAL:C285(vrACT_SRac_InteresesAnteriores2;vrACT_SRac_CargosAnteriores2)
C_REAL:C285(vrACT_SRac_MontoNeto2;vrACT_SRac_Intereses2;vrACT_SRac_MontoPagado2)
C_TEXT:C284(vtACT_SRac_ComunaEC2;vtACT_SRac_CiudadEC2;vtACT_SRac_CodPostalEC2;vtACT_SRac_EmailPersonal2)

C_TEXT:C284(vtACT_SRac_IDDT2;vtACT_SRac_EstadoDT2;vtACT_SRac_EmitidoPor2;vtACT_SRac_TotalTextDT2)
C_TEXT:C284(vtACT_SRac_FechaEmisionDT2)
C_TEXT:C284(vtACT_SRac_Afecto2;vtACT_SRac_IVA2;vtACT_SRac_TotalDT2)

C_LONGINT:C283(vlACT_SRac_IDAviso3;vlACT_SRac_MesNum3;vlACT_SRac_AñoAviso3)
C_DATE:C307(vdACT_SRac_FechaAviso3;vdACT_SRac_FechaVencimiento3;vdACT_SRac_2FechaPago3;vdACT_SRac_3FechaPago3;vdACT_SRac_4FechaPago3)
C_TEXT:C284(vtACT_SRac_MesText3;vtACT_SRac_Observaciones3;vtACT_SRac_ApdoNombre3;vtACT_SRac_IDNac3Apdo3;vtACT_SRac_IDNac2Apdo3;vtACT_SRac_IDNacApdo3;vtACT_SRac_DirEC3;vtACT_SRac_DirPersonal3;vtACT_SRac_DirProfesional3;vtACT_SRac_CodigoFamilias3;vtACT_SRac_NombreFamilias3;vtACT_SRac_MododePago3;vtACT_SRac_NombreCta3;vtACT_SRac_IDNacCta3;vtACT_SRac_CursoCta3;vtACT_SRac_CodigoCta3;vtACT_SRac_NivelCta3)
C_TEXT:C284(vtACT_SRac_TotalText3;vtACT_SRac_MontoAPagarText3)
C_REAL:C285(vrACT_SRac_MontoExento3;vrACT_SRac_MontoAfecto3;vrACT_SRac_MontoIVA3;vrACT_SRac_Total3;vrACT_SRac_SaldoAnterior3;vrACT_SRac_Tot2Fecha3;vrACT_SRac_Tot3Fecha3;vrACT_SRac_Tot4Fecha3;vrACT_SRac_SaldoApdo3;vrACT_SRac_SaldoCta3;vrACT_SRac_MontoAPagar3)
C_REAL:C285(vrACT_SRac_InteresesAnteriores3;vrACT_SRac_CargosAnteriores3)
C_REAL:C285(vrACT_SRac_MontoNeto3;vrACT_SRac_Intereses3;vrACT_SRac_MontoPagado3)
C_TEXT:C284(vtACT_SRac_ComunaEC3;vtACT_SRac_CiudadEC3;vtACT_SRac_CodPostalEC3;vtACT_SRac_EmailPersonal3)

C_TEXT:C284(vtACT_SRac_IDDT3;vtACT_SRac_EstadoDT3;vtACT_SRac_EmitidoPor3;vtACT_SRac_TotalTextDT3)
C_TEXT:C284(vtACT_SRac_FechaEmisionDT3)
C_TEXT:C284(vtACT_SRac_Afecto3;vtACT_SRac_IVA3;vtACT_SRac_TotalDT3)

C_LONGINT:C283(vlACT_SRac_IDAviso4;vlACT_SRac_MesNum4;vlACT_SRac_AñoAviso4)
C_DATE:C307(vdACT_SRac_FechaAviso4;vdACT_SRac_FechaVencimiento4;vdACT_SRac_2FechaPago4;vdACT_SRac_3FechaPago4;vdACT_SRac_4FechaPago4)
C_TEXT:C284(vtACT_SRac_MesText4;vtACT_SRac_Observaciones4;vtACT_SRac_ApdoNombre4;vtACT_SRac_IDNac3Apdo4;vtACT_SRac_IDNac2Apdo4;vtACT_SRac_IDNacApdo4;vtACT_SRac_DirEC4;vtACT_SRac_DirPersonal4;vtACT_SRac_DirProfesional4;vtACT_SRac_CodigoFamilias4;vtACT_SRac_NombreFamilias4;vtACT_SRac_MododePago4;vtACT_SRac_NombreCta4;vtACT_SRac_IDNacCta4;vtACT_SRac_CursoCta4;vtACT_SRac_CodigoCta4;vtACT_SRac_NivelCta4)
C_TEXT:C284(vtACT_SRac_TotalText4;vtACT_SRac_MontoAPagarText4)
C_REAL:C285(vrACT_SRac_MontoExento4;vrACT_SRac_MontoAfecto4;vrACT_SRac_MontoIVA4;vrACT_SRac_Total4;vrACT_SRac_SaldoAnterior4;vrACT_SRac_Tot2Fecha4;vrACT_SRac_Tot3Fecha4;vrACT_SRac_Tot4Fecha4;vrACT_SRac_SaldoApdo4;vrACT_SRac_SaldoCta4;vrACT_SRac_MontoAPagar4)
C_REAL:C285(vrACT_SRac_InteresesAnteriores4;vrACT_SRac_CargosAnteriores4)
C_REAL:C285(vrACT_SRac_MontoNeto4;vrACT_SRac_Intereses4;vrACT_SRac_MontoPagado4)
C_TEXT:C284(vtACT_SRac_ComunaEC4;vtACT_SRac_CiudadEC4;vtACT_SRac_CodPostalEC4;vtACT_SRac_EmailPersonal4)

C_TEXT:C284(vtACT_SRac_IDDT4;vtACT_SRac_EstadoDT4;vtACT_SRac_EmitidoPor4;vtACT_SRac_TotalTextDT4)
C_TEXT:C284(vtACT_SRac_FechaEmisionDT4)
C_TEXT:C284(vtACT_SRac_Afecto4;vtACT_SRac_IVA4;vtACT_SRac_TotalDT4)

  //DATOS RESPONSABLE
ARRAY TEXT:C222(atACT_SRac_RespNombre1;0)
ARRAY TEXT:C222(atACT_SRac_IDNacResp1;0)
ARRAY TEXT:C222(atACT_SRac_IDNac2Resp1;0)
ARRAY TEXT:C222(atACT_SRac_IDNac3Resp1;0)
ARRAY TEXT:C222(atACT_SRac_ComunaECResp1;0)
ARRAY TEXT:C222(atACT_SRac_CiudadECResp1;0)
ARRAY TEXT:C222(atACT_SRac_CodPostalECResp1;0)
ARRAY TEXT:C222(atACT_SRac_DirECResp1;0)
ARRAY TEXT:C222(atACT_SRac_DirPersonalResp1;0)
ARRAY TEXT:C222(atACT_SRac_DirProfesionalResp1;0)
ARRAY TEXT:C222(atACT_SRac_EmailPersonalResp1;0)

ARRAY TEXT:C222(atACT_SRac_RespNombre2;0)
ARRAY TEXT:C222(atACT_SRac_IDNacResp2;0)
ARRAY TEXT:C222(atACT_SRac_IDNac2Resp2;0)
ARRAY TEXT:C222(atACT_SRac_IDNac3Resp2;0)
ARRAY TEXT:C222(atACT_SRac_ComunaECResp2;0)
ARRAY TEXT:C222(atACT_SRac_CiudadECResp2;0)
ARRAY TEXT:C222(atACT_SRac_CodPostalECResp2;0)
ARRAY TEXT:C222(atACT_SRac_DirECResp2;0)
ARRAY TEXT:C222(atACT_SRac_DirPersonalResp2;0)
ARRAY TEXT:C222(atACT_SRac_DirProfesionalResp2;0)
ARRAY TEXT:C222(atACT_SRac_EmailPersonalResp2;0)

ARRAY TEXT:C222(atACT_SRac_RespNombre3;0)
ARRAY TEXT:C222(atACT_SRac_IDNacResp3;0)
ARRAY TEXT:C222(atACT_SRac_IDNac2Resp3;0)
ARRAY TEXT:C222(atACT_SRac_IDNac3Resp3;0)
ARRAY TEXT:C222(atACT_SRac_ComunaECResp3;0)
ARRAY TEXT:C222(atACT_SRac_CiudadECResp3;0)
ARRAY TEXT:C222(atACT_SRac_CodPostalECResp3;0)
ARRAY TEXT:C222(atACT_SRac_DirECResp3;0)
ARRAY TEXT:C222(atACT_SRac_DirPersonalResp3;0)
ARRAY TEXT:C222(atACT_SRac_DirProfesionalResp3;0)
ARRAY TEXT:C222(atACT_SRac_EmailPersonalResp3;0)

ARRAY TEXT:C222(atACT_SRac_RespNombre4;0)
ARRAY TEXT:C222(atACT_SRac_IDNacResp4;0)
ARRAY TEXT:C222(atACT_SRac_IDNac2Resp4;0)
ARRAY TEXT:C222(atACT_SRac_IDNac3Resp4;0)
ARRAY TEXT:C222(atACT_SRac_ComunaECResp4;0)
ARRAY TEXT:C222(atACT_SRac_CiudadECResp4;0)
ARRAY TEXT:C222(atACT_SRac_CodPostalECResp4;0)
ARRAY TEXT:C222(atACT_SRac_DirECResp4;0)
ARRAY TEXT:C222(atACT_SRac_DirPersonalResp4;0)
ARRAY TEXT:C222(atACT_SRac_DirProfesionalResp4;0)
ARRAY TEXT:C222(atACT_SRac_EmailPersonalResp4;0)
