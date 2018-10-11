//%attributes = {}
  //ACTwiz_ResultadosImport

C_LONGINT:C283(<>vRUTTable;vRUTTable;<>vRUTField;vRUTField)
C_TEXT:C284(<>vLabelLink;vLabelLink)

$process:=$1
DELAY PROCESS:C323(Current process:C322;60)
vbACT_ErrorImport:=False:C215
$proc:=IT_UThermometer (1;0;__ ("Importando archivo bancario..."))
While (Test semaphore:C652("ImportBancarios"))
	DELAY PROCESS:C323(Current process:C322;120)
	IT_UThermometer (0;$proc;__ ("Importando archivo bancario..."))
End while 
GET PROCESS VARIABLE:C371($process;<>vbACT_ErrorImport;vbACT_ErrorImport)
IT_UThermometer (-2;$proc)
If (vbACT_ErrorImport)
	CD_Dlog (0;__ ("Se produjo un error en la lectura del archivo."))
Else 
	C_BOOLEAN:C305(<>vbACT_ImportacionApdos;vbACT_ImportacionApdos)
	_O_ARRAY STRING:C218(80;aRUTRechazo;0)
	ARRAY TEXT:C222(aDescRechazo;0)
	_O_ARRAY STRING:C218(80;aRUTDoble;0)
	_O_ARRAY STRING:C218(80;aRUTNoIdentif;0)
	_O_ARRAY STRING:C218(80;aRUTInvalidos;0)
	ARRAY TEXT:C222(aNumTarjetaRe;0)
	_O_ARRAY STRING:C218(80;aRUTApdoNoCta;0)
	_O_ARRAY STRING:C218(80;aMontoCero;0)
	_O_ARRAY STRING:C218(80;aSinDeuda;0)
	ARRAY LONGINT:C221(al_idAvisoAPagar2;0)
	ARRAY LONGINT:C221(aIDAvisoRechazo;0)
	ARRAY LONGINT:C221(alACT_RecNumPagosInforme;0)  //ticket 126668
	ARRAY REAL:C219(aMontoRechazo;0)  //20141029 RCH
	
	montoNoIdentif:=0
	montoRechazos:=0
	montoAprobado:=0
	montoDoble:=0
	montoProcesado:=0
	montoInvalidos:=0
	montoNoApdoCta:=0
	numProcesados:=0
	vbACT_ImportacionApdos:=True:C214
	If ($process=-1)
		  //GET PROCESS VARIABLE($process;<>aRUTRechazo;aRUTRechazo;<>aDescRechazo;aDescRechazo;<>aRUTDoble;aRUTDoble;<>aRUTNoIdentif;aRUTNoIdentif;<>aRUTInvalidos;aRUTInvalidos;<>aRUTApdoNoCta;aRUTApdoNoCta)
		GET PROCESS VARIABLE:C371($process;<>aRUTRechazo;aRUTRechazo;<>aDescRechazo;aDescRechazo;<>aRUTDoble;aRUTDoble;<>aRUTNoIdentif;aRUTNoIdentif;<>aRUTInvalidos;aRUTInvalidos;<>aRUTApdoNoCta;aRUTApdoNoCta;<>aMontoRechazo;aMontoRechazo)
		GET PROCESS VARIABLE:C371($process;<>montoNoIdentif;montoNoIdentif;<>montoRechazos;montoRechazos;<>montoAprobado;montoAprobado;<>montoDoble;montoDoble;<>montoInvalidos;montoInvalidos;<>montoNoApdoCta;montoNoApdoCta)
		GET PROCESS VARIABLE:C371($process;<>numProcesados;numProcesados;<>montoProcesado;montoProcesado)
		GET PROCESS VARIABLE:C371($process;<>aNumTarjetaRe;aNumTarjetaRe)
		GET PROCESS VARIABLE:C371($process;<>vRUTField;vRUTField;<>vRUTTable;vRUTTable)
		GET PROCESS VARIABLE:C371($process;<>vLabelLink;vLabelLink)
		GET PROCESS VARIABLE:C371($process;<>aMontoCero;aMontoCero)
		GET PROCESS VARIABLE:C371($process;<>vbACT_ImportacionApdos;vbACT_ImportacionApdos)
		GET PROCESS VARIABLE:C371($process;<>aSinDeuda;aSinDeuda)
		GET PROCESS VARIABLE:C371($process;<>aARXTransbankNoIdentif;aARXTransbankNoIdentif;<>aARXTransbankDoble;aARXTransbankDoble;<>aARXTransbankInvalidos;aARXTransbankInvalidos;<>aARXTransbankApdoNoCta;aARXTransbankApdoNoCta)
		GET PROCESS VARIABLE:C371($process;<>alACT_idsAvisosImport;al_idAvisoAPagar2)
		GET PROCESS VARIABLE:C371($process;<>aIDAvisoRechazo;aIDAvisoRechazo)
		GET PROCESS VARIABLE:C371($process;<>alACT_RecNumPagosInforme;alACT_RecNumPagosInforme)
	Else 
		COPY ARRAY:C226(<>aRUTRechazo;aRUTRechazo)
		COPY ARRAY:C226(<>aDescRechazo;aDescRechazo)
		COPY ARRAY:C226(<>aRUTDoble;aRUTDoble)
		COPY ARRAY:C226(<>aRUTNoIdentif;aRUTNoIdentif)
		COPY ARRAY:C226(<>aRUTInvalidos;aRUTInvalidos)
		COPY ARRAY:C226(<>aRUTApdoNoCta;aRUTApdoNoCta)
		COPY ARRAY:C226(<>aNumTarjetaRe;aNumTarjetaRe)
		COPY ARRAY:C226(<>aMontoCero;aMontoCero)
		COPY ARRAY:C226(<>aSinDeuda;aSinDeuda)
		COPY ARRAY:C226(<>aARXTransbankNoIdentif;aARXTransbankNoIdentif)
		COPY ARRAY:C226(<>aARXTransbankDoble;aARXTransbankDoble)
		COPY ARRAY:C226(<>aARXTransbankInvalidos;aARXTransbankInvalidos)
		COPY ARRAY:C226(<>aARXTransbankApdoNoCta;aARXTransbankApdoNoCta)
		COPY ARRAY:C226(<>alACT_idsAvisosImport;al_idAvisoAPagar2)
		COPY ARRAY:C226(<>aIDAvisoRechazo;aIDAvisoRechazo)
		COPY ARRAY:C226(<>alACT_RecNumPagosInforme;alACT_RecNumPagosInforme)
		COPY ARRAY:C226(<>aMontoRechazo;aMontoRechazo)
		
		montoNoIdentif:=<>montoNoIdentif
		montoRechazos:=<>montoRechazos
		montoAprobado:=<>montoAprobado
		montoDoble:=<>montoDoble
		montoInvalidos:=<>montoInvalidos
		montoNoApdoCta:=<>montoNoApdoCta
		numProcesados:=<>numProcesados
		montoProcesado:=<>montoProcesado
		vRUTField:=<>vRUTField
		vRUTTable:=<>vRUTTable
		vLabelLink:=<>vLabelLink
		vbACT_ImportacionApdos:=<>vbACT_ImportacionApdos
	End if 
	
	numNoIdentif:=Size of array:C274(aRUTNoIdentif)
	numMasdeUnApdo:=Size of array:C274(aRUTDoble)
	numRechazados:=Size of array:C274(aRUTRechazo)
	numInvalidos:=Size of array:C274(aRUTInvalidos)
	numNoApdoCta:=Size of array:C274(aRUTApdoNoCta)
	numMontoCero:=Size of array:C274(aMontoCero)
	numAprobados:=numProcesados-numNoIdentif-numMasdeUnApdo-numRechazados-numInvalidos-numNoApdoCta-numMontoCero
	vtTipoResultados:=vTipo
	If (vbACT_ImportacionApdos)
		vtACT_LabelMasdeUno:="Registros encontrados para más de un apoderado:"
		vtACT_LabelNodeCuenta:="Registros de apoderados que no son de cuentas:"
	Else 
		vtACT_LabelMasdeUno:="Registros encontrados para más de una cuenta:"
		vtACT_LabelNodeCuenta:="Registros de cuentas sin apoderado de cuentas:"
	End if 
	LOG_RegisterEvt ("Importación de archivo bancario tipo "+vTipo+" "+vtACT_filename+".")
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTwiz_ResultadoImportBancarios";-1;4;__ ("Resultados"))
	DIALOG:C40([xxSTR_Constants:1];"ACTwiz_ResultadoImportBancarios")
	CLOSE WINDOW:C154
	  //AT_Initialize (->aRUTRechazo;->aDescRechazo;->aRUTDoble;->aRUTNoIdentif;->aNumTarjetaRe;->aRUTApdoNoCta;->aMontoCero;->aSinDeuda;->aARXTransbankNoIdentif;->aARXTransbankDoble;->aARXTransbankInvalidos;->aARXTransbankApdoNoCta;->al_idAvisoAPagar2)
	AT_Initialize (->aRUTRechazo;->aDescRechazo;->aRUTDoble;->aRUTNoIdentif;->aNumTarjetaRe;->aRUTApdoNoCta;->aMontoCero;->aSinDeuda;->aARXTransbankNoIdentif;->aARXTransbankDoble;->aARXTransbankInvalidos;->aARXTransbankApdoNoCta;->al_idAvisoAPagar2;->aIDAvisoRechazo;->aMontoRechazo)
	If ($process=-1)
		  //VARIABLE TO VARIABLE($process;<>aRUTRechazo;aRUTRechazo;<>aDescRechazo;aDescRechazo;<>aRUTDoble;aRUTDoble;<>aRUTNoIdentif;aRUTNoIdentif;<>aNumTarjetaRe;aNumTarjetaRe;<>aRUTApdoNoCta;aRUTApdoNoCta;<>aMontoCero;aMontoCero;<>aSinDeuda;aSinDeuda;<>aARXTransbankNoIdentif;aARXTransbankNoIdentif;<>aARXTransbankDoble;aARXTransbankDoble;<>aARXTransbankInvalidos;aARXTransbankInvalidos;<>aARXTransbankApdoNoCta;aARXTransbankApdoNoCta)
		  //VARIABLE TO VARIABLE($process;<>aRUTRechazo;aRUTRechazo;<>aDescRechazo;aDescRechazo;<>aRUTDoble;aRUTDoble;<>aRUTNoIdentif;aRUTNoIdentif;<>aNumTarjetaRe;aNumTarjetaRe;<>aRUTApdoNoCta;aRUTApdoNoCta;<>aMontoCero;aMontoCero;<>aSinDeuda;aSinDeuda;<>aARXTransbankNoIdentif;aARXTransbankNoIdentif;<>aARXTransbankDoble;aARXTransbankDoble;<>aARXTransbankInvalidos;aARXTransbankInvalidos;<>aARXTransbankApdoNoCta;aARXTransbankApdoNoCta;<>alACT_idsAvisosImport;al_idAvisoAPagar2;<>aIDAvisoRechazo;aIDAvisoRechazo)
		VARIABLE TO VARIABLE:C635($process;<>aRUTRechazo;aRUTRechazo;<>aDescRechazo;aDescRechazo;<>aRUTDoble;aRUTDoble;<>aRUTNoIdentif;aRUTNoIdentif;<>aNumTarjetaRe;aNumTarjetaRe;<>aRUTApdoNoCta;aRUTApdoNoCta;<>aMontoCero;aMontoCero;<>aSinDeuda;aSinDeuda;<>aARXTransbankNoIdentif;aARXTransbankNoIdentif;<>aARXTransbankDoble;aARXTransbankDoble;<>aARXTransbankInvalidos;aARXTransbankInvalidos;<>aARXTransbankApdoNoCta;aARXTransbankApdoNoCta;<>alACT_idsAvisosImport;al_idAvisoAPagar2;<>aIDAvisoRechazo;aIDAvisoRechazo;<>aMontoRechazo;aMontoRechazo)
		vtTipoResultados:=vTipo
	Else 
		  //AT_Initialize (-><>aRUTRechazo;-><>aDescRechazo;-><>aRUTDoble;-><>aRUTNoIdentif;-><>aNumTarjetaRe;-><>aRUTApdoNoCta;-><>aMontoCero;-><>aSinDeuda;-><>aARXTransbankNoIdentif;-><>aARXTransbankDoble;-><>aARXTransbankInvalidos;-><>aARXTransbankApdoNoCta)
		  //AT_Initialize (-><>aRUTRechazo;-><>aDescRechazo;-><>aRUTDoble;-><>aRUTNoIdentif;-><>aNumTarjetaRe;-><>aRUTApdoNoCta;-><>aMontoCero;-><>aSinDeuda;-><>aARXTransbankNoIdentif;-><>aARXTransbankDoble;-><>aARXTransbankInvalidos;-><>aARXTransbankApdoNoCta;-><>alACT_idsAvisosImport;-><>aIDAvisoRechazo)
		AT_Initialize (-><>aRUTRechazo;-><>aDescRechazo;-><>aRUTDoble;-><>aRUTNoIdentif;-><>aNumTarjetaRe;-><>aRUTApdoNoCta;-><>aMontoCero;-><>aSinDeuda;-><>aARXTransbankNoIdentif;-><>aARXTransbankDoble;-><>aARXTransbankInvalidos;-><>aARXTransbankApdoNoCta;-><>alACT_idsAvisosImport;-><>aIDAvisoRechazo;-><>aMontoRechazo)
	End if 
End if 