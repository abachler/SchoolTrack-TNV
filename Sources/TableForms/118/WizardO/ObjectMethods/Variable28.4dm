
vTipo:=[xxACT_ArchivosBancarios:118]Tipo:6
$vl_tipo:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
$sem:=Semaphore:C143("ImportBancarios")

<>vbACT_Importando:=True:C214
<>vbACT_ErrorImport:=False:C215


_O_ARRAY STRING:C218(80;aRUTRechazo;0)
ARRAY TEXT:C222(aDescRechazo;0)
_O_ARRAY STRING:C218(80;aRUTDoble;0)
_O_ARRAY STRING:C218(80;aRUTNoIdentif;0)
_O_ARRAY STRING:C218(80;aRUTInvalidos;0)
ARRAY TEXT:C222(aNumTarjetaRe;0)
_O_ARRAY STRING:C218(80;aRUTApdoNoCta;0)
_O_ARRAY STRING:C218(80;aMontoCero;0)
_O_ARRAY STRING:C218(80;aSinDeuda;0)
_O_ARRAY STRING:C218(2;aARXTransbankNoIdentif;0)
_O_ARRAY STRING:C218(2;aARXTransbankDoble;0)
_O_ARRAY STRING:C218(2;aARXTransbankInvalidos;0)
_O_ARRAY STRING:C218(2;aARXTransbankApdoNoCta;0)
ARRAY POINTER:C280(apACT_BlobsAvisos;0)

_O_ARRAY STRING:C218(80;<>aRUTRechazo;0)
ARRAY TEXT:C222(<>aDescRechazo;0)
_O_ARRAY STRING:C218(80;<>aRUTDoble;0)
_O_ARRAY STRING:C218(80;<>aRUTNoIdentif;0)
_O_ARRAY STRING:C218(80;<>aRUTInvalidos;0)
ARRAY TEXT:C222(<>aNumTarjetaRe;0)
_O_ARRAY STRING:C218(5;<>aVencTarjetaRe;0)
_O_ARRAY STRING:C218(80;<>aRUTApdoNoCta;0)
_O_ARRAY STRING:C218(80;<>aMontoCero;0)
_O_ARRAY STRING:C218(80;<>aSinDeuda;0)
_O_ARRAY STRING:C218(2;<>aARXTransbankNoIdentif;0)
_O_ARRAY STRING:C218(2;<>aARXTransbankDoble;0)
_O_ARRAY STRING:C218(2;<>aARXTransbankInvalidos;0)
_O_ARRAY STRING:C218(2;<>aARXTransbankApdoNoCta;0)

<>montoNoIdentif:=0
<>montoRechazos:=0
<>montoAprobado:=0
<>montoDoble:=0
<>montoProcesado:=0
<>montoInvalidos:=0
<>montoNoApdoCta:=0

<>numProcesados:=0

modcargos:=False:C215
vbACT_ModOrderAvisos:=False:C215
ACTabc_ImportProcess ($vl_tipo;!00-00-00!)
CLEAR SEMAPHORE:C144("ImportBancarios")
ACTwiz_ResultadosImport (-1)
FORM GOTO PAGE:C247(8)