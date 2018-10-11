//%attributes = {}
  //ACTabc_ImportPorColegio

$sem:=Semaphore:C143("ImportBancarios")
$sem2:=Semaphore:C143("LoadingBankFile")
C_TEXT:C284(vtACT_BancoArchivo)
C_LONGINT:C283($importer;$3)
C_BOOLEAN:C305(continuarImport;continuarImport2;$typeFileMac)
C_LONGINT:C283($typeWin;$typeMac)
C_DATE:C307($vd_FechaUF)
continuarImport:=True:C214
continuarImport2:=True:C214

vtACT_BancoArchivo:=""
<>vbACT_Importando:=True:C214
<>vbACT_ErrorImport:=False:C215

$blob:=$1
vtACT_fileName:=$2
$importer:=$3
$formadePago:=$4
vd_fechaPago:=$5
vpXS_IconModule:=$6
vsBWR_CurrentModule:=$7
$typeWin:=$8
$typeMac:=$9
$typeFileMac:=($typeMac=1)
$vd_FechaUF:=$10

  //20130729 RCH
$t_nombreUsuario:=$11

ACTabc_declaraVariablesOpImport 
ACTcfg_ItemsMatricula ("InicializaYLee")
ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
LOC_LoadIdenNacionales 
ACTcfg_OpcionesCondonacion ("LeeBlob")
ACTfdp_OpcionesRecargos ("InicializaVars")  //20120725 ASM Para inicializar variables de los recargos para las formas de pago
C_REAL:C285(vrACT_MontoRecargo)

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
ARRAY LONGINT:C221(<>alACT_idsAvisosImport;0)
ARRAY LONGINT:C221(<>aIDAvisoRechazo;0)
ARRAY LONGINT:C221(<>alACT_RecNumPagosInforme;0)

ACTcfg_LoadBancos 
ACTinit_LoadPrefs 

<>montoNoIdentif:=0
<>montoRechazos:=0
<>montoAprobado:=0
<>montoDoble:=0
<>montoProcesado:=0
<>montoInvalidos:=0
<>montoNoApdoCta:=0

<>numProcesados:=0

If ($typeWin=1)
	USE CHARACTER SET:C205("windows-1252";1)
Else 
	USE CHARACTER SET:C205("MacRoman";1)
End if 

$path:=Temporary folder:C486+"ImportArchBancario.txt"
If (SYS_TestPathName ($path)=Is a document:K24:1)
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	DELETE DOCUMENT:C159($path)
	EM_ErrorManager ("Clear")
