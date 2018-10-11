//%attributes = {}
  //ACTabc_PreImportW

READ ONLY:C145([xxACT_ArchivosBancarios:118])
C_LONGINT:C283($process;$1)
C_LONGINT:C283($id_Importador;$2)
C_BOOLEAN:C305(continuarImport)
C_BOOLEAN:C305(vbACT_ErrorImport)
$process:=$1
$id_Importador:=$2
continuarImport:=True:C214

QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1=$id_Importador)
DELAY PROCESS:C323(Current process:C322;60)
$proc:=IT_UThermometer (1;0;__ ("Importando archivo bancario..."))
While (Test semaphore:C652("LoadingBankFile"))
	DELAY PROCESS:C323(Current process:C322;120)
	IT_UThermometer (0;$proc;__ ("Importando archivo bancario..."))
End while 
IT_UThermometer (-2;$proc)
GET PROCESS VARIABLE:C371($process;<>vbACT_ErrorImport;vbACT_ErrorImport)
If (vbACT_ErrorImport)
	  //CD_Dlog (0;"Se produjo un error en la lectura del archivo.")
Else 
	If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214)
		ACTabc_declaraVariablesOpImport 
		
		ARRAY TEXT:C222(at_arreglos2Import;0)
		ARRAY TEXT:C222(at_headers2Import;0)
		C_REAL:C285(monto2Import;montoTotal2Import)
		C_LONGINT:C283(noRegistrosTotal2Import;noRegistros2Import)
		
		GET PROCESS VARIABLE:C371($process;at_arreglos2Import;at_arreglos2Import;at_headers2Import;at_headers2Import;monto2Import;monto2Import;montoTotal2Import;montoTotal2Import;noRegistros2Import;noRegistros2Import)
		GET PROCESS VARIABLE:C371($process;aRUT;aRUT;aMonto;aMonto;aDescCodigo;aDescCodigo;aCodAprobacion;aCodAprobacion;aNumTarjeta;aNumTarjeta)
		GET PROCESS VARIABLE:C371($process;aNombre;aNombre;aFechaPagos;aFechaPagos;aSerieCheque;aSerieCheque;aFechaDctoCheque;aFechaDctoCheque)
		GET PROCESS VARIABLE:C371($process;aCuentaCheque;aCuentaCheque;aBancoCheque;aBancoCheque;aLugarDePago;aLugarDePago;aNoOperacion;aNoOperacion)
		GET PROCESS VARIABLE:C371($process;aMontoMora;aMontoMora;ad_fechaVcto;ad_fechaVcto)
		GET PROCESS VARIABLE:C371($process;al_idAvisoAPagar;al_idAvisoAPagar)
		
		WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"ACT_PreImportArchivos";0;4;__ ("Datos Importados"))
		DIALOG:C40([xxACT_ArchivosBancarios:118];"ACT_PreImportArchivos")
		CLOSE WINDOW:C154
		If (ok#1)
			continuarImport:=False:C215
		End if 
		AT_Initialize (->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aFechaPagos;->aSerieCheque;->aFechaDctoCheque;->aCuentaCheque;->aBancoCheque;->aLugarDePago;->aNoOperacion;->aMontoMora;->ad_fechaVcto)
	End if 
End if 
SET PROCESS VARIABLE:C370($process;continuarImport2;continuarImport)
CLEAR SEMAPHORE:C144("PreImport")