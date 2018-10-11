//%attributes = {}
  //  //ACTabc_ImportPACProcess
  //
  //ACTinit_LoadFdPago 
  //SET BLOB SIZE(xblob;0)
  //ARRAY TEXT(atACT_BankID;0)
  //ARRAY TEXT(atACT_BankName;0)
  //BLOB_Variables2Blob (->xblob;0;->atACT_BankID;->atACT_BankName)
  //xblob:=PREF_fGetBlob (0;"ACT_Bancos";xblob)
  //BLOB_Blob2Vars (->xblob;0;->atACT_BankID;->atACT_BankName)
  //SORT ARRAY(atACT_BankName;atACT_BankID;>)
  //SET BLOB SIZE(xblob;0)
  //
  //CD_THERMOMETRE (1;0;"Procesando archivo PAC...")
  //<>numProcesados:=Size of array(aRUT)
  //<>montoProcesado:=AT_GetSumArray (->aMonto)
  //For ($i;1;Size of array(aRUT))
  //$rut:=CTRY_CL_VerifRUT (aRUT{$i};False)
  //If ($rut#"")
  //QUERY([Personas];[Personas]ACT_RUTTitutal_Cta=aRUT{$i};*)
  //QUERY([Personas]; & ;[Personas]ES_Apoderado_de_Cuentas=True)
  //If (Records in selection([Personas])=1)
  //If (aDescCodigo{$i}="")
  //ACTpgs_CargaDatosPagoApdo (False)
  //vrACT_MontoPago:=aMonto{$i}
  //vtACT_ObservacionesPago:="Importado desde archivo "+vtACT_fileName
  //vsACT_FormasdePago:="PAC"
  //vdACT_FechaPago:=Current date(*)
  //$ctaIndex:=Find in array(atACT_FormasdePago;vsACT_FormasdePago)
  //If ($ctaIndex#-1)
  //vsACT_CtaContablePago:=atACT_FdPCtaContable{$ctaIndex}
  //vsACT_CentroContablePago:=atACT_FdPCentroCostos{$ctaIndex}
  //vsACT_CCtaContablePago:=atACT_FdPCCtaContable{$ctaIndex}
  //vsACT_CCentroContablePago:=atACT_FdPCCentroCostos{$ctaIndex}
  //vsACT_CodAuxCtaPago:=atACT_FdPCtaCodAux{$ctaIndex}
  //vsACT_CodAuxCCtaPago:=atACT_FdPCCtaCodAux{$ctaIndex}
  //End if 
  //ACTpgs_IngresarPagos (7;False)
  //<>montoAprobado:=<>montoAprobado+aMonto{$i}
  //Else 
  //AT_Insert (0;1;-><>aRUTRechazo;-><>aDescRechazo;-><>aNumTarjetaRe;-><>aVencTarjetaRe)
  //<>aRUTRechazo{Size of array(<>aRUTRechazo)}:=aRUT{$i}
  //<>aDescRechazo{Size of array(<>aDescRechazo)}:=aDescCodigo{$i}
  //<>aNumTarjetaRe{Size of array(<>aNumTarjetaRe)}:=""
  //<>montoRechazos:=<>montoRechazos+aMonto{$i}
  //End if 
  //Else 
  //If (Records in selection([Personas])=0)
  //AT_Insert (0;1;-><>aRUTNoIdentif)
  //<>aRUTNoIdentif{Size of array(<>aRUTNoIdentif)}:=aRUT{$i}
  //<>montoNoIdentif:=<>montoNoIdentif+aMonto{$i}
  //Else 
  //AT_Insert (0;1;-><>aRUTDoble)
  //<>aRUTDoble{Size of array(<>aRUTDoble)}:=aRUT{$i}
  //<>montoDoble:=<>montoDoble+aMonto{$i}
  //End if 
  //End if 
  //Else 
  //AT_Insert (0;1;-><>aRUTInvalidos)
  //<>aRUTInvalidos{Size of array(<>aRUTInvalidos)}:=aRUT{$i}
  //<>montoInvalidos:=<>montoInvalidos+aMonto{$i}
  //End if 
  //DELAY PROCESS(Current process;5)
  //CD_THERMOMETRE (0;$i/Size of array(aRUT)*100;"Procesando archivo PAC...")
  //End for 
  //CD_THERMOMETRE (-1)
  //AT_Initialize (->aMonto;->aRUT)