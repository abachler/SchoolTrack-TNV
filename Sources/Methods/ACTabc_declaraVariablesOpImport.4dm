//%attributes = {}
  //ACTabc_declaraVariablesOpImport

C_REAL:C285(vi_SelectedMonth)
C_BOOLEAN:C305(vb_selectionMonth2Pay)
C_BOOLEAN:C305(vb_selectionItems2Pay)
C_BOOLEAN:C305(vb_selectionOrder2PayItems)
C_BOOLEAN:C305(vb_importSoloCuadrado)
C_LONGINT:C283(vlACTimp_Year)
C_BOOLEAN:C305(vb_crearCargoAut)
C_BOOLEAN:C305(vb_utilizarIECargoXMoneda;vb_crearIEDctoXMoneda;vb_fechaPago)
C_TEXT:C284(vsACT_SelectedItemName)
C_TEXT:C284(vt_ItemNames)
C_REAL:C285(vlACT_selectedItemId)
C_BOOLEAN:C305(vb_crearCargoAutCUP)
C_LONGINT:C283(vl_maximoDcto)
ARRAY LONGINT:C221(al_idItems;0)
C_BOOLEAN:C305(consideraMesSC)
ARRAY LONGINT:C221(al_refMeses;0)

  //ÌmportCUPSanBenito
ARRAY LONGINT:C221(al_idAvisoAPagar;0)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY DATE:C224(aFechaPagos;0)
ARRAY TEXT:C222(aSerieCheque;0)
ARRAY DATE:C224(aFechaDctoCheque;0)
ARRAY TEXT:C222(aCuentaCheque;0)
ARRAY TEXT:C222(aBancoCheque;0)
ARRAY TEXT:C222(aLugarDePago;0)
ARRAY TEXT:C222(aNoOperacion;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY REAL:C219(aMontoOriginal;0)
ARRAY DATE:C224(ad_fechaVcto;0)

ARRAY LONGINT:C221(al_idsCargosAPagar;0)
ARRAY DATE:C224(adACT_FechasInicio;0)
ARRAY TEXT:C222(atACT_idsCargos;0)

ARRAY TEXT:C222(atACT_LugarPago;0)

  // Modificado por: Saúl Ponce (11-04-2017)-Ticket 178916, el array de proceso debía ser interproceso
  //ARRAY LONGINT(alACT_RecNumPagosInforme;0)
ARRAY LONGINT:C221(<>alACT_RecNumPagosInforme;0)


  //07-10-125
  // validacion ticket 150497 JVP
  //arreglo para cuando se seleccione la familia
  // para cuando sea el codigo de la familia el indicador

ARRAY TEXT:C222(aCodigoFamilia;0)