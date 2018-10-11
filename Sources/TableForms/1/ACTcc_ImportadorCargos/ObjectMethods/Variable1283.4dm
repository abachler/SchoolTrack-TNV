AL_UpdateArrays (xALP_PreImport;0)
AT_Insert (1;1;->aPareo;->aIDItem;->aGlosa;->aMoneda;->aMontotxt;->aAfectoIVA;->aMesDesde;->aAño2;->aMesHasta;->aAño;->aCargoDescto;->aCtaContable;->aCodAux;->aCentro;->aCCtaContable;->aCCodAux;->aCCentro;->aNoDocTribs)
AT_Insert (1;1;->aAprobado;->aMotivo;->aIDCta)
AT_Insert (1;1;->aAfectoaDxCta;->aAfectoaDesctos;->aPctInteres;->aTipoInteres;->aImpUnica;->aDesctoH2;->aDesctoH3;->aDesctoH4;->aDesctoH5;->aDesctoH6;->aDesctoH7;->aDesctoH8;->aDesctoH9;->aDesctoH10;->aDesctoH11;->aDesctoH12;->aDesctoH13;->aDesctoH14;->aDesctoH15;->aDesctoH16;->aDesctoH17)
AT_Insert (1;1;->aBloqueadas;->aCodigo_interno)
AL_UpdateArrays (xALP_PreImport;-2)
ACTimp_AnalizeData (1)
ACTimp_UpdateInterface 
vt_Motivo:=aMotivo{1}
AL_GotoCell (xALP_PreImport;1;1)