End if 
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$ref:=Create document:C266($path)
EM_ErrorManager ("Clear")
$document:=document
If (ok=1)
	CLOSE DOCUMENT:C267($ref)
	BLOB TO DOCUMENT:C526($document;$blob)
	$ref:=Open document:C264($document;"";Read mode:K24:5)
	If (ok=1)
		CLOSE DOCUMENT:C267($ref)
		ARRAY POINTER:C280(apACT_BlobsAvisos;0)
		modcargos:=False:C215
		vbACT_ModOrderAvisos:=False:C215
		$0:=1
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		$found:=Find in field:C653([xxACT_ArchivosBancarios:118]ID:1;$importer)
		If ($found#-1)
			vtCode:=""
			GOTO RECORD:C242([xxACT_ArchivosBancarios:118];$found)
			vtACT_BancoArchivo:=ACTcfg_OpcionesArchivoBancario ("RetornaNombreBanco";->[xxACT_ArchivosBancarios:118]CodBancoAsociado:12)
			ACTtrf_ValidaArchivoBancario 
			If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
				$offset:=0
				vtCode:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
				vtCode:=ACT_VerificaScript (vtCode)
				vtCode:=ACTtrf_RemoveCheckCode (vtCode)
				$valid:=ACTtrf_IsColegiumTransferFile (vtCode)
				If ($valid)
					$err:=0
					If ($err#0)
						$0:=0
						<>vbACT_ErrorImport:=True:C214
					Else 
						EXE_Execute (vtCode;False:C215;"";->$document)
						
						  //20170413 RCH Se agrega código para limpiar semáforo y hacer la importación.
						CLEAR SEMAPHORE:C144("LoadingBankFile")
						While (Test semaphore:C652("LConfIBank"))
							DELAY PROCESS:C323(Current process:C322;120)
						End while 
						If ($err#0)
							$0:=0
							<>vbACT_ErrorImport:=True:C214
						Else 
							If (continuarImport)
								ACTabc_ImportProcess ($formadePago;vd_fechaPago;$vd_FechaUF;$t_nombreUsuario)
							Else 
								$0:=0
								<>vbACT_ErrorImport:=True:C214
							End if 
						End if 
						
						If (False:C215)  // FOOTRUNNER OUT!
							  //$vt_pref:=PREF_fGet (0;"ACT_EXECUTE_IO_TRF";"FR")
							  //Case of 
							  //: ($vt_pref="PP")  // page pro...
							  //$err:=ACTabc_EjecutaScriptPP (vtCode;$document)
							  //Else   //foot runner
							  //$err:=FRAppendChecksum (vtCode)
							  //If ($err=0)
							  //$err:=FRRunText (vtCode;0;$document)
							  //Else 
							  //$0:=0
							  //<>vbACT_ErrorImport:=True
							  //End if 
							  //End case 
							
							  //CLEAR SEMAPHORE("LoadingBankFile")
							  //While (Test semaphore("LConfIBank"))
							  //DELAY PROCESS(Current process;120)
							  //End while 
							  //If ($err#0)
							  //$0:=0
							  //<>vbACT_ErrorImport:=True
							  //Else 
							  //If (continuarImport)
							  //ACTabc_ImportProcess ($formadePago;vd_fechaPago;$vd_FechaUF;$t_nombreUsuario)
							  //Else 
							  //$0:=0
							  //<>vbACT_ErrorImport:=True
							  //End if 
							  //End if 
						End if 
						
						
					End if 
					vtCode:=""
				Else 
					$0:=0
					<>vbACT_ErrorImport:=True:C214
				End if 
			Else 
				ACTtf_DeclareArrays 
				ACTtf_OpcionesTextosImp 
				GOTO RECORD:C242([xxACT_ArchivosBancarios:118];$found)
				C_LONGINT:C283(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2;WTrf_s3;cs_IEncabezado;cs_IPie)
				C_LONGINT:C283(WTrf_s4)
				C_TEXT:C284(WTrf_s4_CaracterOtro)
				C_TEXT:C284(vt_ICodApr;vIIdentificador;vIFormatoCA)
				SET BLOB SIZE:C606(xBlob;0)
				xBlob:=[xxACT_ArchivosBancarios:118]xData:2
				  //BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro)
				BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH
				SET BLOB SIZE:C606(xBlob;0)
				
				$err:=ACTabc_ImportByWizard ($document;vd_fechaPago;$typeFileMac;$formadePago)
				CLEAR SEMAPHORE:C144("LoadingBankFile")
				While (Test semaphore:C652("PreImport"))
					DELAY PROCESS:C323(Current process:C322;120)
				End while 
				If ($err=0)
					If (continuarImport2)
						While (Test semaphore:C652("LConfIBank"))
							DELAY PROCESS:C323(Current process:C322;120)
						End while 
						If (continuarImport)
							ACTabc_ImportProcess ($formadePago;vd_fechaPago;$vd_FechaUF;$t_nombreUsuario)
						Else 
							$0:=0
							<>vbACT_ErrorImport:=True:C214
						End if 
					Else 
						$0:=0
						<>vbACT_ErrorImport:=True:C214
					End if 
				Else 
					$0:=0
					<>vbACT_ErrorImport:=True:C214
				End if 
			End if 
		Else 
			$0:=0
			<>vbACT_ErrorImport:=True:C214
		End if 
		CLOSE DOCUMENT:C267($ref)
		DELETE DOCUMENT:C159($document)
	Else 
		<>vbACT_ErrorImport:=True:C214
	End if 
Else 
	<>vbACT_ErrorImport:=True:C214
End if 
USE CHARACTER SET:C205(*;1)
<>vbACT_Importando:=False:C215
COPY ARRAY:C226(al_idAvisoAPagar;<>alACT_idsAvisosImport)
CLEAR SEMAPHORE:C144("ImportBancarios")
DELAY PROCESS:C323(Current process:C322;180)