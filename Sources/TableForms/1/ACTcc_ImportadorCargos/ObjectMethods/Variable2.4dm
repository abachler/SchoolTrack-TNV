$line:=AL_GetLine (xALP_PreImport)
If ($line>0)
	AL_GetSort (xALP_PreImport;$c1)
	AL_UpdateArrays (xALP_PreImport;0)
	AT_Delete ($line;1;->aPareo;->aIDItem;->aGlosa;->aMoneda;->aMontotxt;->aAfectoIVA;->aMesDesde;->aMesHasta;->aAño2;->aAño;->aCargoDescto;->aCtaContable;->aCodAux;->aCentro;->aCCtaContable;->aCCodAux;->aCCentro;->aNoDocTribs)
	AT_Delete ($line;1;->aAprobado;->aMotivo;->aIDCta)
	AT_Delete ($line;1;->aAfectoaDxCta;->aAfectoaDesctos;->aPctInteres;->aTipoInteres;->aImpUnica;->aDesctoH2;->aDesctoH3;->aDesctoH4;->aDesctoH5;->aDesctoH6;->aDesctoH7;->aDesctoH8;->aDesctoH9;->aDesctoH10;->aDesctoH11;->aDesctoH12;->aDesctoH13;->aDesctoH14;->aDesctoH15;->aDesctoH16;->aDesctoH17)
	AT_Delete ($line;1;->aBloqueadas;->aCodigo_interno)
	AL_UpdateArrays (xALP_PreImport;-2)
	AL_SetSort (xALP_PreImport;$c1)
	ACTimp_UpdateInterface 
End if 